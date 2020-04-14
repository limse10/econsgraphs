import processing.svg.*;

Button[] mains = new Button[5];
String[] labels = {"LINES", "POINTS", "TEXT", "SHADING", "EXPORT", };
Button[] sub0 = new Button[5];
String[] labels0 = {"Delete Line\n(DEL)", "Add Line", "Add Curve", "Add Super\nCool Curve", "Add AS"};
Button[] sub1 = new Button[1];
String[] labels1 = {"Add/Remove\nFree Points"};
Button[] sub2 = new Button[3];
String[] labels2 = {"Auto Add\nText Boxes", "+1 Text Box", "Delete Text\n(DEL)"};
Button[] sub3 = new Button[4];
String[] labels3 = {"Select Area", "Shade", "Delete Shade\n(DEL)", "Colour"};
Button[] sub4 = new Button[2];
String[] labels4 = {"Export PNG", "Export SVG"};
color[] colors = {color(0, 128, 255), color(0, 255, 0), color(255, 0, 0), color(0, 255, 255), color(255, 255, 0), color(255, 0, 255)};

Window w;

Container main;
Container[] subs = new Container[5];


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



void setup() {
  String path = sketchPath("Diagrams/");
  File file = new File(path);
  if (file.exists() && file.isDirectory()) {
    imageCount = file.listFiles().length;
  }

  size(1200, 800);
  //fullScreen();
  surface.setResizable(true);
  u = height/10;
  background(bg);

  keys[0]=false;
  keys[1]=false;
  keys[2]=false;


  w = new Window(1.5*u, u, width-1.5*u, height-u, u/2);

  main = new Container(mains, labels, MAIN);
  subs[0] = new Container(sub0, labels0, SUB);
  subs[1] = new Container(sub1, labels1, SUB);
  subs[2] = new Container(sub2, labels2, SUB);
  subs[3] = new Container(sub3, labels3, SUB);
  subs[4] = new Container(sub4, labels4, SUB);

  //for (int i = 0; i < bs.length; i++) {
  //  bs[i] = new Button(bls[i], (i+1)*u, 0, u, color(130), color(120));
  //  bs[i].visible=true;
  //}

  //for (int i = 0; i < sb1.length; i++) {
  //  sb1[i] = new Button(sb1l[i], 0, (i+1)*u, u, color(130), color(120));
  //  sb1[i].visible=false;
  //}

  //for (int i = 0; i < sb2.length; i++) {
  //  sb2[i] = new Button(sb2l[i], 0, (i+1)*u, u, color(130), color(120));
  //  sb2[i].visible=false;
  //}
  //for (int i = 0; i < sb3.length; i++) {
  //  sb3[i] = new Button(sb3l[i], 0, (i+1)*u, u, color(130), color(120));
  //  sb3[i].visible=false;
  //}
  //for (int i = 0; i < sb4.length; i++) {
  //  sb4[i] = new Button(sb4l[i], 0, (i+1)*u, u, color(130), color(120));
  //  sb4[i].visible=false;
  //}
  //for (int i = 0; i < sb5.length; i++) {
  //  sb5[i] = new Button(sb5l[i], 0, (i+1)*u, u, color(130), color(120));
  //  sb5[i].visible=false;
  //}

  //sb4[3].bs=new Button[colors.length];
  //for (int i = 0; i < colors.length; i++) {
  //  sb4[3].bs[i] = new Button(colors[i], sb4[3], i);
  //}


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

  render(bg);
}
