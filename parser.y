%{
#include<stdio.h>
#include<stdlib.h>

extern int yylex();
int yyerror(const char* s);

int max_depth = 1;
int cur_depth = 1;
extern FILE* yyin;
%}

%token IF ELIF ELSE OFB CFB

%%

condExpr: ifExpr			{ max_depth = max_depth < cur_depth ? cur_depth : max_depth; cur_depth = 1; }
	;

ifExpr: IF OFB ifExpr CFB elExpr	{ cur_depth++; }
      | IF OFB CFB elExpr
      | IF elExpr
      ;

elExpr: elifExpr elseExpr
      ;
	  
elifExpr: elifExpr ELIF OFB ifExpr CFB	{ cur_depth++; max_depth = max_depth<cur_depth ? cur_depth : max_depth; cur_depth = 1; }
	| elifExpr ELIF OFB CFB
	| elifExpr ELIF
	| 
	;
		
elseExpr: ELSE OFB ifExpr CFB	{ cur_depth++; max_depth = max_depth < cur_depth ? cur_depth : max_depth; cur_depth = 1; }
	| ELSE OFB CFB
	| ELSE
	|
	;	  

%%

int yyerror(const char* s){
	printf("Parsing error. Check input.\n");
	return 0;
}

int main(int argc, char** argv){
	yyin = fopen(argv[1], "r");
	if(yyin){
		yyparse();
		fclose(yyin);
		printf("Parsing successful. No errors found.\nMaximum nesting depth is: %d\n",max_depth);
	}
	else
		printf("Error in opening file.\n");
	return 0;
}
