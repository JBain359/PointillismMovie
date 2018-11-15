import processing.video.*;
Movie myMovie; //This is the actual movie that will be worked with

PImage mS; //The movie will be stored as a new image each frame, the PImage class is just easier to work with in terms of resizing and such

//Pointillism parameters
int speed =1000;
int point = 10;
int opacity = 250;

void setup(){
  size(480,640,P2D);
  
  //Initiaize the movie- Insert the file into the data folder and use its name as a parameter to use it
  myMovie = new Movie(this,"RotoscopingProject.mp4");
  myMovie.loop();
  
}

void movieEvent(Movie movie){
  //Fetching the frame of the movie and storing as an image so it can be resized, then resizing it to the window
  
  movie.read();
  mS = movie.get();
  mS.resize(width,height);
}

void draw(){
  //print(myMovie.frameRate + " "); 
  if(mS != null){ //cant work with an image that isnt there, in the begining it might not be
      pointillize(mS,speed,point,opacity);
  }
}

void pointillize(PImage image,int fillSpeed, int pointSize, int fadeIn ){
      
    image.loadPixels();
    for(int i=0;i<fillSpeed;i++){
      //getting a random pixel location
      int x = int(random(image.width));
      int y = int(random(image.height));
      int loc = x + y*image.width;
      
      //getting the color from that random pixel
      float r = red(image.pixels[loc]);
      float g = green(image.pixels[loc]);
      float b = blue(image.pixels[loc]);
      
      //drawing with the random pixel's location and color
      noStroke();
      fill(r,g,b, fadeIn);
      ellipse(x,y,pointSize, pointSize);
    }
}



void mouseClicked(){
  saveFrame("/output/capture####.jpg");
}
