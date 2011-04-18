#include <iostream>
#include <functional>
#include <unistd.h>
#include <string>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

/*int download(const char* downloader, const char* progname, const char* url){
  pid_t pid;
  int rv;

  switch(pid = fork()){
  case -1:
	perror("fork");
	exit(1);
  case 0:
	printf("This is the child and I am downloading program: %s with %s\n", url, downloader);
	printf("My pid is: %d\n", getpid());
	printf("My parent's pid is: %d\n", getppid());
	execl(downloader,progname, url, (char*) 0);
  default:
	printf("This is the parent process.\n");
	printf("My pid is: %d\n", getpid());
	printf("My child's pid is: %d\n", pid);
	printf("I am now waiting for download to finish.....\n");
	wait(&rv);
	printf("Download finished with the status: %d\n", WEXITSTATUS(rv));
  }
  }*/

void download(string downloader, char* const urls[]){
  //  vector<string>::iterator it;
  int it = 1;
  int rv1, rv2;
  while(urls[it] != 0){
	//++it;
	pid_t child_pid = fork();
	switch(child_pid){
	case -1:
	  perror("fork error");
	  exit(1);
	case 0:
	  cout << "This is the " << it <<"th child and I am downloading the url:" <<
		urls[it] << endl;
	  cout << "My PID is: " << getpid() << endl;
	  cout << "My parent's PID is: " <<  getppid() << endl;
	  //	  const  char* str = urls[0].c_str();
	  //	  const char* const* p = &str;
	  execlp(downloader.c_str(), downloader.c_str(), urls[it], (char*)NULL );
	  //	  exit(result);
	default:
	  cout << "This is the parent process." << endl;
	  cout << "My PID is: " << getpid() <<endl;
	  cout << "I am now waiting for the download to finish..." << endl;
	  // wait(&rv);
	  cout << "Download finished with the status: " << endl;
	}
	++it;
  }
	
  /*for(it = urls.begin(), int i = 0; it != urls.end(); it++, i++){
	pid_t child_pid = fork();
	switch(child_pid){
	case -1:
	  perror("fork error");
	  exit(1);
	case 0:
	  cout << "This is the " << i <<"th child and I am downloading the url:" <<
		v.at(i) << endl;
	  cout << "My PID is: " << getpid() << endl;
	  cout << "My parent's PID is: " getppid() << endl;
	  execvp(downloader, urls);
	default:
	  cout << "This is the parent process." << endl;
	  cout << "My PID is: " << getpid() <<endl;
	  cout << "I am now waiting for the download to finish..." << endl;
	  wait(&rv);
	  cout << "Download finished with the status: %d " << WEXITSTATUS(rv) << endl;
	  }*/ 
	  
}
  //namespace utils{
int main(int argc, char** argv){
	
	//	template<typename downloader, typename url> class download{
	//	public:
	//void download(
  char* const urls[] = {"wget", "www.google.com", "www.yahoo.com", (char*)NULL};
  download("wget", urls);
  //	download("/usr/bin/wget", "/usr/bin/wget", "http://www.google.com");
}

  
