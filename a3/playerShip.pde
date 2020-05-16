/**************************************************************
 * Class: PlayerShip()
 * Constructor: No parameters
 * Desc: 
 ***************************************************************/

class PlayerShip {
  // PVectors for motion
  PVector location, velocity, acceleration;
  float maxSpeed = 3;         // Max velocity of PlayerShip
  float angle = radians(270); // PlayerShip starts facing up (like atari game) 
  float spinSpeed = 0.085;    // rate of rotation
  float accelSpeed = 0.1;     // rate of acceleration
  int lives;                  // lives of PLayerShip
  int radius;                 // Radius of PlayerShip hit circle
  int frameToSecond = 60;     // Frames per second
  int shipIndent = 8;         // Y co-ord of ship indent in drawing

  // Boolean flag that allows PlayerShip to be invulnerable for
  // a short period after starting the game, levelling or dying
  boolean active = false;
  int liveFlash = 0;          // Counter for invulnerability flashes

  // Constructor
  PlayerShip() {
    location = new PVector(width/2, height/2); // Middle point of screen
    velocity = new PVector(0, 0);              // No velocity to begin
    acceleration = new PVector(0, 0);          // No acceleration to begin
    lives = 3; 
    radius = 15;                               // Radius to create ship
  } 

  /**************************************************************
   * Method: PlayerShip.update()
   * Parameters: None
   * Returns: Void
   * Desc: This method updates and wraps the player location, limits 
   the velocity, applies drag to the PlayerShip motion
   ***************************************************************/
  void update() {
    velocity.add(acceleration); 
    velocity.mult(.994); //add drag to velocity
    velocity.limit(maxSpeed);
    location.add(velocity); 
    wrap();
  } 
  
  /**************************************************************
   * Method: PlayerShip.render()
   * Parameters: None
   * Returns: Void
   * Desc: This method translates and rotates PlayerShip location,
   strobes the ship if inactive and draws the PlayerShip to screen.
   ***************************************************************/
  void render() { 
    pushMatrix();
    // Translate and rotate PlayerShip location
    translate(location.x, location.y);
    // HALFI_PI must be added to match angular acceleration
    rotate(angle + HALF_PI); 

    //Draw Ship
    int r = radius;
    // Set stroke and fill for drawing PlayerShip
    stroke(255);
    fill(255);
    // If the player isn't active stobe the drawing of the ship
    // and make the ship white during strobing
    if (!active) {
      // Strobe based on frameCount
      if (frameCount%frameToSecond < frameToSecond/3) {
        // Draw invisible ship
        stroke(0);
        fill(0);
        liveFlash++; // counter of flashes of invulnerable ship
      } else {
        // If the ship has strobed enough
        if (liveFlash > frameToSecond) {
          active = true; // reset to vulnerable/active
        }
      }
      // Draw an equilateral triangle with a inner point
      // (shipIndent) making it a quad
      quad(0, -r, -r, r, 0, shipIndent, r, r);
    } else {
      quad(0, -r, -r, r, 0, shipIndent, r, r);
      liveFlash = 0;
    }
    popMatrix();
  } 

  /**************************************************************
   * Method: PlayerShip.wrap()
   * Parameters: None
   * Returns: Void
   * Desc: This method ensures the Ship stays on screen, detecting
   the edges and resetting to the opposite side
   ***************************************************************/
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

  /**************************************************************
   * Method: PlayerShip.accel()
   * Parameters: None
   * Returns: Void
   * Desc: This method determines the x and y acceleration of the
   PlayerShip through the cosine and sine functions. This allows
   the PlayerShip object to have angular acceleration/motion
   Method built on code by
   ***************************************************************/
  void accel() {
    // Angular Acceleration
    acceleration = new PVector(accelSpeed*cos(angle), accelSpeed*sin(angle));
  }

  /**************************************************************
   * Method: PlayerShip.slow()
   * Parameters: None
   * Returns: Void
   * Desc: This method resets the PlayerShip's acceleration to zero
   ***************************************************************/
  void slow() {
    acceleration = new PVector(0, 0);
  }

  /**************************************************************
   * Method: PlayerShip.rotateRight()
   * Parameters: None
   * Returns: Void
   * Desc: This method rotates the PlayerShip right or clockwise
   by incrementing the angle attribute
   ***************************************************************/
  void rotateRight() {
    angle += spinSpeed;
  }

  /**************************************************************
   * Method: PlayerShip.rotateLeft()
   * Parameters: None
   * Returns: Void
   * Desc: This method rotates the PlayerShip left or 
   counterclockwise by decrementing the angle attribute
   ***************************************************************/
  void rotateLeft() {
    angle -= spinSpeed;
  }

  /**************************************************************
   * Method: PlayerShip.displayLives()
   * Parameters: None
   * Returns: Void
   * Desc: This method displays the number of lives a PlayerShip
   has underneath the score.
   ***************************************************************/
  void displayLives() {
    fill(255);
    int spaceBetween = 45; // space bewteen life icons
    int belowScoreX = 80;  // Start x point of lives below score
    int belowScoreY = 85;  // Start y point of lives below score
    // Loop to show ship images
    for (int i = 0; i < lives; i++) {
      // Hard-coded as under score text box
      int x = belowScoreX + i * spaceBetween;
      int y = belowScoreY;
      quad(x, y-radius, x-radius, y+radius, x, y+shipIndent, x+radius, y+radius);
    }
  }

  /**************************************************************
   * Method: PlayerShip.reset()
   * Parameters: None
   * Returns: Void
   * Desc: This method resets the PlayerShip's position, motion
   and orientation/direction
   ***************************************************************/
  void reset() {
    location.x = width/2;
    location.y = height/2;
    angle = radians(270);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0, 0);
  }

  /**************************************************************
   * Method: PlayerShip.die()
   * Parameters: None
   * Returns: Void
   * Desc: This method resets the PlayerShip, reduces
   the lives counter and sets the gameOver flag when no lives are
   left.
   ***************************************************************/
  void die() {
    reset();
    // Make PlayerShip invulnerable for start of next life
    active = false;
    lives -= 1;

    // No more lives left
    if (lives <= 0) {
      gameOver = true;
    }
  }
}
