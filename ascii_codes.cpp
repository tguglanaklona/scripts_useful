#include "stdafx.h"

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
