class Button {
  int x, y, w, h;
  boolean pressed, hovered = false;
  boolean visible = true;
  color c1;
  color c2;
  String t;

  void create(String t_, int x_, int y_, int w_, int h_, color c1_, color c2_) {
    t=t_;
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    c1=c1_;
    c2=c2_;
    
  }

  void render() {
    
    hovered=false;
    if (visible) {
      fill(c1);
     
      if (mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h) {
        hovered=true;
        fill(c2);
      }
      stroke(0);
      strokeWeight(2);
      rect(x, y, w, h);
      textSize(12);
      textAlign(CENTER, CENTER);
      fill(0);
      text(t, x+w/2, y+h/2);
    }
  }
}
