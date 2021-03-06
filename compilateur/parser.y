%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "comp.h"
char var[10];
void yyerror(char *s);
%}
%union { int nb; char* var; }
%token tINT tPRINT tRETURN tMAIN tCONST tPV tPF tAO tV tCOM tAF tELSE tEGAL tSOU tADD tMUL tDIV tSUP tINF tEGALEGAL
%token <nb> tNB
%token <var> tID
%token <nb> tIF 
%token <nb> tPO
%token <nb> tWHILE
%type <nb> Expr DivMul Terme Else Arguments ArgNext AppelFonc
%left tADD tSOU
%left tMUL tDIV
%nonassoc tIF
%nonassoc tELSE
%start FichierC 

%%
FichierC : { add_instruct("JMP", -1, -1, -1); } DeclarationsFunctions Main { write_instruct_in_file(); };

DeclarationsFunctions : tINT  tID tPO Arguments tPF {	add_func($2, get_nb_lignes() - $4 +1, $4); 
														add_instruct("PUSH_LR", -1, -1, -1);
													} 
						tAO Body tRETURN tID tPV tAF {	add_instruct("COP_R0", get_addr($10), -1, -1); add_instruct("POP_PC", -1, -1, -1); };

Arguments : { $$ = 0; } | tINT tID {  add_symb($2, "int", 0); add_instruct("POP", get_addr($2), -1, -1); } ArgNext { $$ = $4 + 1; } ;

ArgNext : { $$ = 0; } | tV tINT tID ArgNext { add_symb($3, "int", 0); add_instruct("POP", get_addr($3), -1, -1); $$ = $4 + 1; } ;

Main : tINT tMAIN tPO tPF tAO { patch_jump_main(get_nb_lignes() + 1); } Body tRETURN tID tPV tAF { 
	add_instruct("COP_R0", get_addr($9), -1, -1); 
} ;

Body : Declarations Instructions ;

Declarations : | Var VarNext tPV Declarations;

Type : tINT | tCONST ;

VarNext : | tV Var VarNext ;

Var : Type tID { add_symb($2,"int", 0);}
		| Type tID tEGAL Expr { int tmp = get_last_addr();
								free_tmp(); 
								add_symb($2,"int", 1);
								add_instruct("COP", get_addr($2), tmp, -1); } ; 

Expr : Expr tADD DivMul { 	get_tmp();
							add_instruct("ADD", get_last_addr() - 2, get_last_addr() - 2, get_last_addr() - 1 );
							free_tmp();
							free_tmp(); }
		| Expr tSOU DivMul { get_tmp();
							add_instruct("SOU", get_last_addr() - 2, get_last_addr() - 2, get_last_addr() - 1 );
							free_tmp();
							free_tmp(); }
		| DivMul { } ;

DivMul : DivMul tMUL Terme { get_tmp();
							add_instruct("MUL", get_last_addr() - 2, get_last_addr() - 2, get_last_addr() - 1 );
							free_tmp();
							free_tmp(); }
		| DivMul tDIV Terme { get_tmp();
							add_instruct("DIV", get_last_addr() - 2, get_last_addr() - 2, get_last_addr() - 1 );
							free_tmp();
							free_tmp(); }
		| Terme { } ;

Terme :	tPO Expr tPF { }
		| tID { get_tmp();
				add_instruct("COP", get_last_addr(), get_addr($1), -1);}
		| tNB { get_tmp(); 
				add_instruct("AFC", get_last_addr(), $1, -1); } ;

Instructions : | Affectation Instructions | Print Instructions | AppelFonc Instructions | If Instructions | While Instructions ;

Affectation : tID tEGAL Expr tPV {  if (get_addr($1) == -1) {
										char *error;
										sprintf(error, "La variable \"%s\" n'a pas ??t?? d??clar??e", $1);
										yyerror(error);
									}
									add_instruct("COP", get_addr($1), get_last_addr(), -1);
									free_tmp(); };

Print : tPRINT tPO tID {add_instruct("PRI", get_addr($3), -1, -1);} tPF tPV ;

AppelFonc : tID tEGAL tID tPO { $4 = push_context(); } PassageArg tPF tPV { add_instruct("BL", get_start_func($3), -1, -1); pop_context($4); add_instruct("LOAD_R0", get_addr($1), -1, -1); };

PassageArg : | tID  PassageArgNext { add_instruct("PUSH", get_addr($1), -1, -1); };

PassageArgNext : { init_symb(); } | tV tID PassageArgNext { add_instruct("PUSH", get_addr($2), -1, -1); };

Condition : Terme tINF Terme { 	add_instruct("INF", get_last_addr() - 1, get_last_addr() - 1, get_last_addr());
								free_tmp(); }
			| Terme tSUP Terme { 	add_instruct("SUP", get_last_addr() - 1, get_last_addr() - 1, get_last_addr());
									free_tmp(); }
			| Terme tEGALEGAL Terme { 	add_instruct("EQU", get_last_addr() - 1, get_last_addr() - 1, get_last_addr()); 
										free_tmp();}

If : tIF tPO Condition tPF { 	int ligne = add_instruct("JMF", get_last_addr(), -1, -1);
								$1 = ligne; } 
	tAO Instructions { 	int current = get_nb_lignes();
						patch_jmf($1, current + 2);
						int ligne = add_instruct("JMP", -1, -1, -1); 
						$1 = ligne;	} 
	tAF Else { 	if($10 != -1) {
					patch_jmp($1, $10 + 1);
				} else {
					remove_instruct();
				}
		 };

Else : {$$ = -1; } | 
		tELSE tAO Instructions tAF {	int current = get_nb_lignes(); 
										$$ = current; } ;

While : tWHILE tPO Condition tPF { 	int ligne = add_instruct("JMF", get_last_addr(), -1, -1);
									$1 = ligne; }
		tAO Instructions tAF { 	int current = get_nb_lignes();
								patch_jmf($1, current + 2);
								add_instruct("JMP", $1 - 2, -1, -1); };

%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("FichierC\n"); // yydebug=1;
  return yyparse();
}
 