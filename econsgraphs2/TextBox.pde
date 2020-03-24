class TextBox {

  float x, y, wid, h;
  float xoff, yoff;
  String t;
  boolean focus = false;
  boolean moving = false;
  boolean hover = false;

  void create(String t_, float x_, float y_, float w_, float h_) {
    t=t_;
    x=x_;
    y=y_;
    wid=w_;
    h=h_;
  }

  void render() {

    checkHover();
    if (focus) {
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

    if (hover||focus) {
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
    w.write(t, x, y);

    if (textWidth(t)>u) {
      wid=textWidth(t);
    }
  }

  void checkHover() {
    if (w.mx>x&&w.mx<x+wid&&w.my<y&&w.my>y-h) {
      hover=true;
    } else {
      hover = false;
    }
  }
}
