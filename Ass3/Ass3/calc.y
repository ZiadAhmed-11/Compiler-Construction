%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *);
    int yylex(void);

    FILE *yyin;
    FILE *yyout;

    int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

program:
    program statement ';'
    | /* NULL */
    ;

statement:
    expression                      { fprintf(yyout, "%d\n", $1); }
    | VARIABLE '=' expression       { sym[$1] = $3; }
    ;

expression:
    INTEGER                         { $$ = $1; }
    | VARIABLE                      { $$ = sym[$1]; }
    | expression '+' expression     { $$ = $1 + $3; }
    | expression '-' expression     { $$ = $1 - $3; }
    | expression '*' expression     { $$ = $1 * $3; }
    | expression '/' expression {
        if ($3 == 0) {
            yyerror ("cannot divide by zero"); exit(0);
        }
        else
            $$ = $1 / $3; 
    }
    | '-' expression %prec UMINUS   { $$ = -$2;}
    | '(' expression ')'            { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    if (yyin == NULL || yyout == NULL) {
        perror("Error opening files");
        exit(EXIT_FAILURE);
    }

    yyparse();

    fclose(yyin);
    fclose(yyout);

    return 0;
}
