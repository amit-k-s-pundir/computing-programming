#ifndef MOD_FLASH_GLOBAL_H
#define MOD_FLASH_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(MOD_FLASH_LIBRARY)
#  define MOD_FLASHSHARED_EXPORT Q_DECL_EXPORT
#else
#  define MOD_FLASHSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // MOD_FLASH_GLOBAL_H
