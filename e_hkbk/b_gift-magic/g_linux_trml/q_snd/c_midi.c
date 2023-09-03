#include <SDL.h>
#include <SDL_mixer.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    if (SDL_Init(SDL_INIT_AUDIO) < 0) {
        fprintf(stderr, "SDL initialization failed: %s\n", SDL_GetError());
        return 1;
    }

    // Initialize SDL_mixer
    if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 1024) == -1) {
        fprintf(stderr, "SDL_mixer initialization failed: %s\n", Mix_GetError());
        SDL_Quit();
        return 1;
    }

    // Load a MIDI file (replace "your_midi_file.mid" with your MIDI file)
    Mix_Music* music = Mix_LoadMUS("your_midi_file.mid");
    if (!music) {
        fprintf(stderr, "Failed to load MIDI file: %s\n", Mix_GetError());
        Mix_CloseAudio();
        SDL_Quit();
        return 1;
    }

    // Play the MIDI file
    if (Mix_PlayMusic(music, 0) == -1) {
        fprintf(stderr, "Failed to play MIDI file: %s\n", Mix_GetError());
    } else {
        printf("Playing MIDI file. Press Enter to stop...\n");
        getchar();
    }

    // Cleanup and exit
    Mix_FreeMusic(music);
    Mix_CloseAudio();
    SDL_Quit();

    return 0;
}
