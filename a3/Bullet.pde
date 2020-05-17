/**************************************************************
 * Class: Bullet
 * Constructor: PVector(originLoc), String(originType)
 * Desc: This class generates the attributes and methods necessary
 to create, move and display Bullets in the game
 ***************************************************************/

class Bullet {
  // PVectors for motion
  PVector location, velocity;
  float speed = 4;     // Bullet speed
  String originType;   // What object shot the bullet
  int radius = 5;      // Radius of bullet
  float angle;         // Angle of bullet velocity


  // Constructor
  Bullet(PVector originLoc, String originType) {
    this.originType = originType;

    // Starting location for Bullet - AlienShip
    // or playerShip location attributes passed through
    location = new PVector(originLoc.x, originLoc.y);


    // If the bullet is shot from PlayerShip
    if (originType == "PLAYER") {
      angle = player.angle;
      // Angular velocity - determines where the PlayerShip is facing
      // and shoots the bullet in that direction
      velocity = new PVector(speed * cos(angle), speed * sin(angle));
    } 
    // If the bullet is shot from AlienShip
    else if (originType == "ALIEN") {

      // Calculate a point between AlienShip & playerShip location instance
      float xDist = player.location.x - AlienShip.location.x;
      float yDist = player.location.y - AlienShip.location.y;
      PVector pointBetween = new PVector(xDist, yDist);

      // Use the 'heading' PVector function to get angle of bullet
      // towards PlayerShip
      angle = pointBetween.heading();

      // Angular velocity based on calculated angle above
      velocity = new PVector(speed * cos(angle), speed * sin(angle));
    }
  }

  /**************************************************************
   * Method: Bullet.update()
   * Parameters: None
   * Returns: Void
   * Desc: This method updates the bullet's location by adding 
   velocity
   ***************************************************************/
  void update() {
    // Move the bullet
    location.add(velocity);
  }

  /**************************************************************
   * Method: Bullet.display()
   * Parameters: None
   * Returns: Void
   * Desc: This method displays the bullet and the bullets colour
   is dependent on its 'originType' attribute
   ***************************************************************/
  void display() {
    if (originType == "PLAYER") {
      fill(0, 255, 0, 255); // Fluro green for Player's bullet
    } else {
      fill(255, 18, 29); // Red for AlienShip's bullet
    }
    ellipse(location.x, location.y, radius, radius);
  }

  /**************************************************************
   * Method: Bullet.wrap()
   * Parameters: None
   * Returns: Boolean
   * Desc: This method tests whether a bullet is off screen and 
   returns the recult
   ***************************************************************/
  boolean wrap() {
    if (location.x<0 || location.x> width || 
      location.y < 0 || location.y > height) {
      return true;
    } else {
      return false;
    }
  }
}
