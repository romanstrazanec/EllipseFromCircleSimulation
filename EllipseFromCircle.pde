Circle circle;
Line[] lines;
Line[] constLines;      // lines which stay in their starting position
final int nLines = 90;  // number of lines inscribing the circle
float transX, transY;   // values of display translation so the circle is in the middle
PVector p;              // point where all lines start
int step;               // step to start every line after each other


/*
 * @param :r radius of the circle where the point will be created in.
 * @return   PVector (the random point) with x, y coordinates within a circle with a radius :r.
 */
PVector randomPoint(float r) {
  return PVector.random2D().mult(random(r));
}


void setup() {
  fullScreen();
  // size(600, 600);

  // move the display to the center of the screen
  transX = width/2;
  transY = height/2;

  circle = new Circle(0, 0, height/2);  // create circle in the middle

  p = randomPoint(circle.radius);  // set random point
  lines = circle.inscribeLines(p.x, p.y, nLines);  // inscribe n lines from the point p
  constLines = circle.inscribeLines(p.x, p.y, nLines);

  step = 1;
}


void draw() {

  // create new point based on mouse position
  if (mousePressed) {
    p = new PVector(mouseX - transX, mouseY - transY);
    lines = circle.inscribeLines(p.x, p.y, nLines);
    constLines = circle.inscribeLines(p.x, p.y, nLines);
  }

  translate(transX, transY);
  background(0);

  // connectMidCWithP(circle, p);

  circle.show();

  for (int i = 0; i < nLines; i++) {
    lines[i].show();
    constLines[i].show(100);

    // alwaysRotate(lines[i], pow(1.01, i));
    // alwaysRotate(lines[i], ((i % 2) * 2 - 1) * (i*1.5) / nLines);
    // alwaysRotate(lines[i], 300.0 / (i + 1));
    // alwaysRotate(lines[i], 0.3 * ((i % 2) * 2 - 1));

    // one after each other
    if (step - i > 0) rotateUntil90WithAnimation(lines[i], 0.3);

    // if (!rotateUntil90WithAnimation(lines[i], 0.3)) {
    //   p = randomPoint(circle.radius);
    //   lines = circle.inscribeLines(p.x, p.y, nLines);
    // }
  }
  step++;
}


/*
 * Connects the middle point of the circle and the point p.
 */
void connectMidCWithP(Circle c, PVector p) {
  strokeWeight(4);
  point(p.x, p.y);
  point(c.center.x, c.center.y);
  strokeWeight(1);
  line(p.x, p.y, c.center.x, c.center.y);
}


/*
 * Rotates given :line until it reaches its 90 degree rotation around its mid-point.
 * @param :line to rotate.
 * @param :speed factor to fasten the speed of rotation.
 * @return true when the rotation was made, otherwise it's already rotated by 90 degrees.
 */
boolean rotateUntil90WithAnimation(Line line, float speed) {
  if (line.angle <= 90) {
    float rotation;
    if (line.angle <= 45) {
      rotation = map(line.angle, 0, 45, speed, 1 + speed);  // speeding up
    } else {
      rotation = map(line.angle, 45, 90, 1 + speed, speed);  // slowing down
    }
    line.rotateAtMiddleBy(rotation);
    return true;
  }
  return false;
}


/*
 * Keep rotating given :line at constant :speed.
 */
void alwaysRotate(Line line, float speed) {
  line.rotateAtMiddleBy(speed);
}
