/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tINT = 258,
    tPRINT = 259,
    tRETURN = 260,
    tMAIN = 261,
    tCONST = 262,
    tPV = 263,
    tPF = 264,
    tAO = 265,
    tV = 266,
    tCOM = 267,
    tAF = 268,
    tELSE = 269,
    tEGAL = 270,
    tSOU = 271,
    tADD = 272,
    tMUL = 273,
    tDIV = 274,
    tSUP = 275,
    tINF = 276,
    tEGALEGAL = 277,
    tNB = 278,
    tID = 279,
    tIF = 280,
    tPO = 281,
    tWHILE = 282
  };
#endif
/* Tokens.  */
#define tINT 258
#define tPRINT 259
#define tRETURN 260
#define tMAIN 261
#define tCONST 262
#define tPV 263
#define tPF 264
#define tAO 265
#define tV 266
#define tCOM 267
#define tAF 268
#define tELSE 269
#define tEGAL 270
#define tSOU 271
#define tADD 272
#define tMUL 273
#define tDIV 274
#define tSUP 275
#define tINF 276
#define tEGALEGAL 277
#define tNB 278
#define tID 279
#define tIF 280
#define tPO 281
#define tWHILE 282

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 9 "parser.y"
 int nb; char* var; 

#line 114 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
