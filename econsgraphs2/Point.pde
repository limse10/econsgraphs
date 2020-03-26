class Point {
  float x, y;
  int type;
  int root;
  Line l1, l2;
  float r = u/3;
  boolean visible = false;
  boolean hovering = false;
  boolean selected = false;
  Point[] ps = new Point[0];
  Line[] ls = new Line[0];

  Point(int type, Line l1, Line l2) {
    this.type=type;
    this.l1=l1;
    this.l2=l2;
    solve();
    PVector[] x = new PVector[2];
    x[0] = new PVector(this.x, this.y);
    x[1] = new PVector(this.x, 0);
    Line lx = new Line(2, x);
    ls=(Line[])append(ls, lx);
    PVector[] y = new PVector[2];
    y[0] = new PVector(this.x, this.y);
    y[1] = new PVector(0, this.y);
    Line ly = new Line(2, y);
    ls=(Line[])append(ls, ly);
  }
  Point(int type, Line l1, Line l2, int root) {
    this.type=type;
    this.l1=l1;
    this.l2=l2;
    this.root = root; //determines which root to take in case of quadratic 
    solve();
    PVector[] x = new PVector[2];
    x[0] = new PVector(this.x, this.y);
    x[1] = new PVector(this.x, 0);
    Line lx = new Line(2, x);
    ls=(Line[])append(ls, lx);
    PVector[] y = new PVector[2];
    y[0] = new PVector(this.x, this.y);
    y[1] = new PVector(0, this.y);
    Line ly = new Line(2, y);
    ls=(Line[])append(ls, ly);
  }

  void render() {
    solve();
    if (sqrt(sq(w.mx-x)+sq(w.my-y))<0.5*r) {
      hovering = true;
    } else {
      hovering = false;
    }

    if (visible||selected) {
      if (mode==1) {
        stroke(0);
        noFill();
        if (selected) {
          stroke(255, 0, 0);
        } else if (hovering) {
          stroke(250, 127, 127);
        }

        strokeWeight(3);
        w.wcircle(x, y, r);
      }
      ls[0].p[0].x=x;
      ls[0].p[0].y=y;
      ls[0].p[1].x=x;
      ls[1].p[0].x=x;
      ls[1].p[0].y=y;
      ls[1].p[1].y=y;
      if (selected&&visible) {
        for (Line l : ls) {
          l.render();
        }
      }
    }
  }

  void solve() {
    if ((l1.type==0||l1.type==2)&&l2.type==0) {
      if (l1.n==1&&l2.n==1) {////////////////////////////////////////////////////////////////solve 2 linear//////////////////////////////////////////////////////////////

        float y0=l1.p[0].y;
        float y1=l1.p[1].y;
        float y2=l2.p[0].y;
        float y3=l2.p[1].y;
        float x0=l1.p[0].x;
        float x1=l1.p[1].x;
        float x2=l2.p[0].x;
        float x3=l2.p[1].x;
        float tb=(x2-x0-(y2-y0)*(x1-x0)/(y1-y0))/(((x1-x0)*(y3-y2))/(y1-y0)-(x3-x2));
        if (tb>0&&tb<1) {
          x=x2+tb*(x3-x2);
          y=y2+tb*(y3-y2);
          if (((y-y0)/(y1-y0)>0&&(y-y0)/(y1-y0)<1)&&((y-y2)/(y3-y2)>0&&(y-y2)/(y3-y2)<1)) {
            visible=true;
          } else {
            visible = false;
          }
        } else {
          x=Float.NaN;
          y=Float.NaN;
          visible=false;
        }
      } else if (l1.n==1&&l2.n==2) {////////////////////////////////////////////////////////////solve linear + quad//////////////////////////////////////////////////
        float y0=l1.p[0].y;
        float y1=l1.p[1].y;
        float x0=l1.p[0].x;
        float x1=l1.p[1].x;
        float p0x=l2.p[0].x;
        float p0y=l2.p[0].y;
        float p1x=l2.p[1].x;
        float p1y=l2.p[1].y;
        float p2x=l2.p[2].x;
        float p2y=l2.p[2].y;

        float A = y1-y0;
        float B = x0-x1;
        float C = x0*(y1-y0)-y0*(x1-x0);
        float LP0 = A*p0x+B*p0y;
        float LP1 = A*p1x+B*p1y;
        float LP2 = A*p2x+B*p2y;
        float a=LP0-2*LP1+LP2;
        float b=-2*LP0+2*LP1;
        float c=LP0-C;
        float t=0;
        if (root==1) {
          t = (-b+sqrt(sq(b)-4*a*c))/(2*a);
        } else if (root==-1) {
          t = (-b-sqrt(sq(b)-4*a*c))/(2*a);
        }


        x=sq(1-t)*p0x+2*(1-t)*t*p1x+sq(t)*p2x;
        y=sq(1-t)*p0y+2*(1-t)*t*p1y+sq(t)*p2y;
        if (t>0&&t<1&&type==0) {
          if ((y-y0)/(y1-y0)>0&&(y-y0)/(y1-y0)<1) {
            visible=true;
          } else {
            visible = false;
          }
        } else if(type==1){
        visible=true;
        
        } else {
          x=Float.NaN;
          y=Float.NaN;
          visible=false;
        }
      }
    } else if (l1.n==1&&l2.n==3) {//solve linear + cubic
    
  } else if (l1.type==0&&l2.type==1) {//solve linear + AS
}
}
}
