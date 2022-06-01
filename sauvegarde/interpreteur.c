#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0

int mem[100];

void print_mem() {
	for(int i=0; i<10 ; i++) {
		char str1[10];
		sprintf(str1,"[%d] %d\n", i, mem[i]);
		printf(str1);
	}
}

void read_file(int start) {
	FILE *f;
    char ligne[81] ;

	char operation[3];
	int resultat;
	int op1;
	int op2;

    f=fopen("asm.txt","rt");

	if( f==NULL ) { 
		printf("Impossible d'ouvrir le fichier asm.txt.");
		exit(1); 
	}

	int compteur = 1;

	while ( compteur < start ) {
		fgets(ligne, 81, f);
		compteur++;
	}
	
	while ( fgets(ligne, 81, f) != NULL ) { /*fin de fichier non atteinte*/

		sscanf(ligne, "%s %d %d %d", &operation, &resultat, &op1, &op2);
		/* char str1[100];
		sprintf(str1,"%d %s\n", compteur, operation);
		printf(str1);
		compteur++;

		print_mem(); */

		if( !strcmp(operation, "ADD") ) {
			mem[resultat] = mem[op1] + mem[op2];
			/* char str2[100];
			sprintf(str2,"    %d    ", mem[resultat]);
			printf(str2); */
		} else if (!strcmp(operation, "MUL") ) {
			mem[resultat] = mem[op1] * mem[op2];
		} else if (!strcmp(operation, "SOU") ) {
			mem[resultat] = mem[op1] - mem[op2];
		} else if (!strcmp(operation, "DIV") ) {
			mem[resultat] = mem[op1] / mem[op2];
		} else if (!strcmp(operation, "COP") ) {
			mem[resultat] = mem[op1];
		} else if (!strcmp(operation, "AFC") ) {
			mem[resultat] = op1;
		} else if (!strcmp(operation, "JMP") ) {
			fclose(f);
			read_file(resultat);
			exit(0);
		} else if (!strcmp(operation, "JMF") ) {
			if (mem[resultat] == FALSE) {
				//printf("TESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSST");
				fclose(f);
				read_file(op1);
				exit(0);
			}
		} else if (!strcmp(operation, "INF") ) {
			if (mem[op1] < mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "SUP") ) {
			if (mem[op1] > mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "EQU") ) {
			if (mem[op1] == mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "PRI") ) {
			char str[5];
            sprintf(str,"%d\n", mem[resultat]);
			printf(str);
		}
	}

	fclose(f);
}


int main() {
    
	read_file(1);

	return 0;
}



