#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>

int make_socket(uint16_t port){
        int sock;
        struct sockaddr_in name;

        sock = socket(PF_INET, SOCK_STREAM, 0);
        socket(
                if(sock < 0){
                        perror("socket");
                        exit(EXIT_FAILURE);
                }
                
                return sock;
                }
