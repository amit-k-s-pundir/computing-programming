// void sync_workspace(){
// }

void sync(Source src, Destination dest);

void sync_workspace_with(Destination dest){
  // sync<Workspace>(dest);
  sync(workspace, dest);
}

void sync(Workspace src, Workspace dest){
}

void sync(Opt src, Opt dest){
}
