class Screen
{
  private int sizeX = 64;
  private int sizeY = 64;
  private PImage image = new PImage();
  private PImage HDImage = new PImage();
  private PImage defaultImage;
  private String defaultImageName;
  
  //private color[][] pixelMatrix = new color[64][64];
  private int EdgeNeighbours[] = new int[4];
   
  Screen(int X, int Y, String imgName){
    sizeX = X;
    sizeY = Y;
    defaultImageName = imgName;
    image = createImage(sizeX,sizeY,RGB);
    image = loadImage(defaultImageName);
    HDImage = createImage(sizeX*10,sizeY*10,RGB);
    generateHDImage();
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
    if(x >= sizeX || y >= sizeY || x < 0 || y < 0) 
      return false;
    image.loadPixels();
    image.pixels[x+y*sizeX] = col;
    image.updatePixels();
    return true;
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