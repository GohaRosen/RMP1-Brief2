import processing.video.*;
import processing.sound.*;

Movie myMovie;
FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

XML xml;
color[] colours;
float alpha = 255; //random(0,255);



void setup(){
  size(1600,800);
  myMovie = new Movie(this, "Gryffin, Bipolar Sunshine - Whole Heart (Audio).mp4");
  myMovie.loop();
  
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();       // start the Audio Input
  fft.input(in);    // patch the AudioIn
  
  
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
  
    fft.analyze(spectrum);

  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  alpha =  spectrum[i]/3 ;
  } 
   
  }