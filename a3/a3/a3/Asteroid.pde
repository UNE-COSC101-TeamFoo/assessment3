class Asteroid {
  //variables to store the numbers required to generate the asteroid shape
  float length1 = random (5 , 45);
  float length2 = random (50 , 95);
  float length3 = random (50 , 95);
  float length4 = random (5 , 45);
  float height1 = random (5 , 20);
  float height2 = random (30 , 45);
  float height3 = random (30 , 45);
  float height4 = random (5 , 20);
  float inner1 = random (30, 50);
  float inner2 = random (15, 20);
  float inner3 = random (30, 50);
  float inner4 = random (15, 20);
  
  // only needed for testing
  int selfDestruct = round(random(10000, 50000));
  
  //variables to store the position and movement
  float x, y;
  int xDirection;
  int yDirection;
  float speed; 
  int size;
  
  //-------------
  // BN - testing for ColDect
  PVector location;
  //For Col.Dect
  float w = 10;
  float h = 10;
  //-------------
  
  // Contructor
  Asteroid(float xTemp, float yTemp, float speedTemp, int xDirectionTemp, int yDirectionTemp, int sizeTemp) {
    x = xTemp;
    y = yTemp;
    
    location = new PVector(x,y);
    
    speed = speedTemp;
    xDirection = xDirectionTemp;
    yDirection = yDirectionTemp;
    size = sizeTemp;
  }
  
  void update() { 
    // function to update the asteroid class values. May need to be renamed if there is a conflict between function names with other branches.
    //detect collision (call function and use the boolean value)
        // if detect collision = true
        // call splitAsteroid (size, x, y)
        
    if (selfDestruct < millis())
    {
      splitAsteroid(size, x, y);
    }
    
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
      drawLargeAsteroid(size, x, y, length1, length2, length3, length4, height1, height2, height3, height4, inner1, inner2, inner3, inner4);
    }

  // function to increment score (passed type of object) 
  // determine type of object and update score number by that many points
}
