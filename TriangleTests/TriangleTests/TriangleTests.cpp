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
		int assciCode = static_cast<int> (coord[i]);
		if (!(assciCode >= -1 && assciCode <= 255)) {
			std::cout << "'1,2,3' ���������, � �� ��� �� ����� ��� ";
			return false;
		};
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
		std::cout << "���� �� ��������� ������";
		return true;
	}
	if (!isCorrectCoordinate(coord))
	{
		std::cout << "������������ ����������";
		return true;
	}
	return false;
}

void DisplayInLogTypeTriangle(float a, float b, float c)
{
	if (!IsTriange(a, b, c))
	{
		std::cout << "�� �����������";
	}
	else if (IsTriangeEquilateral(a, b, c))
	{
		std::cout << "��������������";
	}
	else if (IsTriangeIsosceles(a, b, c))
	{
		std::cout << "��������������";
	}
	else
	{
		std::cout << "�������";
	}
}

int main(int argc, char** argv)
{
	setlocale(LC_ALL, "Russian");
	if (argc != 4)
	{
		std::cout << "������� ����� ������ � �������� ����������. ������ �����: triangle.exe a b c";
		return 1;
	}
	std::string argv1 = argv[1];
	std::string argv2 = argv[2];
	std::string argv3 = argv[3];
	if (WasErrorInput(argv1) || WasErrorInput(argv2) || WasErrorInput(argv3))
	{
		return 1;
	}
	float a = std::stof(argv1);
	float b = std::stof(argv2);
	float c = std::stof(argv3);
	DisplayInLogTypeTriangle(a, b, c);
	return 0;
}

