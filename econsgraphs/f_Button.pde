class Button {
  float x1, y1, x2, y2, d;
  boolean pressed = false;
  boolean hovered = false;
  boolean visible = false;
  color c1;
  color c2;
  String t;
  Button[] bs = new Button[0];
  PImage icon;
  color c;
  Button parent;
  int i;

  int type;

  Button(int type, String t, PImage icon, float x, float y, float d, color c1, color c2) {
    this.t=t;
    this.x1=x;
    this.y1=y;
    this.x2=x;
    this.y2=y;
    this.d=d;
    this.c1=c1;
    this.c2=c2;
    this.type=type;
    this.icon=icon;
  }
  Button(int type, String t, float x1, float y1, float x2, float y2, float d, color c1, color c2) {
    this.t=t;
    this.x1=x1;
    this.y1=y1;
    this.x2=x2;
    this.y2=y2;
    this.d=d;
    this.c1=c1;
    this.c2=c2;
    this.type=type;
  }

  Button(color c, Button parent, int i) {
    this.c=c;
    this.parent=parent;
    this.i=i;
    type=SUBSUB;
    d=parent.d*4/5;
    x1=(parent.x1+parent.x2)/2+d*(i%3-1);
    y1=parent.y1+parent.d+d*(i/3);
  }

  void render() {
    if (type<2) {
      hovered=false;
      if (visible) {
        fill(c1);

        if (dist(mouseX, mouseY, x1, y1)<d/2||dist(mouseX, mouseY, x2, y2)<d/2||(mouseX>x1&&mouseX<x2&&mouseY>y1-d/2&&mouseY<y2+d/2)) {
          hovered=true;
          fill(c2);
        }

        if (type==MAIN) {
          noStroke();
          strokeWeight(2);
          ellipse(x1, y1, d, d);

          textSize(16);
          textAlign(CENTER, CENTER);
          fill(0);
          text(t, x1, y1+0.6*d);
          image(icon, x1-icon.width/2, y1-icon.height/2);
        } else if (type==SUB) {
          noStroke();
          strokeWeight(2);
          ellipse(x1, y1, d, d);
          ellipse(x2, y2, d, d);
          rect(x1, y1-d/2, x2-x1, d);
          textSize(16);
          textAlign(CENTER, CENTER);
          fill(0);
          text(t, (x1+x2)/2, y1);
        }
      }
      if (visible) {
        if (bs.length!=0) {
          for (Button b : bs) {
            if (b.visible) {
              b.render();
            } else {
              b.hovered=false;
            }
          }
        }
      }
    } else if (type==2) {
      hovered=false;
      if (dist(mouseX, mouseY, x1, y1)<d/2) {
        hovered=true;
      }
      if (visible) {
        fill(c, alpha);
        if (hovered) {
          noFill();
          stroke(127);
          strokeWeight(3);
          ellipse(x1,y1,d, d);
          fill(c, alpha2);
          
        }

        noStroke();
        strokeWeight(2);
        ellipse(x1, y1, 0.9*d, 0.9*d);
      }
    }
  }
}
