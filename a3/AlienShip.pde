class AlienShip {
  //AlienShip global vars - BN  
  float AlienShipSpeed = 2; // AlienShip Speed
  PVector velocity;
  PVector location;
  PVector AShip;
  float xRandom, yRandom;
  float BigRadius = 50;
  float SmallRadius = 25;
  boolean active = false;

  AlienShip() {
    PVector start = new PVector();
    start = randomStart();
    location = new PVector(start.x, start.y);
    velocity = new PVector(1, 1);
  }

  void move() {
    if (location.x > (width + 100)|| location.x < -100) {
      velocity.x *= -1;
    }
    if (location.y > (height + 100)|| location.y < -100) {
      velocity.y *= -1;
    }

    location.x += AlienShipSpeed * velocity.x;
    location.y += AlienShipSpeed * velocity.y;
  }

  void display() {
    // Part A of Ship
    stroke(255);
    fill(0); // fill colour in object
    ellipse(location.x, location.y, BigRadius, BigRadius); // object



    // Part B of Ship
    fill(153); // fill colour in object
    //smaller ellipse on Alien Ship (centred circle)
    ellipse(location.x, location.y, SmallRadius, SmallRadius); // object
  }


  void AlienShipApproach() {
    if (active) {
      AlienShip.move();
      boolean onScreen;
      //Test for if the ship is onscreen
      onScreen = (location.x >= 0 && location.x <= width && location.y >= 0 && location.y <= width);

      // Every two seconds a bullet is shot if the AlienShip is onScreen
      if (frameCount % 300 == 0 && onScreen) {
        bullets.add( new Bullet(AlienShip.location, "ALIEN"));
      }
    }
  } 

  PVector randomStart() {
    int randCount = int(random(1, 4));
    if (randCount <=1) {
      xRandom = random(-100, -50);
      yRandom = random(0, height);
    } else if (1 < randCount || randCount <=2) {
      xRandom = random(0, width);
      yRandom = random(height+50, height +100);
    } else if (2 < randCount || randCount <=3) {
      xRandom = random(width+50, width+100);
      yRandom = random(0, width);
    } else {
      xRandom = random(0, width);
      yRandom = random(-50, -100);
    }

    PVector start = new PVector(xRandom, yRandom);
    return start;
  }

  void die() {
    PVector restart = new PVector();
    restart = randomStart();
    location = new PVector(restart.x, restart.y);
    velocity = new PVector(1, 1);
    active = false;
  }
}
