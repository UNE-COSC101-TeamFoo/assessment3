class AlienShip {

  PVector AShip;
  float w, h;
  float x, y;

  void AlienShip() {
    x = AlienShipxc;
    y = AlienShipyc;
    
    //For Collision Detection 
    w = 10;
    h = 10;
    
    // Part A of Ship
    float AlienShipxw = 50; // width of Part A
    float AlienShipyh = 25; // height of Part A
    ellipse(AlienShipxc,AlienShipyc,AlienShipxw,AlienShipyh); // object
    fill(153); // fill colour in object
    
    // Part B of Ship
    //smaller ellipse on Alien Ship (centred circle)
    float AlienShipxw2 = 30; // width of Part B
    float AlienShipyh2 = 12.5; // height of Part B
    ellipse(AlienShipxc2,AlienShipyc2,AlienShipxw2,AlienShipyh2); // object
  }
  
  void AlienShipApproach(){
  
    AShip = new PVector(AlienShipxc,AlienShipyc);
    
    AlienShip();
    
    AlienShipxc = AlienShipxc + (AlienShipSpeed * AlienShipxDir);
    AlienShipyc = AlienShipyc + (AlienShipSpeed * AlienShipyDir);    
    AlienShipxc2 = AlienShipxc;
    AlienShipyc2 = AlienShipyc;    
    
    if(AlienShipxc > (width-100)){
        AlienShipxDir *= -1;
    }
    if(AlienShipyc > (width-100)){
        AlienShipxDir *= -1;
    }
    
  } 
  
}
