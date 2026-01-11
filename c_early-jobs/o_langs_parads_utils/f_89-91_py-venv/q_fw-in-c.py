# Python script to generate LED blinking firmware code

# Define the parameters for the LED blinking
blink_delay_ms = 500    # Blink delay in milliseconds
num_blinks = 10         # Number of times to blink the LED

# Function to generate the C code for LED blinking firmware
def generate_firmware_code():
    firmware_code = f"""
#include <stdint.h>
#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN 5

int main(void) {{
    // Set LED_PIN as an output
    DDRB |= (1 << LED_PIN);

    for (int i = 0; i < {num_blinks}; i++) {{
        // Turn on the LED
        PORTB |= (1 << LED_PIN);

        // Delay for {blink_delay_ms} milliseconds
        _delay_ms({blink_delay_ms});

        // Turn off the LED
        PORTB &= ~(1 << LED_PIN);

        // Delay for {blink_delay_ms} milliseconds
        _delay_ms({blink_delay_ms});
    }}

    return 0;
}}
"""
    return firmware_code

# Generate the firmware code
firmware_code = generate_firmware_code()

# Save the generated code to a C file
with open("led_blink_firmware.c", "w") as file:
    file.write(firmware_code)
