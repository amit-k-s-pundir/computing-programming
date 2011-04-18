#include <xerces/util/PlatformUtils.hpp>
#include <xerces/dom/DOM.hpp>

#include <iostream>

XERCES_CPP_NAMESPACE_USE

int main(int argc, char* argv[]){
  try{
	XMLPlatformUtils::Initialize();
  }catch(const XMLException& toCatch){
	//Do your failure processing here.
	return 1;
  }

  //Do your actual work with Xerces-C++ here.
  /*
	DOMNode* aNode;
	DOMNode* docRootNode;
	aNode = someDocument->createElement(anElementName);
	docRootNode = someDocument->getDocumentElement();
	docRootNode->appendChild(aNode);
  */
  
  XMLPlatformUtils::Terminate();

  //Other terminations and  cleanup.
  return 0;
}
