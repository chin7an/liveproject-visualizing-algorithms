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
  
  // render the unsorted array first
  renderSortedArray(data, -1);
  for (int idx = 0; idx < min(frameCount, data.length); idx++) {
    int minIdx = idx;
    for (int srchIdx = (idx + 1); srchIdx < data.length; srchIdx++) {
      if (data[srchIdx] < data[minIdx]) {
        minIdx = srchIdx;
      }
    }
    swap(data, minIdx, idx);
    renderSortedArray(data, idx);
  }
}

/*
 * Method to render a sorted array, the sortedIdx parameter is the index until which the array is sorted, can be -1 if nothing is sorted
 * or (arr.length - 1) if the entire array is sorted
 *
 * x co-ordinate = offset + (bar_width * current_index)
 * y co-ordinate = has to handle negative & positive numbers
 *     - positive -> 'number' pixels above axis = (axis - bar)
 *     - negative -> drawn on the axis = same coordinate as the axis
 */
void renderSortedArray(int[] arr, int sortedIdx) {
  for (int idx = 0; idx < arr.length; idx++) {
    int b = data[idx];
    
    int bX = histOffset + (barWd * idx);
    int bY = (b > 0) ? ((height / 2) - b - 1) : ((height / 2) + 1);  // the 1-px is added or subtracted so bars don't hide the axis
    
    // sorted = variable the red component, unsorted = variable the green component
    if (idx <= sortedIdx) {
      // sorted
      fill(abs(b), data.length, 255);
    } else {
      // unsorted
      fill(data.length, abs(b), 255);
    }
    rect(bX, bY, barWd, abs(b));
  }
}

void swap(int[] arr, int idx1, int idx2) {
  int tmp = arr[idx1];
  arr[idx1] = arr[idx2];
  arr[idx2] = tmp;
}
