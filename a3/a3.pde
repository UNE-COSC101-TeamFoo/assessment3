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


/**************************************************************
 * Function: myFunction()
 * Parameters: None ( could be integer(x), integer(y) or String(myStr))
 * Returns: Void ( again this could return a String or integer/float type )
 * Desc: Each funciton should have appropriate documentation. 
 This is designed to benefit both the marker and your team mates.
 So it is better to keep it up to date, same with usage in the header comment
 ***************************************************************/



import ddf.minim.*;                // Import Minim sound library
Minim minim;                       // Minium object to load music
AudioPlayer backgroundSound;          // Object to play background music
AudioPlayer projectileSound;       // Object to play projectile sound
AudioPlayer explosionSound;        // Object to play explosion sound

playerShip player; // CS
Asteroid Asteroid; // EG
Bullet Bullet; // BN
AlienShip AlienShip; // BN


ArrayList <explosion> explosions = new ArrayList<explosion>();
ArrayList <Bullet> bullets = new ArrayList<Bullet>(); // BN
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>(); // EG


int level = 1; // the difficulty level, default is 0
float speedLevel = 0.5;
int asteroidCount = 5*level;  // number of asteroids to be generated
int asteroidArrayPosition = 0;
int score = 0;
boolean sUP=false, sDOWN=false, sRIGHT=false, sLEFT=false;
boolean alive=true;
float bgColor = 0;


void setup() {

  size(800, 800);
  background(bgColor);


  // playerShip class - CS
  player = new playerShip(); 
  //AlienShip  class - BN
  AlienShip = new AlienShip();

  //Asteroids - EG
  int openArrayPos = asteroids.size();
  if (openArrayPos <= 0) {
    for (int i = 0; i < asteroidCount; i++) {
      asteroids.add(new Asteroid(random(75, 725), random(75, 725), speedLevel, round(random(1,3))));
    }
  }

  // sound effects
  minim = new Minim(this);
  projectileSound = minim.loadFile("/Audio/projectileSound.wav");
  explosionSound = minim.loadFile("/Audio/explosionSound.wav");
  backgroundSound = minim.loadFile("/Audio/CreepySpace.mp3");
  backgroundSound.loop();
}

void draw() {

  background(bgColor);
  
  AlienShip.display();
  if (second() % 20 == 0 && !AlienShip.active) {
    AlienShip.active = true;
  }
  AlienShip.AlienShipApproach(); // - BN

  // Update Player location and draw - CS
  moveShip();
  player.update();// - CS
  player.render();// - CS
  player.displayLives();
  collisionDetection(player, AlienShip);

  displayScore();

  for (int i = 0; i < asteroids.size(); i++) {
    asteroidArrayPosition = 0; // need to reset or it keeps incrementing
    Asteroid roid = asteroids.get(i);
    roid.update();
    roid.display();
    collisionDetection(roid, player);
    asteroidArrayPosition++;
  } 



  //Projectiles - BN
  for (int k = 0; k < bullets.size(); k++) {
    Bullet bullet = bullets.get(k);
    //wrap
    if (bullet.location.x<=0 ||bullet.location.x>= width || bullet.location.y <= 0 || bullet.location.y >= height) {
      bullets.remove(bullet);
    }
    bullet.update();
    bullet.display();
    if (collisionDetection(bullet)) {
      bullets.remove(k);
    }
  }



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

  //Collision Detection - BN
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



void moveShip() {
  if (sUP) {
    player.accel();// - CS
  }
  if (sDOWN) {
  }
  if (sRIGHT) {
    player.rotateRight();// - CS
  }
  if (sLEFT) {
    player.rotateLeft();// - CS
  }
}

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

void calculateScore(AlienShip alien) {
  score += 1000;
  alien.die();
}

void displayScore() {
  textAlign(LEFT);
  textSize(20);
  text("Score: " + nf(score, 7), 50, 50);
}



boolean circleToAsteroid(Asteroid roid, PVector circleLoc, int radius) {
  float astX = roid.x;
  float astY = roid.y;
  float astMaxWidth = 0;
  float astMaxHeight = 0;

  if (roid.size == 1) {
    astMaxWidth = 33.3;
    astMaxHeight = 16.6;
  } else if (roid.size == 2) {
    astMaxWidth = 50;
    astMaxHeight = 25;
  } else if (roid.size == 3) {
    astMaxWidth = 100;
    astMaxHeight = 50;
  }
  else {
    System.out.println("return of the ghost asteroid");
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




//Collision Detection - BN

//PlayerShip and AlienShip
void collisionDetection(playerShip r1, AlienShip r2) {
  float d = r2.location.dist(r1.location);
  if (d <= r1.radius + r2.BigRadius) {
    explosions.add(new explosion(player.location.x, player.location.y));
    player.die();
  }
}


void collisionDetection(Asteroid roid, playerShip p1) {
  if (circleToAsteroid(roid, p1.location, p1.radius) && player.active) {
    explosions.add(new explosion(roid.x, roid.y));
    roid.splitAsteroid();
    asteroids.remove(roid);
    checkLevel();
    p1.die();
  }
}


boolean collisionDetection(Bullet bullet) {
  //For Collision Detection
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


void checkLevel () {
  int openArrayPos = asteroids.size();

  if (openArrayPos == 0) {
    level++;
    speedLevel = speedLevel+0.3;
    //note:
    //probably throw a reset of the ship position or a loading screen or both in here?
    player.reset();
    player.active = false;

    if (openArrayPos <= 0) {
      for (int i = 0; i < asteroidCount; i++) {

        //asteroids[index++] = new Asteroid(random(75, 725), random(75, 725), random(3, 5), xDirection, yDirection); //x axis, y axis, speed, xdirection, ydirection
        asteroids.add(new Asteroid(random(75, 725), random(75, 725), speedLevel, round(random(1,3))));
      }
    }
  }
}
