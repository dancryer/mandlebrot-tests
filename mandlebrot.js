
const iSize     = 2048;
const iMaxIters = 512;
const fBailout  = 4.0;
const fYMin     = -1.25;
const fYMax     = 1.25;
const fYTot     = fYMax - fYMin;
const fXMax     = 0.5;
const fXMin     = fXMax - fYTot;
const fXTot     = fXMax - fXMin;
const fStep     = fYTot / iSize;
let iCnt      = 0;
let fCY       = fYMax;

for (let y = 0; y < iSize/2; y++, fCY -= fStep) {
  let fCX = fXMin;
  for (let x = 0; x < iSize; x++, fCX += fStep) {
    let fZX = fCX;
    let fZY = fCY;
    let fTest;
    let i   = iMaxIters;
    
    do {
        let fZX2   = fZX * fZX;
        let fZY2   = fZY * fZY;
      fTest  = fZX2 + fZY2;
      let fNewZX = fZX2 - fZY2 + fCX;
      let fNewZY = 2.0 * fZX * fZY + fCY;
      fZY    = fNewZY;
      fZX    = fNewZX;
    } while (--i && fTest < fBailout);
    iCnt += i ? 0 : 1;
  }
}

let fArea = 2 * iCnt * (fXTot * fYTot) / (iSize * iSize );

console.log( "Done: " + fArea);
