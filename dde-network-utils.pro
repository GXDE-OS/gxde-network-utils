QT       -= gui
QT       += dbus network

TARGET = gxde-network-utils
TEMPLATE = lib
CONFIG += link_pkgconfig c++11 create_pc create_prl no_install_prl no_keywords
PKGCONFIG      += dframeworkdbus

DEFINES += DDENETWORKUTILS_LIBRARY
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
    $$PWD/networkmodel.cpp \
    $$PWD/networkworker.cpp \
    $$PWD/networkdevice.cpp \
    $$PWD/wirelessdevice.cpp \
    $$PWD/wireddevice.cpp \
    $$PWD/connectivitychecker.cpp

HEADERS += \
    $$PWD/networkmodel.h \
    $$PWD/networkworker.h \
    $$PWD/networkdevice.h \
    $$PWD/wirelessdevice.h \
    $$PWD/wireddevice.h \
    $$PWD/connectivitychecker.h

includes.files += *.h
includes.files += \
    $$PWD/NetworkModel \
    $$PWD/NetworkWorker \
    $$PWD/NetworkDevice \
    $$PWD/WirelessDevice \
    $$PWD/WiredDevice

isEmpty(PREFIX) {
    PREFIX = /usr
}

# Automating generation .qm files from .ts files
CONFIG(release, debug|release) {
    !system($$PWD/translate_generation.sh): error("Failed to generate translation")
}

target.path = $$PREFIX/lib
includes.path = $$PREFIX/include/libddenetworkutils

qm_files.path = $${PREFIX}/share/gxde-network-utils/translations/
qm_files.files = translations/*.qm

TRANSLATIONS = translations/dde-control-center.ts

QMAKE_PKGCONFIG_NAME = libddenetworkutils
QMAKE_PKGCONFIG_DESCRIPTION = libddenetworkutils
QMAKE_PKGCONFIG_INCDIR = $$includes.path
QMAKE_PKGCONFIG_LIBDIR = $$target.path
QMAKE_PKGCONFIG_DESTDIR = pkgconfig

INSTALLS += includes target qm_files
