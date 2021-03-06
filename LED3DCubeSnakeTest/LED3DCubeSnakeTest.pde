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
  float fov = PI/3.0; 
  float cameraZ = (height/2.0) / tan(fov/2.0); 
  perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0); 
  Screens[0] = new Screen(64, 64, "1.jpg");
  Screens[1] = new Screen(64, 64, "2.jpg");
  Screens[2] = new Screen(64, 64, "3.jpg");
  Screens[3] = new Screen(64, 64, "4.jpg");
  Screens[4] = new Screen(64, 64, "5.jpg");
  Screens[5] = new Screen(64, 64, "6.jpg");

  //Screens[0].randomizeColors();
  Screens[0].clearScreen();
  
}

void draw() {
  background(20);
  lights();
  //camera(mouseX*2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, 0);
  if (mousePressed) {
    rotX = mouseY*0.01;
    rotY = mouseX*0.01;
  } else {
    //rotY += 0.01;
  }
  rotateY(rotY);
  rotateX(rotX);

  //if (keyPressed == true) {
  //  Screens[0].clearScreen();
  //}else{
  //  Screens[0].randomizeColors();
  //}


  //Snake will happen here
  if (frameCount%5 == 0) {
    //Screens[0].clearScreen();
    //Screens[0].setAllPixel(color(255,255,255));
    Screens[0].clearScreen();
    Screens[0].showDefaultImage();
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
    SnakeVelocity[0] = 0;
    SnakeVelocity[1] = 0;
    switch(keyCode){
      case UP:
        SnakeVelocity[1] = -1;
        break;
      case DOWN:
        SnakeVelocity[1] = 1;
        break;
      case LEFT:
        SnakeVelocity[0] = -1;
        break;
      case RIGHT:
        SnakeVelocity[0] = 1;
        break;
    }
  }

  for (int i = SnakeTail.size()-1; i > SnakeTail.size()-1-SnakeTailSize; i--)
  {
    if(i >= 0)
      Screens[0].setPixel(SnakeTail.get(i)[0], SnakeTail.get(i)[1], SnakeColor);
  }
  
  //Draw Foodpixel
  Screens[0].setPixel(FoodPos[0],FoodPos[1],color(255,0,0));

  
  

  //Update Screen
  Screens[0].update();

  imageMode(CENTER);
  image(Screens[0].getHDImage(), 0, 0, 640, 640);
  translate(640,0,0);
  image(Screens[1].getHDImage(), 0, 0, 640, 640);
}