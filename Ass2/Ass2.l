%{
#include <iostream>
#include <fstream>
using namespace std;
ofstream outputfile;

%}

%%
[ \t\n] ; 
[0-9]+ {
    outputfile<<"TOKEN : " <<yytext;
}

[A-Za-z][A-Za-z0-9]* {
    char upperCaseText[1024];
    int i;
    for (i = 0; i < yyleng; i++) {
        upperCaseText[i] = toupper(yytext[i]);
    }
    upperCaseText[i] = '\0';

    if (strcmp(upperCaseText, "SELECT") == 0) {
         outputfile<<"KEYWORD: SELECT\n";

    } else if (strcmp(upperCaseText, "FROM") == 0) {
       outputfile<<"KEYWORD: FROM\n" ;
    } else if (strcmp(upperCaseText, "WHERE") == 0) {
        outputfile<<"KEYWORD: WHERE\n" ;
    } else {
        outputfile<<"IDENTIFIER : " <<upperCaseText;
    }
}

. {
      outputfile<<"Word : " <<yytext;
}

%%


int yywrap(){return 1;}
int main(int, char**){
yyin=fopen("input.txt","r");
yyout= fopen("outError.txt","w");
outputfile.open("out.txt");
while(yylex()>0){}

fclose(yyin);
fclose(yyout);

}