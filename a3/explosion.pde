// Created by CS on 29/03/20
// Function to animate and draw the explosions
// Only parameters needed are the origin x and y location of the explosion
class explosion {
  
  int explosionOpacity;
  PVector explosionLoc[];
  int currentCycle = 0;
  int explosionLimit = 11;
  float originX,originY;
  
  explosion(float a, float b) {
    originX = a;
    originY = b;
  
    //Create array for PVectors to be intialized into
    explosionLoc = new PVector[explosionLimit];
  
    // Array for the relative positions of the singular explosion particles
    // in relation to the origin x and y locations
    int X[] = {-25,-22,-19,-10,-5,0,8,10,18,20,25};
    int Y[] = {0,-10,23,5,20,-15,25,-7,-30,0,5};
  
    // This variable will be used to lighten the particles as the move out 
    // (Might use transparency instead of plain colour)
    explosionOpacity = 255;
  
    // For loop to initialise the Particle PVector objects with the 
    // relative x and y coords
    for (int i = 0; i < explosionLoc.length; i++) {
    
      explosionLoc[i] = new PVector(originX + X[i], originY + Y[i]);
    }
  }
  
  void display() {
    if (currentCycle < explosionLimit) {
      noStroke();
      fill(160, explosionOpacity); 
      for (int j = 0; j < explosionLoc.length; j++) {
        ellipse(explosionLoc[j].x, explosionLoc[j].y, 3, 3);
      }
    }
 }
 
  void update() {
    explosionOpacity -= 25;

    for (int k = 0; k < explosionLoc.length; k++) {

      if (explosionLoc[k].x < originX) {
        explosionLoc[k].x += -5;
      }
      else if (explosionLoc[k].x > originX) {
        explosionLoc[k].x += 5;
      }
      if (explosionLoc[k].y < originY) {
        explosionLoc[k].y += -5;

      }
      else if (explosionLoc[k].y > originY) {
        explosionLoc[k].y += 5;
      }  
    }
    currentCycle++;
  }
}
