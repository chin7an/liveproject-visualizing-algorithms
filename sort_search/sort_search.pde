// data-size is hard-coded in this version
int[] data = new int[200];
int heightMargin = 30;    // pixels
int widthMargin = 20;    // pixels

int barLo;
int barHi;
int barWd;

int histOffset;

void setup() {
  size(1280, 720);

  // setup the histogram bar parameters
  //   - heights (lo & hi) - divide the height into half, and account for the margins
  barHi = (height / 2) - (heightMargin / 2);
  barLo = -1 * barHi;
  //   - width - nearest multiple of data.length, that does not exceed width, after accounting for the margins
  barWd = (width - widthMargin) / data.length;
  
  // histogram offset, horizontal offset added when calculating each bar's X co-ordinate
  //   - halve the difference of width and the multiple of data-size and bar width
  histOffset = (width - (data.length * barWd)) / 2;

  for (int idx = 0; idx < data.length; idx++) {
    data[idx] = int(random(barLo, barHi));
  }
}

void draw() {
  // white background
  background(255); 
  
  // horizontal axis
  stroke(160);
  line((widthMargin / 2), (height / 2), (width - (widthMargin / 2)), (height / 2));
  
  // draw bars with darker gray outlines
  stroke(100);
  // frameCount taken from the project's solution, this animates the sketch of the histogram
  for (int idx = 0; idx < min(frameCount, data.length); idx++) {
    int b = data[idx];
    
    // origin (0, 0) in processing is the upper-right corner of the sketch
    // default rectMode is CORNER - the first two arguments are the x,y co-ordinates of the upper-right corner
    //
    // x co-ordinate = offset + (bar_width * current_index)
    // y co-ordinate = has to handle negative & positive numbers
    //     - positive -> 'number' pixels above axis = (axis - bar)
    //     - negative -> drawn on the axis = same coordinate as the axis
    int bX = histOffset + (barWd * idx);
    int bY = (b > 0) ? ((height / 2) - b - 1) : ((height / 2) + 1);  // the 1-px is added or subtracted so bars don't hide the axis
    
    // redundant-encoding scheme taken from the solution, but varies the green component instead of red, while fixing the blue component
    fill(data.length, abs(b), 255);
    rect(bX, bY, barWd, abs(b));
  }
}
