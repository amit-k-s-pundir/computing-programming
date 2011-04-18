#include <boost/date_time/gregorian/gregorian_types.hpp>
#include <boost/date_time/posix_time/posix_time_types.hpp>
#include <boost/asio.hpp>

namespace gregorian = boost::gregorian;
namespace posix_time = boost::posix_time;
namespace asio = boost::asio;

asio::io_service io_service_;
asio::deadline_timer timer_ (io_service_);
gregorian::date today = gregorian::day_clock::local_day();
posix_time::time_duration usertime = posix_time::duration_from_string(time)
posix_time::ptime expirationtime (today, usertime);
timer_.expires_at (expirationtime);
timer_.async_wait (foo);    // use Boost::bind() if you want a member function
