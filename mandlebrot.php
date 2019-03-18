<?php

//$fMark     = microtime(true);
$iSize     = 2048;
$iMaxIters = 512;
$fBailout  = 4.0;
$fYMin     = -1.25;
$fYMax     = 1.25;
$fYTot     = $fYMax - $fYMin;
$fXMax     = 0.5;
$fXMin     = $fXMax - $fYTot;
$fXTot     = $fXMax - $fXMin;
$fStep     = $fYTot / $iSize;
$iCnt      = 0;
$fCY       = $fYMax;
for ($y = 0; $y < $iSize/2; $y++, $fCY -= $fStep) {
  $fCX = $fXMin;
  for ($x = 0; $x < $iSize; $x++, $fCX += $fStep) {
    $fZX = $fCX;
    $fZY = $fCY;
    $i   = $iMaxIters;
    do {
      $fZX2   = $fZX * $fZX;
      $fZY2   = $fZY * $fZY;
      $fTest  = $fZX2 + $fZY2;
      $fNewZX = $fZX2 - $fZY2 + $fCX;
      $fNewZY = 2.0 * $fZX * $fZY + $fCY;
      $fZY    = $fNewZY;
      $fZX    = $fNewZX;
    } while (--$i && $fTest < $fBailout);
    $iCnt += $i ? 0 : 1;
  }
}

$fArea = 2 * $iCnt * ($fXTot * $fYTot) / ($iSize * $iSize );

echo "Done: ", $fArea, PHP_EOL;// , " ", microtime(true) - $fMark, " seconds\n";
