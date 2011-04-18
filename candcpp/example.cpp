// =====================================================================================
// 
//       Filename:  example.cpp
// 
//    Description:  Testing Boost
// 
//        Version:  1.0
//        Created:  Sunday 03 May 2009 07:19:51  IST
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Amit Pundir (amit_pundir), sonupundir@gmail.com
//        Company:  
// 
// =====================================================================================
#include <boost/regex.hpp>
#include <iostream>
#include <string>

int main()
{
    std::string line;
    boost::regex pat( "^Subject: (Re: |Aw: )*(.*)" );

    while (std::cin)
    {
        std::getline(std::cin, line);
        boost::smatch matches;
        if (boost::regex_match(line, matches, pat))
            std::cout << matches[2] << std::endl;
    }
}

