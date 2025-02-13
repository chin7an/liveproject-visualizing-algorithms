// TODO list
// 1. make all variables configurable
// 2. derive scaling values in the setup, prior to drawing
// 3. experiment with additional redundant encoding schemes

int barLo = -200;
int barHi = 200;

color oddCol;
color evenCol;

int[] data;

void setup() {
  size(1280, 720);
  
  oddCol = color(253, 124, 110);
  evenCol = color(0, 162, 237);
  
  data = new int[200];
  for (int idx = 0; idx < data.length; idx++) {
    data[idx] = int(random(barLo, barHi));
  }
}

void draw() {
  background(255); 
  
  // horizontal axis
  stroke(160);
  line(5, (height / 2), (width - 5), (height / 2));
  
  stroke(100);
  for (int idx = 0; idx < data.length; idx++) {
    int bar = data[idx];
    
    // find origin of the bar, default mode is CORNER, so the first two arguments are
    // the x,y co-ordinates of the upper-right corner of the rectangle
    
    // x co-ordinate is simple, as the (0, 0) starts from top-left corner, and the horizontal line
    // is drawn from left to right conventionally
    // y co-ordinate is trickier, since co-ordinates are processed from top, where as we want to
    // refer the rendered horizontal axis as the starting point
    //   positive numbers will be 'number' pixels above this line, so we deduct to get the x
    //   negative numbers will be on the line, so we simply use the same coordinate as the axis
    
    // x = offset + bar_width * index
    //     where offset = 40; comes from dividing (1280 - 1200) into halves; 1200 is the nearest
    //                        multiple of 200 (size of data-array), not exceeding width
    // y = axis if negative, axis - number if positive
    // bar width = 6, the multiple of 200 that gets us 1200
    int bX = 40 + (6 * idx);
    int bY = (bar > 0) ? ((height / 2) - bar - 1) : ((height / 2) + 1);
    
    color fillCol = (idx % 2 == 0) ? evenCol : oddCol;
    fill(fillCol);
    rect(bX, bY, 6, abs(bar));
  }
}
