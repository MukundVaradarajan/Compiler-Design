#include "y.tab.h"

%%

[\t\n] ;
if return IF;

else return ELSE;

. return yytext[0];

%%
