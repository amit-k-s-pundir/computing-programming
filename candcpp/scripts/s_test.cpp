
namespace mpl = boost::mpl;

template<class Tree> class XML{
            explicit XML(Tree t){
            }

            Tree value const(){
                    return m_tree_as_xml;
            }

 private           string  m_tree_as_xml;
};

class Tree

template <class T> class Node{

        string name;
        map<string,string> attrs;
        //typdef T NodeContent;
        T nodeContent;
        Node children[];
}


int main(){
        XML<TypeA>::Value xml
