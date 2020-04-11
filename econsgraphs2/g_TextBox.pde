class TextBox {

  float x, y, wid, h;
  float xoff, yoff;
  String[] t = new String[0];
  int substring=0;
  boolean[] subscript = new boolean[0];
  boolean subscripting = false;
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

  void render() {
    println(subscript);
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


    write();
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


  void write() {
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
  void checkHover() {
    if (w.mx>x&&w.mx<x+wid&&w.my<y&&w.my>y-h) {
      hovering=true;
    } else {
      hovering = false;
    }
  }
}
