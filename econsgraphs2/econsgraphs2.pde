
Button[] bs = new Button[5];
String[] bls = {"Lines", "Points", "Text", "Shading", "Export", };
Button[] sb1 = new Button[5];
String[] sb1l = {"Delete Line", "Add Line", "Add Curve", "Add Super\nCool Curve", "Add AS"};
Button[] sb2 = new Button[3];
String[] sb2l = {"Edit\nIntersections", "Edit\nExtensions", "Edit\nFree Points"};
Button[] sb3 = new Button[2];
String[] sb3l = {"Add Text", "Delete Text"};
Button[] sb4 = new Button[3];
String[] sb4l = {"Select Area", "Shade", "Delete Shade"};

Line[] lines = new Line[0];

Point[] points = new Point[0];

Boolean[] keys = new Boolean[3];
Line copied;
//Point[] imp = new Point[0];
//Point[] exs = new Point[0];
TextBox[] tbs = new TextBox[0];
Window w = new Window();
Fill[] fills = new Fill[0];
//Point[] fill = new Point[0];

int x=0;
int imageCount = 0;
int u;
color bg = color(255);
boolean focus = false;
float mode=-1;
boolean keyTyped = false;
int DOTTED = 1;
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
    bs[i] = new Button();
    bs[i].create(bls[i], (i+1)*u, 0, u, u, color(130), color(120));
  }

  for (int i = 0; i < sb1.length; i++) {
    sb1[i] = new Button();
    sb1[i].create(sb1l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb1[i].visible=false;
  }

  for (int i = 0; i < sb2.length; i++) {
    sb2[i] = new Button();
    sb2[i].create(sb2l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb2[i].visible=false;
  }
  for (int i = 0; i < sb3.length; i++) {
    sb3[i] = new Button();
    sb3[i].create(sb3l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb3[i].visible=false;
  }
  for (int i = 0; i < sb4.length; i++) {
    sb4[i] = new Button();
    sb4[i].create(sb4l[i], 0, (i+1)*u, u, u, color(130), color(120));
    sb4[i].visible=false;
  }
}


void draw() {
  background(bg);

  w.renderWindow();   

  for (Fill f : fills) {
    //f.render();
  }
  //for(Line[] ls : lines){
  //for(Line l : ls){
  //l.render();
  //}
  //}
  for (Line l : lines) {
    l.render();
  }

  for (Point p : points) {
    p.render();
    for(Point x : p.ps){
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
  w.renderWindow();   

  w.renderAxes();
}


void mousePressed() {
  focus = false;
  if (bs[0].hovered) {
    mode=0;
  } 
  if (sb1[0].hovered) {
    deleteLine();
  }
  if (sb1[1].hovered) {
    PVector[] p = new PVector[2];
    p[0] = new PVector(100, 400);
    p[1] = new PVector(500, 300);
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (sb1[2].hovered) {
    PVector[] p = new PVector[3];
    p[0] = new PVector(100, 400);
    p[1] = new PVector(500, 300);
    p[2] = new PVector(150, 200);
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (sb1[3].hovered) {
    PVector[] p = new PVector[4];
    p[0] = new PVector(100, 400);
    p[1] = new PVector(500, 300);
    p[2] = new PVector(150, 200);
    p[3] = new PVector(200, 200);
    Line l = new Line(0, p);
    lines = (Line[])append(lines, l);
  }
  if (sb1[4].hovered) {
    PVector[] p = new PVector[2];
    p[0] = new PVector(100, 100);
    p[1] = new PVector(500, 500);
    Line l = new Line(1, p);
    lines = (Line[])append(lines, l);
  }
  if (bs[1].hovered) {
    mode=1;
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
          }
        }
      }
    } 

    for (Point x : points) {
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
      }
    } 
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


  if (bs[2].hovered) {
    mode=2;
  } 
  if (bs[3].hovered) {
    mode=3;
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
    for (Point p : points) {
      for (Line l : p.ls) {
        if (mousePressed&&l.hovering) {
          if (!l.exselected) {
            l.exselected=true;
          } else {
            l.exselected=false;
          }
        }
      }
      if (mousePressed&&p.hovering) {
        if (!p.selected) {
          p.selected=true;
          for (Line l : p.ls) {
            l.exselected=true;
          }
        } else {
          p.selected=false;
        }
      }
    }
  }
  if (mode == 0) {
    for (Button b : sb1) {
      b.visible=true;
    }
    for (Button b : sb2) {
      b.visible=false;
    }
    for (Button b : sb3) {
      b.visible=false;
    }
    for (Button b : sb4) {
      b.visible=false;
    }
  }
  if ((int)mode == 1) {
    for (Button b : sb1) {
      b.visible=false;
    }
    for (Button b : sb2) {
      b.visible=true;
    }
    for (Button b : sb3) {
      b.visible=false;
    }
    for (Button b : sb4) {
      b.visible=false;
    }
  }
  if (mode == 2) {
    for (Button b : sb1) {
      b.visible=false;
    }
    for (Button b : sb2) {
      b.visible=false;
    }
    for (Button b : sb3) {
      b.visible=true;
    }
    for (Button b : sb4) {
      b.visible=false;
    }
  }
  if ((int)mode == 3) {
    for (Button b : sb1) {
      b.visible=false;
    }
    for (Button b : sb2) {
      b.visible=false;
    }
    for (Button b : sb3) {
      b.visible=false;
    }
    for (Button b : sb4) {
      b.visible=true;
    }
  }
}




void keyPressed() {

  if (mode==0) {
    if (key==DELETE) {
      deleteLine();
    }

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




  for (TextBox tb : tbs) {
    if (tb.focus) {
      if (key!=BACKSPACE&&key!=DELETE) {
        tb.t=tb.t+key;
      } else {
        if (tb.t.length()>0) {
          tb.t = tb.t.substring( 0, tb.t.length()-1 );
        }
      }
    }
  }
}

void keyReleased() {
  if (keyCode==17) {
    keys[0]=true;
  } else if (keyCode==67) {
    keys[1]=false;
  } else if (keyCode==86) {
    keys[2]=false;
  }
}
