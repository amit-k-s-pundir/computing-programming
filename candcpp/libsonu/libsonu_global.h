#ifndef LIBSONU_GLOBAL_H
#define LIBSONU_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(LIBSONU_LIBRARY)
#  define LIBSONUSHARED_EXPORT Q_DECL_EXPORT
#else
#  define LIBSONUSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // LIBSONU_GLOBAL_H
