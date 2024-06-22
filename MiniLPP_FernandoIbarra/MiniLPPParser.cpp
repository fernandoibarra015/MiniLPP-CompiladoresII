#include "MiniLPPParser.hpp"


int MiniLPPParser::parse()
{

    return yyparse(*this);
}
