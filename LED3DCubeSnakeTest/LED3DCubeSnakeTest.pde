Screen[] Screens = new Screen[6];
float rotX = 0, rotY = 0;

color SnakeColor = color(0, 255, 0);
int[] SnakePos = {32, 32};
ArrayList <int[]> SnakeTail = new ArrayList <int[]>();
int[] SnakeVelocity = {1, 0};
int SnakeTailSize = 3;
boolean foodIsThere = false;
int[] FoodPos = {0,0};

void setup() {
  size(1280, 720, P3D);
  //fullScreen(P3D, 1);
  noStroke();
  fill(255);
  float fov = PI/2; 
  float cameraZ = (height/2.0) / tan(fov/2.0); 
  perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
  Screens[0] = new Screen(64, 64, "1.jpg");
  Screens[1] = new Screen(64, 64, "2.jpg");
  Screens[2] = new Screen(64, 64, "3.jpg");
  Screens[3] = new Screen(64, 64, "4.jpg");
  Screens[4] = new Screen(64, 64, "5.jpg");
  Screens[5] = new Screen(64, 64, "6.jpg");

  Screens[0].setNeighbours(Screens[0], Screens[1], Screens[0], Screens[1]);
  Screens[1].setNeighbours(Screens[1], Screens[0], Screens[1], Screens[0]);
  //Screens[2].setNeighbours(Screens[2], Screens[2], Screens[3], Screens[1]);
  //Screens[3].setNeighbours(Screens[3], Screens[3], Screens[0], Screens[3]);
  //Screens[4].setNeighbours(Screens[5], Screens[0], Screens[4], Screens[4]);
  //Screens[5].setNeighbours(Screens[0], Screens[4], Screens[5], Screens[5]);
  
}

void draw() {
  background(20);
  lights();
  //camera(mouseX*2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, 0);
  if (mousePressed) {
    rotX = mouseY*0.01;
    rotY = mouseX*0.01;
  } 
  rotateY(rotY);
  rotateX(rotX);

  //Snake will happen here
  if (frameCount%3 == 0) {
    for (int i = 0; i < 6; i++){
      Screens[i].clearScreen();
      Screens[i].showDefaultImage();
    }
    
    SnakePos[0] += SnakeVelocity[0];
    SnakePos[1] += SnakeVelocity[1];
    
    if(SnakePos[0] == FoodPos[0] && SnakePos[1] == FoodPos[1]){
      //eat
      foodIsThere = false;
      SnakeTailSize++;
    }
    
    //Foodspawn
    if(!foodIsThere){
      FoodPos[0] = int(random(0,64));
      FoodPos[1] = int(random(0,64));
      foodIsThere = true;
    }
    
    int[] tempPos = {SnakePos[0],SnakePos[1]};
    SnakeTail.add(tempPos);
  }
  
  
  if(keyPressed){
    //moved to function keyPressed() below
    
  }

  for (int i = SnakeTail.size()-1; i > SnakeTail.size()-1-SnakeTailSize; i--)
  {
    if(i >= 0)
      Screens[0].setPixel(SnakeTail.get(i)[0], SnakeTail.get(i)[1], SnakeColor);
  }
  
  //Draw Foodpixel
  Screens[0].setPixel(FoodPos[0],FoodPos[1],color(255,0,0));

  
  

  //Update Screen
  //for (int i = 0; i < 6; i++)
  //Screens[i].update();

  imageMode(CENTER);
  image(Screens[0].getHDImage(), 0, 0, 640, 640);
  translate(640,0,0);
  image(Screens[1].getHDImage(), 0, 0, 640, 640);
  //translate(640,0,0);
  //image(Screens[2].getHDImage(), 0, 0, 640, 640);
  //translate(-3*640,0,0);
  //image(Screens[3].getHDImage(), 0, 0, 640, 640);
  //translate(640,-640,0);
  //image(Screens[4].getHDImage(), 0, 0, 640, 640);
  //translate(0,2*640,0);
  //image(Screens[5].getHDImage(), 0, 0, 640, 640);
}

void keyPressed() {
  switch(keyCode){
    case UP:
      if (SnakeVelocity[1] != 1 ){
        SnakeVelocity[1] = -1;
        SnakeVelocity[0] = 0;
      }
        break;
    case DOWN:
      if (SnakeVelocity[1] != -1){
        SnakeVelocity[1] = 1;
        SnakeVelocity[0] = 0;
      }
        break;
    case LEFT:
      if (SnakeVelocity[0] != 1){
        SnakeVelocity[0] = -1;
        SnakeVelocity[1] = 0;
      }
        break;
    case RIGHT:
      if (SnakeVelocity[0] != -1){
        SnakeVelocity[0] = 1;
        SnakeVelocity[1] = 0;
      }
      break;
  }
}