//INSTRUCTIONS
// Drawing: 1. Draw!
//          2. Press "Save As Image" button
//          3. Go into the Picture folder and see your drawing!

// Animation: 1. Select the folder in which you want to save your animation in. (Up to 5 folders, you can create 5 different animation) 
//           2. Draw frames 
//           3. Each frame click "Save For Animation" 
//           4. After you are finshed drawing all the frames, click "Play Animation" to see your animation!

//To see demo animation: 1. Click "Demo Animation"
//                       2. Click "Play Animation" 

//IMPORTS
import g4p_controls.*;
import javax.swing.JColorChooser;
import java.awt.Color;

import java.io.*;
import java.lang.*;
import java.io.FilenameFilter;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.io.FileNotFoundException;

PImage img;
PImage exImg;

//VARIABLES
ArrayList<ColourHistory> history1 = new ArrayList <ColourHistory>();
ArrayList<ColourHistory> history2 = new ArrayList <ColourHistory>();
Canvas c = new Canvas(25);
ColourPalette[] colourPal = new ColourPalette[6];

int padding  = 70;
int brushSize = 0;
int countBtn = 0;
int mx;
int my;
boolean erase = false;
float aniSpeed = 1;
int im = 1;
int imNum1 = 1;
int imNum2 = 1;
int imNum3 = 1;
int imNum4 = 1;
int imNum5 = 1;
int im1 = 1;
int imp = 1;
int exIm = 1; 
int mpCount;
boolean isPlay = false;
boolean exIsPlay = false;
String animationFld = "Animation1";
String[] imageData;

//COLOURS
color red = color(255, 0, 0);
color orange = color(255, 129, 3);
color yellow = color(255, 235, 3);
color green = color(50, 205, 50);
color blue = color(100, 230, 255);
color navy = color(0, 36, 175);
color purple = color(90, 11, 160);
color pink = color(255, 0, 255);
color black = color(0);
color white = color(255);
color colour;
Color javaColor;


void setup() {
  size(720, 650);
  createGUI();
  c.resetData();
  mpCount = extractMasterpiece();
  imageData = loadStrings("data/data.txt");
  println(java.util.Arrays.toString(imageData));

  for (int i = 0; i < 6; i++)
    colourPal[i] = new ColourPalette(35, 70+100 * i, (200));
}

void draw() {
  background(255);  
  noStroke();
  if (!isPlay) {
    for (int i = 0; i < c.n; i++ ) {
      for (int j =0; j < c.n; j++) {
        float x = padding + i*c.blockSize;  
        float y = j*c.blockSize;

        fill(c.blockColor[i][j]);

        if (c.hasMouse[i][j])
          if (erase)
            fill(black, 10);
          else
            fill(colour, 90);

        rect(x, y, c.blockSize, c.blockSize);
      }
    }
    for (int s = 0; s < 6; s++) {
      fill(colourPal[s].getColor());
      ellipse (colourPal[s].getX(), colourPal[s].getY(), 50, 50);
    }
  }
  
  // When demo example is played
  else if (exIsPlay){
    exImg = loadImage("Example/Image" + exIm + ".png");
    image(exImg, 70, 0);
    delay(200);
    exIm++;
    if (exIm == 6)
      exIm = 1; 
  }
  
  //When animation is played
  else {
    im = Integer.parseInt(imageData[animationFld.charAt(animationFld.length()-1) -'1']);
    if (im > 0){
      img = loadImage(animationFld + "/Image" + imp + ".png");
      image(img, 70, 0);
      delay(int(aniSpeed * 1000));
      imp++;
   
      if (imp > im)
        imp = 1;
    }
  }
}

// Measure which pixel the mouse is on
void pixelPosition(){
  mx = (mouseX - padding) / (int)c.blockSize;
  my = mouseY / (int)c.blockSize;
}


void mouseMoved() {
  for (int i = 0; i < c.hasMouse.length; i++)
    for (int j = 0; j < c.hasMouse.length; j++)
      c.hasMouse[i][j] = false;
      
  pixelPosition();

  try {
     if (mouseX > 70 && mouseX < width && mouseY > 0 && mouseY < height)
      c.hasMouse[mx][my] = true;
  }

  catch(Exception e) {
  }
}


void mousePressed() {
  pixelPosition();

  try {
    for (int a = -brushSize; a <= brushSize; a++) {  // Check for brush size
      for (int b = -brushSize; b <= brushSize; b++) {
        if (erase) { 
          c.checkered(mx+a, my+b);
          c.hasColor[mx+a][my+b] = false;
        } 
        else {
          for (ColourPalette cp : colourPal) {
            if (cp.mouseInCircle(mouseX, mouseY))
              print("in circle");

            else
               if (mouseX > 70 && mouseX < width && mouseY > 0 && mouseY < height)
              c.blockColor[mx+a][my+b] = colour;
          }

          c.hasColor[mx+a][my+b] = true;
          ColourHistory h = new ColourHistory(mx+a, my+b, colour); //For undo button
          history1.add(h);
        }
      }
    }
  }
  catch(Exception e) {
  }

  // When clicked on a colour palette, the color changes to the corresponding color
  for (ColourPalette cp : colourPal) {
    if (cp.mouseInCircle(mouseX, mouseY))
      if (cp.getHasColor())
        colour = cp.getColor();
  }
}

void mouseDragged() {
  if (mousePressed) {
    for (int i = 0; i < c.hasMouse.length; i++)
      for (int j = 0; j < c.hasMouse.length; j++)
        c.hasMouse[i][j] = false;

   pixelPosition();

    try {
      for (int a = -brushSize; a <= brushSize; a++) {    // Check for brush size
        for (int b = -brushSize; b <= brushSize; b++) {
          if (erase) { 
            c.checkered(mx+a, my+b);
            c.hasColor[mx+a][my+b] = false;
          } 
          
          else {
            c.blockColor[mx+a][my+b] = colour;
            c.hasColor[mx+a][my+b] = true;
            ColourHistory h = new ColourHistory(mx+a, my+b, colour);  // For undo button
         
            if (!history1.contains(h)) 
              history1.add(h);
          }
        }
      }
    }
    catch(Exception e) {
    }
  }
}

// When a custom colour is picked, adds that colour to the colour palette
void updateCircleColor(color c) {
  colourPal[countBtn].setColor(c);
  colourPal[countBtn].setHasColor(true);
  countBtn++;
  if (countBtn % 6 == 0) 
    countBtn = 0;
}

//Saves the number of pictures saved in a text file
void updateNumMasterpiece() {  
  PrintWriter pw = createWriter("data/Masterpiece totals.txt");
  pw.print(mpCount);
  pw.close();
}

// Get the number from the text file
int extractMasterpiece() {
  String[] lines = loadStrings("Masterpiece totals.txt");
  int currentcount = int(lines[0]);

  return currentcount;
}

//int extractAni(){
//  for (int i=0; i< imageData.length; i++){
//    int currentNum = int(imageData[i]);
//  }
//}
