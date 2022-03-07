import controlP5.*;
import de.looksgood.ani.*;
ControlP5 cp5;
Accordion accordion;
PShape door, blue1, blue2, l1, l2;
PImage wrhs;
float y = 340;
float t = 5;
void setup() {
  fullScreen();
  background(123,123,123);
  smooth();
  wrhs = loadImage("wrhs.jpg");
  imageMode(CENTER);
  gui();
  textSize(50);
  Ani.init(this);
}
void gui() {
  
  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("Configuracion")
                .setBackgroundColor(color(0))
                .setBackgroundHeight(300)
                .setBarHeight(50)
                .setFont(createFont("This",20))
                ;
  cp5.addSlider("Tiempo")
     .setPosition(60,20)
     .setSize(120,30)
     .setRange(3,5)
     .setValue(5)
     .setFont(createFont("This",15))
     .moveTo(g1)
     ;
     
  cp5.addSlider("Velocidad")
     .setPosition(60,60)
     .setSize(120,30)
     .setRange(1,5)
     .setValue(1)
     .setFont(createFont("This",15))
     .moveTo(g1)
     ;
  accordion = cp5.addAccordion("acc")
                 .setPosition(100,100)
                 .setWidth(400)
                 .addItem(g1)
                 ;
  accordion.open(0,1,2);
  t = cp5.getController("Tiempo").getValue();
}
void draw(){
  strokeWeight(16);
  line(0, 748, 1920, 748);
  strokeWeight(8);
  rect(710, 260, 500, 480);
  image(wrhs,960,540);
  door = createShape(GROUP);
  blue1 = createShape(RECT, 760, y, 400, 150);
  blue1.setFill(color(0,0,255));
  l1 = createShape(LINE, 760, y+150, 760, y+250);
  l2 = createShape(LINE, 1160, y+150, 1160, y+250);
  blue2 = createShape(RECT, 760, y+250, 400, 150);
  blue2.setFill(color(0,0,255));
  door.addChild(blue1);
  door.addChild(l1);
  door.addChild(l2);
  door.addChild(blue2);
  shape(door);
}
void mouseClicked(){
  for (int i=340; i>40; i=i-1){
  Ani.to(this, t, "y", i);
  
  //algo cabron
  }
}
