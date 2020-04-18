class Line {
  int type;
  int n;
  PVector[] p;
  float tres=0.005;
  float t=0;
  float r = u/4;
  float asr = 2*u;
  boolean translating = false;
  boolean focusing;
  boolean hovering = false;  
  PVector curr = new PVector();
  PVector next = new PVector();
  PVector[] transoff;
  boolean exselected=true;
  color c1 = color(0, 127, 255);
  color c2 = color(0,0,255);


  Line(int type, PVector[] p) {
    this.type=type;
    if (type==0||type==2) {
      this.n=p.length-1;
    }   
    this.p=p;
    transoff = new PVector[p.length];
    for (int i = 0; i < transoff.length; i++) {
      transoff[i]=new PVector(0, 0);
    }
  }


  void render() {
    hovering = false;
    if (type<=1) {
      if (focusing&&mode==0) {
        move();
      }
    }
    if (type==0) {////////////////////////////////////////////draw bezier///////////////////////////////////////////////
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
        strokeWeight(4);

        if (focusing&&mode==0) {
          stroke(c1);
          strokeWeight(4);
        }
        w.wline(curr.x, curr.y, next.x, next.y);
        t+=tres;
        if (abs(curr.x-w.mx)<0.5*r&&abs(curr.y-w.my)<0.5*r) {
          hovering=true;
        }
      }
      if ((focusing||hovering)&&mode==0) {

        if (n==2) {
          strokeWeight(1);
          stroke(127);
          w.wline(p[0].x, p[0].y, p[1].x, p[1].y);
          w.wline(p[2].x, p[2].y, p[1].x, p[1].y);
        } else if (n==3) {
          strokeWeight(1);
          stroke(127);
          w.wline(p[0].x, p[0].y, p[1].x, p[1].y);
          w.wline(p[2].x, p[2].y, p[3].x, p[3].y);
        }

        for (PVector x : p) {

          if (x.z==1) {
          stroke(c2);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/2);
          } else {
            stroke(0);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/4);
          }
        }

        translating = true;
        for (PVector x : p) {
          if (x.z==1) {
            translating = false;
          }
        }
      }
    }

    if (type==1) {//////////////////////////////////draw AS/////////////////////////////////



      if ((abs(w.mx-p[1].x)<0.5*r&&w.my>p[0].y+asr&&w.my<p[1].y)||
        (abs(w.my-p[0].y)<0.5*r&&w.mx>p[0].x&&w.mx<p[1].x-asr)||
        ((sq(w.mx-p[1].x+asr)+sq(w.my-p[0].y-asr))>sq(asr-0.5*r)&&(sq(w.mx-p[1].x+asr)+sq(w.my-p[0].y-asr))<sq(asr+0.5*r))&&w.mx>p[1].x-asr&&w.my<p[0].y+asr) {
        hovering = true;
      }
      stroke(0);
      strokeWeight(4);
      if (focusing&&mode==0) {
        stroke(c1);
        strokeWeight(4);
      }
      w.wline(p[0].x, p[0].y, p[1].x-asr, p[0].y);
      w.wline(p[1].x, p[1].y, p[1].x, p[0].y+asr);
      w.warc(p[1].x-asr, p[0].y+asr, asr);
      if ((focusing||hovering)&&mode==0) {

        for (PVector x : p) {

          if (x.z==1) {
            stroke(c2);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/2);
          } else {
            stroke(0);
            strokeWeight(4);
            w.wpoint(x.x, x.y, r/4);
          }
        }

        translating = true;
        for (PVector x : p) {
          if (x.z==1) {
            translating = false;
          }
        }
      }
    }
    if (type==2) {//////////////////////////////////////////////////draw extension //////////////////////////////////////////////////////
      if (mode==1) {
        if (p[0].x==p[1].x) {
          if (abs(w.mx-p[0].x)<0.5*r&&w.my<p[0].y-r&&w.my>p[1].y) {
            hovering = true;
          } else {
            hovering = false;
          }
        } else if (p[0].y==p[1].y) {
          if (abs(w.my-p[0].y)<0.5*r&&w.mx<p[0].x-r&&w.mx>p[1].x) {
            hovering = true;
          } else {
            hovering = false;
          }
        }
      }
      strokeWeight(2);
      stroke(0);
      if (hovering&&mode==1) {
        stroke(c1);
      }

      if (exselected||hovering) {
        w.wline(p[1].x, p[1].y, p[0].x, p[0].y, DOTTED);
      }
    }
  }

  void move() {

    for (PVector x : p) {
      if (abs(x.x-w.mx)<1.5*r&&abs(x.y-w.my)<1.5*r) {
        hovering = true;
        x.z=1;
        for (PVector c : p) {
          if (c!=x) {
            c.z=0;
          }
        }
      }
    } 


    if (translating&&mousePressed) {
      for (int i = 0; i < p.length; i++) {
        p[i].x=w.mx-transoff[i].x;
        p[i].y=w.my-transoff[i].y;
      }
    }
    for (PVector x : p) {
      if (mousePressed) {
        if (x.z==1) {
          x.x=w.mx;
          x.y=w.my;
        }
      } else {
        x.z=0;
      }
    }
  }
}
