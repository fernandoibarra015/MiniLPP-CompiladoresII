%define parse.error verbose
%define api.pure full

%parse-param {ExprParser& parser}

%code top {
#include <iostream>
#include <stdexcept>
#include "ExprLexer.hpp"
#include "ExprParser.hpp"
}

%code requires {
#include <string>
#include <variant>

class ExprParser; // Forward declaration

using ParserValueType = std::variant<std::string, double, char, bool>;

#define YYSTYPE ParserValueType
#define YYSTYPE_IS_DECLARED 1
}

%{
#include <variant>
using ParserValueType = std::variant<std::string, double, char, bool>;

#define yylex(v) static_cast<int>(parser.getLexer().nextToken(v))

void yyerror(const ExprParser& parser, const char *msg)
{
    throw std::runtime_error(msg);
}
%}

%token OpAdd "+"
%token OpMult "*"
%token OpenPar "("
%token ClosePar ")"
%token OpenBracket "["
%token CloseBracket "]"
%token LessThan "<"
%token GreaterThan ">"
%token LessEqual "<="
%token GreaterEqual ">="
%token Equal "=="
%token NotEqual "!="
%token And "&&"
%token Or "||"
%token Not "!"
%token Assign "="
%token Semicolon ";"
%token True "true"
%token False "false"
%token Para "para"
%token Mientras "mientras"
%token Print "print"
%token Number "number"
%token Char "char"
%token String "string"
%token Ident "identifier"
%token Entero "Entero"
%token Error "error"

%token Inicio "Inicio"
%token Fin "Fin"
%token Escriba "Escriba"
%token AssignArrow "<-"

%%

input: block { parser.setValue(std::get<double>($1)); }
;

block: Inicio stmt_list Fin { /* nothing */ }
     ;

stmt_list: stmt_list stmt { /* nothing */ }
         | stmt { /* nothing */ }
;

stmt: decl_stmt
    | assign_stmt
    | print_stmt
    | while_stmt
    | for_stmt
    | block
    ;

decl_stmt: Entero var_list Semicolon { /* nothing */ }
         ;

var_list: Ident { /* nothing */ }
        | var_list ',' Ident { /* nothing */ }
        ;

assign_stmt: Ident AssignArrow expr Semicolon { /* nothing */ }
           ;

print_stmt: Escriba expr Semicolon { std::cout << std::get<double>($2) << std::endl; }
          ;

while_stmt: Mientras OpenPar expr ClosePar stmt { /* nothing */ }
          ;

for_stmt: Para OpenPar expr Semicolon expr Semicolon expr ClosePar stmt { /* nothing */ }
        ;

expr: expr OpAdd term { $$ = std::get<double>($1) + std::get<double>($3); }
    | expr And term { $$ = std::get<bool>($1) && std::get<bool>($3); }
    | term { $$ = $1; }
;

term: term OpMult factor { $$ = std::get<double>($1) * std::get<double>($3); }
    | factor { $$ = $1; }
;

factor: OpenPar expr ClosePar { $$ = $2; }
      | Number { $$ = $1; }
      | Char { $$ = $1; }
      | True { $$ = $1; }
      | False { $$ = $1; }
      | Ident { $$ = parser.constValue(std::get<std::string>($1)); }
;

%%
