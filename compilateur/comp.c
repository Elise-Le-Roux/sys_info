#include "comp.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Table des symboles
struct symb {
    char nom[10];
    char type[10];
    int init;
    int profondeur;
};

struct symb tab_symb[1000];
int indice_symb = 0;
int profondeur = 0;

// Table instructions

struct instruction {
    char operation[7];
    int resultat;
    int op1;
    int op2;
};

struct instruction tab_instruct[1000];
int indice_instruct = 0;

// Table fonctions
struct func {
    char nom[10];
    int start;
    int nbArg;
    // int profondeur;
    // char type[10];
};

struct func tab_func[1000];
int indice_func = 0;

// Pile contexte
struct symb contexte[1000];
int indice_ctxt = 0;
int profondeur_ctxt = 0;


// Méthodes table des symboles

void init_symb(void) {
    indice_symb = 0;
    profondeur = 0;
}

void print_ts(void){
    for(int i=0; i<10; i++) {
        printf("Nom = %s | Type = %s | Init = %d | Profondeur = %d\n", 
        tab_symb[i].nom, 
        tab_symb[i].type,
        tab_symb[i].init,
        tab_symb[i].profondeur
        );
    }
}

void add_symb(char nom[10], char type[10], int init){
    struct symb symbole;
    strcpy(symbole.nom, nom);
    strcpy(symbole.type, type);
    symbole.init = init;
    symbole.profondeur = profondeur;
    tab_symb[indice_symb] = symbole;
    print_ts();
    indice_symb++;
}


void inc_depth(void){
    profondeur++;
}

void dec_depth(void){
    for(int i=0; i<1000; i++) {
        if(tab_symb[i].profondeur == profondeur) {
            indice_symb = i;
            break;
        }
    }
    profondeur--;
}

int get_addr(char nom[]){
    int result = -1;
    for(int i=0; i<1000; i++) {
        if(strcmp(tab_symb[i].nom, nom) == 0) {
            result = i;
            break;
        }
    }
    return result;
}


int get_tmp(void) {
    int result = indice_symb;
    indice_symb++;
    return result;
}

int get_last_addr(void) {
    return indice_symb - 1;
}

void free_tmp(void) {
    indice_symb--;
}


// Méthodes table instructions

int add_instruct(char instruct[3], int resultat, int op1, int op2) {
    struct instruction ins;
    strcpy(ins.operation, instruct);
    ins.resultat = resultat;
    ins.op1 = op1;
    ins.op2 = op2;
    tab_instruct[indice_instruct] = ins;
    indice_instruct++;
    print_instruct();
    return indice_instruct - 1;
}

void remove_instruct(void) {
    indice_instruct--;
}

void print_instruct(void){
    for(int i=0; i<60; i++) {
        printf("[%d] %s %d %d %d \n",
        i+1, 
        tab_instruct[i].operation, 
        tab_instruct[i].resultat,
        tab_instruct[i].op1,
        tab_instruct[i].op2
        );
    }
}

int get_nb_lignes(void) {
    return indice_instruct;
}

void patch_jmp(int ligne, int patch) {
    tab_instruct[ligne].resultat = patch;
    print_instruct();
}

void patch_jmf(int ligne, int patch) {
    tab_instruct[ligne].op1 = patch;
    print_instruct();
}

void write_instruct_in_file(void) {

    FILE* fichier = NULL;
 
    fichier = fopen("asm.txt", "w");
 
    if (fichier != NULL)
    {
        for (int i=0; i<indice_instruct; i++) {

            fputs(tab_instruct[i].operation, fichier);
            char str[100];

            if (    !strcmp(tab_instruct[i].operation, "AFC") | 
                    !strcmp(tab_instruct[i].operation, "COP") | 
                    !strcmp(tab_instruct[i].operation, "JMF")) {

                sprintf(str," %d %d\n", tab_instruct[i].resultat, 
                                        tab_instruct[i].op1);

            } else if ( !strcmp(tab_instruct[i].operation, "PRI") |
                      !strcmp(tab_instruct[i].operation, "JMP") | 
                      !strcmp(tab_instruct[i].operation, "BL") |
                      !strcmp(tab_instruct[i].operation, "COP_R0") |
                      !strcmp(tab_instruct[i].operation, "LOAD_R0") |
                      !strcmp(tab_instruct[i].operation, "PUSH") |
                      !strcmp(tab_instruct[i].operation, "POP")) {

                sprintf(str," %d\n", tab_instruct[i].resultat);

            } else if ( !strcmp(tab_instruct[i].operation, "PUSH_LR") |
                      !strcmp(tab_instruct[i].operation, "POP_PC") ) {

                sprintf(str,"\n");

            } else {

                sprintf(str," %d %d %d\n",  tab_instruct[i].resultat, 
                                            tab_instruct[i].op1, 
                                            tab_instruct[i].op2); 
            }
            
            fputs(str, fichier);
        }
        fclose(fichier);
    } else {
        printf("Impossible d'ouvrir le fichier asm.txt.");
    }

}

// Méthodes table fonctions

void add_func(char nom[20], int start, int nbArg) {
    struct func f;
    strcpy(f.nom, nom);
    f.start = start;
    f.nbArg = nbArg;
    tab_func[indice_func] = f;
    indice_func++;
}


int get_start_func(char nom[]) {
    int result = -1;
    for(int i=0; i<1000; i++) {
        if(strcmp(tab_func[i].nom, nom) == 0) {
            result = tab_func[i].start;
            break;
        }
    }
    return result;
}

int get_nbArg_func(char nom[]) {
    int result = -1;
    for(int i=0; i<1000; i++) {
        if(strcmp(tab_func[i].nom, nom) == 0) {
            result = tab_func[i].nbArg;
            break;
        }
    }
    return result;
}

//

int push_context(void) {
    for (int i=0; i<indice_symb ; i++) {
        add_instruct("PUSH", i, -1, -1);
        contexte[indice_ctxt] = tab_symb[i];
        indice_ctxt++;
    }
    return indice_symb;
}

void pop_context(int indice) {
    init_symb();
    for (int i=0; i<indice ; i++) {
        add_instruct("POP", indice - i -1, -1, -1);
        tab_symb[indice - i - 1] = contexte[ indice_ctxt - i -1 ]; 
        indice_symb++;
    }
}


void patch_jump_main(int patch) {
    tab_instruct[0].resultat = patch;
    print_instruct();
} 
