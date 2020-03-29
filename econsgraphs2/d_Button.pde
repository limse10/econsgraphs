class Button {
  int x, y, w, h;
  boolean pressed = false;
  boolean hovered = false;
  boolean visible = false;
  color c1;
  color c2;
  String t;
  Button[] bs = new Button[0];
  
  color c;
  Button parent;
  int i;

  int type;

  Button(String t_, int x_, int y_, int w_, int h_, color c1_, color c2_) {
    t=t_;
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    c1=c1_;
    c2=c2_;
    type=0;
  }

  Button(color c, Button parent, int i) {
    this.c=c;
    this.parent=parent;
    this.i=i;
    type=1;
    w=parent.w/3;
    h=parent.h/3;
    x=(parent.x+parent.w)+w*((i*w)%3);
    y=parent.y+h*(i/3);
  }

  void render() {
    if (type==0) {
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
      if (visible) {
        if (bs.length!=0) {
          for (Button b : bs) {
            if (b.visible) {
              b.render();
            }else{
            b.hovered=false;
            }
          }
        }
      }
    } else if (type==1) {
      hovered=false;
      if (visible) {
        fill(c);
        stroke(0);
        strokeWeight(2);
        rect(x, y, w, h);
        if (mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h) {
          hovered=true;

        } 
      }
    }
  }
}
