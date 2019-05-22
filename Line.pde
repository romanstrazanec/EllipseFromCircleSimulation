class Line {
  PVector start, end;
  float angle;

  Line(float x1, float y1, float x2, float y2) {
    start = new PVector(x1, y1);
    end = new PVector(x2, y2);
    angle = 0;
  }

  PVector middle() {
    return new PVector((start.x + end.x)/2, (start.y + end.y)/2);
  }

  float len() {
    final float x = start.x - end.x;
    final float y = start.y - end.y;
    return sqrt(x*x + y*y);
  }

  void rotateAtMiddleBy(float a) {
    final PVector m = middle();
    final float r = len()/2;
    
    angle += a;
    a = radians(a);
    
    while (angle >= 360) angle -= 360;
    while (angle <= -360) angle += 360;

    float s = sin(a), c = cos(a), x, y;
    x = start.x - m.x;
    y = start.y - m.y;
    
    start.x = (x*c - y*s) + m.x;
    start.y = (x*s + y*c) + m.y;
    
    x = end.x - m.x;
    y = end.y - m.y;
    
    end.x = (x*c - y*s) + m.x;
    end.y = (x*s + y*c) + m.y;
  }

  void show() {
    stroke(255);
    line(start.x, start.y, end.x, end.y);
  }
}
