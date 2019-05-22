Circle circle;
Line[] lines;
final int nLines = 20;  // number of lines inscribing the circle
float transX, transY;   // values of display translation so the circle is in the middle
PVector p;              // point where all lines start

/*
 * @param :r radius of the circle where the point will be created in
 * @return   PVector (the random point) with x, y coordinates within a circle with a radius :r
 */
PVector randomPoint(float r) {
  return PVector.random2D().mult(random(r));
}


void setup() {
  // fullScreen();
  size(600, 600);

  // move the display to the center of the screen
  transX = width/2;
  transY = height/2;

  circle = new Circle(0, 0, height/2);  // create circle in the middle

  p = randomPoint(circle.radius);  // set random point
  lines = circle.inscribeLines(p.x, p.y, nLines);  // inscribe n lines from the point p
}


void draw() {

  // create new point based on mouse position
  if (mousePressed) {
    p = new PVector(mouseX - transX, mouseY - transY);
    lines = circle.inscribeLines(p.x, p.y, nLines);
  }

  translate(transX, transY);
  background(0);

  // show point
  strokeWeight(4);
  point(p.x, p.y);
  strokeWeight(1);

  circle.show();

  for (int i = 0; i < nLines; i++) {
    lines[i].show();
    if (lines[i].angle <= 90) {
      float rotation;
      if (lines[i].angle <= 45) {
        rotation = map(lines[i].angle, 0, 45, 0.3, 1.3);
      } else {
        rotation = map(lines[i].angle, 45, 90, 1.3, 0.3);
      }
      lines[i].rotateAtMiddleBy(rotation);
    } else {
      p = randomPoint(circle.radius);
      lines = circle.inscribeLines(p.x, p.y, nLines);
    }
  }
}
