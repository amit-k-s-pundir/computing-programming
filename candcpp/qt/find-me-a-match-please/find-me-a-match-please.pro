#-------------------------------------------------
#
# Project created by QtCreator 2013-02-28T10:41:23
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = find-me-a-match-please
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    GUI.cpp

HEADERS  += mainwindow.h \
    GUI.h

FORMS    += mainwindow.ui

INCLUDEPATH += /opt/apache/include
LIBS += /opt/apache/lib

OTHER_FILES += \
    Employee.sql
