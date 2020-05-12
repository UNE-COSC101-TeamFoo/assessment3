class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;

  float accelX, accelY; //acceleration
  float x, y; // starting location
  float speed = 5;
  String originType;
  int radius = 5;
  float angle;

  Bullet(PVector originLoc, String originType) {
    //for collision detection (Col.Dect.)
    this.originType = originType;


    // Starting location for Bullet - AlienShip
    // or playerShip location attributes passed through
    x = originLoc.x;
    y = originLoc.y;
    location = new PVector(x, y);

    //Angle to determine direction of bullet


    // If bullet is sent from playerShip
    if (originType == "PLAYER") {
      angle = player.angle;
      //Angular velocity
      velocity = new PVector(speed * cos(angle), speed * sin(angle));
    } 
    // If bullet is sent from AlienShip
    else if (originType == "ALIEN") {

      // Create a vector between AlienShip & playerShip location instance
      float xDist = player.location.x - AlienShip.location.x;
      float yDist = player.location.y - AlienShip.location.y;
      PVector lineBetween = new PVector(xDist, yDist);

      // Use the 'heading' PVector function to get angle of new PVector
      angle = lineBetween.heading();

      //Angular velocity based on calculated angle above
      velocity = new PVector(speed * cos(angle), speed * sin(angle));
    }
  }   
  void update() {
    //move the bullet
    location.add(velocity);
  }

  void display() {
    fill(0, 255, 0, 255);
    ellipse(location.x, location.y, radius, radius);
  }
}
