class playerShip {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 4;
  float angle = radians(270); //if your ship is facing up (like in atari game) 
  float spinSpeed = 0.085; // rate of rotation
  float accelSpeed = 0.1; // rate of acceleration
  int lives;
  int liveFlash = 0;
  boolean active = false;
  int radius;


  playerShip() {
    location = new PVector(width/2, height/2); // Middle point
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    lives = 3;
    radius = 15;
  }  
  void update() {
    velocity.add(acceleration);
    velocity.mult(.995); //add drag to acceleration
    velocity.limit(maxSpeed);
    location.add(velocity); 
    wrap();
  } 
  void render() {    
    pushMatrix();
    //Move Ship
    translate(location.x, location.y);
    //Rotate Ship
    rotate(angle + HALF_PI);
    //Draw Ship
    stroke(225);
    if (!active) {
      if (frameCount%60 < 20) {
        stroke(0);
        fill(0);
        liveFlash++; // counter of flashes of dead ship
      } else {
        stroke(255);
        fill(255);
        if (liveFlash > 60) {
          active = true;
        }
      }
      quad(0, -15, -15, 15, 0, 8, 15, 15); // Hard coded to draw around location
    } else {
      quad(0, -15, -15, 15, 0, 8, 15, 15); // Hard coded to draw around location
      liveFlash = 0;
    }
    popMatrix();
  }  
  // This function keeps the player on screen
  void wrap() {
    if (location.x >= width) {
      location.x = 0;
    } else if (location.x <= 0) {
      location.x = width;
    }
    if (location.y >= height) {
      location.y = 0;
    } else if (location.y <= 0) {
      location.y = height;
    }
  }
  void accel() {
    // Angular Acceleration
    acceleration = new PVector(accelSpeed * cos(angle), accelSpeed * sin(angle));
  }
  // Function to stop acceleration
  void slow() {
    acceleration = new PVector(0, 0);
  }
  void rotateRight() {
    angle += spinSpeed;
  }
  void rotateLeft() {
    angle -= spinSpeed;
  }

  void displayLives() {
    stroke(255);
    fill(255);
    for (int i = 0; i < lives; i++) {
      int lifeX = 80 + i * 45;
      int lifeY = 70;
      fill(255);
      quad(lifeX, lifeY, lifeX-10, lifeY+25, lifeX, lifeY+20, lifeX+10, lifeY+25);
    }
  }


  void reset() {
    location.x = width/2;
    location.y = height/2;
    angle = radians(270);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0, 0);
  }


  void die() {
    reset();
    active = false;
    lives -= 1;
  }
}
