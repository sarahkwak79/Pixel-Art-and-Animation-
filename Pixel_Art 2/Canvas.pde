class Canvas{
  //FIELD
  int n;
  boolean[][] blocks;
  boolean[][] hasMouse;
  boolean[][] hasColor;
  color[][] blockColor;
  float blockSize;
  
  //CONSTRUCTOR
  Canvas (int n){
    this.n = n;
  }
  
  // How the canvas looks like in the start
  void initCanvas() {
    for (int i = 0; i < this.n; i++ ) { 
      for (int j =0; j < this.n; j++) {
        checkered(i,j);
      }
    }
  }
  
  // White and gray pixels
  void checkered(int i,int j){
    if ( j % 2 == 0 && i % 2 == 0)
          blockColor[i][j] = color (235);
        else if ( j % 2 == 1 && i % 2 == 1)
          blockColor[i][j] = color (235);
        else 
        blockColor[i][j] = color (255);
  }
  
  void resetData(){
    blocks = new boolean[this.n][this.n];   
    blockColor = new color[this.n][this.n];
    hasMouse = new boolean[this.n][this.n];
    hasColor = new boolean[this.n][this.n];
    blockSize = Math.round(float(width-padding)/this.n); // size of each pixel
    initCanvas();
  }
}
