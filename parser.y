%{
#include<stdio.h>
#include<stdlib.h>
%}

%token IF ELIF ELSE OFB CFB

%%

condExpr: ifExpr
		;

ifExpr: IF OFB ifExpr CFB elExpr
	  | IF OFB CFB elExpr
	  | IF elExpr
	  | IF
	  ;

elExpr: elifExpr elseExpr
	  | elseExpr
	  ;
	  
elifExpr: elifExpr ELIF OFB ifExpr CFB
		| elifExpr ELIF OFB CFB
		| elifExpr ELIF
		| 
		;
		
elseExpr: ELSE OFB ifExpr CFB
		| ELSE OFB CFB
		| ELSE
	  

%%

int yyerror(char* s){
	printf("Error  in %s\n",s);
}

int main(){
	yyparse();
	return 0;
}
