@Echo off
SET program="TriangleTests.exe"
if %program% == "" goto err

echo тест на простой треугольник, результатом программы должена быть строка: "Простой"
%program% "3" "4" "5" > normalTriangle.txt
if errorlevel 1 goto testFailed
fc /b normalTriangle.txt standard/normalTriangle.txt
if errorlevel 1 goto testFailed

echo тест на равнобедренный треугольник, результатом программы должена быть строка: "Равнобедренный"
%program% "4" "4" "3" > isoscelesTriangle.txt
if errorlevel 1 goto testFailed
fc /b isoscelesTriangle.txt standard/isoscelesTriangle.txt
if errorlevel 1 goto testFailed

echo  тест на не треугольник, результатом программы должена быть строка: "Не треугольник"
%program% "2" "3" "6" > notTriangle.txt
if errorlevel 1 goto testFailed
fc /b notTriangle.txt standard/notTriangle.txt
if errorlevel 1 goto testFailed

echo  тест на равносторонний треугольник, результатом программы должена быть строка: "Равносторонний"
%program% "3" "3" "3" > EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed
fc /b EquilateralTriangle.txt standard/EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed


echo тест на неправильное количество аргументов, результатом программы должена быть строка: "Укажите длины сторон в качестве параметров. Формат ввода: triangle.exe a b c"
%program% "0" "0"> errorArgum.txt
if NOT errorlevel 1 goto testFailed
fc /b errorArgum.txt standard/errorArgum.txt
if errorlevel 1 goto testFailed

echo тест на пустоту аргументов, результатом программы должена быть строка: "одна из координат пустая"
%program% "" "" "" > coordinateIsEmpty.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsEmpty.txt standard/coordinateIsEmpty.txt
if errorlevel 1 goto testFailed

echo тест, когда у одной из координат в конце числа стоит точка, результатом программы должена быть строка: "неккоректные координаты"
%program% "0.0." "1" "2" > coordinateIsIncorrect1.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect1.txt standard/coordinateIsIncorrect1.txt
if errorlevel 1 goto testFailed

echo тест, когда у одной из координат в начале числа стоит точка, результатом программы должена быть строка: "неккоректные координаты"
%program% ".0.0" "1" "2" > coordinateIsIncorrect2.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect2.txt standard/coordinateIsIncorrect1.txt
if errorlevel 1 goto testFailed

echo тест, когда координаты написаны буквами, результатом программы должена быть строка: "'1,2,3' корректно, а то что вы ввели это неккоректные координаты"
%program% "десять" "1" "2" > coordinateIsIncorrect3.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect3.txt standard/coordinateIsIncorrect3.txt
if errorlevel 1 goto testFailed

echo тест, когда используем  корректные числа с точкой типо 0.1, результатом программы должена быть строка: "Не треугольник"
%program% "4.2" "1.2" "2" > floatCoordinate.txt
if errorlevel 1 goto testFailed
fc /b floatCoordinate.txt standard/floatCoordinate.txt
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