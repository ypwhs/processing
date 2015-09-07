import java.awt.Toolkit;
import processing.sound.*;

void setup() {
  size(256, 256);
  background(30);
  boxwidth = width-boxmargin*2;
}

long targetTime = 0;
int target = 0;

void mousePressed() {
  if(black==50){
    targetTime = millis()+15000;
    target = 45;
    isWorking = 1;
  }else if(white==200){
    targetTime = millis()+15000;
    target = 60;
    isWorking = 1;
  }
  Toolkit tk = Toolkit.getDefaultToolkit();
  tk.beep();
}


int boxheight = 64;
int boxmargin = 32;
int boxwidth = 0; //<>//

void update(int x, int y) {
  if(x>boxmargin & x < boxwidth + boxmargin){
    if(y>boxmargin & y<boxmargin+boxheight)black=50;
    else black=0;
    if(y>boxheight+boxmargin*2 & y<boxheight*2+boxmargin*2)white=200;
    else white=255;
  }else{
    black=0;white=255;
  }
}

color black=0;
color white=255;

int isWorking = 0;

void draw(){
  update(mouseX, mouseY);
  background(30);
  
  fill(black);
  stroke(255);
  rect(boxmargin, boxmargin, boxwidth, boxheight);
  
  fill(255-black);
  textSize(24);
  text("45", boxmargin+boxwidth/2-18, boxmargin+boxheight/2+6); 
  
  fill(white);
  stroke(255);
  rect(boxmargin, boxmargin*2+boxheight, boxwidth, boxheight);
  fill(255-white);
  text("60", boxmargin+boxwidth/2-18, boxmargin*2+boxheight+boxheight/2+6);
  
  fill(225);
  if(targetTime-millis()>0){
    if(isWorking==1){
        text("Prepare:"+(int)((targetTime-millis())/1000 + 1), boxmargin, height-boxmargin-5);
        rect(boxmargin, height-30,
        (15000-targetTime+millis())*(width-2*boxmargin)/(15000), 15);
      }
    else{
      text("Speak:"+(int)((targetTime-millis())/1000 + 1), boxmargin, height-boxmargin-5);
      rect(boxmargin, height-30,
      (target*1000-targetTime+millis())*(width-2*boxmargin)/(target*1000), 15);
    }
  }else{
    text("TIME OVER", boxmargin, height-boxmargin-5);
    if(isWorking==1){
      isWorking = 2;
      SoundFile beep = new SoundFile(this, "BEEP.MP3");
      beep.play();
      targetTime = millis()+target*1000;
    }else if(isWorking==2){
      isWorking = 0;
      SoundFile beep = new SoundFile(this, "BEEP.MP3");
      beep.play();
    }
  }
}