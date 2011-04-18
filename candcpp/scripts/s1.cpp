#include <iostream>
#include <fstream>
#include <string>

#include "boost/filesystem.hpp"

template<typename X> void create(X x);

template<typename X> void create<Project<TC::Design> >(Project<TC::Design> des_proj){
    setup_files_and_folders(des_proj);
    generate_templates(des_proj);
}

template<class ProjType> class Project{


    int main(int argc, char* argv[]){
        using namespace std;

        ofstream ofile("/home/sonu/workspace/projects/tc/assembly/test.txt", ios_base::out | ios_base::app);
        ofile << "Hello!" << endl;

        string base_working_path = "/home/sonu/workspace/projects/tc/assembly/";
        string proj_dir_name = "test-proj";
        boost::filesystem::path base_path(base_working_path + proj_dir_name);
        cout << base_path << endl;
        create<Project<TC::Design> >
            }
