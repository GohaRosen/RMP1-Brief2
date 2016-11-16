import processing.video.*;
import processing.sound.*;
import ddf.minim.*;

//declaring instances of different classes
Movie myMovie;
Minim minim;
AudioInput in;
AudioPlayer player;


//declaring variables
XML xml;  
color[] colours;  //array of colours
float alpha = 255; //setting alpha to 255 to start with
int randomPick;  


void setup(){
  size(1600,800);
  
  // loading the video  
  myMovie = new Movie(this, "Gryffin, Bipolar Sunshine - Whole Heart (Video).mp4");
  //making it loop so it plays indefinite
  myMovie.loop();
  
  minim = new Minim(this);
  player = minim.loadFile("Gryffin, Bipolar Sunshine - Whole Heart (Audio)_1.mp3");
  player.loop();
  
  //loading xml file 
  xml  = loadXML("colorFile.xml");
  //accessing xml elements
  XML[] children = xml.getChildren("color");
  //populating the array with data from xml file
  colours = new color[children.length];
  
  //looping through the children array, getting r g b values and assigning them to colour array 
  //to get a value for one colour example: colours0 = 76, 153, 0
   for (int i = 0; i < children.length; i++) { 
        int r = children[i].getInt("r");
        int g = children[i].getInt("g");
        int b = children[i].getInt("b");
        colours[i] = color(r, g, b);
     }
  
  //picking random color from the colours array
  randomPick = (int)random(colours.length); 

  
  //setting colour of the layer covering the video by taking random value from randomPick variable
  fill(red(colours[randomPick]), green(colours[randomPick]), blue(colours[randomPick]), alpha);         
  
  // accessing the audio input, creating variable and setting it to stereo and buffer size to 512
  minim = new Minim(this);                    
  in = minim.getLineIn(Minim.STEREO, 512);   
}

void movieEvent (Movie myMovie){
  myMovie.read();  //starting the movie
}

void draw(){
  image(myMovie,0,0,width,height);  // video
  rect(0, 0, 1600, 800);            // shape covering the video

  //levels go from 0-1 so I had to multiply it to see result in changing alpha
  //in college levels had to be 2000, on my computer 400 is enough
  alpha = in.left.level() * 400; 

   if( alpha <= 30){
    player.mute();
  } 
  else if(alpha > 30) {
    player.unmute();
  }
  
 //setting colour of the layer covering the video by taking random value from randomPick variable and setting alpha
 //so when levels are low the layer opacity is high and when levels are high the opacity goes down
  fill(red(colours[randomPick]), green(colours[randomPick]), blue(colours[randomPick]), 256-alpha);

 
 }