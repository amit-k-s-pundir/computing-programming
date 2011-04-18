static int bind_socket(const string & addr, unsigned short port, const string & unixsocket, uid_t uid, gid_t gid, int mode){
    if(unixsocket){
            struct sockaddr_un fcgi_addr_un;
            memset(&fcgi_addr_un, 0, sizeof(fcgi_addr_un));
            fcgi_addr_un.sun_family = AF_UNIX;

