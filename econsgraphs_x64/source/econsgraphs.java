import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.svg.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class econsgraphs extends PApplet {



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
int[] colors = {color(0, 128, 255), color(0, 255, 0), color(255, 0, 0), color(0, 255, 255), color(255, 255, 0), color(255, 0, 255)};

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
int bg = color(230);
boolean focus = false;
float mode=-2;
boolean keyTyped = false;
int DOTTED = 1;
boolean exporting = false;

final int MAIN = 0;
final int SUB = 1;
final int SUBSUB = 2;


public void setup() {
  String dir = sketchPath("Diagrams/");
  File diags = new File(dir);
  if (diags.exists() && diags.isDirectory()) {
    imageCount =diags.listFiles().length;
  }

  String icopath = sketchPath("source/Icons/");
  String[] filenames = listFileNames(icopath);
  for (int i = 0; i < mainicons.length; i++) {
    mainicons[i] = loadImage(icopath+filenames[i]);
  }

  
  //fullScreen();
  surface.setResizable(true);
  u = height/10;
  background(bg);

  keys[0]=false;
  keys[1]=false;
  keys[2]=false;


  w = new Window(1.5f*u, u, width-1.5f*u, height-u, u/2);

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


public void draw() {

  render(bg, false);
}
public void mousePressed() {
  focus = false;
  if (mains[0].hovered) {
    mode=0;
  } 
  if (subs[0].buttons[4].hovered) {
    deleteLine();
  }
  if (subs[0].buttons[0].hovered) {
    PVector[] p = new PVector[2];
    if (lines.length==0) {
      p[0] = new PVector(0, 500);
      p[1] = new PVector(600, 0);
    } else if (lines.length==1) {
      p[0] = new PVector(0, 500);
      p[1] = new PVector(300, 0);
    } else {
      p[0] = new PVector(100, 100);
      p[1] = new PVector(500, 500);
    }
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (subs[0].buttons[1].hovered) {
    PVector[] p = new PVector[3];

    if (lines.length==2) {
      p[0] = new PVector(50, 200);
      p[1] = new PVector(150, 0);
      p[2] = new PVector(380, 550);
    } else if (lines.length==3) {
      p[0] = new PVector(180, 500);
      p[1] = new PVector(280, 270);
      p[2] = new PVector(480, 480);
    } else {
      p[0] = new PVector(180, 500);
      p[1] = new PVector(280, 270);
      p[2] = new PVector(480, 480);
    }
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (subs[0].buttons[2].hovered) {
    PVector[] p = new PVector[4];
    p[0] = new PVector(100, 400);
    p[1] = new PVector(500, 300);
    p[2] = new PVector(150, 200);
    p[3] = new PVector(300, 150);
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (subs[0].buttons[3].hovered) {
    PVector[] p = new PVector[2];
    p[0] = new PVector(100, 100);
    p[1] = new PVector(500, 500);
    Line l = new Line(1, p);
    lines = (Line[])append(lines, l);
  }
  if (mains[1].hovered) {
    mode=1;
    calculatePoints();
    println("-------------------------------------");

    println("current points:");
    for (Point p : points) {
      println(p.x, p.y);
      for (Point x : p.ps) {
        println("--", x.x, x.y);
      }
    }
    println("-------------------------------------");
  } 


  if (mains[2].hovered) {
    mode=2;
  } 

  if (subs[2].buttons[0].hovered) {
    generateTextBoxes();
  }
  if (subs[2].buttons[1].hovered) {

    TextBox tb = new TextBox(-90, 570, u, u/3);
    tbs=(TextBox[])append(tbs, tb);
  }

  if (subs[2].buttons[2].hovered) {
    for (int i=tbs.length-1; i>=0; i--) {
      if (tbs[i].focusing) {
        tbs=del(tbs, i);
      }
    }
  }



  for (TextBox tb : tbs) {
    if (tb.hovering&&!focus) {
      tb.xoff=w.mx-tb.x;
      tb.yoff=w.my-tb.y;
      tb.focusing=true;
      focus=true;
    } else {
      tb.focusing=false;
      focus=false;
    }
  }


  if (subs[3].buttons[0].hovered) {
    mode = 3.1f;
  }
  if (mains[3].hovered) {
    /////////////shading
    mode = 3;
    calculatePoints();
    fill=new Point[0];
    for (Point p : points) {
      for (Point x : p.ps) {

        x.shading=false;
      }
      p.shading=false;
    }
  }


  if (subs[3].buttons[1].hovered) {
    Point[] fillpts = new Point[0];
    for (Point p : points) {
      for (Point x : p.ps) {

        if (x.shading) {
          fillpts=(Point[])append(fillpts, x);
        }
      }
      if (p.shading) {
        fillpts=(Point[])append(fillpts, p);
      }
    }
    Fill f = new Fill(sortP(fillpts));

    fills=(Fill[])append(fills, f);


    for (Point p : points) {
      for (Point x : p.ps) {

        x.shading=false;
      }
      p.shading=false;
    }
    fillpts = new Point[0];
    mode = 3;
  }
  if (subs[3].buttons[3].hovered) {
    deleteFill();
  }


  if (subs[3].buttons[2].hovered) {

    if (!subs[3].buttons[2].pressed) {
                  println("er");

      subs[3].buttons[2].pressed = true;
      for (Button b : subs[3].buttons[2].bs) {
        b.visible=true;
        mode=3.2f;
      }
    } else if (subs[3].buttons[2].pressed) {
      subs[3].buttons[2].pressed = false;
      for (Button b : subs[3].buttons[2].bs) {
        b.visible=false;
        mode=3;
      }
    }
  } else {
    subs[3].buttons[2].pressed = false;
    for (Button b : subs[3].buttons[2].bs) {
      b.visible=false;
    }
  }

  for (Button b : subs[3].buttons[2].bs) {
    if (mode==3.2f) {
      if (b.hovered) {
        for (Fill f : fills) {
          if (f.focusing) {
            f.c=b.c;
          }
        }
      }
    }
  }
  

  if (mains[4].hovered) {
    //export button
    mode=-1;
  }

  if (subs[4].buttons[0].hovered) {
    imageCount++;
    render(255, false);
    PImage crop = get(PApplet.parseInt(w.x+u/2), PApplet.parseInt(w.y+u/2), PApplet.parseInt(w.w), PApplet.parseInt(w.h));
    crop.save("Diagrams/" + "diagram-" + imageCount + ".png");
  }

  if (subs[4].buttons[1].hovered) {
    imageCount++;
    beginRecord(SVG, "Diagrams/"+"diagram-" + imageCount+".svg");
    exporting=true;
    render(255, true);
    endRecord();
    exporting=false;
  }

  if ((int)mode==3) {

    for (Fill f : fills) {

      if (f.hovering&&!focus) {
        f.focusing=true;
        focus=true;
      } else {
        if (!subs[3].buttons[3].hovered) {
          f.focusing=false;
          focus=false;
        }
      }
    }
  }


  focus=false;
  if (mode==0) {
    for (Line l : lines) {
      if (l.hovering&&!focus) {
        for (Line k : lines) {
          k.focusing=false;
        }
        l.focusing = true;
        focus=true;
        for (int i = 0; i < l.p.length; i++) {
          l.transoff[i].x=w.mx-l.p[i].x;
          l.transoff[i].y=w.my-l.p[i].y;
        }
      } else {
        l.focusing = false;
        focus=false;
      }
    }
  }
  if (mode==1) {
    boolean ihaveselectedsomethingalready=false;
    for (Point p : points) {
      for (Line l : p.ls) {
        if (l.hovering) {
          if (!l.exselected) {
            l.exselected=true;
          } else {
            l.exselected=false;
          }
        }
      }
      if (p.hovering) {
        if (!p.selected) {
          p.selected=true;
          ihaveselectedsomethingalready=true;
          for (Line l : p.ls) {
            l.exselected=true;
          }
        } else {
          p.selected=false;
          ihaveselectedsomethingalready=true;
        }
      }

      if (!ihaveselectedsomethingalready) {
        for (Point x : p.ps) {
          for (Line l : x.ls) {
            if (l.hovering) {
              if (!l.exselected) {
                l.exselected=true;
              } else {
                l.exselected=false;
              }
            }
          }
          if (x.hovering) {
            if (!x.selected) {
              x.selected=true;
              for (Line l : x.ls) {
                l.exselected=true;
              }
            } else {
              x.selected=false;
            }
          }
        }
      }
    }
  }
  if (mode==3.1f) {
    boolean ihaveselectedsomethingalready=false;
    for (Point p : points) {

      if (p.hovering) {
        if (!p.shading) {
          p.shading=true;
          ihaveselectedsomethingalready=true;
        } else {
          p.shading=false;
          ihaveselectedsomethingalready=true;
        }
      }

      if (!ihaveselectedsomethingalready) {
        for (Point x : p.ps) {

          if (x.hovering) {
            if (!x.shading) {
              x.shading=true;
            } else {
              x.shading=false;
            }
          }
        }
      }
    }
  }



  if (mode == 0) {
    for (Button b : subs[0].buttons) {
      b.visible=true;
    }
    for (Button b : subs[1].buttons) {
      b.visible=false;
    }
    for (Button b : subs[2].buttons) {
      b.visible=false;
    }
    for (Button b : subs[3].buttons) {
      b.visible=false;
    }
    for (Button b : subs[4].buttons) {
      b.visible=false;
    }
  }
  if ((int)mode == 1) {
    for (Button b : subs[0].buttons) {
      b.visible=false;
    }
    for (Button b : subs[1].buttons) {
      b.visible=true;
    }
    for (Button b : subs[2].buttons) {
      b.visible=false;
    }
    for (Button b : subs[3].buttons) {
      b.visible=false;
    }
    for (Button b : subs[4].buttons) {
      b.visible=false;
    }
  }
  if (mode == 2) {
    for (Button b : subs[0].buttons) {
      b.visible=false;
    }
    for (Button b : subs[1].buttons) {
      b.visible=false;
    }
    for (Button b : subs[2].buttons) {
      b.visible=true;
    }
    for (Button b : subs[3].buttons) {
      b.visible=false;
    }
    for (Button b : subs[4].buttons) {
      b.visible=false;
    }
  }
  if ((int)mode == 3) {
    for (Button b : subs[0].buttons) {
      b.visible=false;
    }
    for (Button b : subs[1].buttons) {
      b.visible=false;
    }
    for (Button b : subs[2].buttons) {
      b.visible=false;
    }
    for (Button b : subs[3].buttons) {
      b.visible=true;
    }
    for (Button b : subs[4].buttons) {
      b.visible=false;
    }
  }
  if ((int)mode == -1) {
    for (Button b : subs[0].buttons) {
      b.visible=false;
    }
    for (Button b : subs[1].buttons) {
      b.visible=false;
    }
    for (Button b : subs[2].buttons) {
      b.visible=false;
    }
    for (Button b : subs[3].buttons) {
      b.visible=false;
    }
    for (Button b : subs[4].buttons) {
      b.visible=true;
    }
  }
}




public void keyPressed() {


  if (key==DELETE) {
    if (mode==0) {
      deleteLine();
    } else if (mode==2) {
      deleteText();
    } else if (mode==3) {
      deleteFill();
    }
  }

  if (mode==0) {

    if (keyCode==17) {
      keys[0]=true;
    } else if (keyCode==67) {
      keys[1]=true;
    } else if (keyCode==86) {
      keys[2]=true;
    }
    if (keys[1]&&keys[0]&&!keys[2]) {
      println("copy");
      for (Line l : lines) {
        if (l.focusing) {
          l.focusing=false;
          copied = new Line(l.type, l.p);
        }
      }
    }
    if (keys[1]&&keys[0]&&!keys[2]) {
      println("copy");
      for (Line l : lines) {
        if (l.focusing) {
          l.focusing=false;
          copied = new Line(l.type, l.p);
        }
      }
    }
    if (keys[2]&&keys[0]&&!keys[1]) {
      println("paste");
      if (copied!=null) {
        PVector[] p = new PVector[copied.p.length];
        for (int i = 0; i < p.length; i++) {
          p[i]=new PVector(copied.p[i].x+u, copied.p[i].y);
        }
        Line pasted = new Line(copied.type, p);
        lines=(Line[])append(lines, pasted);
        copied=pasted;
        for (Line l : lines) {
          if (l.focusing) {
            l.focusing=false;
          }
          pasted.focusing=true;
        }
      }
    }
  }


  if (keyCode==17) {
    for (TextBox tb : tbs) {
      if (tb.focusing) {
        tb.substring++; 
        tb.t=append(tb.t, "");

        tb.subscript=(boolean[])append(tb.subscript, !tb.subscript[tb.subscript.length-1]);
      }
    }
  } else if (key==BACKSPACE||key==DELETE) {
    for (TextBox tb : tbs) {
      if (tb.focusing) {

        if (tb.t[0].length()>0) {
          tb.backspace();
        }
      }
    }
  } else {
    if (keyCode!=16) {

      for (TextBox tb : tbs) {
        if (tb.focusing) {

          tb.write(key);
        }
      }
    }
  }
}

public void keyReleased() {
  if (keyCode==17) {
    keys[0]=true;
  } else if (keyCode==67) {
    keys[1]=false;
  } else if (keyCode==86) {
    keys[2]=false;
  }
}
public void render(int bg, boolean svg) {
  background(bg);

  for (int i = fills.length-1; i>=0; i--) { 
    if (fills[i].suicide) {
      fills=del(fills, i);
    } else {
      fills[i].render();
    }
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
  if (!svg) {
    main.render();
    for (Container c : subs) {
      for (Button b : c.buttons) {
        b.render();
      }
    }
  }
  w.renderWindow();   

  w.renderAxes();
}


public String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    return null;
  }
}

public void generateTextBoxes() {
  for (Point p : points) {
    for (Point x : p.ps) {
      //TextBox tb = new TextBox( x.x-u/2, x.y-u/10, u, u/3);
      //tbs=(TextBox[])append(tbs, tb);
    }
    TextBox tb = new TextBox( p.x-u/2, p.y-u/10, u, u/3);
    tbs=(TextBox[])append(tbs, tb);
  }

  for (Line l : lines) {
    float px=0;
    float py=0;
    for (PVector p : l.p) {
      if (p.x>px) {
        px=p.x;
        py=p.y;
      }
    }
    TextBox tb = new TextBox( px-u/4, py+u/2, u, u/3);
    tbs=(TextBox[])append(tbs, tb);
  }
}


public PVector[] insert(PVector[] input, PVector[] insertion, int index) {
  PVector[] output = new PVector[input.length+insertion.length];
  for (int i = 0; i <= index; i++) {
    output[i]=input[i];
  }
  for (int i = 0; i <= insertion.length-1; i++) {
    output[i+index+1]=insertion[i];
  }
  for (int i = 0; i <= input.length-index-2; i++) {
    output[i+index+insertion.length+1]=input[i+index+1];
  }

  return output;
}

public int[] insert(int[] input, int[] insertion, int index) {
  int[] output = new int[input.length+insertion.length];
  for (int i = 0; i <= index; i++) {
    output[i]=input[i];
  }
  for (int i = 0; i <= insertion.length-1; i++) {
    output[i+index+1]=insertion[i];
  }
  for (int i = 0; i <= input.length-index-2; i++) {
    output[i+index+insertion.length+1]=input[i+index+1];
  }

  return output;
}


public Point[] sortP(Point[] input) {

  int size = input.length;
  Point[] output = new Point[size];
  float xt = 0;
  float yt = 0;
  for (Point p : input) {
    xt+=p.x;
    yt+=p.y;
  }
  float xbar=xt/size;
  float ybar=yt/size;
  float[] angles = new float[size];
  for (int i = 0; i<size; i++) {
    angles[i] = atan2((input[i].y-ybar), (input[i].x-xbar));
  }
  float[] sortedangles = sort(angles);
  for (int i = 0; i<sortedangles.length; i++) {
    for (int j = 0; j<angles.length; j++) {
      if (sortedangles[i]==angles[j]) {
        output[i]=input[j];
      }
    }
  }


  return output;
}
public PVector[] sortP(PVector[] input) {

  int size = input.length;
  PVector[] output = new PVector[size];
  float xt = 0;
  float yt = 0;
  for (PVector p : input) {
    xt+=p.x;
    yt+=p.y;
  }
  float xbar=xt/size;
  float ybar=yt/size;
  float[] angles = new float[size];
  for (int i = 0; i<size; i++) {
    angles[i] = atan2((input[i].y-ybar), (input[i].x-xbar));
  }
  float[] sortedangles = sort(angles);
  for (int i = 0; i<sortedangles.length; i++) {
    for (int j = 0; j<angles.length; j++) {
      if (sortedangles[i]==angles[j]) {
        output[i]=input[j];
      }
    }
  }


  return output;
}

public void calculatePoints() {
  for (int i = points.length-1; i>=0; i--) {
    for (int j = points[i].ps.length-1; j >=0; j--) {
      if (Float.isNaN(points[i].ps[j].x)||Float.isNaN(points[i].ps[j].y)||(points[i].ps[j].x==0&&points[i].ps[j].y==0)) {
        points[i].ps=del(points[i].ps, j);
      }
    }
    if (Float.isNaN(points[i].x)||Float.isNaN(points[i].y)||(points[i].x==0&&points[i].y==0)) {
      points[i].ps=del(points, i);
    }
  }
  for (Line l : lines) {
    for (Line k : lines) {
      if (l!=k) {
        boolean solved=false;
        for (Point p : points) {
          if ((p.l1==l&&p.l2==k)||(p.l1==k&&p.l2==l)) {
            solved=true;
          }
        }
        if (!solved) {
          if (l.type==0&&k.type==0) {
            if (l.n==1&&k.n==1) {
              Point p = new Point(0, l, k);
              points=(Point[])append(points, p);
            } else if (l.n==1&&k.n==2) {
              Point p = new Point(0, l, k, -1);
              points=(Point[])append(points, p);
              p = new Point(0, l, k, 1);
              points=(Point[])append(points, p);
            } else if (l.n==1&&k.n==3) {
            }
          } else if (l.type==0&&k.type==1) {
            Point p = new Point(0, l, k);
            points=(Point[])append(points, p);
          }
          if (Float.isNaN(points[points.length-1].x)||Float.isNaN(points[points.length-1].y)) {
            points=del(points, points.length-1);
          }
        }
      }
    }
    for (Line k : axes) {
      if (l.type==0&&l.n==1) {
        boolean solved=false;
        for (Point p : points) {
          if ((p.l1==k&&p.l2==l)||(p.l1==l&&p.l2==k)) {
            solved=true;
          }
        }
        if (!solved) {
          Point p = new Point(2, k, l);
          points=(Point[])append(points, p);
        }
      }
    }
  } 



  for (Point x : points) {
    if (!Float.isNaN(x.x)&&!Float.isNaN(x.y)) {
      for (Line l : x.ls) {
        for (Line k : lines) {

          if (l!=k&&k!=x.l1&&k!=x.l2) {
            boolean solved=false;
            for (Point p : x.ps) {
              if ((p.l1==l&&p.l2==k)||(p.l1==k&&p.l2==l)) {
                solved=true;
              }
            }


            if (!solved) {
              if (Float.isNaN(x.x)) {
                Point p = new Point(-1, l, k);
                x.ps=(Point[])append(x.ps, p);
              } else 
              if (k.type==0) {
                if (k.n==1) {
                  Point p = new Point(1, l, k);
                  x.ps=(Point[])append(x.ps, p);
                } else if (k.n==2) {
                  Point p = new Point(1, l, k, -1);
                  x.ps=(Point[])append(x.ps, p);
                  p = new Point(1, l, k, 1);
                  x.ps=(Point[])append(x.ps, p);
                }
              }
            }
          }
        }


        for (Line k : axes) {
          if (l.type==2) {
            boolean solved=false;
            for (Point p : x.ps) {
              if ((p.l1==k&&p.l2==l)||(p.l1==l&&p.l2==k)) {
                solved=true;
              }
            }
            if (!solved) {
              Point p = new Point(2, k, l);
              x.ps=(Point[])append(x.ps, p);
            }
          }
        }
      }


      //////////////////////////////////////////////////////////////  
      for (Point c : x.ps) {
        for (Line l : c.ls) {
          for (Line k : axes) {

            if (l!=k&&k!=x.l1&&k!=x.l2) {
              boolean solved=false;
              for (Point p : x.ps) {
                if ((p.l1==l&&p.l2==k)||(p.l1==k&&p.l2==l)) {
                  solved=true;
                }
              }


              if (!solved) {
                if (Float.isNaN(x.x)) {
                  Point p = new Point(-1, l, k);
                  x.ps=(Point[])append(x.ps, p);
                } else 
                if (k.type==0) {
                  if (k.n==1) {
                    Point p = new Point(1, l, k);
                    x.ps=(Point[])append(x.ps, p);
                  } else if (k.n==2) {
                    Point p = new Point(1, l, k, -1);
                    x.ps=(Point[])append(x.ps, p);
                    p = new Point(1, l, k, 1);
                    x.ps=(Point[])append(x.ps, p);
                  }
                }
              }
            }
          }


          for (Line k : axes) {
            if (l.type==2) {
              boolean solved=false;
              for (Point p : x.ps) {
                if ((p.l1==k&&p.l2==l)||(p.l1==l&&p.l2==k)) {
                  solved=true;
                }
              }
              if (!solved) {
                Point p = new Point(2, k, l);
                x.ps=(Point[])append(x.ps, p);
              }
            }
          }
        }
      }
      ////////////////////////////////////////////////////////////
    }
  }

  for (int i = points.length-1; i>=0; i--) {
    for (int j = points[i].ps.length-1; j >=0; j--) {
      if (Float.isNaN(points[i].ps[j].x)||Float.isNaN(points[i].ps[j].y)||(points[i].ps[j].x==0&&points[i].ps[j].y==0)) {
        points[i].ps=del(points[i].ps, j);
      }
    }
    if (Float.isNaN(points[i].x)||Float.isNaN(points[i].y)||(points[i].x==0&&points[i].y==0)) {
      for (int k = points[i].ps.length-1; k >=0; k--) {
        points[i].ps=del(points[i].ps, i);
      }
      points=del(points, i);
    }
  }
  boolean originadded=false;
  for (Point p : points) {
    if (p.x==0&&p.y==0) {
      originadded=true;
    }
  }
  if (!originadded) {
    Point origin = new Point(2, xaxis, yaxis);
    points=(Point[])append(points, origin);
  }
}

public void deleteLine() {
  for (int i = lines.length-1; i >= 0; i--) {
    if (lines[i].focusing) {
      for (int j = points.length-1; j >=0; j--) {
        for (int f = fills.length-1; f >=0; f--) {
          for (Point p : fills[f].ps) {
            if (points[j]==p) {
              fills=del(fills, f);
            }
          }
        }
        for (int k = points[j].ps.length-1; k>=0; k--) {
          for (int f = fills.length-1; f >=0; f--) {
          for (Point p : fills[f].ps) {
            if (points[j].ps[k]==p) {
              fills=del(fills, f);
            }
          }
        }
          if (points[j].ps[k].l1==lines[i]||points[j].ps[k].l2==lines[i]) {
            points[j].ps = del(points[j].ps, j);
          }
        }
        if (points[j].l1==lines[i]||points[j].l2==lines[i]) {
          points = del(points, j);
        }
      }
      lines = del(lines, i);
    }
  }
}

public void deleteFill() {
  for (int i = fills.length-1; i >= 0; i--) {
    if (fills[i].focusing) {

      fills = del(fills, i);
    }
  }
}

public void deleteText() {
  for (int i = tbs.length-1; i >= 0; i--) {
    if (tbs[i].focusing) {

      tbs = del(tbs, i);
    }
  }
}

public String[] del(String[] input, int index) {
  String[] output = new String[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}
public boolean[] del(boolean[] input, int index) {
  boolean[] output = new boolean[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}

public int[] del(int[] input, int index) {
  int[] output = new int[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}
public Line[] del(Line[] input, int index) {
  Line[] output = new Line[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}


public TextBox[] del(TextBox[] input, int index) {
  TextBox[] output = new TextBox[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}
public Fill[] del(Fill[] input, int index) {
  Fill[] output = new Fill[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}

public Point[] del(Point[] input, int index) {
  Point[] output = new Point[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}

public int choose(int n, int r) {
  int output = 1;
  for (int i = 1; i <= r; i++)
  {
    output *= n - (r - i);
    output /= i;
  }
  return output;
}
class Window {
  float x, y, w, h, m, mx, my;

  Line[] axes;
  Window(float x, float y, float w, float h, float m) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.m=m;
    //axes = new Line[0];
    
  }

  public void renderWindow() {
    
    w=width-x;
    h=height-y;
    mx=mouseX-x-3*m;
    my=height-y+m-mouseY;
    if (!exporting) {
      fill(0);
      textAlign(TOP, RIGHT);
      text(mx+", " + my, u/10, height);
    }
  }

  public void renderAxes() {
    //noStroke();
    //fill(bg);
    //rect(u, u, 3*m, height-u);
    //rect(u, u, width-u, m);
    //rect(u, height-m, width-u, m);
    //rect(width-5*m, u, 3*m, height-u);
    strokeWeight(4);
    stroke(0);
    wline(0, 0, 0, h-3*m);
    wline(0, 0, w-10*m, 0);
    wline(0, h-3*m, -m/4, h-3.5f*m);
    wline(0, h-3*m, m/4, h-3.5f*m);
    wline(w-10*m, 0, w-10.5f*m, m/4);
    wline(w-10*m, 0, w-10.5f*m, -m/4);
  }
  
  public void createAxes(){
  PVector[] tempy = new PVector[2];
  tempy[0]=new PVector(0, 0);
  tempy[1]=new PVector(0, h);
  yaxis=new Line(3, tempy);
  PVector[] tempx = new PVector[2];
  tempx[0]=new PVector(0, 0);
  tempx[1]=new PVector(w, 0);
  xaxis=new Line(3, tempx);
  axes[0]=xaxis;
  axes[1]=yaxis;
  }

  public void wrect(float x, float y, float w, float h) {
    rect(this.x+3*m+x, height-m-y, w, h);
  }
  public void wline(float x1, float y1, float x2, float y2) {
    line(this.x+3*m+x1, height-m-y1, this.x+3*m+x2, height-m-y2);
  }
  public void wline(float x1, float y1, float x2, float y2, int dot) {
    float gap = 20;
    if (x1==x2) {
      float ystart = min(y1, y2);
      float yend = max(y1, y2);
      float yx = ystart;
      while (yx<yend-gap) {
        wline(x1, yx, x2, yx+gap/2);
        yx+=gap;
      }
      wline(x1, yx, x2, yend);
    } 
    if (y1==y2) {
      float xstart = min(x1, x2);
      float xend = max(x1, x2);
      float xy = xstart;
      while (xy<xend-gap) {
        wline(xy, y1, xy+gap/2, y2);
        xy+=gap;
      }
      wline(xy, y1, xend, y2);
    }
  }


  public void wcircle(float x, float y, float r) {
    ellipse(this.x+3*m+x, height-m-y, r, r);
  }

  public void wcurve(float a, float b, float c, float x1, float x2, float r) {
    for (float  x = x1; x<x2; x+=2) {
      wline(x, a*sq(x)+b*x+c, x+2, a*sq(x+2)+b*(x+2)+c);
    }
  }

  public void warc(float x1, float y1, float r) {
    for (float  x = x1; x<x1+r; x+=2) {
      wline(x, -sqrt(sq(r)-sq(x-x1))+y1, x+2, -sqrt(sq(r)-sq(x+2-x1))+y1);
    }
  }
  public void wpoint(float x, float y, float r) {
    wline(x-r, y-r, x+r, y+r);
    wline(x-r, y+r, x+r, y-r);
  }

  public void write(String text, float x, float y) {
    text(text, this.x+3*m+x, height-m-y);
  }

  public void wvertex(float x, float y) {
    vertex(this.x+3*m+x, height-m-y);
  }
}
class Container {
  Button[] buttons;
  String[] labels;  
  PImage[] icons;
  int type;
  float x1, y1, x2, y2;

  int[] cols;

  Container(Button[] buttons, String[] labels, PImage[] icons, int type) {
    this.buttons=buttons;
    this.labels=labels;
    this.type=type;
    this.icons = icons;

    if (type==MAIN) {
      for (int i=0; i<buttons.length; i++) {
        this.buttons[i]=new Button(MAIN, labels[i], icons[i], u, (i+1.5f)*1.4f*u, u, color(190), color(170));
        this.buttons[i].visible=true;
      }
      x1=u;
      y1=(1.5f)*1.4f*u;
      x2=u;
      y2=(buttons.length-1+1.5f)*1.4f*u;
    } else if (type==SUB) {
      for (int i=0; i<buttons.length; i++) {
        this.buttons[i]=new Button(SUB, labels[i], (1.3f*i+2)*1.4f*u, 0.8f*u, (1.3f*i+2)*1.4f*u+0.8f*u, 0.8f*u, 0.8f*u, color(200), color(150));
        this.buttons[i].visible=false;
      }
      x1=(1.5f)*1.4f*u;
      y1=u;
      x2=(buttons.length-1+1.5f)*1.4f*u;
      y2=u;
    }
  }

  Container(Button[] buttons, int[] cols, Button parent, int type) {
    this.buttons=buttons;
    this.cols=cols;
    this.type=type;
    float x = parent.x1;
    float y = parent.y1;
    if (type==SUBSUB) {
      for (int i=0; i<cols.length; i++) {
        this.buttons[i]=new Button(cols[i], parent, i);
        this.buttons[i].visible=false;
      }
      
    }
  }




  public void render() {
    if (type==MAIN) {
      noStroke();
      fill(200);
      rect(x1-0.7f*u, y1-0.4f*u, 1.4f*u, y2-y1+0.8f*u);
      ellipse(x1, y1-0.4f*u, 1.4f*u, 1.4f*u);
      ellipse(x1, y2+0.4f*u, 1.4f*u, 1.4f*u);
    } else if (type==SUB) {
    }
    for (Button b : buttons) {
      b.render();
    }
  }
}
class Button {
  float x1, y1, x2, y2, d;
  boolean pressed = false;
  boolean hovered = false;
  boolean visible = false;
  int c1;
  int c2;
  String t;
  Button[] bs = new Button[0];
  PImage icon;
  int c;
  Button parent;
  int i;

  int type;

  Button(int type, String t, PImage icon, float x, float y, float d, int c1, int c2) {
    this.t=t;
    this.x1=x;
    this.y1=y;
    this.x2=x;
    this.y2=y;
    this.d=d;
    this.c1=c1;
    this.c2=c2;
    this.type=type;
    this.icon=icon;
  }
  Button(int type, String t, float x1, float y1, float x2, float y2, float d, int c1, int c2) {
    this.t=t;
    this.x1=x1;
    this.y1=y1;
    this.x2=x2;
    this.y2=y2;
    this.d=d;
    this.c1=c1;
    this.c2=c2;
    this.type=type;
  }

  Button(int c, Button parent, int i) {
    this.c=c;
    this.parent=parent;
    this.i=i;
    type=SUBSUB;
    d=parent.d/3;
    x1=(parent.x1)+d*(i%3);
    y1=parent.y1+parent.d/2+d*(i/3);
  }

  public void render() {
    if (type<2) {
      hovered=false;
      if (visible) {
        fill(c1);

        if (dist(mouseX, mouseY, x1, y1)<d/2||dist(mouseX, mouseY, x2, y2)<d/2||(mouseX>x1&&mouseX<x2&&mouseY>y1-d/2&&mouseY<y2+d/2)) {
          hovered=true;
          fill(c2);
        }

        if (type==MAIN) {
          noStroke();
          strokeWeight(2);
          ellipse(x1, y1, d, d);

          textSize(16);
          textAlign(CENTER, CENTER);
          fill(0);
          text(t, x1, y1+0.6f*d);
          image(icon,x1-icon.width/2,y1-icon.height/2);

        } else if (type==SUB) {
          noStroke();
          strokeWeight(2);
          ellipse(x1, y1, d, d);
          ellipse(x2, y2, d, d);
          rect(x1,y1-d/2,x2-x1,d);
          textSize(16);
          textAlign(CENTER, CENTER);
          fill(0);
          text(t, (x1+x2)/2, y1);
        }
      }
      if (visible) {
        if (bs.length!=0) {
          for (Button b : bs) {
            if (b.visible) {
              b.render();
            } else {
              b.hovered=false;
            }
          }
        }
      }
    } else if (type==2) {
      hovered=false;
      if (visible) {
        fill(c);
        noStroke();
        strokeWeight(2);
        rect(x1, y1, d, d);
        if (dist(mouseX, mouseY, x1, y1)<d/2) {
          hovered=true;
        }
      }
    }
  }
}
class Line {
  int type;
  int n;
  PVector[] p;
  float tres=0.005f;
  float t=0;
  float r = u/4;
  float asr = 2*u;
  boolean translating = false;
  boolean focusing;
  boolean hovering = false;  
  PVector curr = new PVector();
  PVector next = new PVector();
  PVector[] transoff;
  boolean exselected=true;
  int c1 = color(0, 127, 255);
  int c2 = color(0,0,255);


  Line(int type, PVector[] p) {
    this.type=type;
    if (type==0||type==2) {
      this.n=p.length-1;
    }   
    this.p=p;
    transoff = new PVector[p.length];
    for (int i = 0; i < transoff.length; i++) {
      transoff[i]=new PVector(0, 0);
    }
  }


  public void render() {
    hovering = false;
    if (type<=1) {
      if (focusing&&mode==0) {
        move();
      }
    }
    if (type==0) {////////////////////////////////////////////draw bezier///////////////////////////////////////////////
      t=0;
      while (t<=1) {
        curr.x=0;
        curr.y=0;
        next.x=0;
        next.y=0;
        for (int i = 0; i <= n; i++) {
          curr.x+=choose(n, i)*pow(1-t, n-i)*pow(t, i)*p[i].x;
          curr.y+=choose(n, i)*pow(1-t, n-i)*pow(t, i)*p[i].y;
          next.x+=choose(n, i)*pow(1-(t+tres), n-i)*pow((t+tres), i)*p[i].x;
          next.y+=choose(n, i)*pow(1-(t+tres), n-i)*pow((t+tres), i)*p[i].y;
        }


        stroke(0);
        strokeWeight(4);

        if (focusing&&mode==0) {
          stroke(c1);
          strokeWeight(4);
        }
        w.wline(curr.x, curr.y, next.x, next.y);
        t+=tres;
        if (abs(curr.x-w.mx)<0.5f*r&&abs(curr.y-w.my)<0.5f*r) {
          hovering=true;
        }
      }
      if ((focusing||hovering)&&mode==0) {

        if (n==2) {
          strokeWeight(1);
          stroke(127);
          w.wline(p[0].x, p[0].y, p[1].x, p[1].y);
          w.wline(p[2].x, p[2].y, p[1].x, p[1].y);
        } else if (n==3) {
          strokeWeight(1);
          stroke(127);
          w.wline(p[0].x, p[0].y, p[1].x, p[1].y);
          w.wline(p[2].x, p[2].y, p[3].x, p[3].y);
        }

        for (PVector x : p) {

          if (x.z==1) {
          stroke(c2);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/2);
          } else {
            stroke(0);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/4);
          }
        }

        translating = true;
        for (PVector x : p) {
          if (x.z==1) {
            translating = false;
          }
        }
      }
    }

    if (type==1) {//////////////////////////////////draw AS/////////////////////////////////



      if ((abs(w.mx-p[1].x)<0.5f*r&&w.my>p[0].y+asr&&w.my<p[1].y)||
        (abs(w.my-p[0].y)<0.5f*r&&w.mx>p[0].x&&w.mx<p[1].x-asr)||
        ((sq(w.mx-p[1].x+asr)+sq(w.my-p[0].y-asr))>sq(asr-0.5f*r)&&(sq(w.mx-p[1].x+asr)+sq(w.my-p[0].y-asr))<sq(asr+0.5f*r))&&w.mx>p[1].x-asr&&w.my<p[0].y+asr) {
        hovering = true;
      }
      stroke(0);
      strokeWeight(4);
      if (focusing&&mode==0) {
        stroke(c1);
        strokeWeight(4);
      }
      w.wline(p[0].x, p[0].y, p[1].x-asr, p[0].y);
      w.wline(p[1].x, p[1].y, p[1].x, p[0].y+asr);
      w.warc(p[1].x-asr, p[0].y+asr, asr);
      if ((focusing||hovering)&&mode==0) {

        for (PVector x : p) {

          if (x.z==1) {
            stroke(c2);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/2);
          } else {
            stroke(0);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/4);
          }
        }

        translating = true;
        for (PVector x : p) {
          if (x.z==1) {
            translating = false;
          }
        }
      }
    }
    if (type==2) {//////////////////////////////////////////////////draw extension //////////////////////////////////////////////////////
      if (mode==1) {
        if (p[0].x==p[1].x) {
          if (abs(w.mx-p[0].x)<0.5f*r&&w.my<p[0].y-r&&w.my>p[1].y) {
            hovering = true;
          } else {
            hovering = false;
          }
        } else if (p[0].y==p[1].y) {
          if (abs(w.my-p[0].y)<0.5f*r&&w.mx<p[0].x-r&&w.mx>p[1].x) {
            hovering = true;
          } else {
            hovering = false;
          }
        }
      }
      strokeWeight(2);
      stroke(0);
      if (hovering&&mode==1) {
        stroke(c1);
      }

      if (exselected||hovering) {
        w.wline(p[1].x, p[1].y, p[0].x, p[0].y, DOTTED);
      }
    }
  }

  public void move() {

    for (PVector x : p) {
      if (abs(x.x-w.mx)<1.5f*r&&abs(x.y-w.my)<1.5f*r) {
        hovering = true;
        x.z=1;
        for (PVector c : p) {
          if (c!=x) {
            c.z=0;
          }
        }
      }
    } 


    if (translating&&mousePressed) {
      for (int i = 0; i < p.length; i++) {
        p[i].x=w.mx-transoff[i].x;
        p[i].y=w.my-transoff[i].y;
      }
    }
    for (PVector x : p) {
      if (mousePressed) {
        if (x.z==1) {
          x.x=w.mx;
          x.y=w.my;
        }
      } else {
        x.z=0;
      }
    }
  }
}
class Point {
  float x, y;
  int type;
  int root;
  Line l1, l2;
  float r = u/3;
  boolean exists = false;
  boolean hovering = false;
  boolean selected = false;
  boolean shading = false;
  Point[] ps = new Point[0];
  Line[] ls = new Line[0];



  Point(int type, Line l1, Line l2) {
    this.type=type;
    this.l1=l1;
    this.l2=l2;
    solve();
    if (type==0||type==1) {
      PVector[] x = new PVector[2];
      x[0] = new PVector(this.x, this.y);
      x[1] = new PVector(this.x, 0);
      Line lx = new Line(2, x);
      ls=(Line[])append(ls, lx);
      PVector[] y = new PVector[2];
      y[0] = new PVector(this.x, this.y);
      y[1] = new PVector(0, this.y);
      Line ly = new Line(2, y);
      ls=(Line[])append(ls, ly);
    }
  }
  Point(int type, Line l1, Line l2, int root) {
    this.type=type;
    this.l1=l1;
    this.l2=l2;
    this.root = root; //determines which root to take in case of quadratic 
    solve();
    PVector[] x = new PVector[2];
    x[0] = new PVector(this.x, this.y);
    x[1] = new PVector(this.x, 0);
    Line lx = new Line(2, x);
    ls=(Line[])append(ls, lx);
    PVector[] y = new PVector[2];
    y[0] = new PVector(this.x, this.y);
    y[1] = new PVector(0, this.y);
    Line ly = new Line(2, y);
    ls=(Line[])append(ls, ly);
  }

  public void render() {
    solve();
    if (sqrt(sq(w.mx-x)+sq(w.my-y))<0.5f*r) {
      hovering = true;
    } else {
      hovering = false;
    }

    if (exists||selected) {
      if (type==0||type==1) {
        ls[0].p[0].x=x;
        ls[0].p[0].y=y;
        ls[0].p[1].x=x;
        ls[1].p[0].x=x;
        ls[1].p[0].y=y;
        ls[1].p[1].y=y;
        if (((hovering&&mode==1)||selected)&&exists) {
          for (Line l : ls) {
            l.render();
          }
        }
      }
      if (mode==1) {
        stroke(0);
        noFill();
        if (selected) {
          stroke(255, 0, 0);
        } else if (hovering) {
          stroke(250, 127, 127);
        }
        if (type==0) {

          strokeWeight(3);
          w.wcircle(x, y, r);
        }
        if (type==1||type==2) {
          if (hovering||selected) {
            strokeWeight(2);
            w.wcircle(x, y, r);
          }
        }
      } else if (mode==3.1f) {
        stroke(0);
        noFill();
        if (shading) {
          stroke(127, 127, 255);
        } else if (hovering&&mode==3.1f) {
          stroke(80, 127, 80);
        }
        if (type==0) {
          strokeWeight(3);
          w.wcircle(x, y, r);
        }
        if (type==1||type==2) {
          if (hovering||shading) {
            strokeWeight(2);
            w.wcircle(x, y, r);
          }
        }
      }
    }
  }

  public void solve() {
    if (type==-1) {

      x=Float.NaN;
      y=Float.NaN;
    } else if (l1.type==0&&l2.type==0) {
      if (l1.n==1&&l2.n==1) {////////////////////////////////////////////////////////////////solve 2 linear//////////////////////////////////////////////////////////////

        float y0=l1.p[0].y;
        float y1=l1.p[1].y;
        float y2=l2.p[0].y;
        float y3=l2.p[1].y;
        float x0=l1.p[0].x;
        float x1=l1.p[1].x;
        float x2=l2.p[0].x;
        float x3=l2.p[1].x;
        float tb=(x2-x0-(y2-y0)*(x1-x0)/(y1-y0))/(((x1-x0)*(y3-y2))/(y1-y0)-(x3-x2));
        if (tb>0&&tb<1) {
          x=x2+tb*(x3-x2);
          y=y2+tb*(y3-y2);
          if (((y-y0)/(y1-y0)>0&&(y-y0)/(y1-y0)<1)&&((y-y2)/(y3-y2)>0&&(y-y2)/(y3-y2)<1)) {
            exists=true;
          } else {
            exists = false;
          }
        } else {
          x=Float.NaN;
          y=Float.NaN;
          exists=false;
        }
      } else if (l1.n==1&&l2.n==2) {////////////////////////////////////////////////////////////solve linear + quad//////////////////////////////////////////////////
        float y0=l1.p[0].y;
        float y1=l1.p[1].y;
        float x0=l1.p[0].x;
        float x1=l1.p[1].x;
        float p0x=l2.p[0].x;
        float p0y=l2.p[0].y;
        float p1x=l2.p[1].x;
        float p1y=l2.p[1].y;
        float p2x=l2.p[2].x;
        float p2y=l2.p[2].y;

        float A = y1-y0;
        float B = x0-x1;
        float C = x0*(y1-y0)-y0*(x1-x0);
        float LP0 = A*p0x+B*p0y;
        float LP1 = A*p1x+B*p1y;
        float LP2 = A*p2x+B*p2y;
        float a=LP0-2*LP1+LP2;
        float b=-2*LP0+2*LP1;
        float c=LP0-C;
        float t=0;
        if (root==1) {
          t = (-b+sqrt(sq(b)-4*a*c))/(2*a);
        } else if (root==-1) {
          t = (-b-sqrt(sq(b)-4*a*c))/(2*a);
        }


        x=sq(1-t)*p0x+2*(1-t)*t*p1x+sq(t)*p2x;
        y=sq(1-t)*p0y+2*(1-t)*t*p1y+sq(t)*p2y;
        if (t>0&&t<1) {
          if ((y-y0)/(y1-y0)>0&&(y-y0)/(y1-y0)<1&&(x-x0)/(x1-x0)>0&&(x-x0)/(x1-x0)<1) {
            exists=true;
          } else {

            exists = false;
          }
        } else {
          x=Float.NaN;
          y=Float.NaN;
          exists=false;
        }
      } else if (l1.n==1&&l2.n==3) {//solve linear + cubic
      }
    } else if (l1.type==0&&l2.type==1) {//solve linear + AS
      if (l1.n==1) {


        PVector[] ps = new PVector[2];
        y=l2.p[0].y;
        ps[0]=new PVector(0, y);
        ps[1]=new PVector(w.w, y);
        Line l = new Line(2, ps);
        Point p = new Point(0, l, l1);
        p.solve();

        if (p.x>l2.p[0].x&&p.x<l2.p[1].x-l2.asr) {

          x=p.x;
          y=p.y;
          exists=true;
        } else {
          ps = new PVector[2];
          x=l2.p[1].x;
          ps[0]=new PVector(x, 0);
          ps[1]=new PVector(x, w.h);
          l = new Line(2, ps);
          p = new Point(0, l, l1);
          p.solve();
          if (p.y<l2.p[1].y&&p.y>l2.p[0].y+l2.asr) {
            x=p.x;
            y=p.y;
            exists=true;
          }else{
          float m = (l1.p[1].y-l1.p[0].y)/(l1.p[1].x-l1.p[0].x);
          float c = l1.p[0].y-m*l1.p[0].x;
          println(m,c);
          float x1=l2.p[1].x-l2.asr;
          float y1=l2.p[0].y+l2.asr;
          float A = sq(m)+1;
          float B = 2*(m*(c-y1)-x1);
          float C = sq(x1)+sq(c-y1)-sq(l2.asr);
          println(A,B,C);
          x=(-B+sqrt(sq(B)-4*A*C))/(2*A);
          y=m*x+c;
          println(x,y);
          exists = true;
          }
        }
      }
    } else if (l1.type==2&&l2.type==0) {
      if (l2.n==1) {//solve extension and linear
        if (l1.p[0].x==l1.p[1].x) {
          x=l1.p[0].x;
          float m = (l2.p[1].y-l2.p[0].y)/(l2.p[1].x-l2.p[0].x);
          float c = l2.p[0].y-m*l2.p[0].x;
          y=m*x+c;
        } else if (l1.p[0].y==l1.p[1].y) {
          y=l1.p[0].y;
          float m = (l2.p[1].y-l2.p[0].y)/(l2.p[1].x-l2.p[0].x);
          float c = l2.p[0].y-m*l2.p[0].x;
          x=(y-c)/m;
        }      
        exists = true;

        if (x>max(l2.p[0].x, l2.p[1].x)||x<min(l2.p[0].x, l2.p[1].x)||y>max(l2.p[0].y, l2.p[1].y)||y<min(l2.p[0].y, l2.p[1].y)) {
          x=Float.NaN;
          y=Float.NaN;
          exists=false;
        }
      } else if (l2.n==2) {//solve extension and quadratic
        PVector[] ps = new PVector[2];
        if (l1.p[0].x==l1.p[1].x) {
          x=l1.p[0].x;
          ps[0]=new PVector(x, 0);
          ps[1]=new PVector(x, w.h);
          Line l = new Line(0, ps);
          Point p = new Point(0, l, l2, root);
          p.solve();
          x=p.x;
          y=p.y;
          exists=true;
        } else if (l1.p[0].y==l1.p[1].y) {
          y=l1.p[0].y;
          ps[0]=new PVector(0, y);
          ps[1]=new PVector(w.w, y);
          Line l = new Line(0, ps);
          Point p = new Point(0, l, l2, root);
          p.solve();
          x=p.x;
          y=p.y;
          exists=true;
        }
      }
    } else if (l1.type==3&&(l2.type==0||l2.type==2)) {
      if (l1.p[0].x==l1.p[1].x) {
        if (l2.p[0].y==l2.p[1].y) {
          y=l2.p[0].y;
          x=0;
        } else if (l2.p[0].x==l2.p[1].x) {
          x=Float.NaN;
          y=Float.NaN;
        } else {
          x=l1.p[0].x;
          float m = (l2.p[1].y-l2.p[0].y)/(l2.p[1].x-l2.p[0].x);
          float c = l2.p[0].y-m*l2.p[0].x;
          y=m*x+c;
        }
      } else if (l1.p[0].y==l1.p[1].y) {
        if (l2.p[0].x==l2.p[1].x) {
          y=0;
          x=l2.p[0].x;
        } else if (l2.p[0].y==l2.p[1].y) {
          x=Float.NaN;
          y=Float.NaN;
        } else {
          y=l1.p[0].y;
          float m = (l2.p[1].y-l2.p[0].y)/(l2.p[1].x-l2.p[0].x);
          float c = l2.p[0].y-m*l2.p[0].x;
          x=(y-c)/m;
        }
      }   
      exists = true;

      if (y>w.h||y<0) {
        x=Float.NaN;
        y=Float.NaN;
        exists=false;
      }
    } else if (l1.type==3&&l2.type==3) {
      x=0;
      y=0;
      exists=true;
    }
  }
}
class TextBox {

  float x, y, wid, h;
  float xoff, yoff;
  String[] t = new String[0];
  int substring=0;
  boolean[] subscript = new boolean[0];
  boolean focusing = false;
  boolean moving = false;
  boolean hovering = false;
  int reg = 20;
  int sub = 15;

  TextBox(float x, float y, float w, float h) {
    this.t=(String[])append(t, "");
    this.subscript=(boolean[])append(subscript, false);
    this.x=x;
    this.y=y;
    this.wid=w;
    this.h=h;
  }

  public void render() {
    //for(int i =0;i<t.length;i++){
    //println(t[i]);
    //}
    //    println("________________________________________");

    checkHover();
    if (focusing) {
      mode = 2;
      if (mousePressed) {
        moving = true;
      } else {
        moving =false;
      }
    }
    if (moving) {
      x=w.mx-xoff;
      y=w.my-yoff;
    }

    if (hovering||focusing) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    if (mode!=2) {
      noStroke();
    }

    wid=0;
    for (int i=0; i<t.length; i++) {
      if (subscript[i]) {
        textSize(sub);
      } else {
        textSize(reg);
      }
      wid+=textWidth(t[i]);
    }


    writeToScreen();
    if (focusing) {
      if (subscript[substring]) {
        w.write(" |", x+wid, y-reg+sub);
      } else {
        w.write(" |", x+wid, y);
      }
    }




    if (wid<u) {
      wid=u;
    } else {
      textSize(reg);
      wid=wid+textWidth("lol");
    }

    noFill();


    w.wrect(x, y, wid, h);
  }


  public void writeToScreen() {
    textAlign(LEFT, TOP);
    fill(0);
    for (int i = 0; i < t.length; i++) {

      float offset=0;
      for (int j=0; j<i; j++) {
        if (subscript[j]) {
          textSize(sub);
        } else {
          textSize(reg);
        }
        offset+=textWidth(t[j]);
      }

      if (subscript[i]) {
        textSize(sub);
        w.write(" "+t[i], x+offset, y-reg+sub);
      } else {
        textSize(reg);
        w.write(" "+t[i], x+offset, y);
      }
    }
  }
public void write(char key){

t[substring]=t[substring]+key;
}
  public void backspace() {
    for (int i = t.length-1; i>=0; i--) {
      if (t[i].length()==0) {
        t=del(t, i);
        subscript=del(subscript,i);
        substring--;
      }
    }
    t[substring]=t[substring].substring(0,t[substring].length()-1);
    
  }
  public void checkHover() {
    if (w.mx>x&&w.mx<x+wid&&w.my<y&&w.my>y-h) {
      hovering=true;
    } else {
      hovering = false;
    }
  }
}
class Fill {

  Point[] ps = new Point[0];
  PVector[] psv;
  java.awt.Polygon poly;
  boolean hovering= false;
  boolean focusing = false;
  int c = color(random(255),random(255),random(255));
  int alpha = 127;
  int alpha2 = 200;
  
  boolean suicide=false;

  Fill(Point[] ps) {
    this.ps=ps;
    psv = new PVector[ps.length];
  }

  public void render() {
    try{
    psv = new PVector[ps.length];
    poly = new java.awt.Polygon();

    for (int i = 0; i<ps.length; i++) {
      psv[i] = new PVector(ps[i].x, ps[i].y);
    }
    identifyCurves();
    psv=sortP(psv);


    for (PVector p : psv) {
      poly.addPoint((int)p.x, (int)p.y);
    }
    checkHover();

    if (hovering||focusing) {
      fill(c,alpha2);
    } else {
      fill(c,alpha);
    }
    noStroke();
    beginShape();
    for (PVector p : psv) {
      w.wvertex(p.x, p.y);
    }
    endShape();
    }catch(Exception e){
    suicide=true;
    }
  }

  public void checkHover() {
    if (poly.contains((int)w.mx, (int)w.my)&&((int)mode==3&&mode!=3.1f)) {
      hovering=true;
    } else {
      hovering = false;
    }
  }

  public void identifyCurves() {
    Line l;
    PVector[] curve;
    int index=0;
    PVector p1 = new PVector();
    PVector p2 = new PVector();
    for (int i = 0; i<ps.length; i++) {
      if (ps[i].l1.n==2||ps[i].l2.n==2) {
        if (ps[i].l1==ps[(i+1)%(ps.length-1)].l1) {
          l = ps[i].l1;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l1==ps[(i+1)%(ps.length-1)].l2) {
          l = ps[i].l1;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l2==ps[(i+1)%(ps.length-1)].l1) {
          l = ps[i].l2;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l2==ps[(i+1)%(ps.length-1)].l2) {
          l = ps[i].l2;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        }
      }
    }
  }

  public PVector[] generateCurve(Line l, float x1, float y1, float x2, float y2) {
    PVector[] ps = new PVector[0];
    float t=0;
    while (t<=1) {
      float x=0;
      float y=0;

      for (int i = 0; i <= l.n; i++) {
        x+=choose(l.n, i)*pow(1-t, l.n-i)*pow(t, i)*l.p[i].x;
        y+=choose(l.n, i)*pow(1-t, l.n-i)*pow(t, i)*l.p[i].y;
      }
      PVector p = new PVector(x, y);
      if (x>min(x1, x2)&&x<max(x1, x2)&&y>min(y1, y2)&&y<max(y1, y2)) {
        ps=(PVector[])append(ps, p);
      }
      t+=0.005f;
    }
    return ps;
  }
}
  public void settings() {  size(1200, 800, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "econsgraphs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
