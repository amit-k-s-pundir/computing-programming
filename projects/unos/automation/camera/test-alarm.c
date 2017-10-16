#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

sig_atomic_t keep_going = 1;

void catch_alarm(int sig){
        keep_going = 0;
        system("gvim");
}

void do_stuff(void){
        puts("Waiting for alarm :)");
}

int main(void){
        signal(SIGALRM, catch_alarm);
        alarm(5);
        while(keep_going){
                do_stuff();
        }
        return EXIT_SUCCESS;
}
