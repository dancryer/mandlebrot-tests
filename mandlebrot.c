#include <stdio.h>

int main() {
  int iSize       = 2048;
  int iMaxIters   = 512;
  double fBailout  = 4.0;
  double fYMin     = -1.25;
  double fYMax     = 1.25;
  double fYTot     = fYMax - fYMin;
  double fXMax     = 0.5;
  double fXMin     = fXMax - fYTot;
  double fXTot     = fXMax - fXMin;
  double fStep     = fYTot / iSize;
  int iCnt        = 0;
  double fCY       = fYMax;
  for (int y = 0; y < iSize/2; y++, fCY -= fStep) {
    double fCX = fXMin;
    for (int x = 0; x < iSize; x++, fCX += fStep) {
      double fZX = fCX;
      double fZY = fCY;
      double fTest;
      int i   = iMaxIters;
      
      do {
        double fZX2   = fZX * fZX;
        double fZY2   = fZY * fZY;
        fTest  = fZX2 + fZY2;
        double fNewZX = fZX2 - fZY2 + fCX;
        double fNewZY = 2.0 * fZX * fZY + fCY;
        fZY    = fNewZY;
        fZX    = fNewZX;
      } while (--i && fTest < fBailout);
      iCnt += i ? 0 : 1;
    }
  }

  double fArea = 2 * iCnt * (fXTot * fYTot) / (iSize * iSize );

  printf( "Done: %f", fArea);
  return 0;
}
