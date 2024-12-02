/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
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
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SINTACTICO_TAB_H_INCLUDED
# define YY_YY_SINTACTICO_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    BOOL = 258,                    /* BOOL  */
    TRUE = 259,                    /* TRUE  */
    FALSE = 260,                   /* FALSE  */
    VAR = 261,                     /* VAR  */
    IF = 262,                      /* IF  */
    ELSE = 263,                    /* ELSE  */
    WHILE = 264,                   /* WHILE  */
    FOR = 265,                     /* FOR  */
    RETURN = 266,                  /* RETURN  */
    VOID = 267,                    /* VOID  */
    SWITCH = 268,                  /* SWITCH  */
    CASE = 269,                    /* CASE  */
    BRK = 270,                     /* BRK  */
    DUT = 271,                     /* DUT  */
    TRY = 272,                     /* TRY  */
    CATCH = 273,                   /* CATCH  */
    IDTF = 274,                    /* IDTF  */
    PLUS = 275,                    /* PLUS  */
    MINUS = 276,                   /* MINUS  */
    MUL = 277,                     /* MUL  */
    DIV = 278,                     /* DIV  */
    MOD = 279,                     /* MOD  */
    ASSIGN = 280,                  /* ASSIGN  */
    EQUAL = 281,                   /* EQUAL  */
    NOEQUAL = 282,                 /* NOEQUAL  */
    LESSTHAN = 283,                /* LESSTHAN  */
    GREATERTHAN = 284,             /* GREATERTHAN  */
    LESSEQUAL = 285,               /* LESSEQUAL  */
    GREATEREQUAL = 286,            /* GREATEREQUAL  */
    LEFTKEY = 287,                 /* LEFTKEY  */
    RIGHTKEY = 288,                /* RIGHTKEY  */
    LEFTPAREN = 289,               /* LEFTPAREN  */
    RIGHTPAREN = 290,              /* RIGHTPAREN  */
    POINTCOMMA = 291,              /* POINTCOMMA  */
    COMMA = 292,                   /* COMMA  */
    AND = 293,                     /* AND  */
    NEG = 294,                     /* NEG  */
    OR = 295,                      /* OR  */
    DO = 296,                      /* DO  */
    VARBOO = 297,                  /* VARBOO  */
    VARDEC = 298,                  /* VARDEC  */
    VARENT = 299,                  /* VARENT  */
    VARTEXT = 300,                 /* VARTEXT  */
    NUMENT = 301,                  /* NUMENT  */
    NUMDEC = 302,                  /* NUMDEC  */
    TEXT = 303,                    /* TEXT  */
    IN = 304,                      /* IN  */
    FL = 305,                      /* FL  */
    BO = 306                       /* BO  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 109 "sintactico.y"

    int numentero;   
    float numdecimal; 
    char *texto; 

#line 121 "sintactico.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SINTACTICO_TAB_H_INCLUDED  */
