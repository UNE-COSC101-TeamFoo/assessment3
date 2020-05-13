/**************************************************************
 * Class: Asteroid
 * Constructor: float(x), float (y), float (speed), float(size)
 * Returns: Void
 * Desc: Stores variables required to draw and move the asteroids
 ***************************************************************/
class Asteroid {
  //variables to store the numbers required to generate the asteroid shape
  float length1 = random (5, 45); // location of 1st indent on x axis
  float length2 = random (50, 95);// location of 2nd indent on x axis
  float length3 = random (50, 95);// location of 3rd indent on x axis
  float length4 = random (5, 45);// location of 4th indent on x axis
  float height1 = random (5, 20);// location of 1st indent on y axis
  float height2 = random (30, 45);// location of 2nd indent on y axis
  float height3 = random (30, 45);// location of 3rd indent on y axis
  float height4 = random (5, 20);// location of 4th indent on y axis
  float inner1 = random (30, 50);// depth of top x axis indent
  float inner2 = random (15, 20);// depth of right y axis indent
  float inner3 = random (30, 50);// depth of bottom x axis indent
  float inner4 = random (15, 20);// depth of left y axis indent

  //variables to store the position and movement
  float x, y; // the coordinates of the asteroid
  int xDirection; // what vertical direction its moving
  int yDirection;// what horizontal direction its moving
  float speed; //the speed of the movement
  int size;//the size of the asteroid (small, med, large)
  PVector location; // pvector storing location of asteroid


  // Contructor
  Asteroid(float x, float y, float speed, int size) {
    this.x = x;
    this.y = y;
    location = new PVector(x, y);

    this.speed = speed;
    this.size = size;
    
    // set a random direction for each asteroid generated
    xDirection = round(random(-3,3));
    yDirection = round(random(-3,3));
    
    // if the random direction works out to be 0 add 1
    // this prevents an asteroid from getting "stuck"
    if (xDirection == 0) {
      xDirection++;
    }
    if (yDirection == 0) {
      yDirection++;
    }
    
  }
  
 /**************************************************************
 * Function: Asteroid.update()
 * Parameters: none
 * Returns: Void
 * Desc: increment the x and y coordinates of the asteroid to 
 facilitate movement. Reset the asteroid to the opposite side of
 the playable area if it moves off the visible screen.
 ***************************************************************/

  void update() { 
    x = x + (speed * xDirection);
    y = y + (speed * yDirection);

    // check if asteroid is outside the screen boundary
    // if outside screen boundary, reset the coordinates
    if ((x <= 0) || (x > 800) || (y <= 0) || (y > 800)) {

      if (x <= 0) {
        x = 799;
      }
      if (y <= 0) {
        y = 799;
      }
      if (x > 800) {
        x = 1;
      }
      if (y > 800) {
        y = 1;
      }
    }
  }

 /**************************************************************
 * Function: Asteroid.display()
 * Parameters: None
 * Returns: Void
 * Desc: Function to show the asteroids on the screen.
 ***************************************************************/
  void display() {
    fill(255);
    drawAsteroid(size, x, y, length1, length2, length3, length4, height1, height2, height3, height4, inner1, inner2, inner3, inner4);
  }

  // EG
 /**************************************************************
 * Function: Asteroid.drawAsteroid()
 * Parameters: int(size), float(x), float(y), float(length1),
 float(length2), float(length3), float(length4), float(heigh1),
 float(height2), float(height3), float(height4), float(inner1),
 float(inner2), float (inner3), float(inner4)
 * Returns: Void
 * Desc: Function to generate the asteroids when being drawn
 based on the measurements randomized when the asteroids are first
 stored in the array.
 ***************************************************************/
  void drawAsteroid(int size, float x, float y, float length1, float length2, float length3, float length4, float height1, float height2, float height3, float height4, float inner1, float inner2, float inner3, float inner4) {
    if (size == 1) { // small asteroid
      // reduce all generated measurements by 1/3
      // this ensures the shaping scales properly
      length1 = length1/3;
      length2 = length2/3;
      length3 = length3/3;
      length4 = length4/3;
      height1 = height1/3;
      height2 = height2/3;
      height3 = height3/3;
      height4 = height4/3;
      inner1 = inner1/3;
      inner2 = inner2/3;
      inner3 = inner3/3;
      inner4 = inner4/3;

      // plot the shape
      stroke(153);
      noFill();
      beginShape();
      vertex(length1+x, 0+y);
      vertex(inner1+x, 3.3+y);
      vertex(length2+x, 0+y);
      vertex(33.3+x, height1+y);
      vertex(30+x, inner2+y);
      vertex(33.3+x, height2+y);
      vertex(length3+x, 16.6+y);
      vertex(inner3+x, 13.3+y);
      vertex(length4+x, 16.6+y);
      vertex(0+x, height3+y);
      vertex(3.3+x, inner4+y);
      vertex(0+x, height4+y);
      vertex(length1+x, 0+y);
      endShape();
    }

    else if (size == 2) { // medium asteroid
      // reduce all generated measurements by 1/2
      // this ensures the shaping scales properly
      
      length1 = length1/2;
      length2 = length2/2;
      length3 = length3/2;
      length4 = length4/2;
      height1 = height1/2;
      height2 = height2/2;
      height3 = height3/2;
      height4 = height4/2;
      inner1 = inner1/2;
      inner2 = inner2/2;
      inner3 = inner3/2;
      inner4 = inner4/2;
      
      // plot the shape
      stroke(153);
      noFill();
      beginShape();
      vertex(length1+x, 0+y);
      vertex(inner1+x, 5+y);
      vertex(length2+x, 0+y);
      vertex(50+x, height1+y);
      vertex(45+x, inner2+y);
      vertex(50+x, height2+y);
      vertex(length3+x, 25+y);
      vertex(inner3+x, 20+y);
      vertex(length4+x, 25+y);
      vertex(0+x, height3+y);
      vertex(5+x, inner4+y);
      vertex(0+x, height4+y);
      vertex(length1+x, 0+y);
      endShape();
    }

    else if (size == 3) { // large asteroid
      // plot the shape
      stroke(153);
      noFill();
      beginShape();
      vertex(length1+x, 0+y);
      vertex(inner1+x, 10+y);
      vertex(length2+x, 0+y);
      vertex(100+x, height1+y);
      vertex(90+x, inner2+y);
      vertex(100+x, height2+y);
      vertex(length3+x, 50+y);
      vertex(inner3+x, 40+y);
      vertex(length4+x, 50+y);
      vertex(0+x, height3+y);
      vertex(10+x, inner4+y);
      vertex(0+x, height4+y);
      vertex(length1+x, 0+y);
      endShape();
    }
    
    else {
      System.out.println("GHOST ASTEROID");
      // for error handling and debugging purposes
      // not required for gameplay
    }
 }
  
 /**************************************************************
 * Function: Asteroid.splitAsteroid()
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

    // check whether to add two smaller asteroids to array
    if (sizeTemp == 1) {
      // do nothing, can't split the smallest size
    }
  
    if (sizeTemp == 2) {
      for (int i = 0; i < 2; i++) { //loop through to make two asteroids
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(xpos, ypos, speedLevel, 1));  
        xpos = xpos + 20;// avoid overlapping 
        ypos = ypos + 20;
      }
    }

    if (sizeTemp == 3) {
      for (int i = 0; i < 2; i++) { //loop through to make two asteroids
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(xpos, ypos, speedLevel, 2));  
        xpos = xpos + 20; // avoid overlapping 
        ypos = ypos + 20;
      }
    }
  }
}
