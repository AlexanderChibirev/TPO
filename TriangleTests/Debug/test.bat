@Echo off
SET program="TriangleTests.exe"
if %program% == "" goto err

echo ��� �� ���⮩ ��㣮�쭨�, १���⮬ �ணࠬ�� ������� ���� ��ப�: "���⮩"
%program% "3" "4" "5" > normalTriangle.txt
if errorlevel 1 goto testFailed
fc /b normalTriangle.txt standard/normalTriangle.txt
if errorlevel 1 goto testFailed

echo ��� �� ࠢ�����७�� ��㣮�쭨�, १���⮬ �ணࠬ�� ������� ���� ��ப�: "��������७��"
%program% "4" "4" "3" > isoscelesTriangle.txt
if errorlevel 1 goto testFailed
fc /b isoscelesTriangle.txt standard/isoscelesTriangle.txt
if errorlevel 1 goto testFailed

echo  ��� �� �� ��㣮�쭨�, १���⮬ �ணࠬ�� ������� ���� ��ப�: "�� ��㣮�쭨�"
%program% "2" "3" "6" > notTriangle.txt
if errorlevel 1 goto testFailed
fc /b notTriangle.txt standard/notTriangle.txt
if errorlevel 1 goto testFailed

echo  ��� �� ࠢ����஭��� ��㣮�쭨�, १���⮬ �ணࠬ�� ������� ���� ��ப�: "�������஭���"
%program% "3" "3" "3" > EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed
fc /b EquilateralTriangle.txt standard/EquilateralTriangle.txt
if ERRORLEVEL 1 goto testFailed


echo ��� �� ���ࠢ��쭮� ������⢮ ��㬥�⮢, १���⮬ �ணࠬ�� ������� ���� ��ப�: "������ ����� ��஭ � ����⢥ ��ࠬ��஢. ��ଠ� �����: triangle.exe a b c"
%program% "0" "0"> errorArgum.txt
if NOT errorlevel 1 goto testFailed
fc /b errorArgum.txt standard/errorArgum.txt
if errorlevel 1 goto testFailed

echo ��� �� ������ ��㬥�⮢, १���⮬ �ணࠬ�� ������� ���� ��ப�: "���� �� ���न��� �����"
%program% "" "" "" > coordinateIsEmpty.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsEmpty.txt standard/coordinateIsEmpty.txt
if errorlevel 1 goto testFailed

echo ���, ����� � ����� �� ���न��� � ���� �᫠ �⮨� �窠, १���⮬ �ணࠬ�� ������� ���� ��ப�: "�����४�� ���न����"
%program% "0.0." "1" "2" > coordinateIsIncorrect1.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect1.txt standard/coordinateIsIncorrect1.txt
if errorlevel 1 goto testFailed

echo ���, ����� � ����� �� ���न��� � ��砫� �᫠ �⮨� �窠, १���⮬ �ணࠬ�� ������� ���� ��ப�: "�����४�� ���न����"
%program% ".0.0" "1" "2" > coordinateIsIncorrect2.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect2.txt standard/coordinateIsIncorrect1.txt
if errorlevel 1 goto testFailed

echo ���, ����� ���न���� ����ᠭ� �㪢���, १���⮬ �ணࠬ�� ������� ���� ��ப�: "'1,2,3' ���४⭮, � � �� �� ����� �� �����४�� ���न����"
%program% "������" "1" "2" > coordinateIsIncorrect3.txt
if NOT errorlevel 1 goto testFailed
fc /b coordinateIsIncorrect3.txt standard/coordinateIsIncorrect3.txt
if errorlevel 1 goto testFailed

echo ���, ����� �ᯮ��㥬  ���४�� �᫠ � �窮� ⨯� 0.1, १���⮬ �ணࠬ�� ������� ���� ��ப�: "�� ��㣮�쭨�"
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