#include <curl/curl.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

#include <iostream>
#include <string>
#include <map>
#include <utility>
#include <iostream>

using namespace std;

template < typename S, typename T, typename U > class curl_option_and_value_t
{
  typedef S option_t;
  typedef T value_t;
  typedef U next_t;
//        pair<option,value> option_and_value;
  option_t option;
  value_t value;
  next_t *next;			// = NULL;

public:
curl_option_and_value_t (S option, T value, U * next_curl_option_and_value):option (option), value (value),
    next
    (next_curl_option_and_value)
  {
  };
};

typedef size_t (*read_callback_t) (void *ptr, size_t size, size_t nmemb,
				   void *stream);
size_t
read_callback (void *ptr, size_t size, size_t nmemb, void *stream)
{
  size_t retcode;
  intptr_t fd = (intptr_t) stream;
  retcode = read (fd, ptr, size * nmemb);
  fprintf (stderr, "*** We read %d bytes from file\n", retcode);
  return retcode;
};

template < typename S, typename T, typename U > void
set_curl_options (CURL * curl, const curl_option_and_value_t < S, T,
		  U >& curl_option_and_value)
{
  cout << "set_curl_options() called. " << "\n";
};

static curlioerr my_ioctl(CURL* handle, curliocmd cmd, void* userp){
    intptr_t fd = (intptr_t)userp;
    (void) handle;

    switch(cmd){
            case CURLIOCMD_RESTARTREAD:
                    if(-1 == lseek(fd, 0, SEEK_SET))
                            return CURLIOE_FAILRESTART;
                    break;
            default:
                    return CURLIOE_UNKNOWNCMD;
    }
    return CURLIOE_OK;
}

int
main (int argc, char *argv[])
{
  CURL *curl;
  CURLcode res;
  intptr_t hd;
  struct stat file_info;

  string const file;
  string const url;

  if(argc < 3)
          return 1;

  file = argv[1];
  url = argv[2];

  //       curl_option_and_value<CURLOPTION,read_callback_t,CURLOPTION,void*> pair<CURLOPT_READDATA, 
  curl_option_and_value_t < CURLoption, read_callback_t,
    curl_option_and_value_t < CURLoption, void *,
    void *> > curl_option_and_value(CURLOPT_READFUNCTION, read_callback, NULL);
  //        curl_option_and_value.next(CURLOPT_READDATA, (void*)hd);

  map < string, string > options_values;
  set_curl_options (curl, curl_option_and_value);
}
