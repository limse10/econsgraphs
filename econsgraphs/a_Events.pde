

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2) {

    if (mode==3.1) {
      if(tempfill!=null){
      endfill();
    }}
  }
}




void mousePressed() {
  focus = false;

 
    
    if(tempfill!=null&&mode!=3.1){
      endfill();
    }

  if (mains[1].hovered) {
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
  if (mains[2].hovered) {
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


  if (mains[3].hovered) {
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


  if(mode==2){
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
  }

  if (subs[3].buttons[0].hovered) {
    
   
    
    
    
    
    
    mode = 3.1;
  }
  if (mains[4].hovered) {
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


  
  if (subs[3].buttons[2].hovered) {
    deleteFill();
  }


  if (subs[3].buttons[1].hovered) {

    if (!subs[3].buttons[1].pressed) {
      subs[3].buttons[1].pressed = true;
      for (Button b : subs[3].buttons[1].bs) {
        b.visible=true;
        mode=3.2;
      }
    } else if (subs[3].buttons[1].pressed) {
      subs[3].buttons[1].pressed = false;
      for (Button b : subs[3].buttons[1].bs) {
        b.visible=false;
        mode=3;
      }
    }
  } else {
    subs[3].buttons[1].pressed = false;
    for (Button b : subs[3].buttons[1].bs) {
      b.visible=false;
    }
  }

  for (Button b : subs[3].buttons[1].bs) {
    if (mode==3.2) {
      if (b.hovered) {
        mode=3.3;
        fillcol=b.c;
      }
    }
  }


  if (mains[0].hovered) {
    //export button
    mode=-1;
  }
if (subs[4].buttons[0].hovered) {
    new_diagram();
  }
  if (subs[4].buttons[1].hovered) {
    imageCount++;
    render(255, false);
    PImage crop = get(int(w.x+u/2), int(w.y+u/2), int(w.w), int(w.h));
    crop.save("Diagrams/" + "diagram-" + imageCount + ".png");
  }

  if (subs[4].buttons[2].hovered) {
    imageCount++;
    //beginRecord(SVG, "Diagrams/"+"diagram-" + imageCount+".svg");
    //exporting=true;
    //render(255, true);
    //endRecord();
    //exporting=false;
    svg.writeToSVG("Diagrams/"+"diagram-"+ imageCount+".svg");
  }

  if ((int)mode==3) {

    for (Fill f : fills) {

      if (f.hovering&&!focus) {
        f.focusing=true;
        focus=true;
        if (mode==3.3) {
          f.c=fillcol;
          mode=3;
        }
      } else {
        if (!subs[3].buttons[2].hovered) {
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
  if (mode==3.1) {
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
    if (fillpts.length>2) {
      Fill f = new Fill(sortP(fillpts));

      tempfill=f;
    }



    fillpts = new Point[0];
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




void keyPressed() {


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
     
      for (Line l : lines) {
        if (l.focusing) {
          l.focusing=false;
          copied = new Line(l.type, l.p);
        }
      }
    }
    if (keys[1]&&keys[0]&&!keys[2]) {
    
      for (Line l : lines) {
        if (l.focusing) {
          l.focusing=false;
          copied = new Line(l.type, l.p);
        }
      }
    }
    if (keys[2]&&keys[0]&&!keys[1]) {
     
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

void keyReleased() {
  if (keyCode==17) {
    keys[0]=true;
  } else if (keyCode==67) {
    keys[1]=false;
  } else if (keyCode==86) {
    keys[2]=false;
  }
}
