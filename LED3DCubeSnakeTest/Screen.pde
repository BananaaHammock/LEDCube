class Screen
{
  private int sizeX = 64;
  private int sizeY = 64;
  private PImage image = new PImage();
  private PImage HDImage = new PImage();
  private PImage defaultImage;
  private String defaultImageName;
  
  //private color[][] pixelMatrix = new color[64][64];
  //Screen Neighbours, 0:top 1:right 2:bottom 3:left
  private Screen EdgeNeighbours[] = new Screen[4];
   
  Screen(int X, int Y, String imgName){
    sizeX = X;
    sizeY = Y;
    defaultImageName = imgName;
    image = createImage(sizeX,sizeY,RGB);
    image = loadImage(defaultImageName);
    HDImage = createImage(sizeX*10,sizeY*10,RGB);
    generateHDImage();
  }
  
  public void setNeighbours(Screen Scr0, Screen Scr1, Screen Scr2, Screen Scr3){
    EdgeNeighbours[0] = Scr0;
    EdgeNeighbours[1] = Scr1;
    EdgeNeighbours[2] = Scr2;
    EdgeNeighbours[3] = Scr3;
  }
  
  void randomizeColors(){
    image.loadPixels();
    for(int i = 0; i<sizeX; i++){
      for(int j = 0; j<sizeY; j++){
        setPixel(i,j,color(random(255), random(255), random(255)));
        //int loc = j + i*sizeX;
        //image.pixels[loc] = color(random(255), random(255), random(255));
      }
    }
    image.updatePixels();
    generateHDImage();
  }
  
  private void generateHDImage(){
    image.loadPixels();
    HDImage.loadPixels();
    for(int i = 0; i<sizeX; i++){
      for(int j = 0; j<sizeY; j++){
        int loc = j + i*sizeX;
        color tempColor = image.pixels[loc];
        for(int k = i*10; k < i*10+10; k++){
          for(int l = j*10; l < j*10+10; l++){
            int locHD = l + k*(sizeX*10);
            if(l%10 == 0 || l%10 == 9 || k%10 == 0 || k%10 == 9){
              HDImage.pixels[locHD] = color(0,0,0);
            }else{
              HDImage.pixels[locHD] = tempColor;
            }
          }
        }
      }
    }
    HDImage.updatePixels();
  }
  
  public color getPixel(int x, int y){
    return 1;
  }
  
  public boolean setPixel(int x, int y, color col){
    if(x < sizeX && y < sizeY && x >= 0 && y >= 0){ //within this display range
      image.loadPixels();
      image.pixels[x+y*sizeX] = col;
      image.updatePixels();
      return true;
    }else if(x >= sizeX){ //right edge (1)
      if(EdgeNeighbours[1] == null) 
        return false;
      return EdgeNeighbours[1].setPixel(x-sizeX,y,col); //vertical connection
    }else if(x < 0){ //left edge (3)
      if(EdgeNeighbours[3] == null) 
        return false;
      return EdgeNeighbours[3].setPixel(x+sizeX,y,col); //vertical connection
    }
    return false; 
  }
  
  public void clearScreen(){
    image.loadPixels();
    for(int i = 0; i<sizeX; i++){
      for(int j = 0; j<sizeY; j++){
        int loc = j + i*sizeX;
        image.pixels[loc] = color(0,0,0);
      }
    }
    image.updatePixels();
    update();
  }
  
  public void showDefaultImage(){
    image = loadImage(defaultImageName);
    update();
  }
  
  public void setAllPixel(color col){
    image.loadPixels();
    for(int i = 0; i<sizeX; i++){
      for(int j = 0; j<sizeY; j++){
        int loc = j + i*sizeX;
        image.pixels[loc] = col;
      }
    }
    image.updatePixels();
    update();
  }
  
  public void update(){
    generateHDImage();
  }
  
  public PImage getImage(){
    return image;
  }
  
  public PImage getHDImage(){
    return HDImage;
  }
}