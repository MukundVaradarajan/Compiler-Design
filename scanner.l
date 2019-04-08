%{
#include "y.tab.h"
%}

%%

[\t\n] ;

"{".*"}" return BLOCK;

if"(".*")" return IF;

"else if(".*")" return ELIF;

else return ELSE;

. return yytext[0];

%%

int yywrap(){
	return 1;
}
