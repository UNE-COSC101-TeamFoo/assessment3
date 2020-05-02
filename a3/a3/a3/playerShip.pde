class playerShip {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 4;
  float angle = 0;
  float spinSpeed = 0.085; // rate of rotation
  float accelSpeed = 0.1; // rate of acceleration

  //for Collision Detection
  float w,h;
  
  playerShip() {
    location = new PVector(width/2,height/2); // Middle point
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    //For Collision detection
    w = 10;
    h = 10;
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
    rotate(angle);
    //Draw Ship
    stroke(225);
    quad(0,-25,-15,25,0,15,15,25); // Hard coded to draw around location
    popMatrix();
  }  
  // This function keeps the player on screen
  void wrap() {
    if(location.x >= width) {
      location.x = 0;
    } else if(location.x <= 0) {
      location.x = width;
    }
    if(location.y >= height) {
      location.y = 0;
    } else if (location.y <= 0) {
      location.y = height;
    }   
  }
  void accel() {
    // Angular Acceleration
    acceleration = new PVector(accelSpeed * cos(angle-(PI/2)), accelSpeed * sin(angle-(PI/2))); 
  }
  // Function to stop acceleration
  void slow() {
    acceleration = new PVector(0,0);
  }
  void rotateRight() {
    angle += spinSpeed;
  }
  void rotateLeft() {
    angle -= spinSpeed;
  }
}
