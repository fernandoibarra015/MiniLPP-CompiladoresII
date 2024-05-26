%option noyywrap
%option reentrant
%option yylineno
%option extra-type = "std::istream *"

%{
#include <variant>
#include <iostream>
#include <cstdlib>
#include "ExprLexer.hpp"
#include "ExprParserImpl.hpp"

#define YY_DECL int ExprLexer::nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval)
#define yyterminate() return 0

#define YY_INPUT(buf, result, max_size) \
    { \
        auto *in = yyget_extra(yyscanner); \
        in->read(buf, max_size); \
        result = in->gcount(); \
    }
%}

%x comment

%%
[ \t\n]                     {  }
"//"[^\n]*\n                { }
"/*"                        { BEGIN(comment); }
"Entero"                    { return Entero; }
"Inicio"                    { return Inicio; }
"Fin"                       { return Fin; }
"Escriba"                   { return Escriba; }
"<-"                        { return AssignArrow; }
"+"                         { return OpAdd; }
"*"                         { return OpMult; }
"("                         { return OpenPar; }
")"                         { return ClosePar; }
"["                         { return OpenBracket; }
"]"                         { return CloseBracket; }
"<"                         { return LessThan; }
">"                         { return GreaterThan; }
"<="                        { return LessEqual; }
">="                        { return GreaterEqual; }
"=="                        { return Equal; }
"!="                        { return NotEqual; }
"&&"                        { return And; }
"\|\|"                      { return Or; }
"!"                         { return Not; }
"="                         { return Assign; }
";"                         { return Semicolon; }
"true"                      { *lval = true; return True; }
"false"                     { *lval = false; return False; }
"para"                      { return Para; }
"mientras"                  { return Mientras; }
"print"                     { return Print; }
[0-9]+(\.[0-9]+)?           { *lval = std::atof(yytext); return Number; }
\'[a-zA-Z0-9]\'             { *lval = yytext[1]; return Char; }
\"[^\"]*\"                  { *lval = std::string(yytext + 1, yyleng - 2); return String; }
[a-zA-Z_][a-zA-Z0-9_]*      { *lval = std::string(yytext); return Ident; }
.                           { std::cerr << "Invalid symbol: " << yytext[0] << '\n'; return Error; }

<comment>"*/"               { BEGIN(INITIAL); }
<comment>.|\n               { /* Nothing */ }
<comment><<EOF>>            { std::cerr << "Warning: Block comment without close\n";  }
%%
