class Fill {

  Point[] ps = new Point[0];
  PVector[] psv;
  java.awt.Polygon poly;
  boolean hovering= false;
  boolean focusing = false;

  Fill(Point[] ps) {
    this.ps=ps;
    psv = new PVector[ps.length];
  }

  void render() {
    this.ps=ps;
    psv = new PVector[ps.length];
    poly = new java.awt.Polygon();

    for (int i = 0; i<ps.length; i++) {
      psv[i] = new PVector(ps[i].x, ps[i].y);
    }
    identifyCurves();
    psv=sortP(psv);


    for (PVector p : psv) {
      poly.addPoint((int)p.x, (int)p.y);
    }
    checkHover();

    if (hovering||focusing) {
      fill(0, 255, 111);
    } else {
      fill(133, 255, 144);
    }
    noStroke();
    beginShape();
    for (PVector p : psv) {
      w.wvertex(p.x, p.y);
      println(p.x, p.y);
    }
    endShape();
    println("__________________________________________________");
  }

  void checkHover() {
    if (poly.contains((int)w.mx, (int)w.my)&&((int)mode==3&&mode!=3.1)) {
      hovering=true;
    } else {
      hovering = false;
    }
  }

  void identifyCurves() {
    Line l;
    PVector[] curve;
    int index=0;
    PVector p1 = new PVector();
    PVector p2 = new PVector();
    for (int i = 0; i<ps.length; i++) {
      if (ps[i].l1.n==2||ps[i].l2.n==2) {
        if (ps[i].l1==ps[(i+1)%(ps.length-1)].l1) {
          l = ps[i].l1;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l1==ps[(i+1)%(ps.length-1)].l2) {
          l = ps[i].l1;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l2==ps[(i+1)%(ps.length-1)].l1) {
          l = ps[i].l2;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        } else if (ps[i].l2==ps[(i+1)%(ps.length-1)].l2) {
          l = ps[i].l2;
          p1.x=ps[i].x;
          p1.y=ps[i].y;
          p2.x=ps[(i+1)%(ps.length-1)].x;
          p2.y=ps[(i+1)%(ps.length-1)].y;
          curve = generateCurve(l, p1.x, p1.y, p2.x, p2.y);
          index=i;
          this.psv=insert(psv, curve, index);
        }
      }
    }
  }

  PVector[] generateCurve(Line l, float x1, float y1, float x2, float y2) {
    PVector[] ps = new PVector[0];
    float t=0;
    while (t<=1) {
      float x=0;
      float y=0;

      for (int i = 0; i <= l.n; i++) {
        x+=choose(l.n, i)*pow(1-t, l.n-i)*pow(t, i)*l.p[i].x;
        y+=choose(l.n, i)*pow(1-t, l.n-i)*pow(t, i)*l.p[i].y;
      }
      PVector p = new PVector(x, y);
      if (x>min(x1, x2)&&x<max(x1, x2)&&y>min(y1, y2)&&y<max(y1, y2)) {
        ps=(PVector[])append(ps, p);
      }
      t+=0.005;
    }
    return ps;
  }
}
