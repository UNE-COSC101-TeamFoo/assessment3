/**************************************************************
* File: a3.pde
* Group: <Benjamin Nolan,Elsa Gaskell,Callum Sandercock>
* Date Commenced: 21/03/2020
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/

PShape ship; // don't have to use pshape - can use image
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums];
float speed = 0;
float maxSpeed = 4;
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
PVector direction;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score=0;
boolean alive=true;

//variables to store the numbers required to generate the asteroid shape
//note: once we generate multiple asteroids at the same time, will need a permanent way of storing the shape generated for each asteroid.
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
void setup(){
  size(800,800);
  //initialise pvtecotrs 
  //random astroid initial positions and directions;
  //initialise shapes if needed
  

}

/**************************************************************
* Function: myFunction()

* Parameters: None ( could be integer(x), integer(y) or String(myStr))

* Returns: Void ( again this could return a String or integer/float type )

* Desc: Each funciton should have appropriate documentation. 
        This is designed to benefit both the marker and your team mates.
        So it is better to keep it up to date, same with usage in the header comment

***************************************************************/

void moveShip(){
  
  //this function should update if keys are pressed down 
     // - this creates smooth movement
  //update rotation,speed and update current location
  //you should also check to make sure your ship is not outside of the window
  if(sUP){
  }
  if(sDOWN){
  
  }
  if(sRIGHT){
  }
  if(sLEFT){
  }
}
void drawShots(){
   //draw points for each shot from spacecraft 
   //at location and updated to new location
}

void drawAstroids(){
  //check to see if astroid is not already destroyed
  //otherwise draw at location 
  //initial direction and location should be randomised
  //also make sure the astroid has not moved outside of the window
    
}

void collisionDetection(){
  //check if shots have collided with astroids
  //check if ship as collided wiht astroids
}



void draw(){
  background(0);

  AlienShip(); // load AlienShip
  Projectile();
  explosion(300,300); 
 
 // Updated the Player Ship Design - by CS - 28/03/20
 drawPlyrShip(width/2,height/2); 
 
 
 drawSmallAsteroid();
 drawMediumAsteroid();
 drawLargeAsteroid();

  
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  drawShots();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
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
  if (key == ' ') {
    //fire a shot
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
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


void AlienShip(){
  //Alien Ship Design - by BN - 22/03/2020
  //float AlienShipxc = random(100,700); - random pos later
  float AlienShipxc = 100; // x co-ord
  float AlienShipyc = 100; // y co-ord

  float AlienShipxw = 50; // width
  float AlienShipyh = 25; // height
  ellipse(AlienShipxc,AlienShipyc,AlienShipxw,AlienShipyh); // object
  fill(153); // fill colour in object
  
  //smaller ellipse on Alien Ship (centred circle
  float AlienShipxc2 = 100; // x co-ord
  float AlienShipyc2 = 100; // y co-ord

  float AlienShipxw2 = 30; // width
  float AlienShipyh2 = 12.5; // height

  ellipse(AlienShipxc2,AlienShipyc2,AlienShipxw2,AlienShipyh2); // object
}

void Projectile(){
  float PointAx = 50;
  float PointAy = 50;
  stroke(255);
  line(PointAx,PointAy,50,60);
  noLoop();

}


// Created by CS on 28/03/20
// Function to draw the ship
// Unsure how to move this around/change direction
// Update shape to look more pointed
void drawPlyrShip(int x1, int y1) {
  // Work out the other points of the ship
  //These wont change as ship will not resize
  int x2 = x1 - 15;
  int y2 = y1 + 50;
  int x3 = x1;
  int y3 = y1 + 35;
  int x4 = x1 + 15;
  int y4 = y1 + 50;
  stroke(255);
  quad(x1, y1, x2, y2, x3, y3, x4, y4);
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

void drawLargeAsteroid() {
  // will need to add the start position to these values once that is known
  stroke(153);
  noFill();
  beginShape();
 //vertex(0, 0);//1
  vertex(length1, 0);//2
  vertex(inner1, 10);//3
  vertex(length2, 0);//4
 // vertex(100, 0);//5
  vertex(100, height1);//6
  vertex(90, inner2);//7
  vertex(100, height2);//8
  //vertex(100, 50);//9
  vertex(length3, 50);//10
  vertex(inner3, 40);//11
  vertex(length4, 50);//12
  //vertex(0, 50);//13
  vertex(0, height3);//14
  vertex(10, inner4);//15
  vertex(0, height4);//16
  vertex(length1, 0);
  endShape();
}

void drawMediumAsteroid() {
  // will need to add the start position to these values once that is known
  stroke(153);
  noFill();
  beginShape();
  vertex(length1/2, 0);//2
  vertex(inner1/2, 5);//3
  vertex(length2/2, 0);//4
  vertex(50, height1/2);//6
  vertex(45, inner2/2);//7
  vertex(50, height2/2);//8
  vertex(length3/2, 25);//10
  vertex(inner3/2, 20);//11
  vertex(length4/2, 25);//12
  vertex(0, height3/2);//14
  vertex(5, inner4/2);//15
  vertex(0, height4/2);//16
  vertex(length1/2, 0);
  endShape();
}

void drawSmallAsteroid() {
  // will need to add the start position to these values once that is known
  stroke(153);
  noFill();
  beginShape();
  vertex(length1/4, 0);//2
  vertex(inner1/4, 2.5);//3
  vertex(length2/4, 0);//4
  vertex(25, height1/4);//6
  vertex(22.5, inner2/4);//7
  vertex(25, height2/4);//8
  vertex(length3/4, 12.5);//10
  vertex(inner3/4, 10);//11
  vertex(length4/4, 12.5);//12
  vertex(0, height3/4);//14
  vertex(2.5, inner4/4);//15
  vertex(0, height4/4);//16
  vertex(length1/4, 0);
  endShape();
}
        
  
  
