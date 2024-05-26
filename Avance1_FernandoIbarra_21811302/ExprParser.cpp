#include <unordered_map>
#include "ExprParser.hpp"

int ExprParser::parse()
{
    return yyparse(*this);
}

double ExprParser::constValue(const std::string& cname) const
{
    static std::unordered_map<std::string, double> cmap = {
        {"Pi", 3.14159}, 
        {"Tau", 6.28319}, 
        {"SrTwo", 1.41421}, 
        {"SrThree", 1.73205}, 
        {"Phi", 1.61803}, 
        {"E", 2.71828}, 
    };

    auto it = cmap.find(cname);
    return (it == cmap.end())? 0.0 : it->second;
}