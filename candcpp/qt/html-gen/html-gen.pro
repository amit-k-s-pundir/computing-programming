#-------------------------------------------------
#
# Project created by QtCreator 2013-05-20T10:37:10
#
#-------------------------------------------------

QT       -= gui

TARGET = html-gen
TEMPLATE = lib

DEFINES += HTMLGEN_LIBRARY

SOURCES += html-gen.cpp

HEADERS += html-gen.h\
        html-gen_global.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}
