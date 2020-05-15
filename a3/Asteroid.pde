/**************************************************************
 * Class: Asteroid
 * Constructor: float(speed), float(size)
 * Desc: This class generates and stores attributes and methods
 required to update, display and split Asteroids
 ***************************************************************/
class Asteroid {
  // Variables to store the numbers required to generate the 
  // asteroid shape
  float length1, length2, length3, length4;
  float height1, height2, height3, height4;
  float inner1, inner2, inner3, inner4;

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

    // Set random measurements for asteroid construction
    length1 = random (5, 45);  // Location of 1st indent on x axis
    length2 = random (50, 95); // Location of 2nd indent on x axis
    length3 = random (50, 95); // Location of 3rd indent on x axis
    length4 = random (5, 45);  // Location of 4th indent on x axis
    height1 = random (5, 20);  // Location of 1st indent on y axis
    height2 = random (30, 45); // Location of 2nd indent on y axis
    height3 = random (30, 45); // Location of 3rd indent on y axis
    height4 = random (5, 20);  // Location of 4th indent on y axis
    inner1 = random (30, 50);  // Depth of top x axis indent
    inner2 = random (15, 20);  // Depth of right y axis indent
    inner3 = random (30, 50);  // Depth of bottom x axis indent
    inner4 = random (15, 20);  // Depth of left y axis indent

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
        x = width;
      }
      if (y <= 0) {
        y = height;
      }
      if (x > width) {
        x = 0;
      }
      if (y > height) {
        y = 0;
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
    // Scale measurements to size
    float l1 = length1/(4-size);
    float l2 = length2/(4-size);
    float l3 = length3/(4-size);
    float l4 = length4/(4-size);
    float h1 = height1/(4-size);
    float h2 = height2/(4-size);
    float h3 = height3/(4-size);
    float h4 = height4/(4-size);
    float i1 = inner1/(4-size);
    float i2 = inner2/(4-size);
    float i3 = inner3/(4-size);
    float i4 = inner4/(4-size);


    // Set the outline to white and noFill
    stroke(153);
    noFill();

    if (size == 1) { // small asteroid
      // plot the shape
      beginShape();
      vertex(l1+x, y);
      vertex(i1+x, 3.3+y);
      vertex(l2+x, 0+y);
      vertex(33.3+x, h1+y);
      vertex(30+x, i2+y);
      vertex(33.3+x, h2+y);
      vertex(l3+x, 16.6+y);
      vertex(i3+x, 13.3+y);
      vertex(l4+x, 16.6+y);
      vertex(x, h3+y);
      vertex(3.3+x, i4+y);
      vertex(x, h4+y);
      vertex(l1+x, y);
      endShape();
    } else if (size == 2) { // medium asteroid
      // plot the shape
      beginShape();
      vertex(l1+x, y);
      vertex(i1+x, 5+y);
      vertex(l2+x, y);
      vertex(50+x, h1+y);
      vertex(45+x, i2+y);
      vertex(50+x, h2+y);
      vertex(l3+x, 25+y);
      vertex(i3+x, 20+y);
      vertex(l4+x, 25+y);
      vertex(x, h3+y);
      vertex(5+x, i4+y);
      vertex(x, h4+y);
      vertex(l1+x, y);
      endShape();
    } else if (size == 3) { // large asteroid
      // plot the shape
      beginShape();
      vertex(l1+x, y);
      vertex(i1+x, 10+y);
      vertex(l2+x, y);
      vertex(100+x, h1+y);
      vertex(90+x, i2+y);
      vertex(100+x, h2+y);
      vertex(l3+x, 50+y);
      vertex(i3+x, 40+y);
      vertex(l4+x, 50+y);
      vertex(x, h3+y);
      vertex(10+x, i4+y);
      vertex(x, h4+y);
      vertex(l1+x, y);
      endShape();
    } else {
      System.out.println("GHOST ASTEROID");
      // for error handling and debugging purposes
      // not required for gameplay
    }
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
    if (sizeTemp == 1) {
      // do nothing, can't split the smallest size
    }

    if (sizeTemp == 2) {
      for (int i = 0; i < 2; i++) { //loop through to make two asteroids
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(speedLevel, 1));
        Asteroid newRoid = asteroids.get(asteroids.size()-1);
        newRoid.x = xpos + overlapBuf;// avoid overlapping 
        newRoid.y = ypos + overlapBuf;
      }
    }

    if (sizeTemp == 3) {
      for (int i = 0; i < 2; i++) { //loop through to make two asteroids
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(speedLevel, 2)); 
        Asteroid newRoid = asteroids.get(asteroids.size()-1);
        newRoid.x = xpos + overlapBuf; // avoid overlapping 
        newRoid.y = ypos + overlapBuf;
      }
    }
  }
}
