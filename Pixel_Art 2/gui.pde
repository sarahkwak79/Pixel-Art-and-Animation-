/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.
 
 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
 // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:265492:
  appc.background(230);
} //_CODE_:window1:265492:

public void playBtn(GButton source, GEvent event) { //_CODE_:play:664684:
  imp = 1;
  isPlay = true;
} //_CODE_:play:664684:

public void brushsize(GDropList source, GEvent event) { //_CODE_:BrushSize:468207:
  brushSize = BrushSize.getSelectedIndex();
} //_CODE_:BrushSize:468207:

public void saveToComputer(GButton source, GEvent event) { //_CODE_:SaveToComputer:433657:
  
  for (int i = 0; i < c.n; i++ ) {
    for (int j =0; j < c.n; j++) {
      if (!c.hasColor[i][j])
        c.blockColor[i][j] = white;  //turn pixels that does not have a colour into white
    }
  }

  for (int a = 0; a < c.hasMouse.length; a++)
    for (int b = 0; b < c.hasMouse.length; b++)
      c.hasMouse[a][b] = false;

  delay(250);
  save(animationFld+"/Image" + im + ".png");  //save to computer

  //Crop out the saved image so that the colur palettes will not show
  String path = sketchPath();
  try {
    BufferedImage originalImg = ImageIO.read(new File(path + "\\" + animationFld + "\\Image" + im +".png"));

    BufferedImage SubImg = originalImg.getSubimage(70, 0, 650, 650);

    File outputfile = new File(path + "\\" + animationFld + "\\Image" + im +".png");
    ImageIO.write(SubImg, "png", outputfile);
  } 
  catch (FileNotFoundException ex ) {

    ex.printStackTrace();
  } 
  catch (IOException e) {

    e.printStackTrace();
  }

  for (int i = 0; i < c.n; i++ ) {  //bring back the canvas
    for (int j =0; j < c.n; j++) {
      if (!c.hasColor[i][j])
        c.checkered(i, j);
    }
  }
  
  PrintWriter pw1 = createWriter("data/data.txt");  // update number of frames 
  int numImages = Integer.parseInt(imageData[animationFld.charAt(animationFld.length()-1) -'1']);
  
  if (im > numImages)
    imageData[animationFld.charAt(animationFld.length()-1) -'1'] = im+"";
  String imageCount = "";
  
  for (int count = 0; count < 5; count++) {
    imageCount += imageData[count] + ((count < 5)?"\n":"");
    
  }  
  pw1.print(imageCount);
  pw1.close();
  im++;
} //_CODE_:SaveToComputer:433657:

public void customColourBtn(GButton source, GEvent event) { //_CODE_:customColor:854745:
  // call window for custom colours
  javaColor  = JColorChooser.showDialog(null, "Java Color Chooser", Color.white);
  if (javaColor!=null)
    colour = color(javaColor.getRed(), javaColor.getGreen(), javaColor.getBlue());
  updateCircleColor(colour);
} //_CODE_:customColor:854745:

public void clearBtn(GButton source, GEvent event) { //_CODE_:clear:252055:
  c.initCanvas();
} //_CODE_:clear:252055:

public void NumOfPixel(GDropList source, GEvent event) { //_CODE_:NumOfPixels:947347:
  c.n = int(NumOfPixels.getSelectedText());
  c.resetData();
} //_CODE_:NumOfPixels:947347:

public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButton1:847209:
  erase = false;
} //_CODE_:imgButton1:847209:

public void imgButton2_click1(GImageButton source, GEvent event) { //_CODE_:imgButton2:421547:
  erase = true;
} //_CODE_:imgButton2:421547:

public void redBtn(GImageButton source, GEvent event) { //_CODE_:Red:412770:
  colour = red;
} //_CODE_:Red:412770:

public void orangeBtn(GImageButton source, GEvent event) { //_CODE_:Orange:587721:
  colour = orange;
} //_CODE_:Orange:587721:

public void yellowBtn(GImageButton source, GEvent event) { //_CODE_:Yellow:268245:
  colour = yellow;
} //_CODE_:Yellow:268245:

public void greenBtn(GImageButton source, GEvent event) { //_CODE_:Green:313962:
  colour = green;
} //_CODE_:Green:313962:

public void blueBtn(GImageButton source, GEvent event) { //_CODE_:Blue:802784:
  colour = blue;
} //_CODE_:Blue:802784:

public void navyBtn(GImageButton source, GEvent event) { //_CODE_:Navy:934161:
  colour = navy;
} //_CODE_:Navy:934161:

public void purpleBtn(GImageButton source, GEvent event) { //_CODE_:Purple:616098:
  colour = purple;
} //_CODE_:Purple:616098:

public void pinkBtn(GImageButton source, GEvent event) { //_CODE_:Pink:300001:
  colour = pink;
} //_CODE_:Pink:300001:

public void blackBtn(GImageButton source, GEvent event) { //_CODE_:Black:647522:
  colour = black;
} //_CODE_:Black:647522:

public void whiteBtn(GImageButton source, GEvent event) { //_CODE_:White:865317:
  colour = white;
} //_CODE_:White:865317:

public void Undo(GImageButton source, GEvent event) { //_CODE_:undo:902983:
  if (history1.size() == 0)
    return;
  ColourHistory h = history1.get(history1.size() - 1);  // remove the latest pixel
  c.checkered(h.hx, h.hy);
  history2.add(h);  // add to another arraylist for redo
  history1.remove(history1.size() - 1);
} //_CODE_:undo:902983:

public void Redu(GImageButton source, GEvent event) { //_CODE_:redu:637934:
  if (history1.size() == 0)
    return;

  //bring back deleted pixel
  ColourHistory h1 = history2.get(history2.size() - 1);  
  c.blockColor[h1.hx][h1.hy] = h1.hColour;
  history1.add(h1);
  history2.remove(history2.size() - 1);
} //_CODE_:redu:637934:

public void stopBtn(GButton source, GEvent event) { //_CODE_:stop:454256:
  isPlay = false;
  exIsPlay = false;
} //_CODE_:stop:454256:

public void saveDrawing(GButton source, GEvent event) { //_CODE_:drawing:606061:
  for (int i = 0; i < c.n; i++ ) {
    for (int j =0; j < c.n; j++) {
      if (!c.hasColor[i][j])
        c.blockColor[i][j] = white; //turn pixels that does not have a colour into white
    }
  }

  for (int a = 0; a < c.hasMouse.length; a++)
    for (int b = 0; b < c.hasMouse.length; b++)
      c.hasMouse[a][b] = false;

  im1 = extractMasterpiece() + 1; //For saving the picture as a different name then the previous one

  delay(250);
  save("Pictures/Masterpiece" + im1 + ".png");  //save to computer

  //Crop out the saved image so that the colur palettes will not show
  String path = sketchPath();
  try {
    BufferedImage originalImg = ImageIO.read(new File(path + "\\Pictures\\Masterpiece" + im1 + ".png"));

    BufferedImage SubImg = originalImg.getSubimage(70, 0, 650, 650);

    File outputfile = new File(path + "\\Pictures\\Masterpiece" + im1 +".png");
    ImageIO.write(SubImg, "png", outputfile);
  } 
  catch (FileNotFoundException ex ) {
    ex.printStackTrace();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  for (int i = 0; i < c.n; i++ ) {
    for (int j =0; j < c.n; j++) {
      if (!c.hasColor[i][j])
        c.checkered(i, j); //bring back the canvas
    }
  }   
  im1++;
  mpCount++;
  updateNumMasterpiece();  // update text file
} //_CODE_:drawing:606061:

public void animationSpeeds(GSlider source, GEvent event) { //_CODE_:animationSpeed:934632:
  aniSpeed = animationSpeed.getValueF();
} //_CODE_:animationSpeed:934632:

public void animationDemo(GButton source, GEvent event) { //_CODE_:button1:576667:
  exIsPlay = true;
} //_CODE_:button1:576667:

public void animationfolder(GDropList source, GEvent event) { //_CODE_:animationFolder:473240:
  animationFld = animationFolder.getSelectedText();
  im = 1;
  if (animationFld == "Animation1")
    im = imNum1;
  else if (animationFld == "Animation2")
    im = imNum2;
  else if (animationFld == "Animation3")
    im = imNum3;
  else if (animationFld == "Animation4")
    im = imNum4;
  else if (animationFld == "Animation5")
    im = imNum5;
} //_CODE_:animationFolder:473240:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 500, 500, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  label1 = new GLabel(window1, 19, 48, 80, 30);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Number of Pixels");
  label1.setOpaque(false);
  label3 = new GLabel(window1, 16, 140, 150, 20);
  label3.setText("Standard Colours");
  label3.setOpaque(false);
  play = new GButton(window1, 223, 315, 80, 30);
  play.setText("Play Animation");
  play.addEventHandler(this, "playBtn");
  label7 = new GLabel(window1, 18, 95, 80, 24);
  label7.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label7.setText("Brush size");
  label7.setOpaque(false);
  BrushSize = new GDropList(window1, 107, 97, 90, 80, 3, 10);
  BrushSize.setItems(loadStrings("list_468207"), 0);
  BrushSize.addEventHandler(this, "brushsize");
  SaveToComputer = new GButton(window1, 127, 312, 80, 39);
  SaveToComputer.setText("Save For Animation");
  SaveToComputer.addEventHandler(this, "saveToComputer");
  customColor = new GButton(window1, 17, 220, 180, 30);
  customColor.setText("Custom Colour");
  customColor.setLocalColorScheme(GCScheme.CYAN_SCHEME);
  customColor.addEventHandler(this, "customColourBtn");
  clear = new GButton(window1, 402, 16, 80, 30);
  clear.setText("Clear Canvas");
  clear.addEventHandler(this, "clearBtn");
  NumOfPixels = new GDropList(window1, 108, 51, 90, 140, 6, 10);
  NumOfPixels.setItems(loadStrings("list_947347"), 1);
  NumOfPixels.addEventHandler(this, "NumOfPixel");
  imgButton1 = new GImageButton(window1, 224, 90, 40, 40, new String[] { "brush1.png", "brush3.png", "brush2.png" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  imgButton2 = new GImageButton(window1, 287, 90, 40, 40, new String[] { "eraser1.png", "eraser2.png", "eraser3.png" } );
  imgButton2.addEventHandler(this, "imgButton2_click1");
  Red = new GImageButton(window1, 18, 175, 30, 30, new String[] { "red1.png", "red2.png", "red3.png" } );
  Red.addEventHandler(this, "redBtn");
  Orange = new GImageButton(window1, 65, 175, 30, 30, new String[] { "orange1.png", "orange2.png", "green3.png" } );
  Orange.addEventHandler(this, "orangeBtn");
  Yellow = new GImageButton(window1, 110, 175, 30, 30, new String[] { "yellow1.png", "yello2.png", "yellow3.png" } );
  Yellow.addEventHandler(this, "yellowBtn");
  Green = new GImageButton(window1, 155, 175, 30, 30, new String[] { "green1.png", "green2.png", "green3 (2).png" } );
  Green.addEventHandler(this, "greenBtn");
  Blue = new GImageButton(window1, 202, 175, 30, 30, new String[] { "blue2.png", "blue1.png", "blue4.png" } );
  Blue.addEventHandler(this, "blueBtn");
  Navy = new GImageButton(window1, 245, 175, 29, 30, new String[] { "navy1.png", "navy2.png", "navy3.png" } );
  Navy.addEventHandler(this, "navyBtn");
  Purple = new GImageButton(window1, 290, 175, 30, 30, new String[] { "purple1.png", "purple 2.png", "purple3.png" } );
  Purple.addEventHandler(this, "purpleBtn");
  Pink = new GImageButton(window1, 335, 175, 30, 30, new String[] { "pink1.png", "pink2.png", "pink3.png" } );
  Pink.addEventHandler(this, "pinkBtn");
  Black = new GImageButton(window1, 380, 175, 30, 30, new String[] { "black1.png", "black2.png", "black3.png" } );
  Black.addEventHandler(this, "blackBtn");
  White = new GImageButton(window1, 423, 175, 30, 30, new String[] { "white1.png", "white2.png", "white3.png" } );
  White.addEventHandler(this, "whiteBtn");
  undo = new GImageButton(window1, 235, 222, 40, 30, new String[] { "undo1.png", "undo2.png", "undo3.png" } );
  undo.addEventHandler(this, "Undo");
  redu = new GImageButton(window1, 292, 220, 42, 36, new String[] { "redo1.png", "redo2.png", "redo3.png" } );
  redu.addEventHandler(this, "Redu");
  stop = new GButton(window1, 320, 314, 80, 30);
  stop.setText("Stop");
  stop.addEventHandler(this, "stopBtn");
  drawing = new GButton(window1, 19, 267, 80, 36);
  drawing.setText("Save As Drawing");
  drawing.addEventHandler(this, "saveDrawing");
  animationSpeed = new GSlider(window1, 12, 398, 200, 60, 10.0);
  animationSpeed.setShowValue(true);
  animationSpeed.setShowLimits(true);
  animationSpeed.setLimits(1.0, 0.0, 2.0);
  animationSpeed.setNbrTicks(21);
  animationSpeed.setStickToTicks(true);
  animationSpeed.setNumberFormat(G4P.DECIMAL, 1);
  animationSpeed.setOpaque(false);
  animationSpeed.addEventHandler(this, "animationSpeeds");
  label2 = new GLabel(window1, 14, 367, 100, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("Animation Speed");
  label2.setOpaque(false);
  button1 = new GButton(window1, 238, 407, 80, 30);
  button1.setText("Animation Demo");
  button1.addEventHandler(this, "animationDemo");
  animationFolder = new GDropList(window1, 16, 320, 90, 120, 5, 10);
  animationFolder.setItems(loadStrings("list_473240"), 0);
  animationFolder.addEventHandler(this, "animationfolder");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GLabel label1; 
GLabel label3; 
GButton play; 
GLabel label7; 
GDropList BrushSize; 
GButton SaveToComputer; 
GButton customColor; 
GButton clear; 
GDropList NumOfPixels; 
GImageButton imgButton1; 
GImageButton imgButton2; 
GImageButton Red; 
GImageButton Orange; 
GImageButton Yellow; 
GImageButton Green; 
GImageButton Blue; 
GImageButton Navy; 
GImageButton Purple; 
GImageButton Pink; 
GImageButton Black; 
GImageButton White; 
GImageButton undo; 
GImageButton redu; 
GButton stop; 
GButton drawing; 
GSlider animationSpeed; 
GLabel label2; 
GButton button1; 
GDropList animationFolder; 
