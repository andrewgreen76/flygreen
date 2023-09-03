#include <SDL.h>
#include <stdio.h>

int main() {
    // Initialize SDL
    if (SDL_Init(SDL_INIT_AUDIO) < 0) {
        fprintf(stderr, "SDL initialization failed: %s\n", SDL_GetError());
        return 1;
    }

    // Open an audio device
    SDL_AudioSpec audioSpec;
    audioSpec.freq = 44100;         // Frequency (Hz)
    audioSpec.format = AUDIO_S16;   // 16-bit signed audio
    audioSpec.channels = 1;         // Mono audio
    audioSpec.samples = 1024;      // Audio buffer size

    SDL_AudioDeviceID audioDevice = SDL_OpenAudioDevice(NULL, 0, &audioSpec, NULL, 0);
    if (audioDevice == 0) {
        fprintf(stderr, "Failed to open audio device: %s\n", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    // Generate a continuous tone
    SDL_PauseAudioDevice(audioDevice, 0);  // Start audio playback

    printf("Press Enter to stop the tone...\n");
    getchar();  // Wait for Enter key press

    // Clean up and exit
    SDL_CloseAudioDevice(audioDevice);
    SDL_Quit();

    return 0;
}
