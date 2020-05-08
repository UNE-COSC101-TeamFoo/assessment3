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

ArrayList <explosion> explosions = new ArrayList<explosion>();
ArrayList <Bullet> bullets = new ArrayList<Bullet>(); // BN
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>(); // EG


int level = 1; // the difficulty level
int asteroidCount = 10*level;  // number of asteroids to be generated
int asteroidArrayPosition = 0;
int score = 0;
float radians=radians(270); //if your ship is facing up (like in atari game)
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
boolean alive=true;
float bgColor = 0;

  

void setup() {
  
  size(800,800);
  background(bgColor);

  //playership class - CS
  player = new playerShip(); //Player class file: playerShip.pde - located in root folder of this main file  
  //AlienShip - BN
  AlienShip = new AlienShip();
  
  //Asteroids - EG
  int openArrayPos = asteroids.size();
  if (openArrayPos <= 0) {
    for (int i = 0; i < asteroidCount; i++) {
      
        //asteroids[index++] = new Asteroid(random(75, 725), random(75, 725), random(3, 5), xDirection, yDirection); //x axis, y axis, speed, xdirection, ydirection
        asteroids.add(new Asteroid(random(75, 725), random(75, 725), random(1, 3), round(random(3))));
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

  AlienShip.display();
  if(second() % 20 == 0 && !AlienShip.active) {
    AlienShip.active = true; 
  }
  println(AlienShip.active);
  AlienShip.AlienShipApproach(); // - BN
  
  // Update Player location and draw - CS
  moveShip();
  player.update();// - CS
  player.render();// - CS
  player.displayLives();
  
  displayScore();
  
  

  //Projectiles - BN
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();
    bullet.display();
    if (collisionDetection(bullet)) {
      bullets.remove(bullet);
    }
  }

  for (int i = 0; i < asteroids.size(); i++) {
    asteroidArrayPosition = 0; // need to reset or it keeps incrementing
    Asteroid roids = asteroids.get(i);
    roids.update();
    roids.display();
    asteroidArrayPosition++;
  }  
  
  for (int p = 0; p < explosions.size(); p++) {
    if(explosions.size()>0) {
      explosion explode = explosions.get(p);
      if (explode.currentCycle >= explode.explosionLimit) {
        explosions.remove(p);
      } else {
        explode.display();
        if(frameCount%5==0) {
          explode.update();
        }
        
      }
    }  
  }
  
  //Collision Detection - BN

  //PlayerShip and AlienShip
  if(collisionDetection(player, AlienShip)){
  fill(255, 0, 0, 100);
  rect(0, 0, width, height);
  }
      
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
    bullets.add( new Bullet(player.location, "PLAYER"));
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






void calculateScore (int currentSize, String type) {
  if (type == "asteroid") {
    if (currentSize == 1) {
      score = score + 500;
    }
    if (currentSize == 2) {
      score = score + 250;
    }
    if (currentSize == 3) {
      score = score + 100;
    }
    
    System.out.println(score);
  }
}

void calculateScore(AlienShip alien) {
  score += 1000;
  alien.die();
}

void displayScore() {
  textAlign(LEFT);
  textSize(20);
  text("Score: " + nf(score,7),50,50);
}


//Collision Detection - BN

//PlayerShip and AlienShip
boolean collisionDetection(playerShip r1, AlienShip r2){
 float distanceX = (r1.location.x + r1.w) - (r2.location.x + r2.w);
 float distanceY = (r1.location.y + r1.h) - (r2.location.y + r2.h);
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
boolean collisionDetection(Bullet bullet) {
  //For Collision Detection
    // Bullet from AlienShip to Player
    if(bullet.originType == "ALIEN"){
      float d = bullet.location.dist(player.location);
      if(d<10){
        fill(255, 0, 0, 100);
        rect(0, 0, width, height);   
        return true;
      }
    }
    // Bullet from Player to AlienShip
    else if(bullet.originType == "PLAYER"){
      float d = bullet.location.dist(AlienShip.location);
      if(d <= AlienShip.BigRadius+bullet.bulletRadius - 10){
        fill(255, 0, 0, 100);
        rect(0, 0, width, height);  
        explosions.add(new explosion(AlienShip.location.x, AlienShip.location.y));
        calculateScore(AlienShip);
        return true;
      }
      
    }
    return false;
}
/*Projectile and AlienShip
boolean collisionDetection(Bullet r1, AlienShip r2) {
 float distanceX = (r1.location.x + r1.w) - (r2.location.x + r2.w);
 float distanceY = (r1.location.y + r1.h) - (r2.location.y + r2.h);
 float combinedHalfW = r1.w + r2.w;
 float combinedHalfH = r1.h + r2.h;
 if(abs(distanceX) < combinedHalfW){
   if(abs(distanceY) < combinedHalfH){
    return true; 
   }
 }
 return false;
}
*/

//EOF
