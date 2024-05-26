#ifndef __EXPR_LEXER_HPP__
#define __EXPR_LEXER_HPP__

#include <variant>
#include <iosfwd>
#include <string>
#include "ExprParserImpl.hpp"

using ParserValueType = std::variant<std::string, double, char, bool>;

class ExprLexer
{
public:
    using yyscan_t = void*;

public:
    ExprLexer(std::istream& _in);
    ~ExprLexer();

    int nextToken(ParserValueType *lval)
    { return nextTokenHelper(yyscanner, lval); }

    std::string text() const;

    static const char *tokenString(int tk);

private:
    int nextTokenHelper(yyscan_t yyscanner, ParserValueType *lval);

private:
    std::istream& in;
    yyscan_t yyscanner;
};

#endif
