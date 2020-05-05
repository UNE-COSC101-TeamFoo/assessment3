class AlienShip {
  //AlienShip global vars - BN  
  float AlienShipSpeed = 2; // AlienShip Speed
  PVector velocity;
  PVector location;
  PVector AShip;
  float w, h;
  float xRandom, yRandom;

  AlienShip() {
    int randCount = int(random(1,4));
    if(randCount <=1) {
      xRandom = random(-100,-50);
      yRandom = random(0,height);
    } else if (1 < randCount || randCount <=2) {
      xRandom = random(0,width);
      yRandom = random(height+50,height +100);
    } else if (2 < randCount || randCount <=3) {
      xRandom = random(width+50,width+100);
      yRandom = random(0,width);
    } else {
      xRandom = random(0,width);
      yRandom = random(-50,-100);
    }
    location = new PVector(xRandom, yRandom);
    velocity = new PVector(1,1);  
    
    //For Collision Detection 
    w = 10;
    h = 10;
    
  }
  
  void move() {
    if(location.x > (width + 100)|| location.x < -100){
        velocity.x *= -1;
    }
    if(location.y > (height + 100)|| location.y < -100){
        velocity.y *= -1;
    }
    
    location.x += AlienShipSpeed * velocity.x;
    location.y += AlienShipSpeed * velocity.y;    
    
  }
  
  void display() {
    // Part A of Ship
    float AlienShipxw = 50; // width of Part A
    float AlienShipyh = 25; // height of Part A
    ellipse(location.x,location.y,AlienShipxw,AlienShipyh); // object
    fill(153); // fill colour in object
    
    // Part B of Ship
    //smaller ellipse on Alien Ship (centred circle)
    float AlienShipxw2 = 30; // width of Part B
    float AlienShipyh2 = 12.5; // height of Part B
    ellipse(location.x,location.y,AlienShipxw2,AlienShipyh2); // object
  }
    
  
  void AlienShipApproach(){
    AlienShip.move();
    boolean onScreen;
    //Test for if the ship is onscreen
    onScreen = (location.x >= 0 && location.x <= width && location.y >= 0 && location.y <= width);
     
    // Every two seconds a bullet is shot if the AlienShip is onScreen
    if (frameCount % 120 == 0 && onScreen) {
      bullets.add( new Bullet(AlienShip.location, "ALIEN"));      
    }   
  } 
}
