/**
 * Mandelbrot.pde
 * Original code by Daniel Shiffman
 * Enhancements and additions by Ajen Shireman
 * 
 * Left-click:  Increase Zoom
 * Right-click: Decrease Zoom
 * 1: Decrease Iterations
 * 2: Increase Iterations
 * i: Toggle Info
 * t: Toggle Info Color
 * Space: Take Screenshot
 */

import java.util.Date;

// Controls location of zoom
double xmin = -3;
double ymin = -1.25;
// Controls zoom level
double w = 4;
double h = 2.5;
int windowWidth = 1200;
int windowHeight = 800;
double xmax = xmin + w;
double ymax = ymin + h;
double infinityBoundary = Math.pow(2.0, 10);
int maxIterations = 256;
double zoomFactor = 2.0;
int colorOffset = 0;
float redOffset = 25.5;
float greenOffset = -25.5;
float blueOffset = 0;
color cycleColor = color(redOffset, greenOffset, blueOffset);
int magnificationLevel = 1;
double colors = 1.0;
double k;
double maxZoom = 46;

boolean doShowInfo = true;
PVector textColor; 

void setup() {
  size(windowWidth, windowHeight, P2D);
  background(255);
  textColor = new PVector(0, 0, 0);
  k = colors / Math.log(maxZoom);
  loadPixels();
  mandelbrot();
}

void mandelbrot() {
  colorMode(HSB, (float)colors);
  
  xmax = xmin + w;
  ymax = ymin + h; 
  
  // Calculate amount we increment x,y for each pixel
  double dx = (xmax - xmin) / (width);
  double dy = (ymax - ymin) / (height);
  
  // Start y
  double y = ymin;
  for (int j = 0; j < height; j++) {
    // Start x
    double x = xmin;
    for (int i = 0; i < width; i++) {
      
      // Now we test, as we iterate z = z^2 + c does z tend towards infinity?
      // c = x + yi
      double zR = x;
      double zI = y;
      int n;
      double dR = 1;
      double dI = 0;
      for (n = 0; n < maxIterations; n++) {
        double zR2 = zR * zR;
        double zI2 = zI * zI;
        zI = (2.0 * zR * zI) + y;
        zR = zR2 - zI2 + x;
        double d = 2 * (zR * dR - zI * dI) + 1;
        dI = 2 * (zR * dI + dR * zI);
        dR = d;
        // See if the point has moved past infinity
        if (zR2 + zI2 > infinityBoundary) {
          break; 
        }
      }
      // Color the pixel based on how long it took to go to infinity
      // (or whether it stayed inside the set the whole time).
      escapeTime(i, j, n, zR, zI);
      //distance(i, j, n, zR, zI, dR, dI);
      //binary(i, j, n, zI);
      //edb(i, j, n, zR, zI, dR, dI);
      //ear(i, j, n, zR, zI, dR, dI);
      //muEncy(i, j, n, zR, zI, dR, dI, dx);
      //angleRad(i, j, n, zR, zI, dR, dI, dx);
      
      //rainbow(i, j, n);
      //rgbColors(i, j, x, y, zR, zI, n); // use in HSB Mode
      //colorPixel(i, j, n);
      //hsb(i, j, n, ( zR * zR + zI * zI));
      //hsvColors(i, j, x, y, zR, zI, n);
      //hsv(i, j, n, zR, zI, dZr, dZi);
      //greyscale(i, j, n);
      //bw(i, j, n);
      //rgb(i, j, n);
      //rainbow2(i, j, n);
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}

double continuousDewll( int n, double zR, double zI ) {
  double mu = n + 1 - Math.log( Math.log( Math.sqrt(zR * zR + zI * zI) ) ) / Math.log(2);
  return mu;
}

double distanceEstimate ( double zR, double zI, double dR, double dI ) {
  double zR2 = zR * zR;
  double zI2 = zI * zI;
  double dR2 = dR * dR;
  double dI2 = dI * dI;
  
  double modZ = Math.sqrt(zR2 + zI2);
  double modD = Math.sqrt(dR2 + dI2);
  
  double dem = modZ * Math.log(modZ) / modD;
  return dem;
}

/* color pixels according to how many iterations it took to escape the set */
void escapeTime ( int x, int y, int n, double zR, double zI ) {
  if ( n == maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  double hue, sat, bright;
  // normalize n to get rid of banding
  double mu = continuousDewll(n, zR, zI);
  hue = mu * colors / maxIterations;
  sat = colors;
  bright = (colors + hue) % colors;
  bright = colors - hue;
  pixels[x+y*width] = color((float)hue, (float)sat, (float)bright);
}

/* color pixels according to the distance from the edge */
void distance ( int x, int y, int n, double zR, double zI, double dR, double dI ) {
  if ( n == maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  double hue, sat, bright;
  // normalize n to get rid of banding
  double mu = continuousDewll(n, zR, zI);
  
  // compute the distance
  double dem = distanceEstimate(zR, zI, dR, dI);
  double colorIndex = 0 - k * Math.log(dem);
  hue = colorIndex % colors;
  sat = colors;
  bright = colors - mu * colors / maxIterations;
  pixels[x+y*width] = color((float)hue, (float)sat, (float)bright);
}

/* Use binary decomposition to color the pixels */
void binary ( int x, int y, int n, double zI ) {
  if ( n == maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  if ( zI > 0 ) {
    pixels[x+y*width] = color(0, 0, 0);
  }
  else {
    pixels[x+y*width] = color(0, 0, (float)colors);
  }
}

/* Combine all three */
void edb ( int x, int y, int n, double zR, double zI, double dR, double dI ) {
  if ( n == maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  double hue, sat, bright;
  // normalize n to get rid of banding
  double mu = continuousDewll(n, zR, zI);
  
  // compute the distance
  double dem = distanceEstimate(zR, zI, dR, dI);
  double colorIndex = 0 - k * Math.log(dem);
  
  hue = colors - mu * colors / maxIterations;
  if ( zI > 0 ) sat = 0;
  else sat = colors;
  bright = (colorIndex + 0 ) % colors;
  if ( zI % 2 >= 1 ) {
    hue *= 0.85;
    bright *=0.667;
  }
  pixels[x+y*width] = color((float)hue, (float)sat, (float)bright);
}

/* use escape time, angle and radius */
void ear ( int x, int y, int n, double zR, double zI, double dR, double dI ) {
  if ( n == maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  double hue, sat, bright;
  // normalize n to get rid of banding
  double mu = continuousDewll(n, zR, zI);
  double angle = Math.atan(zR / zI);
  double radius = Math.sqrt(zR * zR);
  
  hue = mu * colors / maxIterations;
  sat = angle * colors / (PI/2);
  bright = mu - (int)mu;
  
  pixels[x+y*width] = color((float)hue, (float)sat, (float)bright);
}

void angleRad ( int x, int y, int n, double zR, double zI, double dR, double dI, double pxScale ) {
  double hue, sat, value;
  
  double mu = continuousDewll(n, zR, zI);
  double dwell = (int)mu;
  double finalrad = mu - (int)mu;
  // computeangle of the final coordinate
  double finalang = Math.atan(zR / zI);
  
  double dem = distanceEstimate(zR, zI, dR, dI);
  double dScale = Math.log(dem / pxScale) / Math.log(2);
  
  if ( n >= maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  
  //dwell = Math.log(dwell)/Math.log(100000);
  
  double colorIndex = 0 - k * Math.log(dem);
  hue = colorIndex % colors;
  sat = colors;
  value = colors - hue;
  
  pixels[x+y*width] = color((float)hue, (float)sat, (float)value);
}

/* Adapted from code by Robert Munafo 
 * http://www.mrob.com/pub/muency/color.html
 */
void muEncy ( int x, int y, int n, double zR, double zI, double dR, double dI, double pxScale ) {
  double hue, sat, value;
  
  double mu = continuousDewll(n, zR, zI);
  double dwell = (int)mu;
  double finalrad = mu - (int)mu;
  // computeangle of the final coordinate
  double finalang = Math.atan(zR / zI);
  
  double dem = distanceEstimate(zR, zI, dR, dI);
  double dScale = Math.log(dem / pxScale) / Math.log(2);
  
  if ( n >= maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
    return;
  }
  
  if ( dScale > 0 ) {
    value = 1.0;
  }
  else if ( dScale > -8 ) {
    value = (8 + dScale) / 8;
  }
  else {
    value = 0;
  }
  
  double p = Math.log(dwell) / Math.log(100000);
  
  double angle, radius;
  if ( p > 0.5 ) {
    p = 1.0 - 1.5 * p;
    angle = 1 - p;
    radius = Math.sqrt(p);
  }
  else {
    p = 1.5 * p - 0.5;
    angle = p;
    radius = Math.sqrt(p);
  }
  
  if ( dwell % 2 > 0 ) {
    value -= 0.85;
    radius -= 0.667;
  }
  
  if ( finalang > PI ) {
    angle += 0.05;
  }
  
  angle += 0.0001 * finalrad;
  
  hue = angle * 10.0;
  hue -= (int)hue;
  sat = radius - (int)radius;
  
  pixels[x+y*width] = color((float)hue, (float)sat, (float)value);
}

/** Old coloring nethods **
void hsv ( int x, int y, int n, double zR, double zI, double dZr, double dZi ) {
  double hue, sat, bright;
  
  hue = n * colors / maxIterations;
  sat = colors;
  bright = colors;  
  if ( n == maxIterations ) hue = sat = bright = 0;
  pixels[x+y*width] = color(hue, sat, bright);
}

void hsvColors(int i, int j, double x, double y, double zR, double zI, int n ) {
  if ( n == maxIterations ) pixels[i+j*width] = color(0, 0, 0);
  else {
    double r = (x * x + 2 * x * y + y * y + zR * zR + 2 * zR * zI + zI * zI) / 2;
    r = (zR * zR + zI * zI + x * x + y * y) / 2;
    double hue = n * colors / maxIterations;
    double sat = colors;
    double bright = r * colors / infinityBoundary;
    pixels[i+j*width] = color(hue, sat, bright);
  }
}

void hsb( int x, int y, int n, double v ) {
  int h = (int)(n * colors / maxIterations);
  int s = colors;
  int b = (int)(v * colors / infinityBoundary);
  
  if ( n % 2 != 0 ) {
    b *= 0.85;
    //s *= 0.667;
    h *= 1.15;
  }
  pixels[x+y*width] = color(h, s, b);
  if ( n == maxIterations ) pixels[x+y*width] = color(0, 0, 0);
}

void greyscale ( int x, int y, int n ) {
  int pColor;
  pColor = colors - (int)(n * colors / maxIterations);
  pixels[x+y*width] = color(0, 0, pColor);
}

void bw ( int x, int y, int n ) {
  if ( n >= maxIterations ) pixels[x+y*width] = color(0, 0, 0);
  else pixels[x+y*width] = color(0, 0, colors);
}

void rainbow2 ( int x, int y, int n ) {
  if ( n >= maxIterations ) {
    pixels[x+y*width] = color(0, 0, 0);
  }
  else {
    int red = 0, green = 0, blue = 0;
    if ( n > maxIterations / 2 ) {
      red = 255;
      green = blue = (int)(n * 255 / maxIterations);
    }
    else {
      red = (int)(n * 255 / maxIterations);
      green = blue = 0;
    }
    pixels[x+y*width] = color(red, green, blue);
  }
}

/* Original coloring methods **
void rgb ( int x, int y, int n ) {
  if (n == maxIterations) {
    pixels[x+y*width] = color(0);
  }
  else {
    n = n * 16 % 255;
    int red = 0, blue = 0, green = 0;
    n = (int)(n * 255 / maxIterations);
    if (n > 140) {
      red = n;
      green = n / 2;
      blue = n / 4;
    }
    else if (n > 80) {
      blue = n;
      red = n / 2;
      green = n / 4;
    }
    else if (n > 40) {
      red = n / 2;
      green = n / 2;
      blue = n / 4;
    }
    else {
      green = n;
      blue = n / 2;
      red = n / 4;
    }
    pixels[x+y*width] = color(red, green, blue);
  }
}

void rgbColors(int i, int j, double startX, double startY, double endX, double endY, int n) {
  double angle = PVector.angleBetween(new PVector(startX, startY), new PVector(endX, endY)) / 2;
  //double distance = PVector.distanceBetween(new PVector(startX, startY), new PVector(endX, endY)) / 2;
  double degrees = degrees(angle) / 90.0 % 1.0;
  pixels[i+j*width] = color(degrees % 1.0, n/100.0 % 1.0, angle % 1.0);
}

void rainbow(int i, int j, int n) {
  int scalesDelta = 30;
  int pctColor;
  int red = 0, green = 0, blue = 0;
  if (n <= 10) {
    pctColor = (int)(n / 20.0 * 255);
    red = 255 - pctColor;
    green = 255;
    blue = 0; red = 0; green = 0;
  }
  else if (n <= 20) {
    pctColor = (int)((n - 10) / 10.0 * 255);
    red = 255; red = 255 - pctColor;
    green = pctColor; green = 0;
    blue = 0;
  }
  else if (n <= 30) {
    pctColor = (int)(((n - 20) / 10.0 * 255));
    if (pctColor > 255) pctColor = 255;
    red = 0;
    green = 255 - pctColor;
    blue = pctColor;
    red = pctColor; green = 0; blue = 0;
  }
  else {
    pctColor = (int)((n - 30) * 2);
    if (pctColor > 255)
      pctColor = 255;
    red = 0;
    green = pctColor;
    blue = 255;
    red = green = blue = pctColor;
  }
  if (n == maxIterations) {
    red = green = blue = 0;
  }
    pixels[i+j*width] = color(red, green, blue);
}

void colorPixel(int i, int j, int n) {
  // We color each pixel based on how long it takes to get to infinity
  // If we never got there, let's pick the color black
  if (n == maxIterations) {
    pixels[i+j*width] = color(0);
  }
  else {
    n = n * 16 % 255;
    int red = 0, blue = 0, green = 0;
    if (n > 140) {
      red = n;
      green = n / 2;
      blue = n / 4;
    }
    else if (n > 80) {
      blue = n;
      red = n / 2;
      green = n / 4;
    }
    else if (n > 40) {
      red = n / 2;
      green = n / 2;
      blue = n / 4;
    }
    else {
      green = n;
      blue = n / 2;
      red = n / 4;
    }
    pixels[i+j*width] = color(red, green, blue);
  }
}
/**/

/* Show location, iterations, zoom level, and mouse location */
void showInfo () {
  double dx = (xmax - xmin) / (width);
  double dy = (ymax - ymin) / (height);
  double yposM = ymax - mouseY * dy;
  double xposM = xmin + mouseX * dx;
  double ypos = (ymax + ymin) / 2;
  double xpos = (xmax + xmin) / 2;
  String pos = "Location: " + xpos + ", " + ypos + 
               "\nIterations: " + maxIterations + 
               "\nMagnification Level: " + magnificationLevel + 
               "\nMouse: " + xposM + ", " + yposM;
  updatePixels();
  //fill(textColor.x, textColor.y, textColor.z);
  fill(textColor.x, textColor.y, textColor.z);
  text(pos, 15, 15);
}

void draw() {
  if ( doShowInfo ) showInfo();
  if (mousePressed && mouseButton == LEFT) {
    // Position clicked spot at center of new drawing
    xmin = xmin + (mouseX / (double)windowWidth * w) - (w / 2);
    ymin = ymin + (mouseY / (double)windowHeight * h) - (h / 2);
    // Zoom in
    w /= zoomFactor;
    h /= zoomFactor;
    xmin = xmin + w / zoomFactor;
    ymin = ymin + h / zoomFactor;
    magnificationLevel++;
    println(magnificationLevel);
    mandelbrot();
  }
  if (mousePressed && mouseButton == RIGHT) {
    // Position clicked spot at center of new drawing
    xmin = xmin + (mouseX / (double)windowWidth * w) - (w / 2);
    ymin = ymin + (mouseY / (double)windowHeight * h) - (h / 2);
    // Zoom in
    w *= zoomFactor;
    h *= zoomFactor;
    xmin = xmin - w / (zoomFactor * 2);
    ymin = ymin - h / (zoomFactor * 2);
    magnificationLevel--;
    println(magnificationLevel);
    mandelbrot();
  }
  if (keyPressed && ((keyCode == UP || keyCode == DOWN))) {
    for (int j = 0; j < height; j++) {
      for (int i = 0; i < width; i++) {
        color pixelColor = get(i, j);
        if (keyCode == DOWN) {
          cycleColor = -cycleColor;
          colorOffset--;
        }
        else
          colorOffset++;
        pixels[i+j*width] = pixelColor + cycleColor;
      }
    }
    updatePixels();
  }

}

String mydate(int offset) {
  Date d = new Date();
  long timestamp = d.getTime() + (86400000 * offset);
  String date = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(timestamp);
  return date;
}

void keyPressed() {
  // take a screenshot
  if (key == ' ') {
    save(mydate(0) + "-" + ((xmin + xmax) / 2) + "," + ((ymin + ymax) / 2) + "-" + magnificationLevel + "-" + maxIterations + ".png");
    println("Screenshot Saved");
  }
  // Decrease Iterations
  else if ( key == '1' ) {
    maxIterations /= 2;
    mandelbrot();
  }
  // iIncrease Iterations
  else if ( key == '2' ) {
    maxIterations *= 2;
    mandelbrot();
  }
  // Toggle Information
  else if ( key == 'i' || key =='I' ) {
    doShowInfo = !doShowInfo;
    background(0);
    updatePixels();
  }
  else if ( key == 't' || key == 'T' ) {
    if ( textColor.z >= colors / 2 ) {
      textColor.z = 0;
    }
    else {
      textColor.z = (float)colors;
    }
  }
}


