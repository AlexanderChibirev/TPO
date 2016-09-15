// TriangleTests.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <string>

bool IsTriangeEquilateral(float a, float b, float c);// равносторонний
bool IsTriangeIsosceles(float a, float b, float c); //треугольник равнобедренный ?
bool IsTriange(float a, float b, float c); //обычный?
bool WasErrorInput(std::string coord);//проверка на все ошибки и вывод в консоль этих ошибок
bool isCorrectCoordinate(std::string coord); //есть ли в координате буквы или неправильно введена координата ?

bool isCorrectCoordinate(std::string coord)
{
	bool wasDot = false;
	int i = coord.length();

	while (i--)
	{
		int assciCode = static_cast<int> (coord[i]);
		if (!(assciCode >= -1 && assciCode <= 255)) {
			std::cout << "'1,2,3' корректно, а то что вы ввели это ";
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
		std::cout << "одна из координат пустая";
		return true;
	}
	if (!isCorrectCoordinate(coord))
	{
		std::cout << "неккоректные координаты";
		return true;
	}
	return false;
}

void DisplayInLogTypeTriangle(float a, float b, float c)
{
	if (!IsTriange(a, b, c))
	{
		std::cout << "Не треугольник";
	}
	else if (IsTriangeEquilateral(a, b, c))
	{
		std::cout << "Равносторонний";
	}
	else if (IsTriangeIsosceles(a, b, c))
	{
		std::cout << "Равнобедренный";
	}
	else
	{
		std::cout << "Простой";
	}
}

int main(int argc, char** argv)
{
	setlocale(LC_ALL, "Russian");
	if (argc != 4)
	{
		std::cout << "Укажите длины сторон в качестве параметров. Формат ввода: triangle.exe a b c";
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

