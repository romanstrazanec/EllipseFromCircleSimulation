class Circle {
  PVector center;
  float radius;

  Circle(float x, float y, float r) {
    center = new PVector(x, y);
    radius = r;
  }

  Line[] inscribeLines(float x, float y, int n) {
    Line[] lines = new Line[n];
    for (int i = 0; i < n; i++) {
      float angle = i * TWO_PI/n;
      lines[i] = new Line(x, y, radius*cos(angle) + center.x, radius*sin(angle) + center.y);
    }
    return lines;
  }

  void show() {
    stroke(150, 150, 255);
    noFill();
    ellipse(center.x, center.y, radius*2, radius*2);
  }
}
