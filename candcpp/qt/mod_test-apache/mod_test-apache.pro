#-------------------------------------------------
#
# Project created by QtCreator 2013-05-10T04:58:15
#
#-------------------------------------------------

QT       += network sql xml xmlpatterns dbus

QT       -= gui

TARGET = mod_test-apache
TEMPLATE = lib

DEFINES += MOD_TESTAPACHE_LIBRARY

SOURCES += TestApache.cpp \
    mod_status.c

HEADERS += TestApache.h\
        mod_test-apache_global.h

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}


INCLUDEPATH += /opt/apache2/include
LIBS += /opt/apache2/lib

