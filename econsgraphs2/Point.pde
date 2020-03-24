class Point {
//  float x, y;
//  boolean shown=false;
//  boolean hidden = true;
//  Line l1, l2;
//  boolean hover = false;
//  boolean selected = false;
//  float r=u/3;
//  Line lx = new Line();
//  Line ly = new Line();
//  Line[] exs = new Line[0];
//  Point[] ps = new Point[0];
//  int section=-1;
//  int type=-1; //0 normal, 1 extension 
//  boolean shading = false;

//  void create(int type_, Line l1_, Line l2_) {
//    type = type_;
//    l1=l1_;
//    l2=l2_;

//    solve();
//    if (!(x==0&&y==0)) {
//      lx.create(2, x, y, x, 0);
//      ly.create(2, x, y, 0, y);

//      exs=(Line[])append(exs, lx);
//      exs=(Line[])append(exs, ly);
//    }
//  }
//  void render() {

//    solve();
//    checkHover();
//    if (l2.type==0&&l1.type==1) {
//      if (x>l1.x1&&x>l2.x1&&x<l1.x2&&x<l2.x2&&!hidden) {
//        shown=true;
//      } else {
//        shown=false;
//      }
//    } 
//    if (l1.type==2) {
//      if (!hidden&&(hover||selected)) {
//        shown = true;
//      } else {
//        shown = false;
//      }
//    }
//    if (l2.type==3&&l1.type==1) {

//      if (x>l1.x1&&x>l2.leftbound&&x<l1.x2&&x<l2.rightbound&&!hidden) {
//        shown=true;
//      } else {
//        shown=false;
//      }
//    }
//    if (l2.type==4&&l1.type==1) {
//      if (section==1) {
//        if (x>=l2.x1&&x<=l2.x2-l2.asr&&!hidden) {
//          shown=true;
//        } else {
//          shown=false;
//        }
//      } else if (section==2) {
//        if (y>=l2.y1+l2.asr&&y<=l2.y2&&!hidden) {
//          shown=true;
//        } else {
//          shown=false;
//        }
//      } else if (section==3) {
//        if (x>=l2.x2-l2.asr&&x<=l2.x2&&!hidden) {
//          shown=true;
//        } else {
//          shown=false;
//        }
//      }
//    }
//    if (shown) {

//      stroke(0);

//      noFill();
//      strokeWeight(3);
//      if ((hover||selected)&&((int)mode==1||(int)mode==3)) {
//        if (mode==1.1&&type==0) {
//          stroke(255, 0, 0);
//        }
//        if (mode==1.2&&type==1) {
//          stroke(255, 0, 0);
//        }
//        if (selected&&(int)mode==1) {

//          stroke(0, 204, 102);
//        }
//      }

//      if ((hover||shading)&&mode==3.1) {     
//        stroke(51, 153, 255);
//      }
//      //w.wpoint(x,y,r);
//      w.wcircle(x, y, r);
//      fill(0);
//      //w.write((int)x+", "+(int)y, x, y);
//    }
//    if (selected) {

//      renderEx();
//    }
//  }

//  void show() {
//    hidden = false;

//    boolean check = false;
//    if (type==0) {
//      for (Line d : DD) {
//        if (l2==d||l1==d) {
//        } else {
//          for (Line ex : exs) {
//            check = false;
//            for (Point p : ps) {
//              if (p.l1==ex&&p.l2==d) {
//                check=true;
//              }
//            }
//            if (!check) {
//              Point p = new Point();
//              p.create(1, ex, d);
//              p.solve();
//              ps=(Point[])append(ps, p);
//            }
//          }
//        }
//      }

//      for (Line s : SS) {
//        if (l2==s||l1==s) {
//        } else {
//          for (Line ex : exs) {
//            check = false;
//            for (Point p : ps) {
//              if (p.l1==ex&&p.l2==s) {
//                check=true;
//              }
//            }
//            if (!check) {
//              Point p = new Point();
//              p.create(1, ex, s);
//              p.solve();
//              ps=(Point[])append(ps, p);
//            }
//          }
//        }
//      }

//      for (Line s : curves) {
//        if (l2==s||l1==s) {
//        } else {
//          for (Line ex : exs) {
//            check = false;
//            for (Point p : ps) {
//              if (p.l1==ex&&p.l2==s) {
//                check=true;
//              }
//            }
//            if (!check) {
//              Point p = new Point();
//              p.create(1, ex, s);
//              p.solve();
//              ps=(Point[])append(ps, p);
//            }
//          }
//        }
//      }
//    }

//    for (Line ex : exs) {
//      for (Line x : w.axes) {
//        if (!((ex.x1==ex.x2&&x.x1==x.x2)||(ex.y1==ex.y2&&x.y1==x.y2))) {
//          check = false;
//          for (Point p : ps) {
//            if (p.l1==x&&p.l2==ex||p.l1==ex&&p.l2==x) {
//              check=true;
//            }
//          }
//          if (!check) {
//            Point p = new Point();
//            p.create(1, ex, x);
//            p.solve();
//            if (p.x!=0||p.y!=0) {
//              ps=(Point[])append(ps, p);
//            }
//          }
//        }
//      }
//    }

//    for (Point p : ps) {
//      for (Line ex : p.exs) {
//        for (Line x : w.axes) {
//          if (!((ex.x1==ex.x2&&x.x1==x.x2)||(ex.y1==ex.y2&&x.y1==x.y2))) {

//            check = false;
//            for (Point i : p.ps) {
//              if (i.l1==x&&i.l2==ex||i.l1==ex&&i.l2==x) {
//                check=true;
//              }
//            }
//            if (!check) {
//              Point o = new Point();
//              o.create(1, ex, x);
//              o.solve();
//              if (o.x!=0||o.y!=0) {
//                p.ps=(Point[])append(p.ps, o);
//              }
//            }
//          }
//        }
//      }
//    }
//    for (Line x : w.axes) {
//      check = false;
//      for (Point p : ps) {
//        if ((p.l1==x&&p.l2==l1)||(p.l1==l1&&p.l2==x)) {
//          check=true;
//        }
//      }
//      if (!check) {
//        Point p = new Point();
//        p.create(1, x, l1);
//        p.solve();
//        if (p.x!=0||p.y!=0) {
//          ps=(Point[])append(ps, p);
//        }
//      }
//      check = false;
//      for (Point p : ps) {
//        if ((p.l1==x&&p.l2==l2)||(p.l1==l2&&p.l2==x)) {
//          check=true;
//        }
//      }
//      if (!check) {
//        Point p = new Point();
//        p.create(1, x, l2);
//        p.solve();
//        if (p.x!=0||p.y!=0) {
//          ps=(Point[])append(ps, p);
//        }
//      }
//    }
//  }
//  void hide() {
//    hidden = true;
//    //selected=false;
  }






//  void solve() {
//    //l1=l1_;
//    //l2=l2_;

//    if (l1.type==1&&l2.type==0) {
//      x=(l2.y_int-l1.y_int)/(l1.m-l2.m);
//      y=l1.m*x+l1.y_int;
//    } else if (l1.type==1&&l2.type==3) {
//      x=(-l2.b+l1.m+sqrt(sq(l2.b-l1.m)-4*l2.a*(l2.c-l1.y_int)))/(2*l2.a);
//      y=l1.m*x+l1.y_int;
//    } else if (l1.type==1&&l2.type==4) {
//      x=(l2.y1-l1.y_int)/l1.m;
//      if (x<l2.x2-l2.asr) {
//        section = 1;

//        y=l1.m*x+l1.y_int;
//      } else {
//        section = 2;
//        y=l1.m*l2.x2+l1.y_int;
//        if (y>l2.y1+l2.asr) {
//          x=l2.x2;
//        } else {
//          section = 3;
//          float A = sq(l1.m)+1;
//          float B = 2*(l1.m*(l1.y_int-(l2.y1+l2.asr))-(l2.x2-l2.asr));
//          float C = sq(l2.x2-l2.asr)+sq(l1.y_int-(l2.y1+l2.asr))-sq(l2.asr);

//          x=(-B+sqrt(sq(B)-4*A*C))/(2*A);
//          y=l1.m*x+l1.y_int;
//        }
//      }
//    } else if (l1.type==2&&(l2.type==1||l2.type==0)) {
//      if (l1.x1==l1.x2) {
//        x=l1.x1;
//        y=l2.m*x+l2.y_int;
//      } else if (l1.y1==l1.y2) {
//        y=l1.y1;
//        x=(y-l2.y_int)/l2.m;
//      }
//    } else if (l1.type==2&&l2.type==3) {
//      if (l1.x1==l1.x2) {
//        x=l1.x1;
//        y=l2.a*sq(x)+l2.b*x+l2.c;
//      } else if (l1.y1==l1.y2) {
//        y=l1.y1;
//        x=(-l2.b+sqrt(sq(l2.b)-4*l2.a*(l2.c-y)))/(2*l2.a);
//      }
//    } else if (l1.type==2&&l2.type==2) {
//      if (l1.x1==l1.x2) {
//        x=l1.x1;
//        y=0;
//      } else if (l1.y1==l1.y2) {
//        y=l1.y1;
//        x=0;
//      }
//    }
//  }

//  void checkHover() {
//    if (sq(w.mx-x)+sq(w.my-y)<=sq(r)) {
//      hover = true;
//      if (mode==1.1||mode==1.2) {

//        //renderEx();
//      }
//    } else {
//      hover = false;
//    }
//  }
//  void renderEx() {
//    lx.x1=x;
//    lx.x2=x;
//    lx.y1=y;
//    ly.x1=x;
//    ly.y1=y;
//    ly.y2=y;
//    if (mode==1.2) {
//      for (Point p : ps) {
//        if (p.selected) {
//          p.render();
//        }
//      }
//    }
//    for (Line ex : exs) {
//      if (selected) {
//        ex.render();
//      }
//    }
//  }
//}
