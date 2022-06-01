#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>

#define TRUE 1
#define FALSE 0

int mem[100];

struct timeval begin;
struct timeval end;

// Registres
int LR = 0;
int PC = 0;
int SP = 0;
int R0 = 0;

// Pile
int pile[1000];

FILE* fichier = NULL;

float time_diff(struct timeval *start, struct timeval *end)
{
    return (end->tv_sec - start->tv_sec) + 1e-6*(end->tv_usec - start->tv_usec);
}

void print_mem() {
	printf("  MEM   \n");
	for(int i=0; i<10 ; i++) {
		char str1[10];
		sprintf(str1,"[%d] %d \n", i, mem[i]);
		printf(str1);
	}
	printf("\n");
}

void print_pile() {
	printf("  PILE   \n");
	for(int i=0; i<10 ; i++) {
		char str1[10];
		sprintf(str1,"[%d] %d \n", i, pile[i]);
		printf(str1);
	}
	printf("\n");
}


void read_file(int start) {
	gettimeofday(&end, NULL);
	

	FILE *f;
    char ligne[81] ;

	char operation[7];
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
	
	while ( fgets(ligne, 81, f) != NULL ) { /*fin de fichier non atteinte*/ // & time_diff(&begin, &end) < 80e-4
		gettimeofday(&end, NULL);
		char str2[100];
		sprintf(str2,"%f\n", time_diff(&start, &end));
		//printf(str2);
		
		


		sscanf(ligne, "%s %d %d %d", &operation, &resultat, &op1, &op2);
		/* char str1[100];
		sprintf(str1,"%d %s\n", compteur, operation);
		printf(str1);
		

		print_mem(); */
 
    	//fichier = fopen("debug.txt", "a");
		/* if( fichier==NULL ) { 
		printf("Impossible d'ouvrir le fichier debug.txt.");
		exit(1); 
		} */
		/* char str1[100];
		sprintf(str1,"%s %d start=%d ----- [%d] R0 = %d   SP = %d    PC= %d    LR=%d\n", operation, resultat, start, compteur, R0, SP, PC, LR);
		printf(str1); */
		//fwrite(str1, 1, strlen(str1),fichier);
		//fclose(fichier);

		compteur++; 
		//print_pile();
		//print_mem(); 

		if( !strcmp(operation, "ADD") ) {
			PC++;
			mem[resultat] = mem[op1] + mem[op2];
			/* char str2[100];
			sprintf(str2,"    %d    ", mem[resultat]);
			printf(str2); */
		} else if (!strcmp(operation, "MUL") ) {
			PC++;
			mem[resultat] = mem[op1] * mem[op2];
		} else if (!strcmp(operation, "SOU") ) {
			PC++;
			mem[resultat] = mem[op1] - mem[op2];
		} else if (!strcmp(operation, "DIV") ) {
			PC++;
			mem[resultat] = mem[op1] / mem[op2];
		} else if (!strcmp(operation, "COP") ) {
			PC++;
			mem[resultat] = mem[op1];
		} else if (!strcmp(operation, "AFC") ) {
			PC++;
			mem[resultat] = op1;
		} else if (!strcmp(operation, "JMP") ) {
			fclose(f);
			read_file(resultat);
			exit(0);
		} else if (!strcmp(operation, "BL") ) {
			LR = PC + 1;
			PC = resultat;
			fclose(f);
			read_file(resultat);
			exit(0);
		} else if (!strcmp(operation, "JMF") ) {
			if (mem[resultat] == FALSE) {
				PC = op1;
				fclose(f);
				read_file(op1);
				exit(0);
			}
		} else if (!strcmp(operation, "INF") ) {
			PC++;
			if (mem[op1] < mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "SUP") ) {
			PC++;
			if (mem[op1] > mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "EQU") ) {
			PC++;
			if (mem[op1] == mem[op2]) {
				mem[resultat] = TRUE;
			} else {
				mem[resultat] = FALSE;
			}
		} else if (!strcmp(operation, "PRI") ) {
			PC++;
			char str[5];
            sprintf(str,"%d\n", mem[resultat]);
			printf(str);
		} else if (!strcmp(operation, "LOAD_R0") ) {
			PC++;
			mem[resultat] = R0;
		} else if (!strcmp(operation, "COP_R0") ) {
			PC++;
			R0 = mem[resultat];
		} else if (!strcmp(operation, "POP") ) {
			PC++;
			SP--;
			mem[resultat] = pile[SP];
		} else if (!strcmp(operation, "PUSH") ) {
			PC++;
			pile[SP] = mem[resultat];
			SP++;
		} else if (!strcmp(operation, "POP_PC") ) {
			SP--;
			PC = pile[SP];
			fclose(f);
			read_file(PC);
			exit(0);
		} else if (!strcmp(operation, "PUSH_LR") ) {
			PC++;
			pile[SP] = LR;
			SP++;
		} 


		}

	fclose(f);

	
}


int main() {
    gettimeofday(&begin, NULL);
	read_file(1);
	return 0;
}


