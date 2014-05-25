using namespace std;

void setup_dot_files(){
}

void initialize_fs(){
  setup_workspace();
  with_dir(workspaceDir,
	   [](workspaceDir){
	     setup_dot_files();
	     setup_sources_dir();
	     setup_opt_dir();
	     setup_docs_dir();
	     
}
