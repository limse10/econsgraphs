import processing.svg.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;


SVG svg = new SVG();

Button[] mains = new Button[5];
String[] labels = {"LINES", "POINTS", "TEXT", "SHADING", "EXPORT", };
PImage[] mainicons = new PImage[5];
Button[] sub0 = new Button[5];
String[] labels0 = {"Add Line", "Add Curve", "Add Super\nCool Curve", "Add AS", "Delete Line", };
Button[] sub1 = new Button[0];
String[] labels1 = {"Add/Remove\nFree Points"};
Button[] sub2 = new Button[3];
String[] labels2 = {"Auto Add\nText Boxes", "+1 Text Box", "Delete Text"};
Button[] sub3 = new Button[4];
String[] labels3 = {"Select Area", "Shade", "Colour", "Delete Shade"};
Button[] sub4 = new Button[2];
String[] labels4 = {"Export PNG", "Export SVG"};
Button[] colorbuttons = new Button[6];
color[] colors = {color(0, 128, 255), color(0, 255, 0), color(255, 0, 0), color(0, 255, 255), color(255, 255, 0), color(255, 0, 255)};



Window w;

Container main;
Container[] subs = new Container[5];
Container cols;

Line[] lines = new Line[0];
Line yaxis;
Line xaxis;
Line[] axes = new Line[2];

Point[] points = new Point[0];

Fill[] fills = new Fill[0];
Point[] fill = new Point[0];

Boolean[] keys = new Boolean[3];
Line copied;

TextBox[] tbs = new TextBox[0];

int x=0;
int imageCount = 0;
int u;
color bg = color(230);
boolean focus = false;
float mode=-2;
boolean keyTyped = false;
int DOTTED = 1;
boolean exporting = false;

final int MAIN = 0;
final int SUB = 1;
final int SUBSUB = 2;


void setup() {
  String dir = sketchPath("Diagrams/");
  File diags = new File(dir);
  if (diags.exists() && diags.isDirectory()) {
    imageCount =diags.listFiles().length;
  }

  String icopath = sketchPath("source/icons/main/");
  String[] filenames = listFileNames(icopath);
  for (int i = 0; i < mainicons.length; i++) {
    mainicons[i] = loadImage(icopath+filenames[i]);
  }



  size(1200, 800, P2D);
  //fullScreen();
  surface.setResizable(true);
  u = height/10;
  background(bg);

  keys[0]=false;
  keys[1]=false;
  keys[2]=false;

  
  w = new Window(1.5*u, u, width-1.5*u, height-u, u/2);

  main = new Container(mains, labels, mainicons, MAIN);
  subs[0] = new Container(sub0, labels0, null, SUB);
  subs[1] = new Container(sub1, labels1, null, SUB);
  subs[2] = new Container(sub2, labels2, null, SUB);
  subs[3] = new Container(sub3, labels3, null, SUB);
  subs[4] = new Container(sub4, labels4, null, SUB);


  for (int i=0; i<colors.length; i++) {
    colorbuttons[i]=new Button(colors[i], subs[3].buttons[2], i);
    colorbuttons[i].visible=false;
  }
  //subs[3].buttons[2].bs=colorbuttons;




  PVector[] tempy = new PVector[2];
  tempy[0]=new PVector(0, 0);
  tempy[1]=new PVector(0, w.h);
  yaxis=new Line(3, tempy);
  PVector[] tempx = new PVector[2];
  tempx[0]=new PVector(0, 0);
  tempx[1]=new PVector(w.w, 0);
  xaxis=new Line(3, tempx);
  axes[0]=xaxis;
  axes[1]=yaxis;
  
  
  
  
}


void draw() {

  render(bg, false);
}
