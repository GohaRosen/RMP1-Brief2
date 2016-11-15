import processing.video.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Movie myMovie;
Minim minim;
AudioInput input;
FFT fft;

XML xml;
color[] colours;
float alpha = 255; //random(0,255);



void setup(){
  size(1600,800);
  myMovie = new Movie(this, "Gryffin, Bipolar Sunshine - Whole Heart (Audio).mp4");
  myMovie.loop();
  
  minim = new Minim(this);
  input = minim.getLineIn();
  
  xml  = loadXML("colorFile.xml");
  XML[] children = xml.getChildren("color");
  colours = new color[children.length];
  
   for (int i = 0; i < children.length; i++) { 
    int id = children[i].getInt("id");
        int r = children[i].getInt("r");
        int g = children[i].getInt("g");
        int b = children[i].getInt("b");
        colours[i] = color(r, g, b);
     }
  
  int randomPick = (int)random(colours.length);
  fill(red(colours[randomPick]), green(colours[randomPick]), blue(colours[randomPick]), alpha);         
  noLoop();
}

void movieEvent (Movie myMovie){
  myMovie.read();
}

void draw(){
  image(myMovie,0,0,width,height);  // video
  rect(0, 0, 1600, 800);            // shape covering the video
  
   fft = new FFT(input.bufferSize(), input.sampleRate());
   println(input.bufferSize());
   println(input.sampleRate());
   

}

void drawFFT() {
  background(0);
  stroke(255);
  float fAmp = 0.0;
  float fFreq = 0.0;
  int fBand = 0;
  
  fft = new FFT(input.bufferSize(), input.sampleRate());
 

  fft.forward( input.mix );
  
  for(int i = 0; i < fft.specSize(); i++) {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
    
    if (fAmp < fft.getBand(i)) {
      fAmp = fft.getBand(i);
      fBand = i;
    }
  }
}