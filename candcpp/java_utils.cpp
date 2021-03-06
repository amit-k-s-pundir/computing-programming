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

namespace java_utils{
  
  using namespace std;

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
  FieldDescriptor(const map<string,string>& attrs = default_field_attrs):
	field_attrs(default_field_attrs){
  };
  const string& type, val, access, storage, annotation, javadoc;
};

class FunDescriptor{
  FunDescriptor(const map<string,string>& fun_attrs = default_field_attrs,
				bool unit_test_p = false, const list<string> args = default_args)
	:fun_attrs(default_fun_attrs),{
  };
  string type, ret_type, access, storage, annotation, javadoc;
  bool unit_test_p;
  list<string> args;
};

string write_java_class(vector<ClassDescriptor> clsdscs, vector<FieldDescriptor>
						fieldDscs, vector<FunDescriptor> funDscs){
  
  

  class val{
private:
  map<string,string> class_attrs;
  map<string,map<
			   }
  
}

  int main(int argc, char* argv[]){
  write_java_class(
}

