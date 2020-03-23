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

void AlienShip(){
  //Alien Ship Design - by BN - 22/03/2020
  //float AlienShipxc = random(100,700); - random pos later
  float AlienShipxc = 100; // x co-ord
  float AlienShipyc = 100; // y co-ord
  float AlienShipxw = 100; // width
  float AlienShipyh = 50; // height
  ellipse(AlienShipxc,AlienShipyc,AlienShipxw,AlienShipyh); // objec
  fill(153); // fill colour in object
  
  //smaller ellipse on Alien Ship (centred circle
  float AlienShipxc2 = 100; // x co-ord
  float AlienShipyc2 = 100; // y co-ord
  float AlienShipxw2 = 60; // width
  float AlienShipyh2 = 25; // height
  ellipse(AlienShipxc2,AlienShipyc2,AlienShipxw2,AlienShipyh2); // object
}

void Projectile(){
  float PointAx = 50;
  float PointAy = 50;
  stroke(255);
  strokeWeight(5);
  line(PointAx,PointAy,50,60);
}

void draw(){
  background(0);

  AlienShip(); // load AlienShip
  Projectile();

  //Player ship design - by BN - 22/03/2020
  //float PlayerShipx1 = 350; // first point x
  //float PlayerShipy1 = 750; // first point y
  //float PlayerShipx2 = 400; // second point x
  //float PlayerShipy2 = 700; // second point y
  //float PlayerShipx3 = 450; // second point x
  //float PlayerShipy3 = 750; // second point y
  //stroke(255); // colour of object
  //triangle(PlayerShipx1,PlayerShipy1,PlayerShipx2,PlayerShipy2,PlayerShipx3,PlayerShipy3); // object
  
  
  
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
