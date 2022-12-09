float[][] bullets = new float[100][4];
int bulletN=0;
int time=millis();
float bulletS=5;
int bulletR=100;
boolean pressed=false;
float mouseXR;
float mouseYR;
float randomB=0.5;

class tank {
  float x = 400;
  float y = 250;
  float xUp=0;
  float xDown=0;
  float yLeft=0;
  float yRight=0;
  boolean[] keys={false, false, false, false};

  void display() {
    stroke(100);
    fill(0);
    strokeWeight(15);
    strokeCap(SQUARE);
    line(x, y, x+(mouseX-x)*30/(sqrt(sq(mouseX-x)+sq(mouseY-y))), y+(mouseY-y)*30/(sqrt(sq(mouseX-x)+sq(mouseY-y))));
    stroke(#2B87AA);
    strokeWeight(3);
    fill(#00B5E4);
    ellipse(x, y, 30, 30);
  } 

  void update() {
    if (keys[0]) {
      xUp=1;
      //println("left move");
    } else {
      xUp=0;
      //println("left stop");
    }
    if (keys[1]) {
      xDown=1;
      //println("right move");
    } else {
      xDown=0;
      //println("right stop");
    }
    if (keys[2]) {
      yLeft=1;
      //println("up move");
    } else {
      yLeft=0;
      //println("up stop");
    }
    if (keys[3]) {
      yRight=1;
      //println("down move");
    } else {
      yRight=0;
      //println("down stop");
    }
    x-=xUp;
    x+=xDown;
    y-=yLeft;
    y+=yRight;
  }

  void bullet() {
    noStroke();
    for (int i=0; i<bullets.length; i++) {
      fill(#00B5E4);
      ellipse(bullets[i][0], bullets[i][1], 10, 10);
    }
  }

  void bulletUpdate() {
    for (int i=0; i<bullets.length; i++) {
      bullets[i][0]+=bullets[i][2];
      bullets[i][1]+=bullets[i][3];
    }
  }

  void shoot() {
    if (mousePressed || pressed) {
      if (millis()-time>bulletR) {
        time=millis();
        if (abs(mouseX-main.x)<50 && abs(mouseY-main.y)<50) {
          mouseXR=mouseX;
          mouseYR=mouseY;
        } else {
          mouseXR=mouseX+random(0, 0);
          mouseYR=mouseY+random(0, 0);
        }

        bullets[bulletN%100][0]=main.x+(mouseXR-main.x)*30/(sqrt(sq(mouseXR-main.x)+sq(mouseYR-main.y)));
        bullets[bulletN%100][1]=main.y+(mouseYR-main.y)*30/(sqrt(sq(mouseXR-main.x)+sq(mouseYR-main.y)));
        if (mouseXR>=main.x && mouseYR>=main.y) {
          bullets[bulletN%100][2]=(bulletS/sqrt(sq(mouseYR-main.y)/sq(mouseXR-main.x)+1))+random(-randomB, randomB);
          bullets[bulletN%100][3]=(bulletS/sqrt(sq(mouseXR-main.x)/sq(mouseYR-main.y)+1))+random(-randomB, randomB);
        }
        if (mouseXR>=main.x && mouseYR<=main.y) {
          bullets[bulletN%100][2]=(bulletS/sqrt(sq(mouseYR-main.y)/sq(mouseXR-main.x)+1))+random(-randomB, randomB);
          bullets[bulletN%100][3]=(bulletS/-sqrt(sq(mouseXR-main.x)/sq(mouseYR-main.y)+1))+random(-randomB, randomB);
        }
        if (mouseXR<=main.x && mouseYR>=main.y) {
          bullets[bulletN%100][2]=(bulletS/-sqrt(sq(mouseYR-main.y)/sq(mouseXR-main.x)+1))+random(-randomB, randomB);
          bullets[bulletN%100][3]=(bulletS/sqrt(sq(mouseXR-main.x)/sq(mouseYR-main.y)+1))+random(-randomB, randomB);
        }
        if (mouseXR<=main.x && mouseYR<=main.y) {
          bullets[bulletN%100][2]=(bulletS/-sqrt(sq(mouseYR-main.y)/sq(mouseXR-main.x)+1))+random(-randomB, randomB);
          bullets[bulletN%100][3]=(bulletS/-sqrt(sq(mouseXR-main.x)/sq(mouseYR-main.y)+1))+random(-randomB, randomB);
        }
        bulletN++;
      }
    }
  }
}

tank main;

void setup() {
  size(800, 500);
  main = new tank();
}

void keyPressed() {
  switch(keyCode) {
  case 37: //left
    main.keys[0]=true;
    break;
  case 38: //up
    main.keys[2]=true;
    break;
  case 39: //right
    main.keys[1]=true;
    break;
  case 40: //down
    main.keys[3]=true;
    break;
  case 87: //up
    main.keys[2]=true;
    break;
  case 65: //left
    main.keys[0]=true;
    break;
  case 83: //down
    main.keys[3]=true;
    break;
  case 68: //right
    main.keys[1]=true;
    break;
  case 69: //e
    if (pressed) {
      pressed=false;
    } else {
      pressed=true;
    }
  }
  //println(keyCode);
  // w 87
  // a 65aaas
  // s 63
  // d 68
}

void keyReleased() {
  switch(keyCode) {
  case 37: 
    main.keys[0]=false;
    break;
  case 38: 
    main.keys[2]=false;
    break;
  case 39: 
    main.keys[1]=false;
    break;
  case 40: 
    main.keys[3]=false;
    break;
  case 87: //up
    main.keys[2]=false;
    break;
  case 65: //left
    main.keys[0]=false;
    break;
  case 83: //down
    main.keys[3]=false;
    break;
  case 68: //right
    main.keys[1]=false;
    break;
  }
}

void draw() {
  background(200);
  main.bullet();
  main.bulletUpdate();
  main.shoot();
  main.update();
  main.display();
}
