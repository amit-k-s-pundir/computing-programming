TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp

QMAKE_CXXFLAGS += -std=c++11
INCLUDEPATH += /opt/boost/include
INCLUDEPATH += /opt/include
LIBS += -L/opt/boost/lib -lboost_filesystem -lboost_system
LIBS += -L/opt/lib -ldir-utils
