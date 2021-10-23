%{
	#include <ctype.h>
	#include <stdio.h>
	#define YYSTYPE double /* double type for Yacc stack */
	
	extern int yylex();
	void yyerror(char *msg);
%}

%token TRUE FALSE NOT OR AND

%%
lines	: lines bexpr '\n' { printf("%g\n", $2) ;}
		| lines '\n'
		| /* empty */
		;
		
bexpr	: bexpr OR bterm		{ $$ = ($1 == 1 || $3 == 1) ? 1 : 0}
		| bterm 				{ $$ = $1 };
	
bterm 	: bterm AND bfactor		{ $$ = ($1 == 1 && $3 == 1) ? 1 : 0}
		| bfactor				{ $$ = $1 };	
		
bfactor : NOT bfactor 			{ $$ = ($2 == 1) ? 0 : 1}
		| '(' bexpr ')' 		{$$ = $2 }
		| TRUE					
		| FALSE;
%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}