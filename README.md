# Garage Security System with Password Protection

This code implements a garage security system that uses a password-protected keypad to control the opening and closing of a garage door motor. The motor runs for 4 seconds after the correct password is entered, regulated by timer interrupts.

## Hardware Requirements

- PIC16F877A microcontroller
- Keypad module
- LCD module
- Motor

## Software Requirements

- mikroC IDE
- Proteus
- Fritzing

## Implementation

The code initializes the hardware components and sets up the timer interrupt. The user is prompted to enter the password using the keypad, and the system checks if the entered password is correct. If the password is correct, the motor turns on and runs for 4 seconds before turning off. The timer interrupt is used to regulate the motor's operation and ensure that it runs for the correct amount of time.

If an incorrect password is entered, the system displays a message indicating that the password is incorrect. The user can reset the password by pressing the "*" key on the keypad. The LCD display is also updated to show the entered password as a series of asterisks for added security.

## Usage

- Connect the hardware components to the microcontroller as specified in the code.
- Compile and upload the code to the microcontroller using the mikroC IDE.
- Enter the correct password on the keypad to activate the motor and open the garage door.
- Press the "*" key to reset the password.
- Observe the LCD display for feedback on the system's status.
## Circuit Diagram 

## Simulation 


https://github.com/alaawahba13/Garage-lock/assets/101985923/d1c0aabe-279e-43df-affd-403580056ab8



## Credits

This code was developed by Alaa Wahba. Feel free to use and modify the code for your own purposes.
