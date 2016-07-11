#include "stdafx.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

void text2ascii() { // text.txt -> xtext.txt
	unsigned char ch = 'A';
	FILE *fpOut, *fpIn;
	fpIn = fopen("text.txt", "r");
	fpOut = fopen("xtext.txt", "w");
	while (fscanf(fpIn, "%c", &ch) != EOF) {
		if (ch != '\n') {
			fprintf(fpOut, "%02X", ch);
		}
	}
	fclose(fpOut);
	fclose(fpIn);
}

void ascii2text() { // ptext.txt -> ctext.txt
	unsigned char ch;
	FILE *fpOut, *fpIn;
	fpIn = fopen("ptext.txt", "r");
	fpOut = fopen("ctext.txt", "w");
	while (fscanf(fpIn, "%02X", &ch) != EOF) {
		fprintf(fpOut, "%c", ch);
	}
	fclose(fpOut);
	fclose(fpIn);
}

unsigned int char2ascii(char ch) { //return Dec ascii
	return unsigned int(ch);
}

// print as Hex
std::ofstream out("out.txt");
unsigned int ch = 'A';
out << std::hex << key[i] << std::endl;
