class ColourHistory{
  //FEILD
  int hx;
  int hy;
  color hColour;
  
  
  //CONSTRUCTOR
  ColourHistory(int hx, int hy, color hColour){
    this.hx = hx;
    this.hy = hy;
    this.hColour = hColour;
  }
  
  boolean equals(Object o){
    return this.hx == ((ColourHistory)o).hx && this.hy == ((ColourHistory)o).hy;
  }
}
