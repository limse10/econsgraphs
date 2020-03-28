PVector[] insert(PVector[] input, PVector[] insertion, int index) {
  PVector[] output = new PVector[input.length+insertion.length];
  for (int i = 0; i <= index; i++) {
    output[i]=input[i];
  }
  for (int i = 0; i <= insertion.length-1; i++) {
    output[i+index+1]=insertion[i];
  }
  for (int i = 0; i <= input.length-index-2; i++) {
    output[i+index+insertion.length+1]=input[i+index+1];
  }

  return output;
}

int[] insert(int[] input, int[] insertion, int index) {
  int[] output = new int[input.length+insertion.length];
  for (int i = 0; i <= index; i++) {
    output[i]=input[i];
  }
  for (int i = 0; i <= insertion.length-1; i++) {
    output[i+index+1]=insertion[i];
  }
  for (int i = 0; i <= input.length-index-2; i++) {
    output[i+index+insertion.length+1]=input[i+index+1];
  }

  return output;
}


Point[] sortP(Point[] input) {

  int size = input.length;
  Point[] output = new Point[size];
  float xt = 0;
  float yt = 0;
  for (Point p : input) {
    xt+=p.x;
    yt+=p.y;
  }
  float xbar=xt/size;
  float ybar=yt/size;
  float[] angles = new float[size];
  for (int i = 0; i<size; i++) {
    angles[i] = atan2((input[i].y-ybar), (input[i].x-xbar));
  }
  float[] sortedangles = sort(angles);
  for (int i = 0; i<sortedangles.length; i++) {
    for (int j = 0; j<angles.length; j++) {
      if (sortedangles[i]==angles[j]) {
        output[i]=input[j];
      }
    }
  }


  return output;
}
PVector[] sortP(PVector[] input) {

  int size = input.length;
  PVector[] output = new PVector[size];
  float xt = 0;
  float yt = 0;
  for (PVector p : input) {
    xt+=p.x;
    yt+=p.y;
  }
  float xbar=xt/size;
  float ybar=yt/size;
  float[] angles = new float[size];
  for (int i = 0; i<size; i++) {
    angles[i] = atan2((input[i].y-ybar), (input[i].x-xbar));
  }
  float[] sortedangles = sort(angles);
  for (int i = 0; i<sortedangles.length; i++) {
    for (int j = 0; j<angles.length; j++) {
      if (sortedangles[i]==angles[j]) {
        output[i]=input[j];
      }
    }
  }


  return output;
}

void calculatePoints() {
  for (Point p : points) {
    for (int i = 0; i < p.ps.length; i++) {
      if (Float.isNaN(p.ps[i].x)) {
        p.ps=del(p.ps, i);
      }
    }
  }
  for (Line l : lines) {
    for (Line k : lines) {
      if (l!=k) {
        boolean solved=false;
        for (Point p : points) {
          if ((p.l1==l&&p.l2==k)||(p.l1==k&&p.l2==l)) {
            solved=true;
          }
        }
        if (!solved) {
          if (l.type==0&&k.type==0) {
            if (l.n==1&&k.n==1) {
              Point p = new Point(0, l, k);
              points=(Point[])append(points, p);
            } else if (l.n==1&&k.n==2) {
              Point p = new Point(0, l, k, -1);
              points=(Point[])append(points, p);
              p = new Point(0, l, k, 1);
              points=(Point[])append(points, p);
            } else if (l.n==1&&k.n==3) {
            }
          } else if (l.type==0&&k.type==1) {
            Point p = new Point(0, l, k);
            points=(Point[])append(points, p);
          }
        }
      }
    }
  } 

  for (Point x : points) {

    for (Line l : x.ls) {
      for (Line k : lines) {

        if (l!=k&&k!=x.l1&&k!=x.l2) {
          boolean solved=false;
          for (Point p : x.ps) {
            if ((p.l1==l&&p.l2==k)||(p.l1==k&&p.l2==l)) {
              solved=true;
            }
          }


          if (!solved) {
            if (Float.isNaN(x.x)) {
              Point p = new Point(-1, l, k);
              x.ps=(Point[])append(x.ps, p);
            } else 
            if (k.type==0) {
              if (k.n==1) {
                Point p = new Point(1, l, k);
                x.ps=(Point[])append(x.ps, p);
              } else if (k.n==2) {
                Point p = new Point(1, l, k, -1);
                x.ps=(Point[])append(x.ps, p);
                p = new Point(1, l, k, 1);
                x.ps=(Point[])append(x.ps, p);
              }
            }
          }
        }
      }
    }
  }
}

void deleteLine() {
  for (int i = lines.length-1; i >= 0; i--) {
    if (lines[i].focusing) {
      for (int j = points.length-1; j >=0; j--) {
        for (int k = points[j].ps.length-1; k>=0; k--) {
          if (points[j].ps[k].l1==lines[i]||points[j].ps[k].l2==lines[i]) {
            points[j].ps = del(points[j].ps, j);
          }
        }
        if (points[j].l1==lines[i]||points[j].l2==lines[i]) {
          points = del(points, j);
        }
      }
      lines = del(lines, i);
    }
  }
}

int[] del(int[] input, int index) {
  int[] output = new int[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}
Line[] del(Line[] input, int index) {
  Line[] output = new Line[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}


TextBox[] del(TextBox[] input, int index) {
  TextBox[] output = new TextBox[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}
Fill[] del(Fill[] input, int index) {
  Fill[] output = new Fill[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}

Point[] del(Point[] input, int index) {
  Point[] output = new Point[input.length-1];
  for (int i = 0; i<output.length; i++) {
    if (i<index) {
      output[i]=input[i];
    } else {
      output[i]=input[i+1];
    }
  }
  return output;
}

int choose(int n, int r) {
  int output = 1;
  for (int i = 1; i <= r; i++)
  {
    output *= n - (r - i);
    output /= i;
  }
  return output;
}
