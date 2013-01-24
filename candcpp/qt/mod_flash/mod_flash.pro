#-------------------------------------------------
#
# Project created by QtCreator 2012-09-19T19:01:33
#
#-------------------------------------------------

QT       -= gui

TARGET = mod_flash
TEMPLATE = lib

DEFINES += MOD_FLASH_LIBRARY

SOURCES += mod_flash.cpp

HEADERS += mod_flash.h\
        mod_flash_global.h

symbian {
    MMP_RULES += EXPORTUNFROZEN
    TARGET.UID3 = 0xE51938D1
    TARGET.CAPABILITY = 
    TARGET.EPOCALLOWDLLDATA = 1
    addFiles.sources = mod_flash.dll
    addFiles.path = !:/sys/bin
    DEPLOYMENT += addFiles
}

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}

unix:!macx:!symbian: LIBS += -L$$PWD/../../../../../../../opt/apache2/lib/ -lapr-2

INCLUDEPATH += $$PWD/../../../../../../../opt/apache2/include
DEPENDPATH += $$PWD/../../../../../../../opt/apache2/include
