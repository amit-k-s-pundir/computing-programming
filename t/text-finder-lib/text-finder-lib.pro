#-------------------------------------------------
#
# Project created by QtCreator 2014-11-16T20:33:26
#
#-------------------------------------------------

QT       += widgets

TARGET = text-finder-lib
TEMPLATE = lib

DEFINES += TEXTFINDERLIB_LIBRARY

SOURCES += textfinderlib.cpp

HEADERS += textfinderlib.h\
        text-finder-lib_global.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
