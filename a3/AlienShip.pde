/**************************************************************
 * Class: AlienShip
 * Constructor: no params
 * Desc: This class Generates and stores variables required to 
 * draw and move the AlienShip and the methods of this object
 ***************************************************************/

class AlienShip { 
  float AlienShipSpeed = 1.5;// AlienShip Speed
  PVector velocity, location;// PVectors for motion
  float BigRadius = 50;      // Radius for outer circle of AlienShip
  float SmallRadius = 25;    // Radius for inner circle of AlienShip
  boolean active = false;    // Boolean flag for AlienShip 'active' status
  int alienBuffer = 100;     // Amount of pixels an AlienShip can move offscreen
  int fiveSeconds = 300;     // Amount of frames in 5 seconds
  float xRandom, yRandom;    // Floats to load random start into

  // Constructor
  AlienShip() {
    PVector start = new PVector();
    start = randomStart();
    location = new PVector(start.x, start.y);
    velocity = new PVector(1, 1);
  }

  /*******************************************************************
   * Method: AlienShip.move()
   * Parameters: None
   * Returns: Void
   * Desc: This method moves the AlienShip and limits it movement to
   a little off screen, at which point the AlienShip's direction is
   reversed
   ******************************************************************/
  void move() {
    // If AlienShip travels too far right or left
    if (location.x > (width + alienBuffer)|| location.x < -alienBuffer) {
      velocity.x *= -1;
    }

    // If AlienShip travels too far up or down
    if (location.y > (height + alienBuffer)|| location.y < -alienBuffer) {
      velocity.y *= -1;
    }

    // Add speed times velocity to location
    location.x += AlienShipSpeed * velocity.x;
    location.y += AlienShipSpeed * velocity.y;
  }

  /*******************************************************************
   * Method: AlienShip.display()
   * Parameters: None
   * Returns: Void
   * Desc: This method displays the AlienShip object to the screen 
   as two circles with different radii but the same origin
   ******************************************************************/
  void display() {
    // Outer circle of AlienShip
    stroke(255);
    fill(0); // fill colour in object
    ellipse(location.x, location.y, BigRadius, BigRadius); // object

    // Inner circle of AlienShip
    fill(153); // fill colour in object
    //smaller ellipse on Alien Ship (centred circle)
    ellipse(location.x, location.y, SmallRadius, SmallRadius); // object
  }

  /*******************************************************************
   * Method: AlienShip.approach()
   * Parameters: None
   * Returns: Void
   * Desc: This method moves the AlienShip on screen if active and shoots a 
   bullet towards PlayerShip every 5 seconds if AlienShip is on screen
   ******************************************************************/
  void approach() {
    // If AlienShip is active
    if (active) {
      AlienShip.move();
      boolean onScreen;
      //Test for if the ship is onscreen
      onScreen = (location.x >= 0 && location.x <= width && location.y >= 0 
        && location.y <= width);

      // Every five seconds a bullet is shot if the AlienShip is onScreen
      if (frameCount % fiveSeconds == 0 && onScreen) {
        bullets.add( new Bullet(AlienShip.location, "ALIEN"));
      }
    }
  } 

  /*******************************************************************
   * Method: AlienShip.randomStart()
   * Parameters: None
   * Returns: Void
   * Desc: This method randomizes the start and reset location of 
   the AlienShip object
   ******************************************************************/
  PVector randomStart() {
    // Random int to decide what start AlienShip will have
    int randCount = int(random(1, 4));
    if (randCount <=1) {
      // Random start is to the left of the screen
      xRandom = random(-alienBuffer/2, -alienBuffer);
      yRandom = random(0, height);
    } 
    // Random start is below the bottom of the screen
    else if (1 < randCount || randCount <=2) {
      xRandom = random(0, width);
      yRandom = random(height + alienBuffer/2, height + alienBuffer);
    } 
    // Random start is to the right off screen
    else if (2 < randCount || randCount <=3) {
      xRandom = random(width + alienBuffer/2, width + alienBuffer);
      yRandom = random(0, width);
    } 
    // Random start is above the top of the screen
    else {
      xRandom = random(0, width);
      yRandom = random(-alienBuffer/2, -alienBuffer);
    }
    // Return random start as PVector
    PVector start = new PVector(xRandom, yRandom);
    return start;
  }

  /**************************************************************
   * Method: AlienShip.die()
   * Parameters: None
   * Returns: Void
   * Desc: This method resets the AlienShip's location, velocity and 
   'active' boolean
   ***************************************************************/
  void die() {
    PVector restart = new PVector();
    restart = randomStart();
    location = new PVector(restart.x, restart.y);
    velocity = new PVector(1, 1);
    active = false;
  }
}
