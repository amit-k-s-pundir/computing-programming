// =====================================================================================
// 
//       Filename:  java_utils.cpp
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  Saturday 20 March 2010 04:29:47  IST
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Amit Pundir (amit_pundir), sonupundir@gmail.com
//        Company:  
//
// =====================================================================================

#include <iostream>;
#include <map>;
#include <string>;
#include <vector>;
#include <list>;
#include <initializer_list>

#include 

namespace java_utils{

        using namespace std;
        
        using boost::format;

        typedef map<string,string> str_str_map;
        typedef str_str_map::const_iterator map_iter;

        //  typedef vector<map<string,string>
        //
        const map<string,string>& default_attrs({{"name","ClassNameHolder"},
                        {"access","public"}, {"storage",""},{"javadoc","/**\n*/"},{"annot",""}};
                        class ClassDescriptor{
                        public:
                        ClassDescriptor(const map<string,string>& attrs = default_attrs, bool
                                unit_test_p = false, vector<string> superclasses =
                                default_superclasses, vector<string> interfaces =
                                default_interfaces):attrs(attrs),unit_test_p(unit_test_p),
                        superclasses(superclasses),interfaces
                        (interfaces){
                        };

                        private:
                        const map<string,string>& attrs;
                        //= {{"name", "ClassNameHolder"},{"access", "public"}, {"storage",
                        //  ""},{"javadoc","/**\n*/"},{"annot",""}};
                        bool unit_test_p;
                        vector<string> superclasses, interfaces;
                        };

                        class FieldDescriptor{
                                FieldDescriptor(const map<string,string>& field_attrs = default_field_attrs):
                                        field_attrs(default_field_attrs){
                                        };
                                const string& access, storage, type, name, val, annotation, javadoc;
                        };

                        class FunDescriptor{
                                FunDescriptor(const map<string,string>& fun_attrs = default_field_attrs,
                                                bool unit_test_p = false, const list<string> args = default_args)
                                        :fun_attrs(default_fun_attrs),{
                                        };
                                string access, storage, ret_type, type, annotation, javadoc;
                                bool unit_test_p;
                                list<string> args;
                        };

string& out;

class Fun{
        Fun(){};
        public:
        string operator()(const string& str){
                if(

string write_java_class(const ClassDescriptor& clsDsc, const vector<FieldDescriptor>&
                fieldDscs, const vector<FunDescriptor>& funDscs, string& out){
string out = 
        map<string,string>::const_iterator it = clsDsc.attrs.begin();

        while(it != clsDsc.attrs.end()){

  

  class val{
private:
  map<string,string> class_attrs;
  map<string,map<

			   }
  
}
  
