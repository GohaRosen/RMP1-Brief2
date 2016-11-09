import processing.video.*;
Movie myMovie;

//String url="http://api.openweathermap.org/data/2.5/weather?q=Clonmel&APPID=APIKEY&mode=xml";
int temperature;
float alpha = random(0,255);

void setup(){
  size(1600,800);
  myMovie = new Movie(this, "Gryffin, Bipolar Sunshine - Whole Heart (Audio).mp4");
  myMovie.loop();
  
  //XML xmlResponse = loadXML(url);
  //XML locationNode = xmlResponse.getChild("city");
  //XML temperatureNode = xmlResponse.getChild("temperature");
  //temperature = (int)(temperatureNode.getFloat("value")-273.15);
  //colorMode(HSB, 100);
}

void movieEvent (Movie myMovie){
  myMovie.read();
}

void draw(){
  image(myMovie,0,0,width,height);  // video
  rect(0, 0, 1600, 800);            // shape covering the video
  fill(temperature, alpha);           //colour dependant of temperature

}