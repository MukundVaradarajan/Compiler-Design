%{
#include<stdio.h>
#include<stdlib.h>
%}

%token IF ELIF ELSE OFB CFB ORB CRB

%%

%%

int yyerror(char* s){
	printf("Error  in %s\n",s);
}

int main(){
	yyparse();
	return 0;
}
