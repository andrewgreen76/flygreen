#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alsa/asoundlib.h>
#include <math.h>

#define SAMPLE_RATE 44100
#define FREQUENCY 440  // Frequency of the beep in Hz
#define DURATION 1     // Duration of the beep in seconds

int main() {
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    int dir;
    unsigned int rate = SAMPLE_RATE;
    int frames = DURATION * SAMPLE_RATE;
    int size = frames * 2; // 16-bit audio

    // Allocate buffer
    int16_t *buffer = (int16_t *)malloc(size);
    if (!buffer) {
        perror("Failed to allocate buffer");
        return 1;
    }

    // Fill buffer with sine wave
    for (int i = 0; i < frames; i++) {
        buffer[i] = (int16_t)(32767 * sin(2 * M_PI * FREQUENCY * i / SAMPLE_RATE));
    }

    // Open PCM device
    if (snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
        perror("Unable to open PCM device");
        free(buffer);
        return 1;
    }

    // Allocate hardware parameters
    snd_pcm_hw_params_alloca(&params);
    snd_pcm_hw_params_any(handle, params);
    snd_pcm_hw_params_set_rate_near(handle, params, &rate, &dir);
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(handle, params, 1);
    snd_pcm_hw_params(handle, params);

    // Write to the PCM device
    snd_pcm_writei(handle, buffer, frames);

    // Clean up
    snd_pcm_drain(handle);
    snd_pcm_close(handle);
    free(buffer);

    return 0;
}
