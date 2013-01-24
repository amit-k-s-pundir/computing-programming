#-------------------------------------------------
#
# Project created by QtCreator 2012-12-11T08:53:33
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = update-gcc
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp
QMAKE_CXXFLAGS += -std=c++11
INCLUDEPATH += /opt/include
LIBS += -L/opt/lib -lupdate-gcc
