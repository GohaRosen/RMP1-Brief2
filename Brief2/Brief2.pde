import processing.video.*;
Movie myMovie;

void setup(){
  size(1600,800);
  myMovie = new Movie(this, "Gryffin, Bipolar Sunshine - Whole Heart (Audio).mp4");
  myMovie.loop();
}

void movieEvent (Movie myMovie){
  myMovie.read();
}

void draw(){
  image(myMovie,0,0,width,height);

}