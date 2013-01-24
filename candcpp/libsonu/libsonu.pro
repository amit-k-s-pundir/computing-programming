#-------------------------------------------------
#
# Project created by QtCreator 2013-01-05T21:59:20
#
#-------------------------------------------------

QT       -= gui

TARGET = libsonu
TEMPLATE = lib

DEFINES += LIBSONU_LIBRARY

SOURCES += libsonu.cpp \
    utils/Utils.cpp \
    utils/filesystem/FileSystem.cpp

HEADERS += libsonu.h\
        libsonu_global.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}
