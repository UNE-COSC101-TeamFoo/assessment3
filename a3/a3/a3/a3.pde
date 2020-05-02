/**************************************************************
* File: a3.pde
* Last modified: 02/05/2020 - BN
* Group: <Benjamin Nolan,Elsa Gaskell,Callum Sandercock>
* Date Commenced: 21/03/2020
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/


playerShip player; // CS
Asteroid Asteroid; // EG
Bullet Bullet; // BN
AlienShip AlienShip; // BN

ArrayList <Bullet> bullets; // BN
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>(); // EG

// Asteroids global vars - EG
//variables to store the numbers required to generate the asteroid shape
//note: once we generate multiple asteroids at the same time, will need a permanent way of storing the shape generated for each asteroid.
float length1 = random (5 , 45);
float length2 = random (50 , 95);
float length3 = random (50 , 95);
float length4 = random (5 , 45);
float height1 = random (5 , 20);
float height2 = random  (30 , 45);
float height3 = random (30 , 45);
float height4 = random (5 , 20);
float inner1 = random (30, 50);
float inner2 = random (15, 20);
float inner3 = random (30, 50);
float inner4 = random (15, 20);


int level = 1; // the difficulty level
int asteroidCount = 10*level;  // number of asteroids to be generated
int asteroidArrayPosition = 0;
int score = 0;
float radians=radians(270); //if your ship is facing up (like in atari game)
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
boolean alive=true;
float bgColor = 0;

// will any of these below be used? BN - 02/05/2020
//------------
//PVector[] astroids = new PVector[astroNums];
//PVector[] astroDirect = new PVector[astroNums];
//int astroNums=20;
//float speed = 0;
//float maxSpeed = 4;
//PVector shipCoord;
//PVector direction;
//ArrayList shots= new ArrayList();
//ArrayList sDirections= new ArrayList();
//int score=0;
//------------

//AlienShip global vars - BN  
float AlienShipxc, AlienShipyc; // AlienShip Coords   
float AlienShipxc2, AlienShipyc2; // AlienShip Coords 
float AlienShipSpeed = 2; // AlienShip Speed
float AlienShipxDir = 1; // x Direction of AlienShip to travel
float AlienShipyDir = 1; // y Direction of AlienShip to travel    

void setup() {
  
  size(800,800);
  background(bgColor);

  //playership class - CS
  player = new playerShip(); //Player class file: playerShip.pde - located in root folder of this main file  

  // Projectile array - BN
  bullets = new ArrayList<Bullet>();
  Bullet = new Bullet();  
  
  //AlienShip - BN
  AlienShip = new AlienShip();
  AlienShipxc = random(-10,width-10); // random pos - x co-ord
  AlienShipyc = random(-height-10); // random pos - y co-ord
  AlienShipxc2 = AlienShipxc; // pos x of Part A of Ship
  AlienShipyc2 = AlienShipyc; // pos y of Part A of Ship
  
  //Asteroids - EG
  int openArrayPos = asteroids.size();
  if (openArrayPos <= 0) {
    for (int i = 0; i < asteroidCount; i++) {
        int xDirection;
        int yDirection;
       
       // set a random direction for each asteroid generated
        if(random (100) > 50){
           xDirection = 1; 
        }
        else {
          xDirection = -1;
        }
        
        if(random(100) > 50){
           yDirection = 1;
        }
        else {
          yDirection = -1;
        }
        
        //asteroids[index++] = new Asteroid(random(75, 725), random(75, 725), random(3, 5), xDirection, yDirection); //x axis, y axis, speed, xdirection, ydirection
        asteroids.add(new Asteroid(random(75, 725), random(75, 725), random(1, 3), xDirection, yDirection, round(random(3))));
    }
  }
  
}

// do we need this below? BN - 02/05/2020
/**************************************************************
* Function: myFunction()
* Parameters: None ( could be integer(x), integer(y) or String(myStr))
* Returns: Void ( again this could return a String or integer/float type )
* Desc: Each funciton should have appropriate documentation. 
        This is designed to benefit both the marker and your team mates.
        So it is better to keep it up to date, same with usage in the header comment
***************************************************************/


void draw(){
  
  background(0);
  
  //explosion(300,300);
    
  // should be loaded upon each new level? - BN - 26/04/2020
  AlienShip.AlienShipApproach(); // - BN
  
  // Update Player location and draw - CS
  moveShip();
  player.update();// - CS
  player.render();// - CS

  //Projectiles - BN
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();
    bullet.display();
  }

  //drawSmallAsteroid();// - EG
  //drawMediumAsteroid();// - EG
  //drawLargeAsteroid();// - EG
  for (int i = 0; i < asteroids.size(); i++) {
    asteroidArrayPosition = 0; // need to reset or it keeps incrementing
    Asteroid roids = asteroids.get(i);
    roids.update();
    roids.display();
    asteroidArrayPosition++;
  }  
  
  //might be worth checking to see if you are still alive first
  
  //Collision Detection - BN

  //PlayerShip and AlienShip
  if(collisionDetection(player, AlienShip)){
  fill(255, 0, 0, 100);
  rect(0, 0, width, height);
  }

  //Projectile and AlienShip
  if(collisionDetection(Bullet, AlienShip)){
  fill(255, 0, 0, 100);
  rect(0, 0, width, height);
  }  

  //PlayerShip and Asteroid
  //if(collisionDetection(player, Asteroid)){
  //fill(255, 0, 0, 100);
  //rect(0, 0, width, height);
  //}  
  
  // report if game over or won
  
  // draw score
      
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=true;
    }
    if (keyCode == DOWN) {
      sDOWN=true;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (keyCode == 32) {
    // Projectiles - BN
    bullets.add( new Bullet());
  }
  
}
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
      player.slow();
    }
    if (keyCode == DOWN) {
      sDOWN=false;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  } 
}

//void addScore(){
// score++; 
//}
//void removeLife(){
// lives--; 
//}

void moveShip(){
  if(sUP){
    player.accel();// - CS
  }
  if(sDOWN){}
  if(sRIGHT){
    player.rotateRight();// - CS
  }
  if(sLEFT){
    player.rotateLeft();// - CS
  }
}

// Created by CS on 29/03/20
// Function to animate and draw the explosions
// Only parameters needed are the origin x and y location of the explosion

void explosion(int originX, int originY) {
  
  //Create array for PVectors to be intialized into
  PVector explosionLoc[] = new PVector[11];
  
  
  // Array for the relative positions of the singular explosion particles
  // in relation to the origin x and y locations
  int explosionX[] = {-50,-45,-35,-20,-10,0,15,20,35,40,50};
  int explosionY[] = {0,-20,45,10,40,-30,50,-15,-60,0,10};
  
  // This variable will be used to lighten the particles as the move out 
  // (Might use transparency instead of plain colour)
  int explosionOpacity = 255;
  
  // For loop to initialise the Particle PVector objects with the 
  // relative x and y coords
  for (int i = 0; i < explosionLoc.length; i++) {
    
    explosionLoc[i] = new PVector(originX + explosionX[i], originY + explosionY[i]);
  }
  
  //Dont want outlines for the particles
  noStroke();
  
  
  /* Below is a two loop structure - this is necessary to draw each particle and 
    to make sure each particle is drawn 10 times with reducing opacity */
  for (int j = 0; j < explosionLoc.length; j++) {
    fill(160, explosionOpacity);
    explosionOpacity -= 25;
    
    // This is the loop to draw each particle, and increment the particle's
    // PVector x and y coords so that it expands
    for (int k = 0; k < explosionLoc.length; k++) {
      rect(explosionLoc[k].x, explosionLoc[k].y, 5, 5);
      
      // Conditional increment depending on relative pos to origin
      // AKA expanding
      
      if (explosionLoc[k].x < originX) {
        explosionLoc[k].x -= 5;
      }
      else if (explosionLoc[k].x > originX) {
        explosionLoc[k].x += 5;
      }
      if (explosionLoc[k].y < originY) {
        explosionLoc[k].y -= 5;
      }
      else if (explosionLoc[k].y > originY) {
        explosionLoc[k].y += 5;
      }
    }
  }
}

// EG
void drawLargeAsteroid(int size, float x, float y, float length1, float length2, float length3, float length4, float height1, float height2, float height3, float height4, float inner1, float inner2, float inner3, float inner4) {
  if (size == 1) { // small asteroid
  length1 = length1/4;
  length2 = length2/4;
  length3 = length3/4;
  length4 = length4/4;
  height1 = height1/4;
  height2 = height2/4;
  height3 = height3/4;
  height4 = height4/4;
  inner1 = inner1/4;
  inner2 = inner2/4;
  inner3 = inner3/4;
  inner4 = inner4/4;

  stroke(153);
  noFill();
  beginShape();
  vertex(length1+x, 0+y);
  vertex(inner1+x, 2.5+y);
  vertex(length2+x, 0+y);
  vertex(25+x, height1+y);
  vertex(22.5+x, inner2+y);
  vertex(25+x, height2+y);
  vertex(length3+x, 12.5+y);
  vertex(inner3+x, 10+y);
  vertex(length4+x, 12.5+y);
  vertex(0+x, height3+y);
  vertex(2.5+x, inner4+y);
  vertex(0+x, height4+y);
  vertex(length1+x, 0+y);
  endShape();
  }
  
  if (size == 2) { // medium asteroid
  
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
  
  if (size == 3) { // large asteroid
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
}

void splitAsteroid(int currentSize, float xposTemp, float yposTemp) {
  // delete asteroid from array
  calculateScore(currentSize, "asteroid");
  
  int xDirection;
  int yDirection;
 
 // set a random direction for each asteroid generated
  if(random (100) > 50){
     xDirection = 1; 
  }
  else {
    xDirection = -1;
  }
  
  if(random(100) > 50){
     yDirection = 1;
  }
  else {
    yDirection = -1;
      }
        
  //add two smaller asteroids to array
  if (currentSize == 1) {
    // do nothing, can't split the smallest size
  }
  
  if (currentSize == 2) {
    for (int i = 0; i < 2; i++) {
      float xpos = xposTemp + random (-10, 10);
      float ypos = yposTemp + random (-10, 10);
      asteroids.add(new Asteroid(xpos, ypos, random(1, 3), xDirection, yDirection, 1));  
      xpos = xpos + 20;
      ypos = ypos + 20;
    }
  }
  
  if (currentSize == 3) {
    for (int i = 0; i < 2; i++) {
      float xpos = xposTemp + random (0, 20);
      float ypos = yposTemp + random (0, 20);
      asteroids.add(new Asteroid(xpos, ypos, random(1, 3), xDirection, yDirection, 2));  
      xpos = xpos + 20;
      ypos = ypos + 20;
    }
  }
  
  asteroids.remove(asteroidArrayPosition);
}

void calculateScore (int currentSize, String type) {
  if (type == "asteroid") {
    if (currentSize == 1) {
      score = score + 100;
    }
    if (currentSize == 2) {
      score = score + 200;
    }
    if (currentSize == 3) {
      score = score + 300;
    }
    
    System.out.println(score);
  }
}

//void drawLargeAsteroid() {
//  // will need to add the start position to these values once that is known
//  stroke(153);
//  noFill();
//  beginShape();
// //vertex(0, 0);//1
//  vertex(length1, 0);//2
//  vertex(inner1, 10);//3
//  vertex(length2, 0);//4
// // vertex(100, 0);//5
//  vertex(100, height1);//6
//  vertex(90, inner2);//7
//  vertex(100, height2);//8
//  //vertex(100, 50);//9
//  vertex(length3, 50);//10
//  vertex(inner3, 40);//11
//  vertex(length4, 50);//12
//  //vertex(0, 50);//13
//  vertex(0, height3);//14
//  vertex(10, inner4);//15
//  vertex(0, height4);//16
//  vertex(length1, 0);
//  endShape();
//}

//// EG
//void drawMediumAsteroid() {
//  // will need to add the start position to these values once that is known
//  stroke(153);
//  noFill();
//  beginShape();
//  vertex(length1/2, 0);//2
//  vertex(inner1/2, 5);//3
//  vertex(length2/2, 0);//4
//  vertex(50, height1/2);//6
//  vertex(45, inner2/2);//7
//  vertex(50, height2/2);//8
//  vertex(length3/2, 25);//10
//  vertex(inner3/2, 20);//11
//  vertex(length4/2, 25);//12
//  vertex(0, height3/2);//14
//  vertex(5, inner4/2);//15
//  vertex(0, height4/2);//16
//  vertex(length1/2, 0);
//  endShape();
//}

//// EG
//void drawSmallAsteroid() {
//  // will need to add the start position to these values once that is known
//  stroke(153);
//  noFill();
//  beginShape();
//  vertex(length1/4, 0);//2
//  vertex(inner1/4, 2.5);//3
//  vertex(length2/4, 0);//4
//  vertex(25, height1/4);//6
//  vertex(22.5, inner2/4);//7
//  vertex(25, height2/4);//8
//  vertex(length3/4, 12.5);//10
//  vertex(inner3/4, 10);//11
//  vertex(length4/4, 12.5);//12
//  vertex(0, height3/4);//14
//  vertex(2.5, inner4/4);//15
//  vertex(0, height4/4);//16
//  vertex(length1/4, 0);
//  endShape();
//}

//Collision Detection - BN

//PlayerShip and AlienShip
boolean collisionDetection(playerShip r1, AlienShip r2){
 float distanceX = (r1.location.x + r1.w) - (r2.x + r2.w);
 float distanceY = (r1.location.y + r1.h) - (r2.y + r2.h);
 float combinedHalfW = r1.w + r2.w;
 float combinedHalfH = r1.h + r2.h;
 if(abs(distanceX) < combinedHalfW){
   if(abs(distanceY) < combinedHalfH){
    return true; 
   }
 }
 return false;
}

//PlayerShip and Asteroids
boolean collisionDetection(playerShip r1, Asteroid r2) {
 float distanceX = (r1.location.x + r1.w) - (r2.x + r2.w);
 float distanceY = (r1.location.y + r1.h) - (r2.y + r2.h);
 float combinedHalfW = r1.w + r2.w;
 float combinedHalfH = r1.h + r2.h;
 if(abs(distanceX) < combinedHalfW){
   if(abs(distanceY) < combinedHalfH){
    return true; 
   }
 }
 
 //testing using dist as dist needs floats, does not use PVector
 //asteroids are currently not PVector

 //float fr1x,fr1y,fr2x,fr2y;
 //fr1x = r1.location.x;
 //fr1y = r1.location.y;
 //fr2x = r2.x;
 //fr2y = r2.y;
 //if(dist(fr1x,fr1y,fr2x,fr2y) < 10){
 //float distanceX = (fr1x + r1.w) - (r2.x + r2.w);
 //float distanceY = (fr1y + r1.h) - (r2.y + r2.h);
 //  if(abs(distanceX) < (distanceY)){
 //  return true;
 //}
 return false;
}

//Projectile and AlienShip
boolean collisionDetection(Bullet r1, AlienShip r2) {
 float distanceX = (r1.location.x + r1.w) - (r2.x + r2.w);
 float distanceY = (r1.location.y + r1.h) - (r2.y + r2.h);
 float combinedHalfW = r1.w + r2.w;
 float combinedHalfH = r1.h + r2.h;
 if(abs(distanceX) < combinedHalfW){
   if(abs(distanceY) < combinedHalfH){
    return true; 
   }
 }
 return false;
}

//EOF
