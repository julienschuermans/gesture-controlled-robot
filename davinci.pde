import de.voidplus.leapmotion.*;
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
LeapMotion leap;

// Define servo pins
int roll_1 = 3;
int thumb_2 = 9;
int pitch_3 = 6;
int index_4 = 5;

void setup() {
  size(800, 500);
  background(255);

  //println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  arduino.pinMode(roll_1, Arduino.SERVO);
  arduino.pinMode(thumb_2, Arduino.SERVO);
  arduino.pinMode(pitch_3, Arduino.SERVO);
  arduino.pinMode(index_4, Arduino.SERVO);

  leap = new LeapMotion(this);
}

void draw() {

  background(255);

  for (Hand hand : leap.getHands ()) { 
  
    //
    // Get gesture info from device
    //

    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    float   hand_pinch       = hand.getPinchStrength();

    hand.draw();    
    
    //
    // Translate the LeapMotion info to servo angles
    //

    hand_pitch = hand_pitch - 45; 
    int anglePitch = 90;
    if (hand_pitch < -90) {
      hand_pitch = -90;
    } else if (hand_pitch > 90) {
      hand_pitch = 90;
    }
    anglePitch = abs(int(hand_pitch) - 90);
    
    int angleRoll = 90;
    if (hand_roll < -90) {
      hand_roll = -90;
    } else if (hand_roll > 90) {
      hand_roll = 90;
    }
    angleRoll = abs(int(hand_roll) - 90);
    
    int rollCompensation = (angleRoll-90)/2;

    int angleYaw = 90;
    if (hand_yaw < -90) {
      hand_yaw = -90;
    } else if (hand_yaw > 90) {
      hand_yaw = 90;
    }
    angleYaw = int(hand_yaw) + 90;
    angleYaw += rollCompensation;
    int angleYaw2 = angleYaw - 30 + int(hand_pinch*50); // calibration constants depend on hardware
    int angleYaw4 = angleYaw + 30 - int(hand_pinch*50); 
    
    //
    // Send commands to the arduino
    //

    arduino.servoWrite(roll_1, angleRoll);
    arduino.servoWrite(pitch_3, anglePitch);
    
    if (angleYaw2 > 180) {
      arduino.servoWrite(thumb_2, 180);
    }
    else if (angleYaw2 < 0) {
      arduino.servoWrite(thumb_2, 0);
    }
    else {
      arduino.servoWrite(thumb_2, angleYaw2);
    }
    
    if (angleYaw4 > 180) {
      arduino.servoWrite(index_4, 180);
    }
    else if (angleYaw4 < 0) {
      arduino.servoWrite(index_4, 0);
    }
    else {
      arduino.servoWrite(index_4, angleYaw4);
    }

  }
}
