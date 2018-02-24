// https://www.myphysicslab.com/pendulum/double-pendulum-en.html
float g = 1 ;
float f = 1 ;
float m1 = 100;
float m2 = 200;
float l1 = 200;
float l2 = 200;
float a1 = PI;
float a2 = PI/2;
float av1 = 0;
float av2 = 0;
float aa1 = 0;
float aa2 = 0;
PGraphics trace ; 
float px = 1000, py ;

void setup() {
  size(800, 800);
  frameRate(240);
  trace = createGraphics(800, 800);
  trace.beginDraw();
  trace.background(255);
  trace.endDraw();
}


void draw() {
  float w = width/2;
  float h = height/2;

  if (mousePressed) {
    av1 = av2 = aa1 = aa2 = a2 = 0;
    PVector p = new PVector(mouseX-w, mouseY-h);
    a1= PI/2-p.heading();
    trace.beginDraw();
    trace.background(255);
    trace.endDraw();
  } else {
    aa1 = (-g*(2*m1+m2)*sin(a1)-m2*g*sin(a1-2*a2)-2*sin(a1-a2)*m2*(l2*av2*av2+l1*av1*av1*cos(a1-a2)))/(l1*(2*m1+m2-m2*cos(2*a1-2*a2)));
    aa2 = (2*sin(a1-a2)*(l1*av1*av1*(m1+m2)+g*(m1+m2)*cos(a1)+l2*m2*av2*av2*cos(a1-a2)))/(l2*(2*m1+m2-m2*cos(2*a1-2*a2)));
    av1+=aa1;
    av2+=aa2;
    av1*=f;
    av2*=f;
    a1+=av1;
    a2+=av2;
  }
  float x1 = w+sin(a1)*l1/2;
  float y1 = h+cos(a1)*l1/2;
  float x2 = x1+sin(a2)*l2/2;
  float y2 = y1+cos(a2)*l2/2;
  trace.beginDraw();
  trace.stroke(#FF0000);
  trace.strokeWeight(1);
  if (px<1000) trace.line(int(px),int(py),int(x2), int(y2));
  trace.endDraw();
  px=x2;
  py=y2;
  background(255);
  image(trace, 0, 0);
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(w, h, 4, 4);
  line(w, h, x1, y1);
  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x1, y1, m1/10, m1/10);
  ellipse(x2, y2, m2/10, m2/10);
}