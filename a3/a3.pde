
/**************************************************************
 * File: a3.pde
 * Last modified: 16/05/2020
 * Group: <Benjamin Nolan,Elsa Gaskell,Callum Sandercock>
 * Date Commenced: 21/03/2020
 * Date Completed MVP + Features: 12/05/2020
 * Course: COSC101 - Software Development Studio 1
 * ...
 * Desc: Asteroids is a Single player two dimensional shooter game where a
 * player is required to shoot AlienShips and Asteroids and not be hit by 
 * Asteroids, AlienShips and Projectiles. Player scores points when they 
 * shoot Asteroids and AlienShips. The player has three lives, and loses 
 * a life everytime they collide with another object or are successfully hit.
 * ...
 * Usage: Make sure to run in the processing environment and press play etc...
 * Notes: If any third party items are use they need to be credited (don't use
 * anything with copyright - unless you have permission)
 * ...
 * IMPORTANT! Please install Minim before running (for sound library).
 * ...
 * ...
 * PLAYER INSTRUCTIONS!
 * Please use Spacebar to shoot from PlayerShip.
 * Use Up, Left and Right arrow keys to move PlayerShip
 * ...
 * ...
 * Video link: xxx
 **************************************************************/


import ddf.minim.*;                // Import Minim sound library
Minim minim;                       // Minium object to load music
AudioPlayer backgroundSound;       // Object to play background music
AudioPlayer bulletSound;           // Object to play projectile sound
AudioPlayer explosionSound;        // Object to play explosion sound

PlayerShip player;
AlienShip AlienShip;

// Create ArrayLists to store Explosions, Asteroids and Bullets
ArrayList <Explosion> explosions = new ArrayList<Explosion>();
ArrayList <Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();

float bgColor = 0;
int level = 1;
int score; 
float speedLevel;
int asteroidCount = 5*level;  // number of asteroids to be generated
int alienEntrySec = 40;       // entry second for AlienShip
boolean sUP=false, sRIGHT=false, sLEFT=false;
boolean startMode = true; // Boolean flag for StartScreen
boolean gameOver = false; // Boolean flag for GameOverScreen

//Images for startScreen
PImage foo;
PImage astIcon;

void setup() {
  size(800, 800);

  // Create PlayerShip and AlienShip objects
  player = new PlayerShip(); 
  AlienShip = new AlienShip();

  // Load sound effects
  minim = new Minim(this);
  bulletSound = minim.loadFile("./Audio/bulletSound.wav");
  explosionSound = minim.loadFile("./Audio/explosionSound.wav");
  backgroundSound = minim.loadFile("./Audio/CreepySpace.mp3");
  // Loop background sound
  backgroundSound.loop();

  // Load images
  foo = loadImage("./Images/foo_was_here.jpg");
  astIcon = loadImage("./Images/asteroid.jpg");
}

void draw() {
  // Set black background
  background(bgColor);

  // Check if the game is in Start Mode
  // If so, only display the Start Screen
  if (startMode == true) {
    startScreen();
    return;
  }

  // Check if the game is in Start Mode
  // If so, only display the Game Over screen
  if (gameOver == true) {
    gameOverScreen();
    return;
  }

  // Display score and lives
  displayScore();
  player.displayLives();

  // Update and draw PlayerShip then check if it has
  // collided with AlienShip
  moveShip();
  player.update();
  player.render();
  collisionDetection(player, AlienShip);

  // Display AlienShip and periodically make the AlienShip
  // move onto screen and shoot at PlayerShip
  AlienShip.display();
  if (second() % alienEntrySec == 0 && !AlienShip.active) {
    AlienShip.active = true;
  }
  AlienShip.approach();

  // Iterate through asteroid array update and draw all asteroids.
  // Check whether any asteroids have collided with the PlayerShip
  for (int a = 0; a < asteroids.size(); a++) {
    Asteroid roid = asteroids.get(a);
    roid.update();
    roid.display();
    collisionDetection(roid, player);
  } 

  /* Iterate through bullet array update and draw all asteroids.
   Check if bullet is off screen and if any bullets have collided
   with the PlayerShip, any of the Asteroids or AlienShip. If 
   collision is detected or a bullet is offscreen, remove the 
   bullet from game
   */
  for (int b = 0; b < bullets.size(); b++) {
    Bullet bullet = bullets.get(b);
    bullet.update();
    bullet.display();
    if (bullet.wrap()) {
      bullets.remove(bullet);
    }
    if (collisionDetection(bullet)) {
      bullets.remove(b);
    }
  }


  // Iterate through explosion array. If there are any Explosion objects,
  // draw and periodically update all explosions.
  for (int e = 0; e < explosions.size(); e++) {
    // If the array isn't empty
    if (explosions.size()>0) {
      Explosion explode = explosions.get(e);
      // If the Explosion has reached its limit, remove it
      if (explode.currentCycle >= explode.explosionLimit) {
        explosions.remove(e);
      } else {
        explode.display();
        // Update the explosion every 5 frames
        if (frameCount%5==0) {
          explode.update();
        }
      }
    }
  }
}


/**************************************************************
 * Function: keyPressed()
 * Parameters: None
 * Returns: Void
 * Desc: Detects keyboard input from end-user. Sets booleans for 
 'moveShip' function, adds bullets from PlayerShip and allows 
 transition from Start Screen and Game Over Screen
 ***************************************************************/
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=true;
    }
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (keyCode == 32) {
    // Add a bullet from PlayerShip
    bullets.add( new Bullet(player.location, "PLAYER"));
    // Play bullet Sound
    bulletSound.play();
    bulletSound.rewind();
  }
  if (keyCode == ENTER) {
    // Leave Start Screen
    if (startMode) {
      startMode = false;
    }
    // Leave Game Over Screen and go back to Start Screen
    if (gameOver) {
      startMode = true;
      gameOver = false;
    }
  }
}

/**************************************************************
 * Function: keyReleased()
 * Parameters: None
 * Returns: Void
 * Desc: Detects keyboard input from end-user. Resets booleans
 from 'keyPressed' function, ensuring PlayerShip motion and rotation
 is responsive.
 ***************************************************************/
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
      // Reset acceleration so the PlayerShip
      // doesn't continue at same velocity
      player.slow();
    }
    if (keyCode == RIGHT) {
      // Stop rotating
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      // Stop rotating
      sLEFT=false;
    }
  }
}


/**************************************************************
 * Function: moveShip()
 * Parameters: None
 * Returns: Void
 * Desc: This function accelerates and rotates the PlayerShip
 based on the boolean states set by 'keyPressed' and 'keyReleased'
 functions
 ***************************************************************/
void moveShip() {
  if (sUP) {
    // Accelerate PlayerShip
    player.accel();
  }
  if (sRIGHT) {
    // Rotate PlayerShip clockwise
    player.rotateRight();
  }
  if (sLEFT) {
    // Rotate PlayerShip anti-clockwise
    player.rotateLeft();
  }
}

/**************************************************************
 * Function: calculateScore()
 * Parameters: Asteroid(roid or AlienShip(alien)
 * Returns: Void
 * Desc: Increments the score if the asteroid was destroyed
 without the player losing a life. Overloaded function to work
 with different objects as parameters
 ***************************************************************/
void calculateScore (Asteroid roid) {
  if (player.active) {
    if (roid.size == 1) {
      score += 500;
    }
    if (roid.size == 2) {
      score += 250;
    }
    if (roid.size == 3) {
      score += 100;
    }
  }
}

void calculateScore(AlienShip alien) {
  score += 1000;
  alien.die(); // Reset AlienShip
}

/**************************************************************
 * Function: displayScore()
 * Parameters: None
 * Returns: Void
 * Desc: Displays the score variable at 7 digits in top left corner
 ***************************************************************/
void displayScore() {
  // Set text alignment, size and colour
  int scoreX = 50;
  int scoreY = 50;
  textAlign(LEFT);
  textSize(20);
  fill(255);
  // Display score as 7 digits before decimal point in top-left corner
  text("Score: " + nf(score, 7), scoreX, scoreY);
}


/***************************************************************************
 * Function: collisionDetection()
 * Parameters: Asteroid(roid), PVector(circleLoc), int(radius)
 * Returns: boolean
 * Desc: This function treats the Asteroid object as a rectangle. Then it
 tests this rectangle for collision with a circle, by finding the closest 
 sides of the rectangle to the circle. This function also tests the circles 
 origin to see if it falls inside of the rectangle. If the distance between
 the closest point of the rectangle and the circle origin is less than the 
 circle's radius or the circle is inside the rectangle then there is a 
 collision. 
 This function is built on code by Jeffery Thompson, accessed at:
 http://www.jeffreythompson.org/collision-detection/circle-rect.php
 **************************************************************************/
boolean circleToAsteroid(Asteroid roid, PVector circleLoc, int radius) {
  // Set initial variables for Asteroid rectangle
  float astX = roid.x;
  float astY = roid.y;
  float astMaxWidth = 0;
  float astMaxHeight = 0;

  // Set max width and height of rectangle based on Asteroid size
  if (roid.size == 1) {
    astMaxWidth = 33.3;
    astMaxHeight = 16.6;
  } else if (roid.size == 2) {
    astMaxWidth = 50;
    astMaxHeight = 25;
  } else if (roid.size == 3) {
    astMaxWidth = 100;
    astMaxHeight = 50;
  } else {
    // Error test
    System.out.println("return of the ghost asteroid");
  }

  // Temporary variables to set closest edge for testing
  float testX = circleLoc.x;
  float testY = circleLoc.y;

  //Test LEFT side of rectangle against circle origin
  if (testX < astX) {
    testX = astX;
  }
  //Test RIGHT side of rectangle against circle origin
  else if (testX > astX + astMaxWidth) {
    testX = astX + astMaxWidth;
  }
  //Test TOP side of rectangle against circle origin
  if (testY < astY) {
    testY = astY;
  }
  //Test BOTTOM side of rectangle against circle origin
  else if (testY > astY + astMaxHeight) {
    testY = astY + astMaxHeight;
  }

  // Caluclate distance from closest edge of rectangle to circle
  PVector closestEdge = new PVector(testX, testY);
  float distance = closestEdge.dist(circleLoc);
  // Test if Circle origin is within the rectangle
  boolean insideTestX = circleLoc.x >= astX&&circleLoc.x <= astX + astMaxWidth;
  boolean insideTestY = circleLoc.y >= astY&&circleLoc.y <= astY + astMaxHeight;
  boolean insideTest = insideTestX && insideTestY;
  // If distance from closest edge is less than radius or the circle is 
  // inside the Asteroid rectangle - there is a collision
  if (distance <= radius || insideTest ) { 
    return true;
  } else {
    return false;
  }
}


/**********************************************************************
 * Function: collisionDetection()
 * Parameters: Playership(p1), AlienShip(a2)
 * Returns: Void
 * Desc: Detects collision between PlayerShip and AlienShip through
 calculating distance between PVector locations. If less than the 
 radii of both circles the PlayerShip dies and an Explosion is created.
 Overloaded function to handle different object params and different 
 function returns.
 **********************************************************************/
void collisionDetection(PlayerShip p1, AlienShip a2) {
  float d = a2.location.dist(p1.location);
  if (d <= p1.radius + a2.BigRadius) {
    explosions.add(new Explosion(p1.location.x, p1.location.y));
    player.die();
  }
}

/****************************************************************************
 * Function: collisionDetection()
 * Parameters: Asteroid(roid), Playership(p1)
 * Returns: Void
 * Desc: Detects collision between Asteroid and PlayerShip through
 the 'circleToAsteroid' function, treating the PlayerShip as a circle.
 If true and the PlayerShip is active the PlayerShip dies, the Asteroid is 
 split/removed and an Explosion is created. Then the 'checkLevel' function is
 called to ensure there are Asteroids on screen. Overloaded function to 
 handle different object params and different function returns.
 ***************************************************************************/
void collisionDetection(Asteroid roid, PlayerShip p1) {
  if (circleToAsteroid(roid, p1.location, p1.radius) && p1.active) {
    explosions.add(new Explosion(roid.x, roid.y));
    p1.die();
    roid.splitAsteroid();
    asteroids.remove(roid);
    checkLevel();
  }
}

/**************************************************************
 * Function: collisionDetection()
 * Parameters: Bullet(bullet)
 * Returns: boolean
 * Desc: Detects collision between bullet and any other object.
 Depending on originType of bullet, this function detects bullet 
 collision with AlienShip, PlayerShip and Asteroids. Overloaded 
 function to handle different object params and different function 
 returns.
 **************************************************************/
boolean collisionDetection(Bullet bullet) {
  // AlienShip Bullet collision with PlayerShip
  if (bullet.originType == "ALIEN") {
    float d = bullet.location.dist(player.location);
    if (d <= player.radius + bullet.radius && player.active) {
      // Add explosion and player dies
      explosions.add(new Explosion(player.location.x, player.location.y));
      player.die();
      return true;
    }
  }

  // PlayerShip bullet collision 
  else if (bullet.originType == "PLAYER") {

    // Collision with AlienShip
    float d = bullet.location.dist(AlienShip.location);
    if (d <= AlienShip.BigRadius + bullet.radius) {
      explosions.add(new Explosion(AlienShip.location.x, AlienShip.location.y));
      calculateScore(AlienShip);
      return true;
    }

    /* Collision with Asteroid
     Iterate through asteroids and use 'circleToAsteroid' function to 
     detect if the bullet collided with any asteroid.
     */
    for (int m = 0; m < asteroids.size(); m++) {
      Asteroid roid = asteroids.get(m);
      if (circleToAsteroid(roid, bullet.location, bullet.radius)) {
        // Add explosion, split/remove Asteroid and 'checkLevel' function
        explosions.add(new Explosion(roid.x, roid.y));
        roid.splitAsteroid();
        asteroids.remove(roid);
        checkLevel();
        return true;
      }
    }
  }
  return false;
}

/******************************************************************
 * Function: checkLevel()
 * Parameters: None
 * Returns: Void
 * Desc: Checks whether there are any asteroids left on the screen
 by checking the size of the array that stores the asteroid objects.
 If array is empty, increments the level and speed of the game,
 resets the player, and generates new asteroids. Also used
 to populate game with initial Asteroids
 ******************************************************************/
void checkLevel() {
  float speedIncrement = 0.3; //increment for speed

  // If no asteroids remain
  if (asteroids.size() == 0) {
    level++; //increment the level
    speedLevel += speedIncrement; // increase speed
    player.reset(); // reset the player position on the screen
    player.active = false; // Ensure player invulnerability
    // generate new asteroids according to the asteroidCount variable
    for (int i = 0; i < asteroidCount; i++) {
      asteroids.add(new Asteroid(speedLevel, round(random(1, 3))));
    }
  }
}

/***************************************************************
 * Function: startScreen()
 * Parameters: None
 * Returns: Void
 * Desc: Displays a start screen that will be displayed where the
 * startMode variable is true, and will only be replaced with 
 gameplay when ENTER is pressed. Also displays controls for the 
 game to the end-user
 ***************************************************************/
void startScreen() {
  // set background colour
  background(bgColor); 
  int iconLength = 100;
  int fooX = 625;
  int fooY = 100;
  int astIconX = 75;
  int astIconY = 100;
  // Set images for Start Screen
  image(foo, fooX, fooY, iconLength, iconLength);
  image(astIcon, astIconX, astIconY, iconLength, iconLength);

  // Set text colour, size and alignment
  int accelerateY = 440;
  int turnY = 460;
  int shootY = 480;
  fill(255); 
  textSize(36);
  textAlign(CENTER); 
  text("ASTEROID CLONE", width/2, height/4); // Title
  // Reset text size
  textSize(20); 
  text("CONTROLS", width/2, height/2);
  text("ACCELERATE: UP ARROW KEY", width/2, accelerateY);
  text("TURN: LEFT/RIGHT ARROW KEYS", width/2, turnY);
  text("SHOOT: SPACEBAR", width/2, shootY);
  text("Press ENTER to Play", width/2, (height/4)*3);
  // Reset level, score, speed, lives and populate with Asteroids
  score = 0;
  level = 1;
  speedLevel = 0.2;
  player.lives = 3;
  checkLevel();
}

/*****************************************************************
 * Function: gameOverScreen()
 * Parameters: None
 * Returns: Void
 * Desc: Displays a game over screen that will be displayed where 
 the gameOverMode variable is true, and will only be replaced with 
 the Start Screen when ENTER is pressed. Also clears the ArrayLists
 and resets the AlienShip location for a new game.
 *****************************************************************/
void gameOverScreen() {
  background(bgColor); // set background color
  textSize(30); // set text size
  fill(255); // set text color
  textAlign(CENTER, CENTER); // align text in centre of screen
  text("GAME OVER", width/2, height/4); //text to be displayed
  textSize(20); // change text size for lower words
  text(score + " points scored!", width/2, height/3); //display points scored
  text("Press ENTER to return to Start", width/2, height/2); 

  // Clear Asteroids, Bullets and Explosions from game
  // and reset AlienShip location to prepare for restarted game
  asteroids.clear();
  bullets.clear();
  explosions.clear();
  AlienShip.randomStart();
}
