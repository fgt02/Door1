import controlP5.*;
import de.looksgood.ani.*;
ControlP5 cp5;
Accordion accordion;
PShape door, blue1, blue2, l1, l2; // variables que conforman la puerta
PImage wrhs; //imagen de fondo
float Tiempo, Sensor_Superior, Sensor_Inferior, y = 740, SS1, SS2,Tiempo_Espera; //declaracion variables tiempo y altura de sensores
boolean manualAutomático;

// Display
// Modo manual (botones)
// Modo automatico (configuracion acordeon)
// Sensores de limite
// Velocidades

void setup() { //setup
  fullScreen(); //pantalla completa
  frameRate(60);
  smooth(); //smooth
  wrhs = loadImage("wrhs.jpg"); //asigna imagen
  imageMode(CENTER); //coordenadas de la imagen son en el centro
  gui(); //acordion
  textSize(50);
  Ani.init(this); //inicializar ani
  Ani.setDefaultEasing(Ani.QUART_OUT);

}
void gui() { //acordion
  
  cp5 = new ControlP5(this);
  
  Group g1 = cp5.addGroup("Configuracion") //configuracion acordion
                .setBackgroundColor(color(0))
                .setBackgroundHeight(400)
                .setBarHeight(50)
                .setFont(createFont("This",20))
                ;
  cp5.addSlider("Tiempo") //slider tiempo
     .setPosition(90,20)
     .setSize(120,30)
     .setRange(3,5)
     .setValue(5)
     .setFont(createFont("This",13))
     .moveTo(g1)
     ;

  cp5.addSlider("Sensor_Superior") //slider sensor superior
     .setPosition(40,80)
     .setSize(30,120)
     .setRange(2,4)
     .setValue(4)
     .setFont(createFont("This",13))
     .moveTo(g1)
     ;
     
  cp5.addSlider("Sensor_Inferior") //slider sensor inferior
     .setPosition(180,80)
     .setSize(30,120)
     .setRange(0,2)
     .setValue(0)
     .setFont(createFont("This",13))
     .moveTo(g1)
     ;
     
  cp5.addSlider("Tiempo_Espera") //slider tiempo
     .setPosition(90,240)
     .setSize(120,30)
     .setRange(1,5)
     .setValue(5)
     .setFont(createFont("This",13))
     .moveTo(g1)
     ;
  
  cp5.addToggle("manualAutomático")
     .setPosition(100,300)
     .setSize(90,30)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setFont(createFont("This",13))
     .moveTo(g1)
     ;
     
  accordion = cp5.addAccordion("acc") //posicion acordion
                 .setPosition(100,100)
                 .setWidth(400)
                 .addItem(g1)
                 ;
accordion.open(0,1,2);
}


void draw(){ //dibujo
  background(123,123,123); //color gris de fondo
  strokeWeight(16); //contorno ancho
  line(0, 748, 1920, 748); //linea del piso
  strokeWeight(8); //contorno delgado
  fill(255);
  rect(710, 260, 500, 480); //bordes de la puerta
  image(wrhs,960,540); //fondo warehouse
  SS1 = 740 - (Sensor_Superior*100);
  SS2 = 740 - (Sensor_Inferior*100);
  sensor(SS1); //dibujo sensor superior
  sensor(SS2); //dibujo sensor inferior
  door(); //dibujo puerta
}

void sensor(float y){ //funcion sensores
  fill(0,255,0);
  strokeWeight(2);
  circle(730, y, 25);
}

void door(){ //funcion puerta
  strokeWeight(8);
  door = createShape(GROUP); //grupo puerta
  blue1 = createShape(RECT, 760, y-400, 400, 150); //parte azul arriba
  blue1.setFill(color(0,0,255)); //color azul
  l1 = createShape(LINE, 760, y-250 , 760, y-150); //linea izquierda
  l2 = createShape(LINE, 1160, y-250, 1160, y-150); //linea derecha
  blue2 = createShape(RECT, 760, y-150, 400, 150); //parte azul abajo
  blue2.setFill(color(0,0,255)); //color azul
  door.addChild(blue1); //agregar a grupo door
  door.addChild(l1);
  door.addChild(l2);
  door.addChild(blue2);
  shape(door); //dibujar door
}

void open(){
Ani.to (this, Tiempo, "y", SS1);
}
void close(){
Ani.to (this, Tiempo, "y", SS2);
}



void mouseClicked (){
  open();
}
