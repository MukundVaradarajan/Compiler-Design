%{
#include "y.tab.h"
%}

%%

[\t\n] ;

"{" return OFB;

"}" return CFB;

if"(".*")" return IF;

"else if(".*")" return ELIF;

else return ELSE;

. ;

%%

int yywrap(){
	return 1;
}
