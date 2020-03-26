class Window {
  int x, y, w, h, m, mx, my;

  Line[] axes;
  void create(int x_, int y_, int w_, int h_, int m_) {
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    m=m_;
    axes = new Line[0];
    //Line xaxis = new Line();
    //Line yaxis = new Line();
    //xaxis.create(2, 0, 0, 0, h-2*m);
    //yaxis.create(2, 0, 0, w-8*m, 0);
    //axes=(Line[])append(axes, xaxis);
    //axes=(Line[])append(axes, yaxis);
    //Point p = new Point();
    //p.create(0,xaxis,yaxis);
    //imp=(Point[])append(imp,p);
  }

  void renderWindow() {
    //noStroke();
    //fill(bg);
    //rect(u, u, width-u, height-u);
    w=width-u;
    h=height-u;
    mx=mouseX-u-3*m;
    my=height-u+m-mouseY;
    fill(0);
    textAlign(TOP, RIGHT);
    text(mx+", " + my, u/10, height);
  }

  void renderAxes() {
    //noStroke();
    //fill(bg);
    //rect(u, u, 3*m, height-u);
    //rect(u, u, width-u, m);
    //rect(u, height-m, width-u, m);
    //rect(width-5*m, u, 3*m, height-u);
    strokeWeight(4);
    stroke(0);
    wline(0, 0, 0, h-2*m);
    wline(0, 0, w-8*m, 0);
    wline(0, h-2*m, -m/4, h-2.5*m);
    wline(0, h-2*m, m/4, h-2.5*m);
    wline(w-8*m, 0, w-8.5*m, m/4);
    wline(w-8*m, 0, w-8.5*m, -m/4);
  }

  void wrect(float x, float y, float w, float h) {
    rect(u+3*m+x, height-m-y, w, h);
  }
  void wline(float x1, float y1, float x2, float y2) {
    line(u+3*m+x1, height-m-y1, u+3*m+x2, height-m-y2);
  }
  void wline(float x1, float y1, float x2, float y2, int dot) {
    float t=0;
    float tres = dist(x1,y1,x2,y2)/5000;
    while (t<1) {
      wline(x1+t*(x2-x1), y1+t*(y2-y1), x1+(t+tres/2)*(x2-x1), y1+(t+tres/2)*(y2-y1));
      t+=tres;
    }
  }


  void wcircle(float x, float y, float r) {
    ellipse(u+3*m+x, height-m-y, r, r);
  }

  void wcurve(float a, float b, float c, float x1, float x2, float r) {
    for (float  x = x1; x<x2; x+=2) {
      wline(x, a*sq(x)+b*x+c, x+2, a*sq(x+2)+b*(x+2)+c);
    }
  }

  void warc(float x1, float y1, float r) {
    for (float  x = x1; x<x1+r; x+=2) {
      wline(x, -sqrt(sq(r)-sq(x-x1))+y1, x+2, -sqrt(sq(r)-sq(x+2-x1))+y1);
    }
  }
  void wpoint(float x, float y, float r) {
    wline(x-r, y-r, x+r, y+r);
    wline(x-r, y+r, x+r, y-r);
  }

  void write(String text, float x, float y) {
    text(text, u+3*m+x, height-m-y);
  }

  void wvertex(float x, float y) {
    vertex(u+3*m+x, height-m-y);
  }
}
