import mido
from mido import MidiFile, MidiTrack, Message

# Create a new MIDI file with one track
mid = MidiFile()
track = MidiTrack()
mid.tracks.append(track)

# Add a note-on message for each note in the C major scale
notes = [60, 62, 64, 65, 67, 69, 71, 72]  # MIDI note numbers for C major scale
for note in notes:
    track.append(Message('note_on', note=note, velocity=64, time=0))

# Add a note-off message for each note (after a certain duration)
for note in notes:
    track.append(Message('note_off', note=note, velocity=64, time=480))  # Adjust time as needed

# Save the MIDI file
mid.save('output.mid')
