class Asteroid {
  //variables to store the numbers required to generate the asteroid shape
  float length1 = random (5, 45);
  float length2 = random (50, 95);
  float length3 = random (50, 95);
  float length4 = random (5, 45);
  float height1 = random (5, 20);
  float height2 = random (30, 45);
  float height3 = random (30, 45);
  float height4 = random (5, 20);
  float inner1 = random (30, 50);
  float inner2 = random (15, 20);
  float inner3 = random (30, 50);
  float inner4 = random (15, 20);

  //variables to store the position and movement
  float x, y;
  int xDirection;
  int yDirection;
  float speed; 
  int size;
  PVector location;


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
    
    if (xDirection == 0) {
      xDirection++;
    }
    if (yDirection == 0) {
      yDirection++;
    }
    
   // set a random direction for each asteroid generated
    //if (random (100) > 50) {
    //  xDirection = 1;
    //} else {
    //  xDirection = -1;
    //}

    //if (random(100) > 50) {
    //  yDirection = 1;
    //} else {
    //  yDirection = -1;
    //}
  }

  void update() { 
    // function to update the asteroid class values. May need to be renamed if there is a conflict between function names with other branches.
    //detect collision (call function and use the boolean value)
    // if detect collision = true
    // call splitAsteroid (size, x, y)

    x = x + (speed * xDirection);
    y = y + (speed * yDirection);

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

  // Custom method for drawing the object
  void display() {
    fill(255);
    drawAsteroid(size, x, y, length1, length2, length3, length4, height1, height2, height3, height4, inner1, inner2, inner3, inner4);
  }

  // function to increment score (passed type of object) 
  // determine type of object and update score number by that many points

  // EG
  void drawAsteroid(int size, float x, float y, float length1, float length2, float length3, float length4, float height1, float height2, float height3, float height4, float inner1, float inner2, float inner3, float inner4) {
    if (size == 1) { // small asteroid
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
    }
  }
  void splitAsteroid() {
    calculateScore(this);
    float xposTemp = this.x;
    float yposTemp = this.y;
    int sizeTemp = this.size;

    //add two smaller asteroids to array
    if (sizeTemp == 1) {
      // do nothing, can't split the smallest size
    }

    if (sizeTemp == 2) {
      for (int i = 0; i < 2; i++) {
        float xpos = xposTemp + random (-10, 10);
        float ypos = yposTemp + random (-10, 10);
        asteroids.add(new Asteroid(xpos, ypos, speedLevel, 1));  
        xpos = xpos + 20;
        ypos = ypos + 20;
      }
    }

    if (sizeTemp == 3) {
      for (int i = 0; i < 2; i++) {
        float xpos = xposTemp + random (0, 20);
        float ypos = yposTemp + random (0, 20);
        asteroids.add(new Asteroid(xpos, ypos, speedLevel, 2));  
        xpos = xpos + 20;
        ypos = ypos + 20;
      }
    }
  }
}
