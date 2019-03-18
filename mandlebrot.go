package main

import "fmt"

func main() {
	iSize := 2048
	iMaxIters := 512
	fBailout := 4.0
	fYMin := -1.25
	fYMax := 1.25
	fYTot := fYMax - fYMin
	fXMax := 0.5
	fXMin := fXMax - fYTot
	fXTot := fXMax - fXMin
	fStep := fYTot / float64(iSize)
	iCnt := 0
	fCY := fYMax

	for y := 0; y < iSize/2; y++ {
		fCX := fXMin

		for x := 0; x < iSize; x++ {
			fZX := fCX
			fZY := fCY
			i := iMaxIters

			for true {
				fZX2 := fZX * fZX
				fZY2 := fZY * fZY
				fTest := fZX2 + fZY2
				fNewZX := fZX2 - fZY2 + fCX
				fNewZY := 2.0*fZX*fZY + fCY
				fZY = fNewZY
				fZX = fNewZX
				i = i - 1

				if i <= 0 || fTest >= fBailout {
					break
				}
			}

			if i <= 0 {
				iCnt = iCnt + 1
			}

			fCX = fCX + fStep
		}

		fCY = fCY - fStep
	}

	fArea := 2 * float64(iCnt) * (fXTot * fYTot) / (float64(iSize) * float64(iSize))
	fmt.Println("Done:", fArea)
}
