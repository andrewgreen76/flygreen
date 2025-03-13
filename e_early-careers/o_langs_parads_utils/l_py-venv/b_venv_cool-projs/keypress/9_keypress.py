import keyboard

def on_key_press(event):
    print("Key pressed:", event.name)

keyboard.on_press(on_key_press)

# Run the script indefinitely to keep detecting key presses
#keyboard.wait()
