library Player;

import '../game_object.dart';
import '../pyramid.dart';

import '../sheep/i_sheep_herder.dart';

class Player extends GameObject implements ISheepHerder {
  static const xSpeed = 0.04;
  static const ySpeed = 0.04;
  static const zSpeed = 0.04;

  static const initialPositionX = 0.0;
  static const initialPositionY = 5.0;
  static const initialPositionZ = 0.0;

  static const yRotationSpeed = 2.0;

  // how many degrees shotld the drone tilt (this does not affect position)
  static const movingTilt_notMoving = 0.0;
  static const movingTilt_moving = 10.0;

  GameObject droneBody;

  Player() {
    // sets inital position
    translateX(initialPositionX);
    translateY(initialPositionY);
    translateZ(initialPositionZ);

    droneBody = new Pyramid();
    addChild(droneBody);
  }

  @override
  void handleUserInput() {
    // Forward Backward
    bool preserveTiltFB = false;
    if (inputHandler.isPressingFORWARD) {
      translateZ(-zSpeed);
      droneBody.rotationX = -movingTilt_moving;
      preserveTiltFB = true;
    }
    if (inputHandler.isPressingBACKWARD) {
      translateZ(zSpeed);
      droneBody.rotationX = movingTilt_moving;
      preserveTiltFB = true;
    }
    if (!preserveTiltFB) {
      droneBody.rotationX = movingTilt_notMoving;
    }

    // Left Right
    bool preserveTiltLR = false;
    if (inputHandler.isPressingRIGHT) {
      translateX(xSpeed);
      droneBody.rotationZ = -movingTilt_moving;
      preserveTiltLR = true;
    }
    if (inputHandler.isPressingLEFT) {
      translateX(-xSpeed);
      droneBody.rotationZ = movingTilt_moving;
      preserveTiltLR = true;
    }
    if (!preserveTiltLR) {
      droneBody.rotationZ = movingTilt_notMoving;
    }

    // Up Down
    if (inputHandler.isPressingUP) {
      translateY(ySpeed);
    }
    if (inputHandler.isPressingDOWN) {
      translateY(-ySpeed);
    }

    // Rotation (roatating the camera left-right also moves the player)
    if (inputHandler.isPressingROTATE_RIGHT || inputHandler.isPressingCAMERA_RIGHT) {
      rotateY(-yRotationSpeed);
    }
    if (inputHandler.isPressingROTATE_LEFT || inputHandler.isPressingCAMERA_LEFT) {
      rotateY(yRotationSpeed);
    }
  }

  // ISheepHerder --------------------------------------------------------------------
  
  // TODO: implement rotation
  @override
  double get rotation => rotationY;
}
