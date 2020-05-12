
/**************************************************************
* File: a3.pde
* Last modified: 12/05/2020
* Group: <Benjamin Nolan,Elsa Gaskell,Callum Sandercock>
* Date Commenced: 21/03/2020
* Date Completed MVP + Features: 12/05/2020
* Course: COSC101 - Software Development Studio 1
* ...
* Desc: Asteroids is a Single player two dimensional shooter game where a player is required to shoot
* AlienShips and Asteroids and not be hit by Asteroids, AlienShips and Projectiles.
* Player scores points when they shoot Asteroids and AlienShips.
* The player has three lives, and loses a life everytime they collide with another object or are shot at.
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
* IMPORTANT! Please install minim before running (for sound library).
* ...
* ...
* PLAYER INSTRUCTIONS!
* Please use Spacebar to shoot from PlayerShip.
* Use Up, Left and Right arrow keys to move PlayerShip
* ...
* ...
**************************************************************/

import ddf.minim.*;                // Import Minim sound library
Minim minim;                       // Minium object to load music
AudioPlayer backgroundSound;          // Object to play background music
AudioPlayer projectileSound;       // Object to play projectile sound
AudioPlayer explosionSound;        // Object to play explosion sound

playerShip player; // CS
Asteroid asteroid; // EG
Bullet Bullet; // BN
AlienShip AlienShip; // BN

ArrayList <explosion> explosions = new ArrayList<explosion>(); // CS
ArrayList <Bullet> bullets = new ArrayList<Bullet>(); // BN
ArrayList <Asteroid> asteroids = new ArrayList<Asteroid>(); // EG

int level = 1; // the difficulty level, default is 0
int asteroidCount = 5*level;  // number of asteroids to be generated
int asteroidArrayPosition = 0;
int score = 0; // starting score
boolean sUP=false, sDOWN=false, sRIGHT=false, sLEFT=false;
boolean alive=true;
float bgColor = 0; // background colour black

PImage foo; //for logo

void setup() {
  
  size(800,800);
  background(bgColor);
  
  // playerShip class - CS
  player = new playerShip(); 
  
  //AlienShip class - BN
  AlienShip = new AlienShip();
  
  //Asteroids - EG
  int openArrayPos = asteroids.size();
  if (openArrayPos <= 0) {
    for (int i = 0; i < asteroidCount; i++) {      
        asteroids.add(new Asteroid(random(75, 725), random(75, 725), random(1, 3), round(random(3))));
    }
  }

  // sound effects
  minim = new Minim(this);
  projectileSound = minim.loadFile("/Audio/projectileSound.wav");
  explosionSound = minim.loadFile("/Audio/explosionSound.wav");
  backgroundSound = minim.loadFile("/Audio/CreepySpace.mp3");
  backgroundSound.loop();

  foo = loadImage("foo_was_here.jpg"); //for logo

}

void draw(){
     
  background(bgColor);

  //UnComment if you're feeling lucky! :)
  //image(foo,700,25,100,100); //for logo

  // AlienShip - BN
  AlienShip.display(); // load AlienShip object
  // Frequency of when AlienShip appears 
  if (second() % 20 == 0 && !AlienShip.active) {
    AlienShip.active = true;
  }
  AlienShip.AlienShipApproach(); // Movement of AlienShip

  // Player Ship - CS
  moveShip();
  player.update();
  player.render();
  player.displayLives(); // Show lives on screen
  collisionDetection(player, AlienShip); // Collision Detection between PlayerShip and AlienShip

  displayScore(); // Display Score

  // Asteroids - EG
  for (int i = 0; i < asteroids.size(); i++) {
    asteroidArrayPosition = 0; // need to reset or it keeps incrementing
    Asteroid roid = asteroids.get(i);
    roid.update();
    roid.display();
    collisionDetection(roid, player);// Collision Detection between Asteroid and PlayerShip
    asteroidArrayPosition++;
  } 

  // Projectiles/Bullets - BN
  for (int k = 0; k < bullets.size(); k++) {
    Bullet bullet = bullets.get(k);
    if (bullet.location.x<=0 ||bullet.location.x>= width || bullet.location.y <= 0 || bullet.location.y >= height) {
      bullets.remove(bullet);
    }
    bullet.update();
    bullet.display();
    // When bullet hits an object, needs to be removed, otherwise goes through.
    if (collisionDetection(bullet)) {
      bullets.remove(k);
    }
  }

  // Explosions - CS
  for (int p = 0; p < explosions.size(); p++) {
    if (explosions.size()>0) {
      explosion explode = explosions.get(p);
      if (explode.currentCycle >= explode.explosionLimit) {
        explosions.remove(p);
      } else {
        explode.display();
        if (frameCount%5==0) {
          explode.update();
        }
      }
    }
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
  if (keyCode == 32) { // spacebar
    // Pass param of Player to identify bullet from PlayerShip
    bullets.add( new Bullet(player.location, "PLAYER"));
    // Play sound of bullet when released
    projectileSound.play();
    projectileSound.rewind();
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
    player.accel();
  }
  if(sDOWN){} // Down not used
  if(sRIGHT){
    player.rotateRight();
  }
  if(sLEFT){
    player.rotateLeft();
  }
}

// Calculate scoring for Asteroids hit by PlayerShip
void calculateScore (Asteroid roid) {
  if (roid.size == 1) {
    score = score + 500;
  }
  if (roid.size == 2) {
    score = score + 250;
  }
  if (roid.size == 3) {
    score = score + 100;
  }
}

// Calculate scoring for AlienShip hit by PlayerShip
void calculateScore(AlienShip alien) {
  score += 1000;
  alien.die();
}

// Display Score
void displayScore() {
  textAlign(LEFT);
  textSize(20);
  text("Score: " + nf(score, 7), 50, 50);
}

// Collision Detection between Asteroid and PlayerShip
boolean circleToAsteroid(Asteroid roid, PVector circleLoc, int radius) {
  float astX = roid.x;
  float astY = roid.y;
  float astMaxWidth;
  float astMaxHeight;

  if (roid.size == 1) {
    astMaxWidth = 33.3;
    astMaxHeight = 16.6;
  } else if (roid.size == 2) {
    astMaxWidth = 50;
    astMaxHeight = 25;
  } else {
    astMaxWidth = 100;
    astMaxHeight = 50;
  }
  // temporary variables to set edges for testing
  float testX = circleLoc.x;
  float testY = circleLoc.y;

  //Test LEFT side
  if (testX < astX) {
    testX = astX;
  }
  //Test RIGHT side
  else if (testX > astX + astMaxWidth) {
    testX = astX + astMaxWidth;
  }
  //Test TOP side
  if (testY < astY) {
    testY = astY;
  }
  //Test BOTTOM side
  else if (testY > astY + astMaxHeight) {
    testY = astY + astMaxHeight;
  }

  // get distance from closest edges
  PVector closestEdge = new PVector(testX, testY);
  float distance = closestEdge.dist(circleLoc);
  boolean insideTestX = circleLoc.x >= astX && circleLoc.x <= astX + astMaxWidth;
  boolean insideTestY = circleLoc.y >= astY && circleLoc.y <= astY + astMaxHeight;
  boolean insideTest = insideTestX && insideTestY;
  
  if (distance <= radius || insideTest ) {
    return true;
  } else {
    return false;
  }
}

// Collision Detection between PlayerShip and AlienShip
void collisionDetection(playerShip r1, AlienShip r2) {
  float d = r2.location.dist(r1.location);
  if (d <= r1.radius + r2.BigRadius) {
    explosions.add(new explosion(player.location.x, player.location.y));
    player.die();
  }
}

// Collision Detection between Asteroid and PlayerShip
void collisionDetection(Asteroid roid, playerShip p1) {
  if (circleToAsteroid(roid, p1.location, p1.radius) && player.active) {
    explosions.add(new explosion(roid.x, roid.y));
    roid.splitAsteroid();
    asteroids.remove(roid);
    checkLevel();
    p1.die();
    System.out.println("hit by asteroid");
  }
}

// Collision Detection between Bullet and another object
boolean collisionDetection(Bullet bullet) {
  // Bullet from AlienShip to Player
  if (bullet.originType == "ALIEN") {
    float d = bullet.location.dist(player.location);
    if (d <= player.radius + bullet.radius && player.active) {
      explosions.add(new explosion(player.location.x, player.location.y));
      player.die();
      return true;
    }
  }
  // Bullet from Player to AlienShip
  else if (bullet.originType == "PLAYER") {
    float d = bullet.location.dist(AlienShip.location);
    if (d <= AlienShip.BigRadius + bullet.radius) {
      explosions.add(new explosion(AlienShip.location.x, AlienShip.location.y));
      calculateScore(AlienShip);
      return true;
    }
    // Bullet from Player to Asteroid
    for (int m = 0; m < asteroids.size(); m++) {
      Asteroid roid = asteroids.get(m);
      if (circleToAsteroid(roid, bullet.location, bullet.radius)) {
        explosions.add(new explosion(roid.x, roid.y));
        roid.splitAsteroid();
        asteroids.remove(roid);
        checkLevel();
        return true;
      }
    }
  }
  return false;
}

// Stage/Level reset after clearing screen
void checkLevel () {
  int openArrayPos = asteroids.size();

  if (openArrayPos == 0) {
    level++;
    player.reset();
    player.active = false;

    if (openArrayPos <= 0) {
      for (int i = 0; i < asteroidCount; i++) {

        //asteroids[index++] = new Asteroid(random(75, 725), random(75, 725), random(3, 5), xDirection, yDirection); //x axis, y axis, speed, xdirection, ydirection
        asteroids.add(new Asteroid(random(75, 725), random(75, 725), 1 + level*0.1, round(random(1,3))));
      }
    }
  }
}
//EOF
