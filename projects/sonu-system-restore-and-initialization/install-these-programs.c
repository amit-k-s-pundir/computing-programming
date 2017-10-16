#include <stdio.h>

/* Decompresses a compressed archive into a directory created with a
   name derived from the name of the compressed file; i.e. abc.tgz
   would be decompressed into the directory abc. */
cons char* decompress(cons char* compressedFileName){
  if (bzip_file_p(compressedFileName)){
    decompress_bzip_file(compressedFileName);
  } else {
    if(tgz_file_p(compressedFileName)){
      decompress_tgz_file(compressedFileName);
    }
  }
};

bool bzip_file_p(fileName){

}

/*  const char* fileName =
   get_fileName_from_archiveName(compressedFileName);
*/

int default_install_fn(cons char* downlo){
  const char* downloadedFile = download(downloadURL);
  const char* fileName = decompress(downloadedFile);

void install_stable_binary(char* downloadUrl, char*
			   downloadedFileName, char* workDir, void*
			   installFn){
  if (0 == workDir){workdir = "/opt/downloads"};
  if (0 == installFn) {installFn = defaultInstallFn};
  with_dir(workDir, defaultInstallFn);
};


int main(){

  return 0;
}p
. nh n n ,k,k
