class Line {
  int type;
  int n;
  PVector[] p;
  float tres=0.01;
  float t=0;
  PVector curr = new PVector();
  PVector next = new PVector();
  Line(int type, PVector[] p) {
    this.type=type;
    if (type==0) {
      this.n=p.length-1;
    }   
    this.p=p;
  }

  void render() {
    if (n<=3) {//draw bezier
      t=0;
      while (t<=1) {
        curr.x=0;
        curr.y=0;
        next.x=0;
        next.y=0;
        for (int i = 0; i <= n; i++) {
          curr.x+=choose(n, i)*pow(1-t, n-i)*pow(t, i)*p[i].x;
          curr.y+=choose(n, i)*pow(1-t, n-i)*pow(t, i)*p[i].y;
          next.x+=choose(n, i)*pow(1-(t+tres), n-i)*pow((t+tres), i)*p[i].x;
          next.y+=choose(n, i)*pow(1-(t+tres), n-i)*pow((t+tres), i)*p[i].y;
        }


        stroke(0);        
        //w.wpoint(curr.x, curr.y,2);
        w.wline(curr.x, curr.y, next.x, next.y);
        t+=tres;
      }
      for (PVector point : p) {
        w.wpoint(point.x, point.y, 5);
      }
    }
  }
}




//class Line {
//  int type; //0 SS, 1 DD, 2 dotted, 3 curve, 4 AS
//  float x1, y1, x2, y2, x3, y3;
//  float y_int, m, a, b, c;
//  boolean hovered = false;
//  boolean focus = false;
//  boolean moving1 = false;
//  boolean moving2 = false;
//  boolean moving3 = false;
//  boolean translating = false;

//  boolean selected = false;

//  float leftbound=0;
//  float rightbound=0;

//  float r = u/4;
//  float asr = 2*u;
//  int sw = 4;


//  void create(int t, float x1_, float y1_, float x2_, float y2_) {
//    type = t;
//    x1=x1_;
//    y1=y1_;
//    x2=x2_;
//    y2=y2_;
//    if (type<=1) {
//      m=(y2-y1)/(x2-x1);
//    }
//  }
//  void create(int t, float x1_, float y1_, float x2_, float y2_, float x3_, float y3_) {
//    type = t;
//    x1=x1_;
//    y1=y1_;
//    x2=x2_;
//    y2=y2_;
//    x3=x3_;
//    y3=y3_;
//    a=((y1-y2)*(x1-x3)-(y1-y3)*(x1-x2))/((x1-x2)*(x1-x3)*(x2-x3));
//    b=(y1-y2-(sq(x1)-sq(x2))*a)/(x1-x2);
//    c=y1-sq(x1)*a-x1*b;
//  }



//  void render() {
//    stroke(0);

//    if (type==1||type==0) {
//      if (focus) {
//        if (sq((w.mx-x1))+sq((w.my-y1))<sq(1.5*r)) {
//          moving1 = true;
//          moving2 = false;
//        }
//        if (sq((w.mx-x2))+sq((w.my-y2))<sq(1.5*r)) {
//          moving2 = true;
//          moving1 = false;
//        }
//        if (mousePressed) {
//          if (moving1) {
//            x1=w.mx;
//            y1=w.my;
//          }
//          if (moving2) {
//            x2=w.mx;
//            y2=w.my;
//          }
//        } else {
//          moving1=false;
//          moving2=false;
//        }
//      }
//      restrict();
//      checkHover();
//      if (hovered||focus) {
//        strokeWeight(5);
//        noFill();
//        w.wcircle(x1, y1, r);
//        w.wcircle(x2, y2, r);
//        sw=6;
//      } else {
//        sw=4;
//      }
//      strokeWeight(sw);
//      w.wline(x1, y1, x2, y2);
//    } else if (type==2) {
//      checkHover();
//      if (hovered||selected) {
//        stroke(0);
//        if (hovered&&(mode==1.1||mode==1.2)) {
//          stroke(255, 0, 0);
//        } else if (selected) {
//          stroke(0);
//        }
//        strokeWeight(2);
//        if (x1==x2) {
//          float y=0;
//          while (y<y1) {
//            w.wline(x1, y, x2, y+4);
//            y+=8;
//          }
//        }
//        if (y1==y2) {
//          float x=0;
//          while (x<x1) {
//            w.wline(x, y1, x+4, y2);
//            x+=8;
//          }
//        }
//      }
//      //w.wline(x1,y1,x2,y2);
//    } else if (type==3) {
//      a=((y1-y2)*(x1-x3)-(y1-y3)*(x1-x2))/((x1-x2)*(x1-x3)*(x2-x3));
//      b=(y1-y2-(sq(x1)-sq(x2))*a)/(x1-x2);
//      c=y1-sq(x1)*a-x1*b;

//      if (focus) {
//        if (sq((w.mx-x1))+sq((w.my-y1))<sq(1.6*r)) {
//          moving1=true;
//          moving2=false;
//          moving3=false;
//        }
//        if (sq((w.mx-x2))+sq((w.my-y2))<sq(1.6*r)) {
//          moving1=false;
//          moving2=true;
//          moving3=false;
//        }
//        if (sq((w.mx-x3))+sq((w.my-y3))<sq(1.6*r)) {
//          moving1=false;
//          moving2=false;
//          moving3=true;
//        }
//        if (mousePressed) {
//          if (moving1) {
//            x1=w.mx;
//            y1=w.my;
//          }
//          if (moving2) {
//            x2=w.mx;
//            y2=w.my;
//          }
//          if (moving3) {
//            x3=w.mx;
//            y3=w.my;
//          }
//        } else {
//          moving1=false;
//          moving2=false;
//          moving3=false;
//        }
//      }
//      restrict();
//      checkHover();
//      if (hovered||focus) {
//        strokeWeight(5);
//        noFill();
//        w.wcircle(x1, y1, r);
//        w.wcircle(x2, y2, r);
//        w.wcircle(x3, y3, r);

//        sw=6;
//      } else {
//        sw=4;
//      }
//      strokeWeight(sw);

//      if (x1<x2&&x1<x3) {
//        leftbound = x1;
//      } else if (x2<x3&&x2<x1) {
//        leftbound = x2;
//      } else if (x3<x1&&x3<x2) {
//        leftbound = x3;
//      }
//      if (x1>x2&&x1>x3) {
//        rightbound = x1;
//      } else if (x2>x3&&x2>x1) {
//        rightbound = x2;
//      } else if (x3>x1&&x3>x2) {
//        rightbound = x3;
//      }
//      w.wcurve(a, b, c, leftbound, rightbound, sw);
//    } else if (type==4) {

//      if (focus) {
//        if (sq((w.mx-x1))+sq((w.my-y1))<sq(1.5*r)) {
//          moving1 = true;
//          moving2 = false;
//        }
//        if (sq((w.mx-x2))+sq((w.my-y2))<sq(1.5*r)) {
//          moving2 = true;
//          moving1 = false;
//        }
//        if (mousePressed) {
//          if (moving1) {
//            x1=w.mx;
//            y1=w.my;
//          } 
//          if (moving2) {
//            x2=w.mx;
//            y2=w.my;
//          }


//        } else {
//          moving1=false;
//          moving2=false;
//        }
//      }
//      restrict();

//      checkHover();
//      if (hovered||focus) {
//        strokeWeight(5);
//        noFill();
//        w.wcircle(x1, y1, r);
//        w.wcircle(x2, y2, r);
//        sw=6;
//      } else {
//        sw=4;
//      }
//      strokeWeight(sw);
//      w.wline(x1, y1, x2-asr, y1);
//      w.wline(x2, y2, x2, y1+asr);
//      w.warc(x2-asr, y1+asr, asr);
//    }
//  }

//  void checkHover() {
//    if ((type==1||type==0)&&mode==0) {
//      if ((abs(m*w.mx+y_int-w.my)<r&&w.mx>x1-r&&w.mx<x2+r)||sq((w.mx-x1))+sq((w.my-y1))<sq(1.5*r)||sq((w.mx-x2))+sq((w.my-y2))<sq(1.5*r)) {
//        hovered=true;
//      } else {
//        hovered=false;
//      }
//    }
//    if (type==2) {
//      if ((int)mode==1) {
//        if (x1==x2) {

//          if (abs(w.mx-x1)<r/3&&w.my<y1&&w.my>y2) {
//            hovered = true;
//          } else {
//            hovered = false;
//          }
//        }
//        if (y1==y2) {
//          if (abs(w.my-y1)<r/3&&w.mx<x1&&w.mx>x2) {
//            hovered = true;
//          } else {
//            hovered = false;
//          }
//        }
//      }
//    }

//    if (type==3&&mode==0) {
//      if (((abs(a*sq(w.mx)+b*w.mx+c-w.my)<r)&&w.mx>leftbound-r&&w.mx<rightbound+r)||sq((w.mx-x1))+sq((w.my-y1))<sq(1.6*r)||sq((w.mx-x2))+sq((w.my-y2))<sq(1.6*r)||sq((w.mx-x3))+sq((w.my-y3))<sq(1.6*r)) {
//        hovered=true;
//      } else {
//        hovered=false;
//      }
//    }
//    if (type==4&&mode==0) {
//      if ((abs(w.my-y1)<r&&w.mx>x1&&w.mx<=x2-asr)||(abs(w.mx-x2)<r&&w.my<y2&&w.my>=y1+asr)||sq((w.mx-x1))+sq((w.my-y1))<sq(1.5*r)||sq((w.mx-x2))+sq((w.my-y2))<sq(1.5*r)) {
//        hovered=true;
//      } else {
//        hovered=false;
//      }
//    }
//  }
//  void restrict() {
//    if (type<=1) {
//      if (x1>x2) {
//        float t = x1;
//        x1=x2;
//        x2=t;
//      }
//      if (y1>y2&&type==0) {
//        float t = y1;
//        y1=y2;
//        y2=t;
//      }
//      if (y1<y2&&type==1) {
//        float t = y1;
//        y1=y2;
//        y2=t;
//      }
//      if (x1<0) {
//        x1=0;
//      }
//      if (y1<0) {
//        y1=0;
//      }
//      if (y2<0) {
//        y2=0;
//      }
//      if (y1>w.h-2*w.m) {
//        y1=height-u-2*w.m;
//      }
//      if (x2>w.w-8*w.m) {
//        x2=w.w-8*w.m;
//      }
//      if (y2>w.h-2*w.m) {
//        y2=height-u-2*w.m;
//      }

//      if (x2!=x1) {
//        m=(y2-y1)/(x2-x1);
//        y_int=y1-m*x1;
//      }

//      if (x1==x2) {
//        x1-=20;
//        x2+=20;
//      }
//      if (y1==y2) {
//        if (type==1) {
//          y1+=2;
//          y2-=2;
//        }
//        if (type==2) {
//          y1-=2;
//          y2+=2;
//        }
//      }
//    }
//    if (type==3) {
//      if (abs(x1-x2)<5) {
//        x1-=15;
//        x2+=15;
//      }
//      if (abs(x1-x3)<5) {
//        x1-=15;
//        x3+=15;
//      }
//      if (abs(x3-x2)<5) {
//        x3-=15;
//        x2+=15;
//      }

//      if (x1<0) {
//        x1=0;
//      }
//      if (y1<0) {
//        y1=0;
//      }
//      if (x2<0) {
//        x2=0;
//      }
//      if (y2<0) {
//        y2=0;
//      }
//      if (x3<0) {
//        x3=0;
//      }
//      if (y3<0) {
//        y3=0;
//      }
//      if (x1>w.w-8*w.m) {
//        x1=w.w-8*w.m;
//      }
//      if (y1>w.h-2*w.m) {
//        y1=height-u-2*w.m;
//      }
//      if (x2>w.w-8*w.m) {
//        x2=w.w-8*w.m;
//      }
//      if (y2>w.h-2*w.m) {
//        y2=height-u-2*w.m;
//      }
//      if (x3>w.w-8*w.m) {
//        x3=w.w-8*w.m;
//      }
//      if (y3>w.h-2*w.m) {
//        y3=height-u-2*w.m;
//      }
//    }

//    if (type==4) {
//      if (x1<0) {
//        x1=0;
//      }
//      if (y1<0) {
//        y1=0;
//      }
//      if (x2<asr) {
//        x2=1.5*asr;
//      }
//      if (y2<asr) {
//        y2=1.5*asr;
//      }
//      if (x1>w.w-8*w.m) {
//        x1=w.w-8*w.m;
//      }

//      if (x2>w.w-8*w.m) {
//        x2=w.w-8*w.m;
//      }
//      if (y2>w.h-2*w.m) {
//        y2=height-u-2*w.m;
//      }
//      if (moving1) {
//        if (x1>=x2-asr) {
//          x1=x2-1.5*asr;
//        }
//        if (y1>=y2-asr) {
//          y1=y2-1.5*asr;
//        }
//      } else if (moving2) {
//        if (x2<=x1+asr) {
//          x2=x1+1.5*asr;
//        }
//        if (y2<=y1+asr) {
//          y2=y1+1.5*asr;
//        }
//      }
//    }
//  }

//  //void create(int t, int m_, int c_) {
//  //  type = t;
//  //  m=m_;
//  //  c=c_;
//  //}

//  //void render() {
//  //  if (type == 0) {
//  //    x1=-c/m;
//  //    y1=0;
//  //    if (c>=0) {
//  //      x1=0;
//  //      y1=c;
//  //    } 
//  //    x2=width-u-8*w.m;
//  //    y2=m*(width-u-3*w.m);
//  //    if (y2>height-u-2*w.m) {
//  //      y2=height-u-2*w.m;
//  //      x2=(y2-c)/m;
//  //    }
//  //  } else if (type==1) {
//  //    x1=0;
//  //    y1=c;
//  //    x2=-c/m;
//  //    y2=0;
//  //  }
//  //  w.aline(x1, y1, x2, y2);
//  //}
//}
