#ifndef __MINI_LPP__PARSE_HPP__
#define __MINI_LPP__PARSE_HPP__


#include "MiniLPPLexer.hpp"
#include "MiniLPPParserImpl.hpp"
#include "MiniLPPAst.hpp"
#include <string>
#include <iostream>
#include <fstream>
#include <string>

class MiniLPPParser
{
private:
   MiniLPPLexer& lexer;
   AstNode* ast;
   Types_vars types_ide;
public:
    MiniLPPParser(MiniLPPLexer& lexer): lexer(lexer){};

    int parse();


    MiniLPPLexer& getLexer() const
    {
        return lexer;
    }

    void setRoot(AstNode* root)
    {
        ast = root;
        
    }

    AstNode* getRoot() const
    {
        return ast;
    }


    
    void Add_var_type(std::string tipos, std::string variable)
    {
        bool encontrado = false;
        for (const auto& var : types_ide) {
            if (var.vars_ebp == variable) {
                encontrado = true;
                std::string msgcompleto = "Error: Variable declarada previamente " + variable;
                throw std::runtime_error(msgcompleto.c_str());\
                break;
            }
        }
        int posicion = 0;

        if(tipos == "anterior")
        {
            if (!encontrado) {
                

                types_ide.push_back({"siguiente", variable});
                
            }

        }else {
            if (!encontrado) {
                
                types_ide.push_back({tipos, variable});
                
            }
        }
            
    };

    Types_vars& getVector()
    {
        std::vector<int> posiciones;
        std::string tipoAn ;
        for (int i = 0; i < types_ide.size(); i++) {
            
            if(types_ide[i].type == "siguiente")
            {
                posiciones.push_back(i);
            }else
            {
                tipoAn = types_ide[i].type;
                for(int j = 0; j < posiciones.size(); j++)
                {
                    types_ide[posiciones[j]].type = tipoAn;
                }
                posiciones.clear();
                tipoAn = "";
            }
          
        }
        
        return types_ide;
    }

};

#endif