#include <boost/mpl/lambda.hpp>
#include <boost/proto/proto.hpp>

using namespace boost;

namespace mpl = boost::mpl;
namespace fusion = boost::fusion;
namespace proto = boost::proto;

// Allow unqualified use of Proto's wildcard pattern
using proto::_;
