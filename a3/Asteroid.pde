/**************************************************************
 * Class: Asteroid
 * Constructor: float(speed), float(size)
 * Desc: This class generates and stores attributes and methods
 required to update, display and split Asteroids
 ***************************************************************/

class Asteroid {
  // Arrays to store the measurements required to generate the 
  // asteroid shape
  float[] lengthMeasurement; //array of random verticies on the x axis
  float[] heightMeasurement; //array of random verticies on the y axis
  float[] innerMeasurement; //array of random verticies on the interior
  float[] standardMeasurement; //array of verticies that don't change


  // Variables to store the position and movement
  float x, y;                 // Coordinates of the asteroid
  int xDirection, yDirection; // Horizontal and vertical direction of motion
  float speed;                // Speed of the movement
  int size;                   //Size of the asteroid (small, med, large)
  PVector location;           // PVector storing location of asteroid



  // Contructor
  Asteroid(float speed, int size) {
    x = random(75, 725); // Randomize start x co-ord
    y = random(75, 725); // Randomize start y co-ord
    location = new PVector(x, y);
    this.speed = speed;
    this.size = size;

    // random numbers indicating the location of the indents on the x axis
    lengthMeasurement = new float[] {random (5, 45), random (50, 95), 
      random (50, 95), random (5, 45)};

    // random numbers indicating the location of the indents on the y axis
    heightMeasurement = new float[] {random (5, 20), random (30, 45), 
      random (30, 45), random (5, 20)};

    // random numbers indicating the angle the indents will form 
    innerMeasurement = new float[] {random (30, 50), random (15, 20), 
      random (30, 50), random (15, 20)};

    // standard measurements for the specific size asteroid
    standardMeasurement = new float[] {10, 100, 90, 50, 40};

    // Create an 2D array for the measurement arrays
    float[][] measurements = {lengthMeasurement, heightMeasurement, 
      innerMeasurement, standardMeasurement};

    // Using a two loop structure iterate through all measurements
    // and scaling them to the asteroid size
    for (int i = 0; i < measurements.length; i++) {
      for (int m = 0; m < measurements[i].length; m++) {
        // Divided by 4 - size to give appropriate length
        measurements[i][m] /= 4 - size;
      }
    }

    // Set a random direction for each asteroid generated
    xDirection = round(random(-3, 3));
    yDirection = round(random(-3, 3));

    // If the random direction works out to be 0 add 1
    // this prevents an asteroid from getting "stuck"
    if (xDirection == 0) {
      xDirection++;
    }
    if (yDirection == 0) {
      yDirection++;
    }
  }

  /**************************************************************
   * Method: Asteroid.update()
   * Parameters: none
   * Returns: Void
   * Desc: Increment the x and y coordinates of the asteroid to 
   facilitate movement. Reset the asteroid to the opposite side of
   the playable area if it moves off the visible screen.
   ***************************************************************/
  void update() { 
    x += (speed * xDirection);
    y += (speed * yDirection);

    // check if asteroid is outside the screen boundary
    // if outside screen boundary, reset the coordinates
    if ((x <= 0) || (x > width) || (y <= 0) || (y > height)) {

      if (x <= 0) {
        x = width; // move asteroid to far right of screen
      }
      if (y <= 0) {
        y = height; // move asteroid to bottom of screen
      }
      if (x > width) {
        x = 0; // move asteroid to far left of screen
      }
      if (y > height) {
        y = 0; // move asteroid to top of screen
      }
    }
  }

  /**************************************************************
   * Method: Asteroid.display()
   * Parameters: none
   * Returns: Void
   * Desc: Function to generate the asteroids when being drawn
   based on the measurements randomized when the asteroids are first
   stored in the array.
   ***************************************************************/
  void display() {
    // draw the shape using the generated measurements
    stroke(153); // set line color to grey
    noFill(); // do not fill in shape
    beginShape();
    vertex(lengthMeasurement[0]+x, y);
    vertex(innerMeasurement[0]+x, standardMeasurement[0]+y);
    vertex(lengthMeasurement[1]+x, y);
    vertex(standardMeasurement[1]+x, heightMeasurement[0]+y);
    vertex(standardMeasurement[2]+x, innerMeasurement[1]+y);
    vertex(standardMeasurement[1]+x, heightMeasurement[1]+y);
    vertex(lengthMeasurement[2]+x, standardMeasurement[3]+y);
    vertex(innerMeasurement[2]+x, standardMeasurement[4]+y);
    vertex(lengthMeasurement[3]+x, standardMeasurement[3]+y);
    vertex(x, heightMeasurement[2]+y);
    vertex(standardMeasurement[0]+x, innerMeasurement[3]+y);
    vertex(x, heightMeasurement[3]+y);
    vertex(lengthMeasurement[0]+x, y);
    endShape();
  }

  /**************************************************************
   * Method: Asteroid.splitAsteroid()
   * Parameters: None
   * Returns: Void
   * Desc: When called, splits the asteroid in question into two smaller
   asteroids (if possible)
   ***************************************************************/
  void splitAsteroid() {
    calculateScore(this);// calculates the score earned by destroying it
    float xposTemp = this.x;// sets coordinates of current asteroid
    float yposTemp = this.y;// sets coordinates of current asteroid
    int sizeTemp = this.size;// sets size of current asteroid
    int overlapBuf = 20;

    // check whether to add two smaller asteroids to array
    // If size is one - it cannot be split
    if (sizeTemp > 1) {
      for (int i = 0; i < 2; i++) { //loop through to make two asteroids
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(speedLevel, size - 1));
        Asteroid newRoid = asteroids.get(asteroids.size()-1);
        newRoid.x = xpos + overlapBuf;// avoid overlapping 
        newRoid.y = ypos + overlapBuf;
      }
    }
  }
}
