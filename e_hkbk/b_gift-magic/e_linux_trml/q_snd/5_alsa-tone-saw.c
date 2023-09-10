#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

#define SAMPLE_RATE 44100
#define DURATION_SECONDS 2
#define AMPLITUDE 0x7FFF // Maximum amplitude for 16-bit audio

int main() {
    int err;
    snd_pcm_t *pcm_handle;
    snd_pcm_hw_params_t *params;
    unsigned int rate = SAMPLE_RATE;
    unsigned int pcm_samples = DURATION_SECONDS * SAMPLE_RATE;
    short *buffer;
    int i;

    // Allocate memory for the audio buffer
    buffer = (short *)malloc(pcm_samples * sizeof(short));
    if (!buffer) {
        fprintf(stderr, "Memory allocation error\n");
        return 1;
    }

    // Initialize the ALSA PCM handle
    err = snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    if (err < 0) {
        fprintf(stderr, "Error opening PCM device: %s\n", snd_strerror(err));
        free(buffer);
        return 1;
    }

    // Allocate and initialize hardware parameters
    snd_pcm_hw_params_malloc(&params);
    snd_pcm_hw_params_any(pcm_handle, params);
    snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
    snd_pcm_hw_params_set_channels(pcm_handle, params, 1);

    // Apply hardware parameters
    err = snd_pcm_hw_params(pcm_handle, params);
    if (err < 0) {
        fprintf(stderr, "Error setting hardware parameters: %s\n", snd_strerror(err));
        free(buffer);
        return 1;
    }

    // Generate a sawtooth wave
    for (i = 0; i < pcm_samples; ++i) {
        buffer[i] = (i * AMPLITUDE * 2 / pcm_samples) - AMPLITUDE;
    }

    // Write the audio data to the PCM device
    err = snd_pcm_writei(pcm_handle, buffer, pcm_samples);
    if (err < 0) {
        fprintf(stderr, "Error writing to PCM device: %s\n", snd_strerror(err));
    }

    // Close the PCM handle and free resources
    snd_pcm_drain(pcm_handle);
    snd_pcm_close(pcm_handle);
    free(buffer);

    return 0;
}
