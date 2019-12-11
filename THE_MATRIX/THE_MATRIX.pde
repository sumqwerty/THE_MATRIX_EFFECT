import processing.video.*;

Capture video;
PFont fontToUse;
int minStrLen;
int maxStrLen;
int charSize = 10;
color strColor = color(64, 192, 64);
color leadColor = color(160, 255, 160);
int maxSpeed = 7;
int minSpeed = 3;
char charset[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '/', '*', ':', '=', '$'};


Matrix Strings[];

void setup()
{
  for (int c = 0; c < 88; c+=2)
  {
    charset = (char[])append(charset, char(12450 + c)); // katakana char

  }
  
  
  size(640,480);
  video = new Capture(this, 640,480);
  minStrLen = (height / charSize) / 2;
  maxStrLen = (height / charSize) * 7 / 8;
  Strings = new Matrix[width / charSize];
  for (int s = 0; s < Strings.length; s++)
    Strings[s] = new Matrix(s * charSize);
  fontToUse = createFont("MS Gothic.ttf", charSize, true, charset);
  textFont(fontToUse);
  video.start();
  println(displayWidth,displayHeight);
}

void captureEvent(Capture video)
{
  video.read();
}


void draw()
{
  float detail = 5; //setting the extent of details
  fill(0, 25);
  loadPixels();
  video.loadPixels();
  for(int x=0; x < width-1; ++x)
  {
    for(int y=0; y < height; ++y)
    {
      int loc1 = x     + y * width;
      int loc2 = (x+1) + y * width;
      
      float b1 = brightness(video.pixels[loc1]);
      float b2 = brightness(video.pixels[loc2]);
      
      float diff = abs(b1-b2);
      
      
      if(diff > detail)
      {
        pixels[loc1] = color(strColor);
      }
      
      else pixels[loc1] = color(0);
      
      
    }
  }
  updatePixels();

  
  for (int s = 0; s < Strings.length; s++)
  {
    Strings[s].move();
    Strings[s].display();
  }
   
}
