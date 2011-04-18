#include <iostream>
#include <string>
#include <vector>
#include <functional>
#include <algorithm>
#include <utility> //std::function

#include <unistd.h>
#include <cerrno>
#include <cstdlib>

#include <signal.h>
#include <boost/foreach.hpp>
#include <boost/program_options.hpp>
namespace po = boost::program_options;
#include <libxml/parser.h>
#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>
#include <libxml/tree.h>
#include <libxml/HTMLparser.h>
#include <libxml/HTMLtree.h>
#include <curl/multi.h>
#include <curl/curl.h>
#include <curses.h>

//using namespace std;
using std::string;
using std::vector;

// libcurl variables for error strings and returned data.
static char errorBuffer[CURL_ERROR_SIZE];
static std::string buffer;

xmlXPathObjectPtr getNodeSet(xmlDocPtr doc, xmlChar* xpath) {
  xmlXPathContextPtr context;
  xmlXPathObjectPtr result;
  
  context = xmlXPathNewContext(doc);
  
  if (NULL == context) {
    std::cerr << "Error in xmlXPathNewContext()" << "\n";
    return NULL;
  }
  
  result = xmlXPathEvalExpression(xpath, context);
  xmlXPathFreeContext(context);
  
  if (NULL == result) {
    std::cerr << "Error in xmlXPathEvalExpression" << "\n";
    return NULL;
  }
  
  if (xmlXPathNodeSetIsEmpty(result->nodesetval)) {
    xmlXPathFreeObject(result);
    std::cout << "No result." << "\n";
    return NULL;
  }
  
  return result;
};

void init_libxml() {
  xmlInitParser();
};

void finish_libxml(){
  xmlCleanupParser();
};

// libcurl write callback function.
static int writer(char* data, size_t size, size_t nmemb, std::string*
writerData) {
  if (writerData == NULL)
    return 0;
  writerData->append(data, size * nmemb);
  
  return size * nmemb;
};

static bool init(CURL *&conn, const char *url) {
    CURLcode code;

    conn = curl_easy_init();

    if (conn == NULL)
    {
        fprintf(stderr, "Failed to create CURL connection\n");

        exit(EXIT_FAILURE);
    }

    code = curl_easy_setopt(conn, CURLOPT_ERRORBUFFER, errorBuffer);
    if (code != CURLE_OK)
    {
        fprintf(stderr, "Failed to set error buffer [%d]\n", code);

        return false;
    }

    code = curl_easy_setopt(conn, CURLOPT_URL, url);
     if (code != CURLE_OK)
    {
        fprintf(stderr, "Failed to set URL [%s]\n", errorBuffer);

        return false;
    }

    code = curl_easy_setopt(conn, CURLOPT_FOLLOWLOCATION, 1L);
    if (code != CURLE_OK)
    {
        fprintf(stderr, "Failed to set redirect option [%s]\n",
                errorBuffer);

        return false;
    }

    code = curl_easy_setopt(conn, CURLOPT_WRITEFUNCTION, writer);
    if (code != CURLE_OK)
    {
        fprintf(stderr, "Failed to set writer [%s]\n", errorBuffer);

        return false;
    }

    code = curl_easy_setopt(conn, CURLOPT_WRITEDATA, &buffer);
    if (code != CURLE_OK)
    {
        fprintf(stderr, "Failed to set write data [%s]\n", errorBuffer);

        return false;
    }

    return true;
};

void init_gui() {
//    (void) signal(SIGINT, finish); /* Arrange interrupts to terminate. */
 //   (void) initscr(); /* Initialize the curses library. */
  //  keypad(stdscr, TRUE); /* Enable keyboard mapping. */
   // (void) cbreak(); /* Take input characters one at a time, no wait for \n
 //   (void) echo(); /* Echo input in colour. */

  //  if (has_colors()) {
   //     start_color();
        /*
        * Simple color assignment, often all we need.  Color pair 0 cannot
        * be redefined.  This example uses the same value for the color
        * pair as for the foreground color, though of course that is not
        * necessary:
        */
    ////    init_pair(1, COLOR_RED,     COLOR_BLACK);
      //  init_pair(2, COLOR_GREEN,   COLOR_BLACK);
       // init_pair(3, COLOR_YELLOW,  COLOR_BLACK);
        //init_pair(4, COLOR_BLUE,    COLOR_BLACK);
//        init_pair(5, COLOR_CYAN,    COLOR_BLACK);
 //       init_pair(6, COLOR_MAGENTA, COLOR_BLACK);
  //      init_pair(7, COLOR_WHITE,   COLOR_BLACK);
   //     for (;;)
    //    {
     //       int c = getch();     /* refresh, accept single keystroke of input
      //      attrset(COLOR_PAIR(num % 8));
       //     num++;

            /* process the command keystroke */
 //       }
        //finish(0);               /* we're done */

    //}
};

static void finish(int sig) {
        endwin();

        /* do your non-curses wrapup here */

        exit(0);
};

/**
void init() {
        curl_easy_setopt(eh, CURLOPT_WRITEFUNCTION, p_writeFn);
        curl_easy_setopt(eh, CURLOPT_HEADER, 0L);
        curl_easy_setopt(eh, CURLOPT_URL, url.c_str());
//  curl_easy_setopt(eh, CURLOPT_PRIVATE, url.c_str());
        curl_easy_setopt(eh, CURLOPT_VERBOSE, 0L);
        curl_global_init(CURL_GLOBAL_ALL);
}
**/

class Proj{
};

xmlDocPtr getDoc(const std::string & docName) {
  xmlDocPtr doc;
  doc = xmlParseFile(docName.c_str());
  
  if (NULL == doc) {
    std::cerr << "Document could not be parsed successfully." << "\n";
  }
  
  return doc;
};

Proj* parseProject(xmlDocPtr doc, xmlNsPtr ns, xmlNodePtr cur) {
    Proj* ret = NULL;

    /**
    * If using C (instead of C++), we would do this:
    *
    **/
    /*
    * allocate the struct
    */
    /*   ret = (personPtr) malloc(sizeof(person));
       if (ret == NULL) {
           fprintf(stderr,"out of memory\n");
           return(NULL);
       }
       memset(ret, 0, sizeof(person));
    */
};

vector<Proj> getActiveDesProjs() {
};

void displayProj(const Proj & pr){
//  return 0
};
void displayProjs(const vector<Proj>& projs){
};
void getAndShowDesProjs() {
  displayProjs(getActiveDesProjs());
};

template<class NodePtr, class DocPtr> class XPath{
  public:
    DocPtr doc;
    NodePtr curNode;
//    const std::string & fileName;

    XPath(const std::string & fileName){
//      this->doc = xmlReadFile(fileName.c_str(), NULL, XML_PARSE_RECOVER |
//XML_PARSE_NOERROR);
//      doc = xmlReadMemory(buffer.c_str(), buffer.length(),
//"noname.xml", NULL, XML_PARSE_RECOVER|XML_PARSE_NOERROR);
      doc =  htmlReadDoc((xmlChar*) buffer.c_str(), "noname.xml", NULL,
HTML_PARSE_NOERROR);
    };
    
    int evalFile(const std::string & fileName, const xmlChar* xpathExpr, const
    xmlChar* nsList){
      xmlDocPtr doc;
    };

    int registerNamespaces(xmlXPathContextPtr xpathCtxt, const xmlChar* nsList);
    
    void printXPathNodes(xmlNodeSetPtr nodes, const std::ofstream &
    file){};

    template<class ... Types> int xPathTask(std::string & xpathExpr,
std::function<xmlNodePtr(xmlXPathObjectPtr, Types ...)>& fn, Types ... rest){
//      xmlDocPtr doc;
      xmlXPathContextPtr xpathCtxt;
      xmlXPathObjectPtr xpathObj;
      //      doc = xmlParseFile(fileName.c_str());
      xpathCtxt = xmlXPathNewContext(doc);
      xpathObj = xmlXPathEvalExpression((const xmlChar*)xpathExpr.c_str(),
xpathCtxt);
      //update_xpath_nodes(xpathObj->nodesetval, value);
      fn(xpathObj, rest ...);
      xmlXPathFreeObject(xpathObj);
      xmlXPathFreeContext(xpathCtxt);
      xmlFreeDoc(doc);

      return 0;
    };
};

xmlNodePtr fn(xmlXPathObjectPtr t){
  std::cout << buffer << "\n";
  xmlNodePtr r;
  return r;
};

struct F{
  xmlDocPtr doc;
  F(xmlDocPtr doc){
  this->doc = doc;
  };
  xmlNodePtr operator()(xmlXPathObjectPtr xPathObj){
    //    std::cout << buffer << "\n";
    /**
    if(NULL != xPathObj){
    std::cout << xmlXPathCastToString(xPathObj) << std::endl;
    }
    **/
    xmlNodeSetPtr nodes = xPathObj->nodesetval;
   // std::cout << xmlXPathCastNodeSetToString(nodes) << "\n";
    std::cout << nodes->nodeNr << "\n";
    for(int i = 0; i < nodes->nodeNr; i++){
   // xmlChar* word = xmlNodeListGetString(doc,
//nodes->nodeTab[i], 1);
       xmlChar* word = xmlNodeGetContent(nodes->nodeTab[i]);
    printf("word: %s\n", word);
    xmlFree(word);
    }
  }
};

int main(int argc, char* argv[]){
  po::options_descriptions desc("Allowed options");
  try{
    desc.add_options()
      ("help", "produce help message")
      ("url", po::value<string>(), "the url for a resource on which the xpath expression will be used.")
      ("xpath", po::value<vector<string> >(), "valid xpath expression(s)")
      ;
    po::variables_map vm;
    po::store(po::parse_command_line(ac, av, desc), vm);
    po::notify(vm);
  } catch(exception& e){

  //CURL* eh = curl_easy_init();
  const string
  url("http://www.topcoder.com/tc?module=ViewAssemblyActiveContests");
  CURL* conn = NULL;
  CURLcode code;
  
  curl_global_init(CURL_GLOBAL_DEFAULT);
  
  if(!init(conn, url.c_str())){
    std::cerr << "Connection initialization failed." << "\n";
    exit(EXIT_FAILURE);
  }
  
  curl_easy_perform(conn);
  
//  std::cout << buffer << "\n";
  std::cout << std::string(errorBuffer) << "\n";

  XPath<xmlNodePtr, xmlDocPtr> xPath("test.xml");
// std::string
//xPathExp("//table/tbody/tr/*/a");
std::string xPathExp("//table[@class=\"stat\"]//a");
  F f(xPath.doc);
 std::function<xmlNodePtr(xmlXPathObjectPtr)> ff(f);
//std::function<xmlNodePtr, xmlXPathObjectPtr>::function<F>(f);
  
  xPath.xPathTask(xPathExp, ff);

// xmlDocPtr htmlDoc =  htmlParseDoc((xmlChar*) buffer, NULL);
  
//  std::function<xmlNodePtr(xmlXPathObjectPtr, )
  
  curl_easy_cleanup(conn);
  
//  parseHtml(buffer, title);
//  getAndShowDesProjs();
  return EXIT_SUCCESS;
}

