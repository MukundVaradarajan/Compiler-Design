%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
int max_depth = 0;
int cur_depth = 0;
extern FILE* yyin;
%}

%token IF ELIF ELSE OFB CFB

%%

condExpr: ifExpr						{ max_depth = max_depth < cur_depth ? cur_depth : max_depth; cur_depth = 0; }
		;

ifExpr: IF OFB ifExpr CFB elExpr		{ cur_depth++; }
	  | IF OFB CFB elExpr
	  | IF elExpr
	  | IF								
	  ;

elExpr: elifExpr elseExpr
	  ;
	  
elifExpr: elifExpr ELIF OFB ifExpr CFB	{ cur_depth++; max_depth = max_depth < cur_depth ? cur_depth : max_depth; cur_depth = 0; }
		| elifExpr ELIF OFB CFB
		| elifExpr ELIF
		| 
		;
		
elseExpr: ELSE OFB ifExpr CFB			{ cur_depth++; max_depth = max_depth < cur_depth ? cur_depth : max_depth; cur_depth = 0; }
		| ELSE OFB CFB
		| ELSE
		|
	  

%%

int yyerror(char* s){
	printf("Error  in %s\n",s);
}

int main(int argc, char** argv){
	yyin = fopen(argv[1], "r");
	if(yyin){
		yyparse();
		fclose(yyin);
	}
	else
		printf("Error in opening file.\n");
	return 0;
}
