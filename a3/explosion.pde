/**************************************************************
 * Class: Explosion()
 * Constructor: Float(x), Float(y)
 * Desc: This class creates an object that displays and updates 
 an explosion effect around an origin point, periodically 
 expanding the image drawn and reducing opacity to show the effect.
 ***************************************************************/

class Explosion {
  int explosionOpacity;    // Variable to store changing opacity
  PVector explosionLoc[];  // Array to store PVectors of particles
  int currentCycle = 0;    // Counter of explosion cycles
  int explosionLimit = 11; // Limit of update cycles
  float originX, originY;  // Origin co-ords of explosion

  // Constructor
  Explosion(float x, float y) {
    // Play explosion sound
    explosionSound.play();
    explosionSound.rewind();
    originX = x;
    originY = y;

    //Create array for PVectors to be intialized into
    explosionLoc = new PVector[explosionLimit];

    // Array for the relative positions of the singular explosion particles
    // in relation to the origin x and y locations
    // Hard-coded to plot natural particle positions
    int X[] = {-25, -22, -19, -10, -5, 0, 8, 10, 18, 20, 25};
    int Y[] = {0, -10, 23, 5, 20, -15, 25, -7, -30, 0, 5};

    // This variable will be used to control opacity of the particles 
    // as they move out each update cycle
    explosionOpacity = 255;

    // For loop to initialise the Particle PVector objects with the 
    // relative x and y coords
    for (int i = 0; i < explosionLoc.length; i++) {
      explosionLoc[i] = new PVector(originX + X[i], originY + Y[i]);
    }
  }

  /**************************************************************
   * Method: Explosion.display()
   * Parameters: None
   * Returns: Void
   * Desc: This method displays each of the particles for the 
   explosion, setting opacity beforehand
   ***************************************************************/
  void display() {

    if (currentCycle < explosionLimit) {
      noStroke();
      fill(160, explosionOpacity); 
      // Draw all particles in explosionLoc array
      for (int j = 0; j < explosionLoc.length; j++) {
        // Draw the particle
        ellipse(explosionLoc[j].x, explosionLoc[j].y, 3, 3);
      }
    }
  }

  /**************************************************************
   * Method: Explosion.update()
   * Parameters: None
   * Returns: Void
   * Desc: This method reduces opacity, and expands each of the 
   particle locations in explosionLoc based on their position in
   relation to the attributes 'originX' and 'originY'
   ***************************************************************/
  void update() {
    // Reduce Opacity
    explosionOpacity -= 25;

    // For each particle
    for (int k = 0; k < explosionLoc.length; k++) {
      // If particle is to the left of origin
      if (explosionLoc[k].x < originX) {
        explosionLoc[k].x += -5;
      }
      // If particle is to the right of origin
      else if (explosionLoc[k].x > originX) {
        explosionLoc[k].x += 5;
      }
      // If particle is below origin
      if (explosionLoc[k].y < originY) {
        explosionLoc[k].y += -5;
      } 
      // If particle is above origin
      else if (explosionLoc[k].y > originY) {
        explosionLoc[k].y += 5;
      }
    }
    // Update cycle counter
    currentCycle++;
  }
}
