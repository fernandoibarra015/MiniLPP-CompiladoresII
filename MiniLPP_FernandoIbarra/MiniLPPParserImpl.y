%define parse.error verbose
%define api.pure full

%parse-param { MiniLPPParser& parse }

%code requires
{
    #include <string>
    #include "MiniLPPAst.hpp"

    class MiniLPPParser;

    using ParserValueType = AstNode *;

    #define YYSTYPE ParserValueType
    #define YYSTYPE_IS_DECLARED 1
}

%code top
{
    #include "MiniLPPLexer.hpp"
    #include "MiniLPPParser.hpp"
    #include <iostream>
    #include <stdexcept>
    #include "MiniLPPAst.hpp"

    #define yylex(v) static_cast<int>(parse.getLexer().nextToken(v))

    void yyerror(const MiniLPPParser& parse, const char *msg)
    {
        std::string agregado = " at the line ";
        std::string msgcompleto  = msg + agregado + std::to_string(parse.getLexer().line());

        throw std::runtime_error(msgcompleto.c_str());
    }
}

%token Array "Arreglo"
%token As "Como"
%token Add "+"
%token And "y"
%token Pointer "<-"
%token Boolean_type "Booleano"
%token Call "llamar"
%token Case "caso"
%token Character "Caracter"
%token Comma ","
%token Colon ":"
%token Div "div"
%token Do "Haga"
%token Else "Sino"
%token ElseIf "Sino Si"
%token End "Fin"
%token Equal "="
%token False "Falso"
%token For "Para"
%token Function "Funcion"
%token GreaterThan ">"
%token GreaterThanOrEqual ">="
%token Caret "^"
%token Identifier "Identifier"
%token If "Si"
%token Integer "Entero"
%token Is "es"
%token LessThan "<"
%token LessThanOrEqual "<="
%token Mod "mod"
%token Multiply "*"
%token Not "no"
%token Number "Number"
%token Of "De"
%token OpenBracket "["
%token OpenParenthesis "("
%token Or "o"
%token Procedure "Procedimiento"
%token Read "Lea"
%token Record "Registro"
%token Repeat "Repita"
%token Return "Retorne"
%token Sequential "Secuencial"
%token Start "inicio"
%token String "Cadena"
%token Subtract "-"
%token Semicolon ";"
%token Text "Text"
%token CharT "CharT"
%token Then "Entonces"
%token True "Verdadero"
%token Type "Tipo"
%token Until "hasta"
%token Var "Var"
%token While "Mientras"
%token Write "Escriba"
%token CloseBracket "]"
%token CloseParenthesis ")"
%token Real "Real"
%token NotEqual "<>"

%%

input: program { parse.setRoot($1); }
;

program: subtypes-section variable-section subprogram-decl inicio { $$ = new Program($2,$3,$4); }
;

iif_stmt: If expr Then stmts ElseIf iif_stmt_con { $$ = new If_Stmt($2,$4,$6); }
        | If expr Then stmts Else stmts End If { $$ = new If_Stmt($2,$4,$6); }
        | If expr Then stmts End If { $$ = new If_Stmt($2,$4,new Null_()); }
;

iif_stmt_con: expr Then stmts ElseIf iif_stmt_con { $$ = new If_Stmt($1,$3,$5); }
            | expr Then stmts Else stmts End If { $$ = new If_Stmt($1,$3,$5); }
            | expr Then stmts End If { $$ = new If_Stmt($1,$3,new Null_()); }
;

assing_stmt: asignar Pointer values { $$ = new Assing_stmt((IdentExpr*)$1,$3); }
;

type: Integer { $$ = new IdentExpr("Entero"); }
    | Real { $$ = new IdentExpr("Real"); }
    | Text
    | Boolean_type { $$ = new IdentExpr("Booleano"); }
    | Character { $$ = new IdentExpr("Caracter"); }
;

Procedieminto_Stmt: Procedure Identifier params variable-section Start stmts End
;

subtypes-section: subtypes-section Type Identifier Is type-subtypIs
                | Type Identifier Is type-subtypIs { }
                | 
;

repeat_stmt: Repeat stmts Do expr
;

stmts: stmts stmt { $$ = new BlockStmts($1,$2); }
    | stmt { $$ = $1; }
;

call_stmt: Call call_function
;

inicio: Start stmts End { $$ = $2; }
;

variable-section: Types_variables { $$ = $1; }
                | variable-section Types_variables { $$ = new Vars_decl($1,$2); }
                | { $$ = new Null_(); }
;

for_stmt: For asignar Pointer expr Until expr Do stmts End For { $$ = new For_stmt(new Assing_stmt((IdentExpr*)$2,$3),(Expr*)$6,$8 ); }
;

read_stmt: Read asignar { $$ = new Null_(); }
;

params_con: values
          | params_con Comma values
;

write_stmt: Write Write_list { $$ = new Write_stmt($2); }
;

subprogram-decl: subprogram-decl stms_f_p
              | stms_f_p
              | %empty { $$ = new Null_(); }
;

values: expr { $$ = $1; }
      | True { $$ = new Boolean_Expr(1); }
      | False { $$ = new Boolean_Expr(0); }
      | CharT { $$ = $1; }
      | Text { $$ = $1; }
;

more_iden: more_iden Comma Identifier { $$ = new Vars_decl($1,$3); parse.Add_var_type("anterior", ((IdentExpr*)($3))->text); }
         | Comma Identifier { $$ = $2; parse.Add_var_type("anterior", ((IdentExpr*)($2))->text); }
         | { $$ = new Null_(); }
;

expr: expr Add term { $$ = new Add_Expr((Expr*)$1,(Expr*)$3); }
    | expr Subtract term { $$ = new Sub_Expr((Expr*)$1,(Expr*)$3); }
    | term { $$ = $1; }
;

Types_variables: Array OpenBracket Number CloseBracket Of type Identifier
               | type Identifier more_iden { $$ = new Vars_decl($2,$3); parse.Add_var_type(((IdentExpr*)($1))->text, ((IdentExpr*)($2))->text); }
               | Identifier Identifier { }
;

type-subtypIs: Array OpenBracket Number CloseBracket Of type
             | type
;

stmt: assing_stmt { $$ = $1; }
    | write_stmt { $$ = $1; }
    | for_stmt { $$ = $1; }
    | retorne_stmt { $$ = $1; }
    | call_stmt { $$ = $1; }
    | while_stmt { $$ = $1; }
    | repeat_stmt { $$ = $1; }
    | read_stmt { $$ = $1; }
    | iif_stmt { $$ = $1; }
    | %empty { $$ = new Null_(); }
;

while_stmt: While expr Do stmts End While { $$ = new While_stmt($2,$4); }
;

retorne_stmt: Return values
;

params: OpenParenthesis decl_var_Function CloseParenthesis
      | %empty
;

Funcion_Stmt: Function Identifier params Colon type variable-section Start stmts End
;

asignar: Identifier { $$ = $1; }
      | Call_Array
;

decl_var_Function: decl_var_Function Comma TypIs_paramettros
                | TypIs_paramettros
;

stms_f_p: Funcion_Stmt
        | Procedieminto_Stmt
;

TypIs_paramettros: Var Array OpenBracket Number CloseBracket Of type Identifier
                 | Var type Identifier
                 | Var Identifier Identifier
                 | Identifier Identifier
                 | type Identifier
                 | Array OpenBracket Number CloseBracket Of type Identifier
;

Call_Array: Identifier OpenBracket expr CloseBracket { }
;

asignar: Identifier { $$ = $1; }
      | Call_Array
;

term: term Multiply factor { $$ = new Mul_Expr((Expr*)$1,(Expr*)$3); }
    | term Div factor { $$ = new Div_Expr((Expr*)$1,(Expr*)$3); }
    | term Mod factor { $$ = new Mod_Expr((Expr*)$1,(Expr*)$3); }
    | term GreaterThan factor { $$ = new GreaterThan_Expr((Expr*)$1,(Expr*)$3); }
    | term LessThan factor { $$ = new LessThan_Expr((Expr*)$1,(Expr*)$3); }
    | term GreaterThanOrEqual factor { $$ = new GreaterThanOrEqual_Expr((Expr*)$1,(Expr*)$3); }
    | term LessThanOrEqual factor { $$ = new LessThanOrEqual_Expr((Expr*)$1,(Expr*)$3); }
    | term NotEqual factor { $$ = new NoEqual_Expr((Expr*)$1,(Expr*)$3); }
    | term Caret factor
    | term Or factor { $$ = new Or_Expr((Expr*)$1,(Expr*)$3); }
    | term And factor { $$ = new And_Expr((Expr*)$1,(Expr*)$3); }
    | term Equal factor { $$ = new Equal_Expr((Expr*)$1,(Expr*)$3); }
    | factor { $$ = $1; }
;

params2: OpenParenthesis params_con CloseParenthesis
      | OpenParenthesis CloseParenthesis
      | %empty
;

factor: Identifier { $$ = $1; }
      | OpenParenthesis expr CloseParenthesis
      | Number { $$ = $1; }
      | True { $$ = new Boolean_Expr(1); }
      | Identifier { $$ = $1; }
      | False { $$ = new Boolean_Expr(0); }
      | Call_Array
      | Not Identifier { }
;

call_function: Identifier params2
;

params_con: values
          | params_con Comma values
;

Write_list: Write_list Comma values
          | values { $$ = $1; }
;
