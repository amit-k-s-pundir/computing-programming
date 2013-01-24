#include <iostream>
#include <string>
#include <ctime>

#include <boost/chrono/chrono_io.hpp>
#include <boost/asio.hpp>

using namespace std;
using namespace boost;
using namespace boost::posix_time;

int main(int argc, char** argv)
{
  boost::asio::io_service io_service;
  boost::asio::deadline_timer t(io_service);
  t.expires_from_now(boost::posix_time::seconds(5));
  t.async_wait(handler);
  io_service.run();
                     

  supervise_processes(processes, duration);
  return 0;
}

int supervise_processes(vector[pid_t], Duration duration){
}

/**
 * Ensures that the *process* is launched and runs for the given
 * *duration* and no longer than the given *duration*.
 **/
int run_process_for_duration(string process, double duration){
  system(process.c_str());
}

/**
 * Ensures that the *process* is launched and runs for the given
 * *duration* and no longer than the given *duration*. It keeps doing
 * this for the duration of the *timeout*.
 **/
int run_process_for_duration_with_timeout(string process, double duration, double timeout){
  
}
  
