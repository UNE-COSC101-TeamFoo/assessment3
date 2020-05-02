class Bullet {
  //standard PVector used for the location of the bullet
  PVector location;
  PVector velocity;
  PVector acceleration;
  //vars used to check the angle between location and the mouse
  float oldPosX, oldPosY, rotation, speed;
  float speedX,speedY;
  float accelX,accelY;
  float x, y, w, h;
  float angle;
  
  float xDirection = 1;
  float yDirection = 1;
  
  Bullet() {
    //for collision detection
    w = 10;
    h = 10;
    //
    
    //location properties
    x = player.location.x+5;
    y = 400;
    
    //speed = 0;
    speedX = 5;
    speedY = 5;
    rotation = 10;
    //m = location.mag();
    accelX = 90;
    accelY = 90;
    
    //println(player.angle);
    //println(player.location);
    
    location = new PVector(x,y);
    //location.normalize();
    //location.mult(10);
    velocity = new PVector(speedX,speedY);
    acceleration = new PVector(accelX,accelY);
    
    //oldPosX = -15;
    //oldPosY = -25;
    //oldPosX = mouseX;
    //oldPosY = mouseY;
    //this checks the angle
    //rotation = 90;
    //bullet speed
    
  } 
  void update() {
    //move the bullet
    //location.x = location.x + cos(rotation/180*PI)*speed;
    //location.y = location.y + sin(rotation/180*PI)*speed;
    //location = new PVector(location.x,location.y);
    //location.x = location.x;
    //location.x = player.location.x + location.x*speed;
    //location.y = player.location.y + location.y*speed;
    //location.add(velocity);
    //acceleration = PVector.sub(player.location,location);
    
    //acceleration.setMag(0.2);
    
    //velocity.add(acceleration);
    //location.add(velocity);
    
    location.add(velocity);
    
    //if( (location.x > width) || (location.x < 0) ){
    // velocity.x = velocity.x * -1; 
    //}
    //if( (location.y > height) || (location.y < 0) ){
    // velocity.y = velocity.y * -1; 
    //}

    //removes the bullet from the arrayList if it is off the room
    //if (location.x > 0 && location.x < width && location.y > 0 && location.x < width) {
    //}
    //else {
    //  bullets.remove(i);
    //} 
  }
  
  void display(){
    //pushMatrix();
    //translate(location.x,location.y);
    //rotate(rotation);
    ellipse(location.x,location.y,10,10);
   // popMatrix();
  }
  
}
