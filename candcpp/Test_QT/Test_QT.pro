#-------------------------------------------------
#
# Project created by QtCreator 2010-10-15T06:26:35
#
#-------------------------------------------------

CONFIG += qt debug
QT += network xml opengl xmlpatterns
PKGCONFIG += dbus-1
LIBS += -L/opt/boost/libs -lmath
INCLUDEPATH += /opt/boos/include
TARGET = Test_QT
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

#FORMS    += mainwindow.ui
