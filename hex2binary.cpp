#include <iostream>
#include <fstream>
#include <sstream>
#include <bitset>
#include <string>

void hex2binary(unsigned int hex){
	std::ofstream out("out.txt");

    std::stringstream ss;
    ss << std::hex << hex;
    int n; ss >> n;
    std::bitset<32> b(n);
    // outputs "00000000000000000000000000001010"
    std::cout << b.to_string() << std::endl;
	out << b.to_string();

    out.close();
}
