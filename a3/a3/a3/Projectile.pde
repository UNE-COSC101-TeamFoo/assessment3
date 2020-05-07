class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float accelX,accelY; //acceleration
  float x, y; // starting location
  float w, h; //dimensions for Bullet 
  float bulletSpeed = 7;
  
  //For Collision Detection
  String originType2;
  float d;

  Bullet(PVector originLoc, String originType) {

    //Dimensions of bullet
    w = 5;
    h = 5;
    
    //For Collision Detection 
    originType2 = originType;
   
    // Starting location for Bullet - AlienShip
    // or playerShip location attributes passed through
    x = originLoc.x;
    y = originLoc.y;
    location = new PVector(x,y);
    
    //Angle to determine direction of bullet
    float bulletAngle;
    
    // If bullet is sent from playerShip
    if (originType == "PLAYER") {
      bulletAngle = player.angle - HALF_PI;
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
      //println(bulletAngle);
      
      //Angular velocity based on calculated angle above
      velocity = new PVector(bulletSpeed * cos(bulletAngle), bulletSpeed * sin(bulletAngle));
    }
  }
  
  void update() {
    //move the bullet
    location.add(velocity);
    
    //For Collision Detection
    // Bullet from AlienShip to Player
    if(originType2 == "ALIEN"){
      float d = location.dist(player.location);
      if(d<10){
        fill(255, 0, 0, 100);
        rect(0, 0, width, height);        
      }
    }
    // Bullet from Player to AlienShip
    else if(originType2 == "PLAYER"){
      float d = location.dist(AlienShip.location);
      if(d<10){
        fill(255, 0, 0, 100);
        rect(0, 0, width, height);        
      }
    }
  }
  
  void display(){
    fill(0,255,0,255); //fluro green
    ellipse(location.x,location.y,w,h);
  }
}
