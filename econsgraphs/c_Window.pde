class Window {
  float x, y, w, h, m, mx, my;

  Line[] axes;
  Window(float x, float y, float w, float h, float m) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.m=m;
    //axes = new Line[0];
    
  }

  void renderWindow() {
    
    w=width-x;
    h=height-y;
    mx=mouseX-x-3*m;
    my=height-y+m-mouseY;
    if (!exporting) {
      fill(0);
      textAlign(TOP, RIGHT);
      text(mx+", " + my, u/10, height);
    }
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
    wline(0, 0, 0, h-3*m);
    wline(0, 0, w-10*m, 0);
    wline(0, h-3*m, -m/4, h-3.5*m);
    wline(0, h-3*m, m/4, h-3.5*m);
    wline(w-10*m, 0, w-10.5*m, m/4);
    wline(w-10*m, 0, w-10.5*m, -m/4);
  }
  
  void createAxes(){
  PVector[] tempy = new PVector[2];
  tempy[0]=new PVector(0, 0);
  tempy[1]=new PVector(0, h);
  yaxis=new Line(3, tempy);
  PVector[] tempx = new PVector[2];
  tempx[0]=new PVector(0, 0);
  tempx[1]=new PVector(w, 0);
  xaxis=new Line(3, tempx);
  axes[0]=xaxis;
  axes[1]=yaxis;
  }

  void wrect(float x, float y, float w, float h) {
    rect(this.x+3*m+x, height-m-y, w, h);
  }
  void wline(float x1, float y1, float x2, float y2) {
    line(this.x+3*m+x1, height-m-y1, this.x+3*m+x2, height-m-y2);
  }
  void wline(float x1, float y1, float x2, float y2, int dot) {
    float gap = 20;
    if (x1==x2) {
      float ystart = min(y1, y2);
      float yend = max(y1, y2);
      float yx = ystart;
      while (yx<yend-gap) {
        wline(x1, yx, x2, yx+gap/2);
        yx+=gap;
      }
      wline(x1, yx, x2, yend);
    } 
    if (y1==y2) {
      float xstart = min(x1, x2);
      float xend = max(x1, x2);
      float xy = xstart;
      while (xy<xend-gap) {
        wline(xy, y1, xy+gap/2, y2);
        xy+=gap;
      }
      wline(xy, y1, xend, y2);
    }
  }


  void wcircle(float x, float y, float r) {
    ellipse(this.x+3*m+x, height-m-y, r, r);
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
    text(text, this.x+3*m+x, height-m-y);
  }

  void wvertex(float x, float y) {
    vertex(this.x+3*m+x, height-m-y);
  }
}
