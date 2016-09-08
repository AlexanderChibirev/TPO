SET program="TriangleTests.exe"
if %program% == "" goto err

echo must return normal triangle
%program% "3" "4" "5" > normalTriangle.txt
if errorlevel 1 goto testFailed
fc /b normalTriangle.txt standard/normalTriangle.txt
if errorlevel 1 goto testFailed

echo must return isosceles triangle
%program% "4" "4" "3" > isoscelesTriangle.txt
if errorlevel 1 goto testFailed
fc /b isoscelesTriangle.txt standard/isoscelesTriangle.txt
if errorlevel 1 goto testFailed

echo not triangle
%program% "2" "3" "6" > notTriangle.txt
if errorlevel 1 goto testFailed
fc /b notTriangle.txt standard/notTriangle.txt
if errorlevel 1 goto testFailed

echo  must return Equilateral Triangle
%program% "3" "3" "3" > EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed
fc /b EquilateralTriangle.txt standard/EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed


echo return wrong amount of arguments was proposed
%program% "0" "0"> errorArgum.txt
if NOT errorlevel 1 goto testFailed
fc /b errorArgum.txt standard/errorArgum.txt
if errorlevel 1 goto testFailed

echo return coordinate is incorrect
%program% "0.0." "sad" "-212esad" > coordinateIsIncorrect.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect.txt standard/coordinateIsIncorrect.txt
if errorlevel 1 goto testFailed

echo return coordinate is empty
%program% "" "" "" > coordinateIsEmpty.txt
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