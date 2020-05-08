class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float accelX,accelY; //acceleration
  float x, y; // starting location
  float w, h; //dimensions for Col.Dect.
  float bulletSpeed = 7;
  String originType;
  float bulletRadius = 5;
 
  Bullet(PVector originLoc, String originType) {
    //for collision detection (Col.Dect.)
    this.originType = originType;

     
    // Starting location for Bullet - AlienShip
    // or playerShip location attributes passed through
    x = originLoc.x;
    y = originLoc.y;
    location = new PVector(x,y);
    
    //Angle to determine direction of bullet
    float bulletAngle;
    
    // If bullet is sent from playerShip
    if (originType == "PLAYER") {
      bulletAngle = player.angle;
      //Angular velocity
      velocity = new PVector(bulletSpeed * cos(bulletAngle), bulletSpeed * sin(bulletAngle));

    } 
    // If bullet is sent from AlienShip
    else if (originType == "ALIEN") {
      
      // Create a vector between AlienShip & playerShip location instance
      float xDist = player.location.x - AlienShip.location.x;
      float yDist = player.location.y - AlienShip.location.y;
      PVector lineBetween = new PVector(xDist, yDist);
      
      // Use the 'heading' PVector function to get angle of new PVector
      bulletAngle = lineBetween.heading();
      println(bulletAngle);
      
      //Angular velocity based on calculated angle above
      velocity = new PVector(bulletSpeed * cos(bulletAngle), bulletSpeed * sin(bulletAngle));
    }
  }   
  void update() {
    //move the bullet
    location.add(velocity);
  }
  
  void display(){
    ellipse(location.x,location.y,bulletRadius,bulletRadius);
  }
}
