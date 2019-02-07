# Gesture Controlled Endoscopic Surgical Tools

This Arduino and Processing code allows to control servos by hand gestures captured through a LeapMotion controller.
A demo video on [YouTube](https://www.youtube.com/watch?v=UMRH_Itp0wk) shows how I used four servos to control robotic EndoWrist tools.

## Getting Started

These instructions will get you a copy of the project up and running on your local surgical robot.

### Arduino

The serial communication between the Arduino and the host computer is handled by the Firmata library. Download it [here](https://github.com/firmata/arduino). 


### Processing

The Processing script handles incoming data from the LeapMotion device and sends commands to the Arduino over USB. You'll need the following libraries: 

- [LeapMotion](https://github.com/nok/leap-motion-processing)
- [Firmata](https://github.com/firmata/processing)


## Connecting the Hardware

When you connect the servos to the Arduino, make sure they match with the pins defined at the top of `davinci.pde`. The defaults connections are as follows.

- roll:	pin 3
- thumb: 	pin 9
- pitch: 	pin 6
- index: 	pin 5

To connect the Processing script to the Arduino, first figure out which serial port to use. You can do this by uncommenting

```
println(Arduino.list())
```

If necessary, change the index `2` in the line below:

```
arduino = new Arduino(this, Arduino.list()[2], 57600);
```

## Running the software

1. Write `leapfirmata.ino` to your Arduino like any other sketch.
2. Load the `davinci.pde` script in Processing, press 'Run'.

## Authors

* **Julien Schuermans** - [julienschuermans](https://github.com/julienschuermans)


