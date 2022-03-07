import controlP5.*;
import de.looksgood.ani.*;
ControlP5 cp5;
Accordion accordion;
PShape door, blue1, blue2, l1, l2; // variables que conforman la puerta
PImage wrhs; //imagen de fondo
float y = 340; //variable altura para la puerta
float t = 5; //tiempo

// Display
// Modo manual (botones)
// Modo automatico (configuracion acordeon)
// Sensores de limite
// Velocidades

void setup() { //setup
  fullScreen(); //pantalla completa
  background(123,123,123); //color gris de fondo
  smooth(); //smooth
  wrhs = loadImage("wrhs.jpg"); //asigna imagen
  imageMode(CENTER); //coordenadas de la imagen son en el centro
  gui(); //acordion
  textSize(50);
  Ani.init(this); //inicializar ani
}
void gui() { //acordion
  
  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("Configuracion") //configuracion acordion
                .setBackgroundColor(color(0))
                .setBackgroundHeight(300)
                .setBarHeight(50)
                .setFont(createFont("This",20))
                ;
  cp5.addSlider("Tiempo") //slider tiempo
     .setPosition(60,20)
     .setSize(120,30)
     .setRange(3,5)
     .setValue(5)
     .setFont(createFont("This",15))
     .moveTo(g1)
     ;
     
  cp5.addSlider("Velocidad") //slider velocidad
     .setPosition(60,60)
     .setSize(120,30)
     .setRange(1,5)
     .setValue(1)
     .setFont(createFont("This",15))
     .moveTo(g1)
     ;
  accordion = cp5.addAccordion("acc") //posicion acordion
                 .setPosition(100,100)
                 .setWidth(400)
                 .addItem(g1)
                 ;
  t = cp5.getController("Tiempo").getValue(); //variable tiempo
}
void draw(){ //dibujo
  strokeWeight(16); //contorno ancho
  line(0, 748, 1920, 748); //linea del piso
  strokeWeight(8); //contorno delgado
  rect(710, 260, 500, 480); //bordes de la puerta
  image(wrhs,960,540); //fondo warehouse
  door = createShape(GROUP); //grupo puerta
  blue1 = createShape(RECT, 760, y, 400, 150); //parte azul arriba
  blue1.setFill(color(0,0,255)); //color azul
  l1 = createShape(LINE, 760, y+150, 760, y+250); //linea izquierda
  l2 = createShape(LINE, 1160, y+150, 1160, y+250); //linea derecha
  blue2 = createShape(RECT, 760, y+250, 400, 150); //parte azul abajo
  blue2.setFill(color(0,0,255)); //color azul
  door.addChild(blue1); //agregar a grupo door
  door.addChild(l1);
  door.addChild(l2);
  door.addChild(blue2);
  shape(door); //dibujar door
}
void mouseClicked(){
  for (int i=340; i>40; i=i-1){
  Ani.to(this, t, "y", i);
  }
}

//reorehoi
