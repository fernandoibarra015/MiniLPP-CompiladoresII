#include <iostream>
#include <fstream>
#include "MiniLPPLexer.hpp"
#include "MiniLPPParser.hpp"
#include <unordered_map>



// Función para ejecutar un comando y capturar su salida
std::string runCmd(const std::string& cmd)
{
    FILE *stream = popen(cmd.c_str(), "r");
    if (stream == nullptr) {
        throw std::runtime_error("popen() failed!");
    }

    std::ostringstream ssdata;
    char buffer[256] = {0};

    while (fgets(buffer, sizeof(buffer) - 1, stream))
        ssdata << buffer;

    pclose(stream);
    return ssdata.str();
}



std::string runASM(std::string name_file ,std::string code)
{
        
        std::ofstream archivo;
        archivo.open(name_file, std::ios::out | std::ios::trunc);
        if (!archivo.is_open()) {
           throw std::runtime_error("Failed to open asm file for writing!");
        }
        archivo << code;
        archivo.close();

        std::string cmd = "../EasyASM-x86 --run "+ name_file + " 2>&1";

        
    std::cout<< "\n"<<runCmd(cmd);
        
};



int main(int argc, char *argv[]) 
{
    //std::cout<< argc;
    if (argc != 3) {
        std::cerr << "Not enough arguments\n";
        return 1;
    }
    
    std::string fileLPP = argv[1];
    std::string fileASM = argv[2];


    
    std::ifstream in(fileLPP, std::ios::in);
    if (!in.is_open()) {
        std::cerr << "Cannot open file\n";
        return 1;
    }

    MiniLPPLexer lexer(in);
    MiniLPPParser parser(lexer);
   
   try
   {
        parser.parse();

        std::string code = parser.getRoot()->GeneratorCode(parser.getVector());
        runASM(fileASM, code);
   }
   catch(const std::exception& e)
   {
        std::cerr << e.what() << '\n';
   }
   
}