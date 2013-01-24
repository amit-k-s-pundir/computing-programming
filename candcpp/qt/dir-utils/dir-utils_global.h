#ifndef DIRUTILS_GLOBAL_H
#define DIRUTILS_GLOBAL_H

//#include <QtCore/qglobal.h>

#if defined(DIRUTILS_LIBRARY)
#  define DIRUTILSSHARED_EXPORT Q_DECL_EXPORT
#else
#  define DIRUTILSSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // DIRUTILS_GLOBAL_H
