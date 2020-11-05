#ifndef RQTPHYSICS_GLOBAL_H
#define RQTPHYSICS_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(RQTPHYSICS_LIBRARY)
#  define RQTPHYSICS_EXPORT Q_DECL_EXPORT
#else
#  define RQTPHYSICS_EXPORT Q_DECL_IMPORT
#endif

#endif // RQTPHYSICS_GLOBAL_H
