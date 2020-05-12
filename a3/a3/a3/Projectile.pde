// Bullet class
// Works of both BN and CS
// Commentary by BN
class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;

  float accelX, accelY; // Acceleration
  float x, y; // starting location
  float speed = 5; // speed
  String originType; // String to pass PLAYER or ALIEN value
  int radius = 5;
  float angle;

  // Constructor
  Bullet(PVector originLoc, String originType) {
    this.originType = originType;
    // Starting location for Bullet - AlienShip
    // or playerShip location attributes passed through
    x = originLoc.x;
    y = originLoc.y;
    location = new PVector(x, y);

    // If bullet is sent from playerShip
    if (originType == "PLAYER") {
      angle = player.angle;
      //Angular velocity
      velocity = new PVector(speed * cos(angle), speed * sin(angle));
    } 
    // If bullet is sent from AlienShip
    else if (originType == "ALIEN") {

      // Creating a line beteeen AlienShip and Player to shoot Bullet L.O.S
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

  // Move the Bullet   
  void update() {
    location.add(velocity);
  }
  // Display bullet object
  void display() {
    if(originType == "PLAYER"){
      fill(0, 255, 0, 255); // flurro green for Player's bullet
    }
    else{
     //stroke(255,18,29); //makes yellow bullet for player when alien on screen with player
     fill(255,18,29); // red for AlienShip's bullet
    }
    ellipse(location.x, location.y, radius, radius);
  }
}
//EOF