#-------------------------------------------------
#
# Project created by QtCreator 2012-12-18T04:43:35
#
#-------------------------------------------------

QT       -= gui

TARGET = dir-utils
TEMPLATE = lib

DEFINES += DIRUTILS_LIBRARY

SOURCES += dir-utils.cpp

HEADERS += dir-utils.h\
        dir-utils_global.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}

QMAKE_CXXFLAGS += -std=c++11
INCLUDEPATH += /opt/boost/include
LIBS += -L/opt/boost/lib -lboost_filesystem -lboost_system
