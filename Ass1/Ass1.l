%{
#include <iostream>
#include <fstream>
using namespace std;
ofstream outputfile;
int chr=0;
int Lines=0;
string word="";
%}


%%
[a-zA-Z]+       {outputfile<<"Word :"<<yytext<<", Characters :"<<strlen(yytext)<<endl;}





%%
int yywrap(){ return 1;}  
int main(int, char**) {
  yyin = fopen( "in.txt", "r" );
  yyout = fopen( "outError.txt", "w" );
  outputfile.open ("out.txt");
  while (yylex()>0){}
  
  fclose(yyin);
  fclose(yyout);
}
