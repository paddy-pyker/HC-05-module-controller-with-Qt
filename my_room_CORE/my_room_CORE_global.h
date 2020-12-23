#ifndef MY_ROOM_CORE_GLOBAL_H
#define MY_ROOM_CORE_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(MY_ROOM_CORE_LIBRARY)
#  define MY_ROOM_CORE_EXPORT Q_DECL_EXPORT
#else
#  define MY_ROOM_CORE_EXPORT Q_DECL_IMPORT
#endif

#endif // MY_ROOM_CORE_GLOBAL_H
