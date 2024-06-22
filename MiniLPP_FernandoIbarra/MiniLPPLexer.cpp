#include <fstream>
#include "MiniLPPLexer.hpp"
#include "MiniLPPLexerImpl.hpp"
#include <iostream>
#include <string>
#include <algorithm> 

MiniLPPLexer::MiniLPPLexer(std::istream& _in)
  : in(_in)
{
    yylex_init_extra(&in, &yyscanner);
}

MiniLPPLexer::~MiniLPPLexer()
{
    yylex_destroy(yyscanner);
}

std::string MiniLPPLexer::text() const
{
    return std::string(yyget_text(yyscanner));
}

const int MiniLPPLexer::line() const
{
    return yyget_lineno(yyscanner);
}

