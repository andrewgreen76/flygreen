#include <alsa/asoundlib.h>

int main() {
    int err;
    snd_pcm_t *pcm_handle;
    snd_pcm_sframes_t frames;

    // Open the default ALSA PCM device
    err = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (err < 0) {
        fprintf(stderr, "Error opening PCM device: %s\n", snd_strerror(err));
        return 1;
    }

    // Set parameters for the PCM stream
    snd_pcm_set_params(pcm_handle, SND_PCM_FORMAT_S16_LE, SND_PCM_ACCESS_RW_INTERLEAVED, 1, 44100, 0, 500000);

    // Generate a simple audio tone
    char buf[4];
    for (int i = 0; i < 10000; i++) {
        buf[0] = 0x7F;
        buf[1] = 0x00;
        buf[2] = 0x7F;
        buf[3] = 0x00;

        frames = snd_pcm_writei(pcm_handle, buf, sizeof(buf) / sizeof(buf[0]));
        if (frames < 0) {
            frames = snd_pcm_recover(pcm_handle, frames, 0);
        }
        if (frames < 0) {
            fprintf(stderr, "snd_pcm_writei failed: %s\n", snd_strerror(err));
            break;
        }
    }

    // Close the PCM device
    snd_pcm_close(pcm_handle);

    return 0;
}
