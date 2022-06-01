#ifndef COMP_H
#define COMP_H

enum instruct{MUL, SOU, DIV, COP, AFC, JMP, JMF, INF, SUP, EQU, PRI};

void init_symb(void);

void print_ts(void);

void add_symb(char nom[10], char type[10], int init);

void inc_depth(void);

void dec_depth(void);

int get_addr(char nom[]);

void init(void);

int get_tmp(void);

int get_last_addr(void);

void free_tmp(void);

int add_instruct(char instruct[], int resultat, int op1, int op2);

void remove_instruct(void);

void print_instruct(void);

int get_nb_lignes(void);

void patch_jmp(int ligne, int patch);

void patch_jmf(int ligne, int patch);

void write_instruct_in_file(void);

void add_func(char nom[20], int start, int nbArg);

int get_start_func(char nom[]);

int get_nbArg_func(char nom[]);

int push_context(void);

void pop_context(int indice);

void patch_jump_main(int patch);

#endif