class ColourPalette{
  //FIELD
  private int x;
  private int y;
  private color c;
  private boolean hasColor;
  
  //CONSTRUCTOR
  ColourPalette(int x, int y, color c){
    this.x = x;
    this.y = y;
    this.c = c;
    this.hasColor = false;
  }
  
 int getColor(){
    return this.c;
  }
  
  void setColor(color c){
    this.c = c;
  }
  
  boolean getHasColor(){
    return this.hasColor;
  }
  
  void setHasColor(boolean hasColor){
    this.hasColor = hasColor;
  }
  
  int getX(){
    return this.x;
  }
  
  int getY(){
    return this.y;
  }
  
  //When mouse is in the circle
  boolean mouseInCircle(int mx, int my){
      return pow(x - mx, 2) + pow(y - my, 2) <= 2500;
  }
}
