/* calc.h
   Generated by wsdl2h 1.2.9l from http://www.cs.fsu.edu/~engelen/calc.wsdl and typemap.dat
   2009-11-19 15:08:31 GMT
   Copyright (C) 2001-2007 Robert van Engelen, Genivia Inc. All Rights Reserved.
   This part of the software is released under one of the following licenses:
   GPL or Genivia's license for commercial use.
*/

/* NOTE:

 - Compile this file with soapcpp2 to complete the code generation process.
 - Use soapcpp2 option -I to specify paths for #import
   To build with STL, 'stlvector.h' is imported from 'import' dir in package.
 - Use wsdl2h options -c and -s to generate pure C code or C++ code without STL.
 - Use 'typemap.dat' to control schema namespace bindings and type mappings.
   It is strongly recommended to customize the names of the namespace prefixes
   generated by wsdl2h. To do so, modify the prefix bindings in the Namespaces
   section below and add the modified lines to 'typemap.dat' to rerun wsdl2h.
 - Use Doxygen (www.doxygen.org) to browse this file.
 - Use wsdl2h option -l to view the software license terms.

   DO NOT include this file directly into your project.
   Include only the soapcpp2-generated headers and source code files.
*/

//gsoapopt w

/******************************************************************************\
 *                                                                            *
 * http://websrv.cs.fsu.edu/~engelen/calc.wsdl                                *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Import                                                                     *
 *                                                                            *
\******************************************************************************/


// STL vector containers (use option -s to disable)
#import "stlvector.h"

/******************************************************************************\
 *                                                                            *
 * Schema Namespaces                                                          *
 *                                                                            *
\******************************************************************************/


/* NOTE:

It is strongly recommended to customize the names of the namespace prefixes
generated by wsdl2h. To do so, modify the prefix bindings below and add the
modified lines to typemap.dat to rerun wsdl2h:

ns1 = "http://websrv.cs.fsu.edu/~engelen/calc.wsdl"
ns2 = "urn:calc"

*/

//gsoap ns2   schema namespace:	urn:calc
//gsoap ns2   schema form:	unqualified

/******************************************************************************\
 *                                                                            *
 * Schema Types                                                               *
 *                                                                            *
\******************************************************************************/



/******************************************************************************\
 *                                                                            *
 * Services                                                                   *
 *                                                                            *
\******************************************************************************/


//gsoap ns2  service name:	calc 
//gsoap ns2  service type:	calcPortType 
//gsoap ns2  service port:	http://websrv.cs.fsu.edu/~engelen/calcserver.cgi 
//gsoap ns2  service namespace:	urn:calc 
//gsoap ns2  service transport:	http://schemas.xmlsoap.org/soap/http 

/** @mainpage calc Definitions

@section calc_bindings Bindings
  - @ref calc

*/

/**

@page calc Binding "calc"

@section calc_service Service Documentation "calc"
gSOAP 2.7.9k generated service definition

@section calc_operations Operations of Binding  "calc"
  - @ref ns2__add
  - @ref ns2__sub
  - @ref ns2__mul
  - @ref ns2__div
  - @ref ns2__pow

@section calc_ports Endpoints of Binding  "calc"
  - http://websrv.cs.fsu.edu/~engelen/calcserver.cgi

Note: use wsdl2h option -N to change the service binding prefix name

*/

/******************************************************************************\
 *                                                                            *
 * calc                                                                       *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * ns2__add                                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "ns2__add" of service binding "calc"

/**

Operation details:

Service definition of function ns__add
  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call_ns2__add(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int ns2__add(
    struct soap *soap,
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C++ proxy class (defined in soapcalcProxy.h):
  class calc;

Note: use soapcpp2 option '-i' to generate improved proxy and service classes;

*/

//gsoap ns2  service method-style:	add rpc
//gsoap ns2  service method-encoding:	add http://schemas.xmlsoap.org/soap/encoding/
//gsoap ns2  service method-action:	add ""
int ns2__add(
    double                              a,	///< Request parameter
    double                              b,	///< Request parameter
    double                             &result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * ns2__sub                                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "ns2__sub" of service binding "calc"

/**

Operation details:

Service definition of function ns__sub
  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call_ns2__sub(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int ns2__sub(
    struct soap *soap,
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C++ proxy class (defined in soapcalcProxy.h):
  class calc;

Note: use soapcpp2 option '-i' to generate improved proxy and service classes;

*/

//gsoap ns2  service method-style:	sub rpc
//gsoap ns2  service method-encoding:	sub http://schemas.xmlsoap.org/soap/encoding/
//gsoap ns2  service method-action:	sub ""
int ns2__sub(
    double                              a,	///< Request parameter
    double                              b,	///< Request parameter
    double                             &result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * ns2__mul                                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "ns2__mul" of service binding "calc"

/**

Operation details:

Service definition of function ns__mul
  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call_ns2__mul(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int ns2__mul(
    struct soap *soap,
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C++ proxy class (defined in soapcalcProxy.h):
  class calc;

Note: use soapcpp2 option '-i' to generate improved proxy and service classes;

*/

//gsoap ns2  service method-style:	mul rpc
//gsoap ns2  service method-encoding:	mul http://schemas.xmlsoap.org/soap/encoding/
//gsoap ns2  service method-action:	mul ""
int ns2__mul(
    double                              a,	///< Request parameter
    double                              b,	///< Request parameter
    double                             &result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * ns2__div                                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "ns2__div" of service binding "calc"

/**

Operation details:

Service definition of function ns__div
  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call_ns2__div(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int ns2__div(
    struct soap *soap,
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C++ proxy class (defined in soapcalcProxy.h):
  class calc;

Note: use soapcpp2 option '-i' to generate improved proxy and service classes;

*/

//gsoap ns2  service method-style:	div rpc
//gsoap ns2  service method-encoding:	div http://schemas.xmlsoap.org/soap/encoding/
//gsoap ns2  service method-action:	div ""
int ns2__div(
    double                              a,	///< Request parameter
    double                              b,	///< Request parameter
    double                             &result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * ns2__pow                                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "ns2__pow" of service binding "calc"

/**

Operation details:

Service definition of function ns__pow
  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] generated by soapcpp2):
@code
  int soap_call_ns2__pow(
    struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C server function (called from the service dispatcher defined in soapServer.c[pp]):
@code
  int ns2__pow(
    struct soap *soap,
    // request parameters:
    double                              a,
    double                              b,
    // response parameters:
    double                             &result
  );
@endcode

C++ proxy class (defined in soapcalcProxy.h):
  class calc;

Note: use soapcpp2 option '-i' to generate improved proxy and service classes;

*/

//gsoap ns2  service method-style:	pow rpc
//gsoap ns2  service method-encoding:	pow http://schemas.xmlsoap.org/soap/encoding/
//gsoap ns2  service method-action:	pow ""
int ns2__pow(
    double                              a,	///< Request parameter
    double                              b,	///< Request parameter
    double                             &result	///< Response parameter
);

/* End of calc.h */
