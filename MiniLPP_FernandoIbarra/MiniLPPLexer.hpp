#ifndef __MINILPPLEXER_HPP__
#define __MINILPPLEXER_HPP__

#include <iosfwd>
#include <string>
#include <unordered_map>
#include <vector>
#include <variant>
#include "MiniLPPAst.hpp"


enum class Token: int {
    Eof = 0,
    Error = 256,
    Undef = 257,

    Array = 258,
    As = 259,
    Add = 260,
    And = 261,
    Pointer = 262,
    Boolean_type = 263,
    Call = 264,
    Case = 265,
    Character = 266,
    Comma = 267,
    Colon = 268,
    Div = 269,
    Do =    270,
    Else = 271,
    ElseIf = 272,
    End = 273,
    Equal = 274,
    False = 275,
    For = 276,
    Function = 277,
    GreaterThan = 278,
    GreaterThanOrEqual = 279,
    Caret = 280,
    Identifier = 281,
    If = 282,
    Integer = 283,
    Is = 284,
    LessThan = 285,
    LessThanOrEqual = 286,
    Mod = 287,
    Multiply = 288,
    Not = 289,
    Number = 290,
    Of = 291,
    OpenBracket = 292,
    OpenParenthesis = 293,
    Or =    294,
    Procedure = 295,
    Read = 296,
    Record = 297,
    Repeat = 298,
    Return = 299,
    Sequential = 300,
    Start = 301,
    String = 302,
    Subtract = 303,
    Semicolon = 304,
    Text = 305,
    CharT = 306,
    Then = 307,
    True =  308,
    Type = 309,
    Until = 310,
    Var = 311,
    While = 312,
    Write = 313,
    CloseBracket = 314,
    CloseParenthesis = 315,
    Real = 316,
    NotEqual = 317,

};


class MiniLPPLexer
{
    public:
        using yyscan_t = void*;
        using ParserValueType = AstNode *;
        
    public:
        MiniLPPLexer(std::istream& _in);
        ~MiniLPPLexer();

        Token nextToken(ParserValueType *lval)
        { return nextTokenHelper(yyscanner, lval); }

        const int line() const;
        std::string text() const;
    
    private:
        Token nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval);
        std::istream& in;
        yyscan_t yyscanner;
};

#endif