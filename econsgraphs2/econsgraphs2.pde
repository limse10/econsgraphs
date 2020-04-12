import processing.svg.*;
Button[] bs = new Button[5];
String[] bls = {"Lines", "Points", "Text", "Shading", "Export", };
Button[] sb1 = new Button[5];
String[] sb1l = {"Delete Line\n(DEL)", "Add Line", "Add Curve", "Add Super\nCool Curve", "Add AS"};
Button[] sb2 = new Button[1];
String[] sb2l = {"Add/Remove\nFree Points"};
Button[] sb3 = new Button[3];
String[] sb3l = {"Auto Add\nText Boxes","+1 Text Box", "Delete Text\n(DEL)"};
Button[] sb4 = new Button[4];
String[] sb4l = {"Select Area", "Shade", "Delete Shade\n(DEL)", "Colour"};
Button[] sb5 = new Button[2];
String[] sb5l = {"Export PNG", "Export SVG"};
color[] colors = {color(0, 128, 255), color(0, 255, 0), color(255, 0, 0), color(0, 255, 255), color(255, 255, 0), color(255, 0, 255)};

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
Window w = new Window();


int x=0;
int imageCount = 0;
int u;
color bg = color(255);
boolean focus = false;
float mode=-1;
boolean keyTyped = false;
int DOTTED = 1;
boolean exporting = false;


void setup() {
  size(1200, 800);
  //fullScreen();
  surface.setResizable(true);

  background(230);

  keys[0]=false;
  keys[1]=false;
  keys[2]=false;


  u = height/10;

  w.create(u, u, width-u, height-u, u/2);

  String path = sketchPath("Diagrams/");
  File file = new File(path);
  if (file.exists() && file.isDirectory()) {
    imageCount = file.listFiles().length;
  }

  for (int i = 0; i < bs.length; i++) {
    bs[i] = new Button(bls[i], (i+1)*u, 0, u, u, color(130), color(120));
    bs[i].visible=true;
  }

  for (int i = 0; i < sb1.length; i++) {
    sb1[i] = new Button(sb1l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb1[i].visible=false;
  }

  for (int i = 0; i < sb2.length; i++) {
    sb2[i] = new Button(sb2l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb2[i].visible=false;
  }
  for (int i = 0; i < sb3.length; i++) {
    sb3[i] = new Button(sb3l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb3[i].visible=false;
  }
  for (int i = 0; i < sb4.length; i++) {
    sb4[i] = new Button(sb4l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb4[i].visible=false;
  }
  for (int i = 0; i < sb5.length; i++) {
    sb5[i] = new Button(sb5l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb5[i].visible=false;
  }

  sb4[3].bs=new Button[colors.length];
  for (int i = 0; i < colors.length; i++) {
    sb4[3].bs[i] = new Button(colors[i], sb4[3], i);
  }

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
  background(bg);

  w.renderWindow();   

  for (Fill f : fills) {
    f.render();
  }

  for (Line l : lines) {
    l.render();
  }

  for (Point p : points) {
    p.render();
    for (Point x : p.ps) {
      x.render();
    }
  }


  for (TextBox tb : tbs) {
    tb.render();
  }




  fill(100);
  stroke(0);
  strokeWeight(4);
  rect(0, 0, width, u);
  rect(0, u, u, height);

  for (Button b : bs) {
    b.render();
  }
  for (Button b : sb1) {
    b.render();
  }
  for (Button b : sb2) {
    b.render();
  }
  for (Button b : sb3) {
    b.render();
  }
  for (Button b : sb4) {
    b.render();
  }
  for (Button b : sb5) {
    b.render();
  }
  w.renderWindow();   

  w.renderAxes();
}
