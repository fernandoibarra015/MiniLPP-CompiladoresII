%option noyywrap
%option reentrant
%option yylineno
%option case-insensitive
%option extra-type = "std::istream *"

%{
    #include <iostream>
    #include <cstdlib>
    #include <algorithm>
    #include <string>
    #include "MiniLPPLexer.hpp"
    #include "MiniLPPAst.hpp"

    #define YY_DECL Token MiniLPPLexer::nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval)
    #define yyterminate() return Token::Eof

    #define YY_INPUT(buf, result, max_size) \
    { \
        auto *in = yyget_extra(yyscanner); \
        in->read(buf, max_size); \
        result = in->gcount(); \
    }
%}

%x comment

%%

[ \t\n]               { /* Ignore whitespace */ }
"//"[^\n]*\n          { /* Ignore single-line comments */ }
"/*"                  { BEGIN(comment); }
[\r\n]                { /* Ignore newlines */ }

"Arreglo"             { return Token::Array; }
"Como"                { return Token::As; }
"+"                   { return Token::Add; }
"y"                   { return Token::And; }
"<-"                  { return Token::Pointer; }
"Booleano"            { return Token::Boolean_type; }
"Llamar"              { return Token::Call; }
"Caso"                { return Token::Case; }
"Caracter"            { return Token::Character; }
","                   { return Token::Comma; }
":"                   { return Token::Colon; }
"div"                 { return Token::Div; }
"Haga"                { return Token::Do; }
"Sino"                { return Token::Else; }
"Sino Si"             { return Token::ElseIf; }
"Fin"                 { return Token::End; }
"="                   { return Token::Equal; }
"Falso"               { return Token::False; }
"Para"                { return Token::For; }
"Funcion"             { return Token::Function; }
">"                   { return Token::GreaterThan; }
">="                  { return Token::GreaterThanOrEqual; }
"^"                   { return Token::Caret; }
"Si"                  { return Token::If; }
"Entero"              { return Token::Integer; }
"Es"                  { return Token::Is; }
"<"                   { return Token::LessThan; }
"<="                  { return Token::LessThanOrEqual; }
"mod"                 { return Token::Mod; }
"*"                   { return Token::Multiply; }
"no"                  { return Token::Not; }
"De"                  { return Token::Of; }
"["                   { return Token::OpenBracket; }
"("                   { return Token::OpenParenthesis; }
"o"                   { return Token::Or; }
"Procedimiento"       { return Token::Procedure; }
"Lea"                 { return Token::Read; }
"Registro"            { return Token::Record; }
"Repita"              { return Token::Repeat; }
"Retorne"             { return Token::Return; }
"Secuencial"          { return Token::Sequential; }
"Inicio"              { return Token::Start; }
"Cadena"              { return Token::String; }
"-"                   { return Token::Subtract; }
";"                   { return Token::Semicolon; }
"Entonces"            { return Token::Then; }
"Verdadero"           { return Token::True; }
"Tipo"                { return Token::Type; }
"Hasta"               { return Token::Until; }
"Var"                 { return Token::Var; }
"Mientras"            { return Token::While; }
"Escriba"             { return Token::Write; }
"Real"                { return Token::Real; }
"]"                   { return Token::CloseBracket; }
")"                   { return Token::CloseParenthesis; }
"<>"                  { return Token::NotEqual; }

\'[^\n]\' {
    std::string yytextxstring = std::string(yytext); 
    char result;
    for (char c : yytextxstring) {
        if (c != '\'') {
            result = c;
        }
    }
    *lval = new Char_Expr(result); 
    return Token::CharT; 
}
\"[0-9a-zA-Z_ ]*[^\n]*\" {
    std::string yytextxstring = std::string(yytext); 
    std::string result;
    for (char c : yytextxstring) {
        if (c != '"') {
            result += c;
        }
    }
    *lval = new Text_Expr(result);
    return Token::Text; 
}
[0-9]+ {
    *lval = new NumExpr(std::atof(yytext)); 
    return Token::Number; 
}
[a-zA-Z_][0-9a-zA-Z_]* {
    *lval = new IdentExpr(std::string(yytext));  
    return Token::Identifier; 
}

. {
    std::cerr << "Invalid symbol\n";
    std::cout << yytext;
    return Token::Error;
}

<comment>"*/" { BEGIN(INITIAL); }
<comment>.|\n { /* Ignore comment content */ }
<comment><<EOF>> {
    std::cerr << "Warning: Block comment without close\n";
}
%%
