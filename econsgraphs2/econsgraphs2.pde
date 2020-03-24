
Button[] bs = new Button[5];
//ArrayList<Button> bs = new ArrayList<Button>();
String[] bls = {"Lines", "Points", "Text", "Shading", "Export", };
Button[] sb1 = new Button[5];
String[] sb1l = {"Delete Line", "Add DD", "Add SS", "Add Curve", "Add AS"};
Button[] sb2 = new Button[3];
String[] sb2l = {"Edit\nIntersections", "Edit\nExtensions", "Edit\nFree Points"};
Button[] sb3 = new Button[2];
String[] sb3l = {"Add Text", "Delete Text"};
Button[] sb4 = new Button[3];
String[] sb4l = {"Select Area", "Shade", "Delete Shade"};

Line[][] lines = new Line[4][0];
Line[] DD = new Line[0];
Line[] SS = new Line[0];
Line[] curves = new Line[0];
Line[] AS = new Line[0];


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
boolean focusing = false;
float mode=0;
boolean keyTyped = false;
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


  //Line testl = new Line();
  //testl.create(-2,0,0,0,0);
  //  Point[] test = new Point[4];
  //  test[0]= new Point();
  //      test[1]= new Point();
  //  test[2]= new Point();
  //  test[3]= new Point();


  //  test[0].x=100;
  //  test[0].y=100;
  //  test[1].x=200;
  //  test[1].y=300;
  //  test[2].x=500;
  //  test[2].y=100;
  //  test[3].x=600;
  //  test[3].y=400;
  //  test=sortP(test);
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
  for (Line l : DD) {
    l.render();
  }
  for (Line l : SS) {
    l.render();
  }
  for (Line l : curves) {
    l.render();
  }
  for (Line l : AS) {
    l.render();
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

  if (bs[0].hovered) {
    mode=0;
    //add line button
  } 
  if (sb1[0].hovered) {
    // Delete Line

  }
  if (sb1[1].hovered) {
    //add demand line button
    PVector[] p = new PVector[4];
    p[0] = new PVector(100,400);
    p[3] = new PVector(500,300);
    p[2] = new PVector(150,200);
    p[1] = new PVector(40,320);

    Line l = new Line(0,p);
    DD = (Line[])append(DD, l);
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



int choose(int n, int r){
int output = 1;
for (int i = 1; i <= r; i++)
{
    output *= n - (r - i);
    output /= i;
}
return output;

}


void keyPressed() {
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
