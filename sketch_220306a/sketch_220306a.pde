import controlP5.*;
import de.looksgood.ani.*;
ControlP5 cp5;
Accordion accordion;
PShape door, blue1, blue2, l1, l2; // variables que conforman la puerta
PImage wrhs, buttonUp, buttonDown, emergency; //imagen de fondo
float Tiempo, Sensor_Superior, Sensor_Inferior, y = 740, Tiempo_Espera, xx, xy, altura; //declaracion variables tiempo y altura de sensores
boolean manualAutomatico;
int i=0;
AniSequence move;
// Display
// Modo manual (botones)
// Modo automatico (configuracion acordeon)
// Sensores de limite
// Velocidades

  
void setup() { //setup
  fullScreen(); //pantalla completa
  frameRate(60);
  background(123,123,123); //color gris de fondo
  smooth(); //smooth
  wrhs = loadImage("wrhs.jpg"); //asigna imagen
  imageMode(CENTER); //coordenadas de la imagen son en el centro
  //gui(); //acordion
  textSize(50);
  Ani.init(this); //inicializar ani
  Ani.setDefaultEasing(Ani.QUART_OUT);
  
  cp5 = new ControlP5(this);
  
  //imágenes de botones manuales
  buttonUp = loadImage("button.png");
  buttonDown = loadImage("buttonDown.png");
  emergency = loadImage("emergency.png");
 
 cp5.addButton("Up")
    .setPosition(1350,280)
    .setImage(buttonUp)
    .updateSize()
    ;
 cp5.addButton("Down")
    .setPosition(1350, 600)
    .setImage(buttonDown)
    .updateSize()
    ;
 cp5.addButton("Emergency")
    .setPosition(1290, 380)
    .setImage(emergency)
    .updateSize()
    ;
  cp5.addSlider("Tiempo") //slider tiempo
     .setPosition(240,220)
     .setSize(120,30)
     .setRange(3,5)
     .setValue(3)
     .setFont(createFont("this",13))
     ;
  cp5.addSlider("Sensor_Superior") //slider sensor superior
     .setPosition(190,280)
     .setSize(30,120)
     .setRange(2,4)
     .setValue(4)
     .setFont(createFont("this",13))
     ;
     
  cp5.addSlider("Sensor_Inferior") //slider sensor inferior
     .setPosition(350,280)
     .setSize(30,120)
     .setRange(0,2)
     .setValue(0)
     .setFont(createFont("this",13))
     ;
     
  cp5.addSlider("Tiempo_Espera") //slider tiempo
     .setPosition(240,480)
     .setSize(120,30)
     .setRange(1,5)
     .setValue(1)
     .setFont(createFont("this",13))
     ;
  
    cp5.addToggle("manualAutomatico")
    .setPosition(250,550)
    .setSize(90,30)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .setFont(createFont("this",13))
    ;
    
  cp5.addButton("Run")
     .setPosition(250,650)
     .setSize(90,30)
     .setFont(createFont("this",13))
     ;

}

void draw(){ //dibujo
  background(123,123,123); //color gris de fondo
  strokeWeight(16); //contorno ancho
  line(0, 748, 1920, 748); //linea del piso
  strokeWeight(8); //contorno delgado
  fill(255);
  rect(710, 260, 500, 480); //bordes de la puerta
  image(wrhs,960,540); //fondo warehouse
  door();
  sensor(740 - (Sensor_Superior*100)); //dibujo sensor superior
  sensor(740 - (Sensor_Inferior*100)); //dibujo sensor inferior
  textSize(30);
  altura = ((740-y)/100);
  fill(255);
  rect(150,160,400,40);
  rect(1290,70,270,40);
  rect(1290,170,270,40);
  fill(0);
  rect(150,200,400,500);
  text("Numero de ciclos: " + i,1300,100);
  text("Altura: " + altura + " m", 1300,200);
  text("PANEL DE CONTROL",160,190);
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

void mouseMoved(){
  xx = mouseX;
  xy = mouseY;
if(xx>710 && xx<1210 && xy>740 - (Sensor_Superior*100) && xy<740 - (Sensor_Inferior*100)){
        move = new AniSequence(this);
        move.beginSequence();
        move.add(Ani.to(this,Tiempo,"y",740 - (Sensor_Superior*100)));  
        move.add(Ani.to(this,Tiempo_Espera,"y",740 - (Sensor_Superior*100)));
        move.add(Ani.to(this,Tiempo*1.2,"y",740 - (Sensor_Inferior*100)));
        move.endSequence(); 
        move.start();}
  }


void controlEvent(ControlEvent theEvent) {
   
  if(theEvent.isFrom("Up") && manualAutomatico == true){
    Ani.to(this,Tiempo,"y",740 - (Sensor_Superior*100));
 }
  else if(theEvent.isFrom("Down") && manualAutomatico == true){
    Ani.to(this,Tiempo*1.2,"y",740 - (Sensor_Inferior*100));
  }
  else if(theEvent.isFrom("Run") && manualAutomatico == false){   
    move = new AniSequence(this);
    move.beginSequence();
    move.add(Ani.to(this,Tiempo,"y",740 - (Sensor_Superior*100)));  
    move.add(Ani.to(this,Tiempo_Espera,"y",740 - (Sensor_Superior*100)));
    move.add(Ani.to(this,Tiempo*1.2,"y",740 - (Sensor_Inferior*100)));
    move.endSequence(); 
    move.start();
    i=i+1;
 } 
  else if(theEvent.isFrom("Emergency") && (Ani.to(this,Tiempo,"y",740 - (Sensor_Superior*100)).isPlaying() || Ani.to(this,Tiempo*1.2,"y",740 - (Sensor_Inferior*100)).isPlaying() || move.isPlaying())){
    Ani.to(this,Tiempo,"y",740 - (Sensor_Superior*100)).pause();
    Ani.to(this,Tiempo*1.2,"y",740 - (Sensor_Inferior*100)).pause();
    move.pause();
  }
  }
  
