#-------------------------------------------------
#
# Project created by QtCreator 2013-05-09T07:13:17
#
#-------------------------------------------------

QT       -= gui

TARGET = extjs-utils
TEMPLATE = lib

DEFINES += EXTJSUTILS_LIBRARY

SOURCES += extjsutils.cpp

HEADERS += extjsutils.h\
        extjs-utils_global.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}
