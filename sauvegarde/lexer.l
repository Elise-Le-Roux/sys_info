%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%

[ \t\n]+	{}
int { return tINT; }
printf { return tPRINT; }
return { return tRETURN; }
main { return tMAIN; }
const { return tCONST; }
if { return tIF; }
while { return tWHILE; }
else { return tELSE; }
[A-Za-z][A-Za-z0-9_]* { 
    yylval.var = strdup(yytext);  
    return tID; 
} 
[0-9]+((e)[0-9]+)? { 
    yylval.nb = (int) strtold(yytext, NULL);
    return tNB ; 
}
">" { return tSUP; }
"<" { return tINF; }
"==" { return tEGALEGAL; }
"("	{ return tPO; }
")"	{ return tPF; }
"{"	{ return tAO; }
"}"	{ return tAF; }
";" { return tPV; }
"," { return tV; }
"//".*$ { return tCOM; }
"="	{ return tEGAL; }
"-"	{ return tSOU; }
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV; }

%%
