SET program="TriangleTests.exe"
if %program% == "" goto err

echo must return normal triangle
%program% "3.2" "2" "3" "4" "5" "6" > normalTriangle.txt
if errorlevel 1 goto testFailed
fc /b normalTriangle.txt standard/normalTriangle.txt
if errorlevel 1 goto testFailed

echo must return isosceles triangle
%program% "1" "0" "3" "6" "5" "0" > isoscelesTriangle.txt
if errorlevel 1 goto testFailed
fc /b isoscelesTriangle.txt standard/isoscelesTriangle.txt
if errorlevel 1 goto testFailed

echo not triangle
%program% "0" "0" "-1" "1" "-2" "2" > notTriangle.txt
if errorlevel 1 goto testFailed
fc /b notTriangle.txt standard/notTriangle.txt
if errorlevel 1 goto testFailed

echo return wrong amount of arguments was proposed
%program% "0" "0"> errorArgum.txt
if NOT errorlevel 1 goto testFailed
fc /b errorArgum.txt standard/errorArgum.txt
if errorlevel 1 goto testFailed

echo return coordinate is incorrect
%program% "0.0." "sad" "-212esad" ".1" "-..2" "....2" > coordinateIsIncorrect.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect.txt standard/coordinateIsIncorrect.txt
if errorlevel 1 goto testFailed

echo return coordinate is empty
%program% "" "" "" "" "" "2" > coordinateIsEmpty.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsEmpty.txt standard/coordinateIsEmpty.txt
if errorlevel 1 goto testFailed

echo OK
pause 
exit /B

:testFailed
ECHO Testing failed
pause
exit /B

:err


pause