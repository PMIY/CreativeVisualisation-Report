import processing.pdf.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
Capture video;
OpenCV opencv;  
 
int num=0;
int maxNUM=10000;
float radius =10;
float a=255;
float rr=0;
float p;
PVector rectA = new PVector(radius*((2+sqrt(3))/(sqrt(6)+sqrt(2))),radius/(sqrt(6)+sqrt(2)));
PVector rectB = new PVector(radius*sqrt(3)/2.0,radius*0.5);
PVector rectC = new PVector(radius/sqrt(2),radius/sqrt(2));

void setup(){
  beginRecord (PDF, "test.pdf");
  
  fullScreen();
  frameRate(60);
  video = new Capture(this, 1600/5, 900/5);
  opencv = new OpenCV(this, 1600/5, 900/5);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  
  smooth();
  noStroke();
  fill(0,32,99,a);
  video.start();
}

int faceX;

void draw(){
  
  background(250);
  translate(width/2-5,(height/2)-25);
  num+=10;
  if(num>maxNUM){num=0;}
  drawEnblenTree(rectA,num,a,rr);
  
  scale(2);
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  if (faces.length>0) {
    faceX=faces[0].x;
  }
  for (int i = 0; i < faces.length; i++) {
  if(faces[i].x>0 && faces[i].x<1280){
    p=faces[i].x;
    }
  }
}

void drawEnblenTree(PVector vec,int num,float a,float rr){
    translate(rectA.x,0);
    rotate(15.0*PI/180);
    drawRectIn(rectB);
  
    translate(rectB.x,0);
    rotate(15.0*PI/180);
    drawRectOut(rectA);
    
    translate(rectA.x,0);
    rotate(15.0*PI/180);
    drawRectIn(rectC);
    
    if(num>0){
    translate(rectA.y+rr,0);
    fill(0,32,99,a);
    rotate(noise(p)*PI/180);
    drawEnblenTree(rectC,num-1,a-0.025,rr+0.05);
    }
}
//------------------------------
void drawRectIn(PVector vec){
  beginShape();
  vertex(0,0);
  vertex(vec.x,0);
  vertex(vec.x,vec.y);
  vertex(0,vec.y);
  endShape(CLOSE);
}

void drawRectOut(PVector vec){
  beginShape();
  vertex(0,0);
  vertex(vec.x,0);
  vertex(vec.x,-vec.y);
  vertex(0,-vec.y);
  endShape(CLOSE);
}

void keyPressed(){
  if (key == ' ') {p=random(15);}
  if (key == ENTER) {num+=500;}
  if (key == 'c') {num=0;}
}

void captureEvent(Capture c) {
  c.read();
}
void mousePressed () {
    endRecord ();
    exit ();
}