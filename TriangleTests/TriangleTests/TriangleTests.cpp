// TriangleTests.cpp: ���������� ����� ����� ��� ����������� ����������.
//

#include "stdafx.h"
#include <iostream>
#include <string>

bool IsTriangeEquilateral(float a, float b, float c);// ��������������
bool IsTriangeIsosceles(float a, float b, float c); //����������� �������������� ?
bool IsTriange(float a, float b, float c); //�������?
bool WasErrorInput(std::string coord);//�������� �� ��� ������ � ����� � ������� ���� ������
bool isCorrectCoordinate(std::string coord); //���� �� � ���������� ����� ��� ����������� ������� ���������� ?

bool isCorrectCoordinate(std::string coord)
{
	bool wasDot = false;
	int i = coord.length();
	while (i--)
	{
		if (!isdigit(coord[i]))
		{
			if (wasDot)
			{
				return false;
			}
			else if (coord[i] == '.') { wasDot = true; }
			else if(coord[i] == '-' && i == 0){
				return true;
			}
			else { return false; }
		}
	}
	if (coord[coord.length() - 1] == '.' || coord[0] == '.')
	{
		return false;
	}
	return true;
}

bool IsTriangeIsosceles(float a, float b, float c) 
{
	if (!(a != b && a != c && b != c))
	{
		return true;
	}
	return false;
}

bool IsTriangeEquilateral(float a, float b, float c) 
{
	if (a == b && b == c && a == c)
	{
		return true;
	}
	return false;
}


bool IsTriange(float a, float b, float c) 
{
	if (a + b <= c || a + c <= b || b + c <= a)
	{
		return false;
	}
	return true;
}

bool WasErrorInput(std::string coord)
{
	if (coord.empty())
	{
		std::cout << "coordinate is empty";
		return true;
	}
	if (!isCorrectCoordinate(coord))
	{
		std::cout << "coordinate is incorrect";
		return true;
	}
	return false;
}

void DisplayInLogTypeTriangle(float a, float b, float c)
{
	if (!IsTriange(a, b, c))
	{
		std::cout << "not triangle";
	}
	else if (IsTriangeEquilateral(a, b, c))
	{
		std::cout << "equilateral triangle";
	}
	else if (IsTriangeIsosceles(a, b, c))
	{
		std::cout << "isosceles triangle";
	}
	else
	{
		std::cout << "normal triangle";
	}
}

int main(int argc, char** argv)
{

	if (argc != 7)
	{
		std::cout << "Wrong amount of arguments was proposed\nEnter a correct arguments amount please, for example:\n '�1,�1,�2,�2,�3,�3'";
		return 1;
	}
	//get argument from .bat file or � ������ ������ ������ � ���������
	std::string argv1 = argv[1];
	std::string argv2 = argv[2];
	std::string argv3 = argv[3];
	std::string argv4 = argv[4];
	std::string argv5 = argv[5];
	std::string argv6 = argv[6];
	if (WasErrorInput(argv1) || WasErrorInput(argv2) || WasErrorInput(argv3) || WasErrorInput(argv4) || WasErrorInput(argv5) || WasErrorInput(argv6))
	{
		return 1;
	}
	//string to double
	float x1 = std::stof(argv1);
	float y1 = std::stof(argv2);
	float x2 = std::stof(argv3);
	float y2 = std::stof(argv4);
	float x3 = std::stof(argv5);
	float y3 = std::stof(argv6);
	
	float a = sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2));//�������
	float b = sqrt((x1 - x3)*(x1 - x3) + (y1 - y3)*(y1 - y3));
	float c = sqrt((x3 - x2)*(x3 - x2) + (y3 - y2)*(y3 - y2));
	DisplayInLogTypeTriangle(a, b, c); //������� � ������� ��� ������������
	//system("pause");
	return 0;
}

