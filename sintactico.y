%{
#include <stdio.h>
extern int yylex(void);
extern char *yytext;
extern int yylineno;
void yyerror(char *s);
extern FILE *yyin;

#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 900

typedef enum { IN, FL, ST, BO } DataType;

typedef struct {
    char *name;
    DataType type;  
    union {
        int intValue;
        float floatValue;
        char *stringValue;
        int boolValue;  
    } value;
} Symbol;

Symbol symbolTable[MAX_SYMBOLS];
int symbolCount = 0;

void addSymbol(char *name, DataType type) {
    for (int i = 0; i < symbolCount; ++i) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            printf("Error: El símbolo '%s' ya está definido.\n", name);
            return;
        }
    }
    if (symbolCount >= MAX_SYMBOLS) {
        printf("Error: Se ha alcanzado el límite máximo de símbolos.\n");
        return;
    }

    symbolTable[symbolCount].name = strdup(name);
    symbolTable[symbolCount].type = type;

    switch (type) {
        case IN:
            symbolTable[symbolCount].value.intValue = 0;
            break;
        case FL:
            symbolTable[symbolCount].value.floatValue = 0.0f;
            break;
        case ST:
            symbolTable[symbolCount].value.stringValue = NULL;
            break;
        case BO:
            symbolTable[symbolCount].value.boolValue = 0;
            break;
    }
    symbolCount++;
}

void *getSymbolValue(char *name, DataType *type) {
    for (int i = 0; i < symbolCount; ++i) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            *type = symbolTable[i].type;
            switch (*type) {
                case IN:
                    return &symbolTable[i].value.intValue;
                case FL:
                    return &symbolTable[i].value.floatValue;
                case ST:
                    return symbolTable[i].value.stringValue;
                case BO:
                    return &symbolTable[i].value.boolValue;
            }
        }
    }
    printf("Error: El símbolo '%s' no está definido.\n", name);
    return NULL;
}

const char* tipoToString(DataType tipo) {
    switch (tipo) {
        case IN: return "entero";
        case FL: return "flotante";
        case ST: return "texto";
        case BO: return "booleano";
        default: return "desconocido";
    }
}

void setIntValue(char *name, int value) {
    DataType type;
    int *valPtr = getSymbolValue(name, &type);
    if (valPtr != NULL) {
        if (type == IN) {
            *valPtr = value;
        } else {
            printf("Error en línea %d: Asignación incorrecta de tipo '%s' a '%s' (se esperaba tipo entero).\n", yylineno, tipoToString(type), name);
        }
    } else {
        printf("Error en línea %d: El símbolo '%s' no está definido.\n", yylineno, name);
    }
}

// Similar para setFloatValue, setStringValue, setBooleanValue
%}

%union {
    int numentero;   
    float numdecimal; 
    char *texto; 
}

%token BOOL TRUE FALSE VAR IF ELSE WHILE FOR RETURN VOID SWITCH CASE BRK DUT TRY CATCH IDTF PLUS MINUS MUL DIV MOD ASSIGN EQUAL NOEQUAL LESSTHAN GREATERTHAN LESSEQUAL GREATEREQUAL LEFTKEY RIGHTKEY LEFTPAREN RIGHTPAREN POINTCOMMA COMMA AND NEG OR DO VARBOO VARDEC VARENT VARTEXT
%token <numentero> NUMENT
%token <numdecimal> NUMDEC  
%token <texto*> TEXT
%token IN FL BO

%left OR
%left AND
%left EQUAL NOEQUAL
%left LESSTHAN GREATERTHAN LESSEQUAL GREATEREQUAL
%left PLUS MINUS
%left MUL DIV MOD
%left NEG

%%

program:
    declaration
    | initialization
    | expresion
    | expresion_comp
    | funcion
    | program declaration
    | program initialization
    | program expresion
    | program expresion_comp
    | program funcion
    ;

declaration:
    VARDEC IDTF POINTCOMMA                   	 
    | VARENT IDTF POINTCOMMA                   	 
    | VARBOO IDTF POINTCOMMA                   	 
    | VARTEXT IDTF POINTCOMMA                   	 
    ;

initialization:
    VARTEXT IDTF ASSIGN TEXT POINTCOMMA
    | VARDEC IDTF ASSIGN NUMDEC POINTCOMMA
    | VARENT IDTF ASSIGN NUMENT POINTCOMMA
    | VARBOO IDTF ASSIGN BOOL POINTCOMMA
    ;

expresion:
    LEFTPAREN expresion RIGHTPAREN
    | NUMENT                                    	 
    | NUMDEC                                    	 
    | TEXT                                      	 
    | expresion PLUS expresion
    | expresion MINUS expresion
    | expresion MUL expresion
    | expresion DIV expresion
    ;

expresion_comp:
    expresion AND expresion
    | expresion OR expresion
    | NEG LEFTPAREN expresion RIGHTPAREN
    | NOEQUAL LEFTPAREN expresion RIGHTPAREN AND expresion
    | expresion AND NOEQUAL LEFTPAREN expresion RIGHTPAREN
    | NOEQUAL LEFTPAREN expresion RIGHTPAREN OR expresion
    | expresion OR NOEQUAL LEFTPAREN expresion RIGHTPAREN
    ;

funcion:
  VARDEC IDTF LEFTPAREN lista_parametros RIGHTPAREN bloque_funcion 
  | VARENT IDTF LEFTPAREN lista_parametros RIGHTPAREN bloque_funcion 
  | VARBOO IDTF LEFTPAREN lista_parametros RIGHTPAREN bloque_funcion 
  | VARTEXT IDTF LEFTPAREN lista_parametros RIGHTPAREN bloque_funcion 
  | VARDEC IDTF LEFTPAREN lista_parametros RIGHTPAREN RETURN expresion POINTCOMMA
  | VARENT IDTF LEFTPAREN lista_parametros RIGHTPAREN RETURN expresion POINTCOMMA
  | VARBOO IDTF LEFTPAREN lista_parametros RIGHTPAREN RETURN expresion POINTCOMMA
  | VARTEXT IDTF LEFTPAREN lista_parametros RIGHTPAREN RETURN expresion POINTCOMMA
  ;

lista_parametros:
  /* lista de parametros vacía */
  | parametro
	| parametro COMMA lista_parametros
	;

parametro:
    VARENT IDTF 
    | VARDEC IDTF 
    | VARTEXT IDTF
    | VARBOO IDTF  
    | VARENT IDTF ASSIGN NUMENT
    | VARDEC IDTF ASSIGN NUMDEC;  
    | VARTEXT IDTF ASSIGN VARTEXT;  
    | VARBOO IDTF ASSIGN VARBOO;  
    ;  
 

bloque_funcion:
  	LEFTKEY sentencia RIGHTKEY  
	;

sentencia:
  	expresion POINTCOMMA           
	| IF LEFTPAREN expresion RIGHTPAREN bloque_funcion ELSE bloque_funcion 
	| IF LEFTPAREN expresion RIGHTPAREN bloque_funcion 
	| WHILE LEFTPAREN expresion_comp RIGHTPAREN bloque_funcion 
	| WHILE LEFTPAREN expresion RIGHTPAREN bloque_funcion 
	| FOR LEFTPAREN NUMENT ASSIGN IDTF COMMA expresion COMMA for_asignation RIGHTPAREN bloque_funcion 
	| RETURN expresion POINTCOMMA  	
	| BRK POINTCOMMA            
  | SWITCH LEFTPAREN IDTF RIGHTPAREN LEFTKEY lista_casos RIGHTKEY  	
	| TRY bloque_funcion CATCH bloque_funcion
  | FUNCALL POINTCOMMA
  | funcion
  | DO bloque_funcion WHILE LEFTPAREN expresion RIGHTPAREN POINTCOMMA
	;

for_asignation:			
    IDTF PLUS PLUS
    | IDTF MINUS MINUS
    ;

lista_casos:
      caso
    | lista_casos caso;

caso:
      CASE expresion POINTCOMMA bloque_funcion BRK POINTCOMMA
    | DUT bloque_funcion;

FUNCALL:
    IDTF LEFTPAREN lista_argumentos RIGHTPAREN;

lista_argumentos:
    expresion
  | lista_argumentos COMMA expresion;

%%

/* Funciones auxiliares para la gestión de errores y la salida */
void yyerror(char *s) {
	 fprintf(stderr, "Error sintáctico en línea %d: %s\n", yylineno, s);
}

int main(int argc, char **argv){
	printf("Inicio del programa: \n");
	if(argc > 1){
    	yyin = fopen(argv[1], "rt");
	}else{
    	yyin = stdin;
	}
	yyparse();
	return 0;
}
