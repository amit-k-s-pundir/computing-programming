#include <vector>
#include <iostream>
#include <sstream>
#include <fstream>
#include <functional>

using namespace std;

namespace sonu{
namespace automation{
namespace web{
//using namespace std;

class LocalInstall{
    virtual bool update(){
        ostringstream ss;
       ss << "wget -EN -ckp " << url;
}
};

bool update_local_installs_and_mirrors(const vector<LocalInstall>& locals){
    for(LocalInstall& local : locals){
        local.update();
   } 
    return true;
    }

typedef struct WgetRequest{
    string getURL;
    string referer;
    int bytes;
    string userAgent;
    string accept;
    string host;
    string connection;
} WgetRequest;

typedef struct WgetResponse{
    string httpHeader;
    string server;
    string date;
    int contentLength;
    string lastModified;
    string connection;
    string expires;
    string cacheControl;
    string contentRange;
} WgetResponse;

struct WgetDownload{
    WgetRequest request;
    WgetResponse response;
    string downloadName;
    string url;
    string storageFilePathurl;
    int lineNumber;
    int downloadSize;
    int downloadedSize;

    static WgetDownload parse_next(){
    }
};

struct parse_next{
    string file;
    ifstream is;
    WgetDownload & operator()(){
    }
    parse_next(const string & file = "~/wget-log"){
        file = file;
        is = ifstream(file);
    }
}
    
class WgetIterator : public iterator<input_iterator_tag, WgetDownload>{
    private:
    WgetDownload* download;
    public:
    reference operator*() const;
    pointer operator->() const;
    WgetIterator& operator++();
    WgetIterator operator++(int);

};

reference WgetIterator::operator *() const{
    return *download;
}

pointer WgetIterator::operator ->() const{
  &(*download);
}


template <class T> void finish_downloads(vector<T> downloads);
template <class U> void finish_download(U download);

template <> void finish_download<WgetDownload>(WgetDownload download_){
 ostringstream ss;
 ss << "wget " << wgetParams << wgetArgs;
}

template <> void finish_downloads<WgetDownload>(vector<WgetDownloads> downloads){
   for(auto it = downloads.begin(); it != downloads.end(); ++it){
       WgetDownload download = *it;
       if(download.downloadedSize < download.downloadSize){
           finish_download(download);
       }
   }
}

int main(int argc, char** argv){
    vector<LocalInstall> locals = {};
    return 0;
}
