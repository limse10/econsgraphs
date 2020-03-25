
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

Point p;

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


if(p!=null){
p.render();
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
    for (int i = lines.length-1; i >= 0; i--) {
      if (lines[i].focusing) {
        lines = del(lines, i);
      }
    }
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
    p = new Point(0,lines[0],lines[1]);
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

int[] del(int[] input, int index) {
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
Line[] del(Line[] input, int index) {
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


TextBox[] del(TextBox[] input, int index) {
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
Fill[] del(Fill[] input, int index) {
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



int choose(int n, int r) {
  int output = 1;
  for (int i = 1; i <= r; i++)
  {
    output *= n - (r - i);
    output /= i;
  }
  return output;
}


void keyPressed() {
  if(mode==0&&key==DELETE){
  for (int i = lines.length-1; i >= 0; i--) {
      if (lines[i].focusing) {
        lines = del(lines, i);
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
