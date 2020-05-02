class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float accelX,accelY; //acceleration
  float x, y; // starting location
  float w, h; //dimensions for Col.Dect.
  float bulletSpeed = 7;
 
  Bullet() {
    //for collision detection (Col.Dect.)
    w = 100;
    h = 100;

    //Starting location for Bullet   
    x = player.location.x;
    y = player.location.y;
    
    // bullet acceleration
    accelX = 0;
    accelY = 0;
    
    location = new PVector(x,y);        
    velocity = new PVector(bulletSpeed * cos(player.angle - HALF_PI), bulletSpeed * sin(player.angle - HALF_PI));
    acceleration = new PVector(accelX,accelY);             
  }   
  void update() {
    //move the bullet
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  void display(){
    ellipse(location.x,location.y,10,10);
  }
}
