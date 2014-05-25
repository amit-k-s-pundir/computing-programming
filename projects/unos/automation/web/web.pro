#-------------------------------------------------
#
# Project created by QtCreator 2013-06-17T18:29:59
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = sonu-utils-web-automation
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    locals.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui


QMAKE_CXXFLAGS += -std=c++11
INCLUDEPATH += /opt/boost/include
LIBS += /opt/boost/lib
