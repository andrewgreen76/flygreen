#include <iostream>
#include <fstream>
#include <stdio.h>
#include <Windows.h>
using namespace std; 

void keepRenaming( string &, string &, string&);

int main()
{
	string deskPath = "C:/users/owner/Desktop/";
	string fileName = "H";
	string fileExt = ".txt";

	keepRenaming(deskPath, fileName, fileExt);

	return 0;
}

void keepRenaming( string &dp,  string &fn,  string &ext)
{
	char a[] = { 72, 101, 114, 101, 39, 115, 32, 74, 111, 104, 110, 110, 121, 33, 32, 56, 68 }; 
	int i = 1;
	int ms = 500;
	string oldFPath = dp + fn + ext;
	ofstream file(oldFPath);
	file.close();
	string newFPath;

	Sleep(ms);
	
	while(1)
	{
		if (i == 17)
		{
			fn = "H";
			i = 1;
		}
		else
		{
			string nextCh(1, a[i]);
			fn = fn + nextCh;
			i++;
		}

		newFPath = dp + fn + ext;

		if (rename(oldFPath.c_str(), newFPath.c_str()) != 0) {
			//perror("\nError renaming file\n");
		}
		else{	//std::cout << "\nFile renamed successfully\n";
		}

		oldFPath = newFPath;
		Sleep(ms);
	}	

	return; 
}