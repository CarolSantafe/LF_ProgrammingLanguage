%{
#include "sintactico.tab.h"
%}

/* Definición de patrones para los tokens */
identificador [a-zA-Z_][a-zA-Z0-9_]*  
numentero	-?[0-9]+
numdecimal   -?[0-9]+\.[0-9]+
texto    	\"[^\"]*\"

%%

"booleano"    	{ return BOOL; }
"cierto"      	{ return TRUE; }
"nulo"        	{ return FALSE; }
"variable"    	{ return VAR; }
"sicumple"    	{ return IF; }
"sinoque"     	{ return ELSE; }
"mientrasque" 	{ return WHILE; }
"repita"      	{ return FOR; }
"devuelve"    	{ return RETURN; }
"nada"        	{ return VOID; }
"escojaOpcion" 	{ return SWITCH; }
"opcion"      	{ return CASE; }
"romper"      	{ return BRK; }
"efecto"      	{ return DUT; }
"intente"     	{ return TRY; }
"atrape"      	{ return CATCH; }
"haga"      	{ return DO; }
"varNumEnt"    	{ return VARENT; }
"varNumDec"    	{ return VARDEC; }
"varTexto"    	{ return VARTEXT; }
"varBoleean"   	{ return VARBOO; }

{numentero}   	{ return NUMENT; }
{numdecimal}  	{ return NUMDEC; }
{texto}       	{ return TEXT; }
{identificador}   { return IDTF; }

"+"           	{ return PLUS; }
"-"           	{ return MINUS; }
"*"           	{ return MUL; }
"/"           	{ return DIV; }
"%"           	{ return MOD; }
"="           	{ return ASSIGN; }
"=="          	{ return EQUAL; }
"!="          	{ return NOEQUAL; }
"<"           	{ return LESSTHAN; }
">"           	{ return GREATERTHAN; }
"<="          	{ return LESSEQUAL; }
">="          	{ return GREATEREQUAL; }
"{"           	{ return LEFTKEY; }
"}"           	{ return RIGHTKEY; }
"("           	{ return LEFTPAREN; }
")"           	{ return RIGHTPAREN; }
";"           	{ return POINTCOMMA; }
","           	{ return COMMA; }
"&&"          	{ return AND; }
"!"           	{ return NEG; }
"||"          	{ return OR; }

[ \t\n]       	{ /* Ignorar espacios y saltos de línea */ }
"//".*        	{ /* Ignorar comentarios de una línea */ }
.             	{ printf("Error léxico: %s\n", yytext); }

%%

/** Sección de código de usuario **/
int yywrap() {
	return 1;
}
