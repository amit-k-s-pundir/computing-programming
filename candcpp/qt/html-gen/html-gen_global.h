#ifndef HTMLGEN_GLOBAL_H
#define HTMLGEN_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(HTMLGEN_LIBRARY)
#  define HTMLGENSHARED_EXPORT Q_DECL_EXPORT
#else
#  define HTMLGENSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // HTMLGEN_GLOBAL_H
