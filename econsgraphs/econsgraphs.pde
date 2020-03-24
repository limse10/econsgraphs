import processing.svg.*;

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


Point[] imp = new Point[0];
//Point[] exs = new Point[0];
TextBox[] tbs = new TextBox[0];
Window w = new Window();
Fill[] fills = new Fill[0];
Point[] fill = new Point[0];

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

  beginRecord(SVG, "filename.svg");

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
    f.render();
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

  for (Point p : imp) {

    p.render();
    if (p.selected) {
      for (Point x : p.ps) {
        x.render();
        for (Point i : x.ps) {
          i.render();
        }
      }
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

  if (bs[0].hovered) {
    mode=0;
    //add line button
  } 
  if (sb1[0].hovered) {
    // Delete Line

    for (int i=DD.length-1; i>=0; i--) {
      if (DD[i].focus) {
        for (Point p : imp) {
          for (int x = p.ps.length-1; x>=0; x--) {
            if (p.ps[x].l2==DD[i]) {
              for (int f = fills.length-1; f>=0; f--) {
                for (Point k : fills[f].pts) {
                  if (k==p.ps[x]) {
                    fills=del(fills, f);
                  }
                }
              }
              p.ps=del(p.ps, x);
            }
          }
        }
        for (int j = imp.length-1; j >= 0; j--) {
          for (int f = fills.length-1; f>=0; f--) {
            for (Point k : fills[f].pts) {
              if (k==imp[j]) {
                fills=del(fills, f);
              }
            }
          }
          if (imp[j].l1==DD[i]||imp[j].l2==DD[i]) {
            imp=del(imp, j);
          }
        }
        DD=del(DD, i);
      }
    }
    for (int i=SS.length-1; i>=0; i--) {
      if (SS[i].focus) {
        for (Point p : imp) {
          for (int x = p.ps.length-1; x>=0; x--) {
            if (p.ps[x].l2==SS[i]) {
              for (int f = fills.length-1; f>=0; f--) {
                for (Point k : fills[f].pts) {
                  if (k==p.ps[x]) {
                    fills=del(fills, f);
                  }
                }
              }
              p.ps=del(p.ps, x);
            }
          }
        }
        for (int j = imp.length-1; j >= 0; j--) {
          for (int f = fills.length-1; f>=0; f--) {
            for (Point k : fills[f].pts) {
              if (k==imp[j]) {
                fills=del(fills, f);
              }
            }
          }
          if (imp[j].l2==SS[i]) {
            imp=del(imp, j);
          }
        }
        SS=del(SS, i);
      }
    }
    for (int i=curves.length-1; i>=0; i--) {
      if (curves[i].focus) {
        for (Point p : imp) {
          for (int x = p.ps.length-1; x>=0; x--) {
            if (p.ps[x].l2==curves[i]) {
              for (int f = fills.length-1; f>=0; f--) {
                for (Point k : fills[f].pts) {
                  if (k==p.ps[x]) {
                    fills=del(fills, f);
                  }
                }
              }
              p.ps=del(p.ps, x);
            }
          }
        }
        for (int j = imp.length-1; j >= 0; j--) {
          for (int f = fills.length-1; f>=0; f--) {
            for (Point k : fills[f].pts) {
              if (k==imp[j]) {
                fills=del(fills, f);
              }
            }
          }
          if (imp[j].l2==curves[i]) {
            imp=del(imp, j);
          }
        }
        curves=del(curves, i);
      }
    }
    for (int i=AS.length-1; i>=0; i--) {
      if (AS[i].focus) {
        for (Point p : imp) {
          for (int x = p.ps.length-1; x>=0; x--) {
            if (p.ps[x].l2==AS[i]) {
              for (int f = fills.length-1; f>=0; f--) {
                for (Point k : fills[f].pts) {
                  if (k==p.ps[x]) {
                    fills=del(fills, f);
                  }
                }
              }
              p.ps=del(p.ps, x);
            }
          }
        }
        for (int j = imp.length-1; j >= 0; j--) {
          for (int f = fills.length-1; f>=0; f--) {
            for (Point k : fills[f].pts) {
              if (k==imp[j]) {
                fills=del(fills, f);
              }
            }
          }
          if (imp[j].l2==AS[i]) {
            imp=del(imp, j);
          }
        }
        AS=del(AS, i);
      }
    }
  }
  if (sb1[1].hovered) {
    //add demand line button
    Line l = new Line();
    l.create(1, 0, 600+DD.length*100, 700, DD.length*100 );
    DD = (Line[])append(DD, l);
  }

  if (sb1[2].hovered) {
    //add supply line button
    Line l = new Line();
    l.create(0, 100+SS.length*100, 0, 800, w.h-2*w.m+SS.length*100);
    SS = (Line[])append(SS, l);
  }
  if (sb1[3].hovered) {
    //add curve button
    Line l = new Line();
    l.create(3, 20, 300, 400, 300, 600, 500);
    curves = (Line[])append(curves, l);
  }
  if (sb1[4].hovered) {
    //add AS button
    Line l = new Line();
    l.create(4, 100, 40, 600, 600);
    AS = (Line[])append(AS, l);
  }



  if (bs[1].hovered) {
    //add points button
    mode=1;



    //imp=new Point[0];
    for (Line d : DD) {
      for (Line s : SS) {
        boolean exists=false;
        for (Point p : imp) {
          if (p.l1==d&&p.l2==s||p.l1==s&&p.l2==d) {
            exists=true;
          }
        }

        if (!exists) {
          Point x = new Point();
          x.create(0, d, s);
          x.solve();
          imp=(Point[])append(imp, x);
        }
      }
    }
    for (Line d : DD) {
      for (Line c : curves) {
        boolean exists=false;
        for (Point p : imp) {
          if (p.l1==d&&p.l2==c||p.l1==c&&p.l2==d) {
            exists=true;
          }
        }

        if (!exists) {
          Point x = new Point();
          x.create(0, d, c);
          x.solve();
          imp=(Point[])append(imp, x);
        }
      }
    }
    for (Line d : DD) {
      for (Line s : AS) {
        boolean exists=false;
        for (Point p : imp) {
          if (p.l1==d&&p.l2==s||p.l1==s&&p.l2==d) {
            exists=true;
          }
        }
        if (!exists) {
          Point x = new Point();
          x.create(0, d, s);
          x.solve();
          imp=(Point[])append(imp, x);
        }
      }
    }




    for (Point p : imp) {

      if (p.selected) {
        p.show();
      }
      for (Point x : p.ps) {
        if (x.selected) {
          x.show();
        }
        for (Point i : x.ps) {
          if (i.selected) {
            i.show();
          }
        }
      }
    }


    println("___________");
    println("existing points:");
    for (Point p : imp) {
      println(p.x+", "+p.y+", "+p.ps.length+", "+p.exs.length);
      for (Point ex : p.ps) {
        println(" -- "+ex.x+", "+ex.y+", "+ex.ps.length);
        for (Point x : ex.ps) {
          println("    -- "+x.x+", "+x.y);
        }
      }
    }
    println("___________");
  } else {
  }

  if (mode==1.1) {
    for (Point p : imp) {
      if (p.hover&&!p.selected) {
        p.selected =true;
      } else if (p.hover&&p.selected) {
        p.selected=false;
        for (Point x : p.ps) {
          x.hide();
        }
      }
      for (Line l : p.exs) {
        if (l.hovered&&!l.selected) {
          l.selected =true;
        } else if (l.hovered&&l.selected) {
          l.selected=false;
        }
      }
      for (Point x : p.ps) {

        for (Line l : x.exs) {
          if (l.hovered&&!l.selected) {
            l.selected =true;
          } else if (l.hovered&&l.selected) {
            l.selected=false;
          }
        }
      }
    }
  }
  if (mode==1.2) {
    for (Point p : imp) {
      for (Line l : p.exs) {
        if (l.hovered&&!l.selected) {
          l.selected =true;
        } else if (l.hovered&&l.selected) {
          l.selected=false;
        }
      }
      for (Point x : p.ps) {
        if (p.selected) {
          if (x.hover&&!x.selected) {
            x.selected =true;
          } else if (x.hover&&x.selected) {
            x.selected=false;
          }
        }
        for (Point i : x.ps) {
          if (p.selected) {
            if (i.hover&&!i.selected) {
              i.selected =true;
            } else if (i.hover&&i.selected) {
              i.selected=false;
            }
          }
        }


        for (Line l : x.exs) {
          if (l.hovered&&!l.selected) {
            l.selected =true;
          } else if (l.hovered&&l.selected) {
            l.selected=false;
          }
        }
      }
    }
  }

  if ((int)mode==1) {
  }

  if (sb2[0].hovered) {
    mode = 1.1;
    for (Point p : imp) {
      p.show();
      for (Point x : p.ps) {
        if (!x.selected) {
          x.hide();
        }
        for (Point i : x.ps) {
          if (!i.selected) {
            i.hide();
          }
        }
      }
    }
  }
  if (sb2[1].hovered) {
    mode = 1.2;
    for (Point p : imp) {
      if (!p.selected) {
        p.hide();
      }
      for (Point x : p.ps) {
        x.show();
        for (Point i : x.ps) {
          i.show();
        }
      }
    }
  }
  



  if (bs[2].hovered) {
    mode = 2;
  }
  if (sb3[0].hovered) {
    TextBox tb = new TextBox();
    tb.create("", width/2, height/2, u, u/3);
    tbs=(TextBox[])append(tbs, tb);
  }

  if (sb3[1].hovered) {
    for (int i=tbs.length-1; i>=0; i--) {
      if (tbs[i].focus) {
        tbs=del(tbs, i);
      }
    }
  }


  if (bs[3].hovered) {
    /////////////shading
    mode = 3;
  }

  if (sb4[0].hovered) {
    mode = 3.1;
    for (Point p : imp) {

      if (p.selected) {
        p.show();
      }
      for (Point x : p.ps) {
        if (x.selected) {
          x.show();
        }
        for (Point i : x.ps) {
          if (i.selected) {
            i.show();
          }
        }
      }
    }
  }
  if (sb4[1].hovered) {
    Fill f = new Fill();
    Point[] fillpts = new Point[0];
    for (Point p : imp) {
      for (Point x : p.ps) {
        for (Point i : x.ps) {
          if (i.shading) {
            fillpts=(Point[])append(fillpts, i);
          }
        }
        if (x.shading) {
          fillpts=(Point[])append(fillpts, x);
        }
      }
      if (p.shading) {
        fillpts=(Point[])append(fillpts, p);
      }
    }

    f.create(sortP(fillpts));
    fills=(Fill[])append(fills, f);


    for (Point p : imp) {
      for (Point x : p.ps) {
        for (Point i : x.ps) {
          i.shading=false;
        }
        x.shading=false;
      }
      p.shading=false;
    }
    fillpts = new Point[0];
    mode = 3;
  }
  if (sb4[2].hovered) {
    for (int i=fills.length-1; i>=0; i--) {
      if (fills[i].focus) {
        fills=del(fills, i);
      }
    }
  }

  if (mode==3.1) {
    for (Point p : imp) {
      if (p.hover&&!p.shading&&p.shown) {
        p.shading =true;
      } else if (p.hover&&p.shading) {
        p.shading=false;
      }
      for (Point x : p.ps) {
        if (p.selected) {
          if (x.hover&&!x.shading&&x.shown) {
            x.shading =true;
          } else if (x.hover&&x.shading) {
            x.shading=false;
          }
        }

        for (Point i : x.ps) {
          if (i.selected) {
            if (i.hover&&!i.shading&&i.shown) {
              i.shading =true;
            } else if (i.hover&&i.shading) {
              i.shading=false;
            }
          }
        }
      }
    }
  }



  if (bs[4].hovered) {
    //export button

    mode=-1;
    for (Button b : sb1) {
      b.visible=false;
    }
    for (Button b : sb2) {
      b.visible=false;
    }
    PImage crop = get(w.x+3, w.y+3, w.w-3, w.h-3);
    imageCount++;
    crop.save("Diagrams/" + "diagram-" + imageCount + ".png");
    endRecord();
  }


  if (mode==0) {
    for (Line l : DD) {
      if (l.hovered&&!focusing) {
        l.focus=true;
        focusing=true;
      } else {
        l.focus=false;
        focusing=false;
      }
    }
    for (Line l : SS) {
      if (l.hovered&&!focusing) {
        l.focus=true;
        focusing=true;
      } else {
        l.focus=false;
        focusing=false;
      }
    }
    for (Line l : curves) {
      if (l.hovered&&!focusing) {
        l.focus=true;
        focusing=true;
      } else {
        l.focus=false;
        focusing=false;
      }
    }
    for (Line l : AS) {
      if (l.hovered&&!focusing) {
        l.focus=true;
        focusing=true;
      } else {
        l.focus=false;
        focusing=false;
      }
    }
  }

  for (TextBox tb : tbs) {
    if (tb.hover&&!focusing) {
      tb.xoff=w.mx-tb.x;
      tb.yoff=w.my-tb.y;
      tb.focus=true;
      focusing=true;
    } else {
      tb.focus=false;
      focusing=false;
    }
  }
  if ((int)mode==3) {
    for (Fill f : fills) {

      if (f.hover&&!focusing) {
        f.focus=true;
        focusing=true;
      } else {
        f.focus=false;
        focusing=false;
      }
    }
  }

  if ((int)mode!=1&&mode!=3.1) {
    for (Point p : imp) {
      for (Point x : p.ps) {  
        for (Point i : x.ps) {       
          i.hide();
        }
        x.hide();
      }
      p.hide();
    }
  }
  if ((int)mode!=3) {
    for (Point p : imp) {
      for (Point x : p.ps) {
        x.shading=false;
      }
      p.shading=false;
    }
  }
  if (mode!=0) {

    for (Line l : DD) {
      l.focus=false;
    }
    for (Line l : SS) {
      l.focus=false;
    }
    for (Line l : curves) {
      l.focus=false;
    }
    for (Line l : AS) {
      l.focus=false;
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
Point[] del(Point[] input, int index) {
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

Point[] sortP(Point[] input) {

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
