class Point {
  float x, y;
  int type;
  Line l1, l2;
  float r = u/3;
  Point(int type, Line l1, Line l2) {
    this.type=type;
    this.l1=l1;
    this.l2=l2;
    solve();
  }

  void render() {
    stroke(0);
    noFill();
    strokeWeight(3);
    w.wcircle(x, y, r);
  }

  void solve() {
    if (l1.type==0&&l2.type==0) {
      if (l1.n==1&&l2.n==1) {//solve 2 linear
        //float m1=(l1.p[1].y-l1.p[0].y)/(l1.p[1].x-l1.p[0].x);
        //float m2=(l2.p[1].y-l2.p[0].y)/(l2.p[1].x-l2.p[0].x);
        //x=(m1*l1.p[0].x-m2*l2.p[0].x+l2.p[0].y-l1.p[0].y)/(m1-m2);
        //y=m1*(x-l1.p[0].x)+l1.p[0].y;
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
        }
      } else if (l1.n==1&&l2.n==2) {//solve linear + quad
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
        float t = (-b+sqrt(sq(b)-4*a*c))/(2*a);
        println(t);
        if (t>0&&t<1) {
          x=sq(1-t)*p0x+2*(1-t)*t*p1x+sq(t)*p2x;
          y=sq(1-t)*p0y+2*(1-t)*t*p1y+sq(t)*p2y;
        }
        
      } else if (l1.n==1&&l2.n==3) {//solve linear + cubic
      }
    } else if (l1.type==0&&l2.type==1) {//solve linear + AS
    } else if (l1.type==1&&l2.type==0) {
    }
  }
}
