%{
	#include <stdlib.h>
%}
true 	[t][r][u][e]
false 	[f][a][l][s][e]
not 	[n][o][t]
and 	[a][n][d]
or 		[o][r]
%%
[ \t]		; { /* Espacios en blanco */ }
[\n ()]		return yytext[0];
{true} 		{ 
				yylval = 1;
				return TRUE;
			}
{false} 	{ 
				yylval = 0;
				return FALSE; 
			}
{not} 			return NOT;
{and}			return AND;
{or}			return OR;
.			printf("Error lexico\n");
%%
int yywrap(void)
{
	return 1;
}