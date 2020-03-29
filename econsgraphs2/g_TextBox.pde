class TextBox {

  float x, y, wid, h;
  float xoff, yoff;
  String t;
  boolean focusing = false;
  boolean moving = false;
  boolean hovering = false;

  TextBox(String t_, float x_, float y_, float w_, float h_) {
    t=t_;
    x=x_;
    y=y_;
    wid=w_;
    h=h_;
  }

  void render() {

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
    noFill();
    w.wrect(x, y, wid, h);
    textAlign(LEFT, TOP);
    textSize(20);
    fill(0);
    if (focusing) {
      w.write(t+"|", x, y);
    } else {
      w.write(t, x, y);
    }

    if (textWidth(t)>u) {
      wid=textWidth(t+1);
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
