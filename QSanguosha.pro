# -------------------------------------------------
# Project created by QtCreator 2010-06-13T04:26:52
# -------------------------------------------------
TARGET = QSanguosha
QT += network widgets
QT += qml
TEMPLATE = app

CONFIG(release,debug|release){
# fmod will prevent us to debug
CONFIG += audio
}

CONFIG += lua

CONFIG -= flat

CONFIG += precompile_header
PRECOMPILED_HEADER = src/pch.h
DEFINES += USING_PCH

SOURCES += \
    src/main.cpp \
    src/client/aux-skills.cpp \
    src/client/client.cpp \
    src/client/clientplayer.cpp \
    src/client/clientstruct.cpp \
    src/core/banpair.cpp \
    src/core/card.cpp \
    src/core/engine.cpp \
    src/core/general.cpp \
    src/core/json.cpp \
    src/core/lua-wrapper.cpp \
    src/core/player.cpp \
    src/core/protocol.cpp \
    src/core/settings.cpp \
    src/core/skill.cpp \
    src/core/structs.cpp \
    src/core/util.cpp \
    src/dialog/cardeditor.cpp \
    src/dialog/cardoverview.cpp \
    src/dialog/choosegeneraldialog.cpp \
    src/dialog/configdialog.cpp \
    src/dialog/connectiondialog.cpp \
    src/dialog/customassigndialog.cpp \
    src/dialog/distanceviewdialog.cpp \
    src/dialog/generaloverview.cpp \
    src/dialog/mainwindow.cpp \
    src/dialog/playercarddialog.cpp \
    src/dialog/roleassigndialog.cpp \
    src/dialog/scenario-overview.cpp \
    src/package/exppattern.cpp \
    src/package/god.cpp \
    src/package/maneuvering.cpp \
    src/package/nostalgia.cpp \
    src/package/package.cpp \
    src/package/standard.cpp \
    src/package/standard-cards.cpp \
    src/package/standard-generals.cpp \
    src/package/standard-skillcards.cpp \
    src/package/thicket.cpp \
    src/package/wind.cpp \
    src/scenario/boss-mode-scenario.cpp \
    src/scenario/couple-scenario.cpp \
    src/scenario/guandu-scenario.cpp \
    src/scenario/miniscenarios.cpp \
    src/scenario/scenario.cpp \
    src/scenario/scenerule.cpp \
    src/scenario/zombie-scenario.cpp \
    src/server/ai.cpp \
    src/server/gamerule.cpp \
    src/server/generalselector.cpp \
    src/server/room.cpp \
    src/server/roomthread.cpp \
    src/server/server.cpp \
    src/server/serverplayer.cpp \
    src/ui/button.cpp \
    src/ui/cardcontainer.cpp \
    src/ui/carditem.cpp \
    src/ui/chatwidget.cpp \
    src/ui/clientlogbox.cpp \
    src/ui/dashboard.cpp \
    src/ui/indicatoritem.cpp \
    src/ui/magatamas-item.cpp \
    src/ui/photo.cpp \
    src/ui/pixmapanimation.cpp \
    src/ui/qsanbutton.cpp \
    src/ui/rolecombobox.cpp \
    src/ui/roomscene.cpp \
    src/ui/sprite.cpp \
    src/ui/startscene.cpp \
    src/ui/window.cpp \
    src/util/detector.cpp \
    src/util/nativesocket.cpp \
    src/util/recorder.cpp \
    src/core/record-analysis.cpp \
    src/package/hegemony.cpp \
    src/scenario/fancheng-scenario.cpp \
    src/core/room-state.cpp \
    src/core/wrapped-card.cpp \
    src/ui/bubblechatbox.cpp \
    src/ui/generic-cardcontainer-ui.cpp \
    src/ui/qsan-selectable-item.cpp \
    src/ui/skin-bank.cpp \
    src/ui/table-pile.cpp \
    src/ui/timed-progressbar.cpp \
    src/ui/ui-utils.cpp \
    src/package/bgm.cpp \
    src/package/fire.cpp \
    src/package/h-formation.cpp \
    src/package/h-momentum.cpp \
    src/package/mountain.cpp \
    src/package/sp.cpp \
    src/package/yjcm.cpp \
    src/package/yjcm2012.cpp \
    src/package/yjcm2013.cpp \
    src/package/yjcm2014.cpp \
    swig/sanguosha_wrap.cxx \
    src/dialog/banipdialog.cpp \
    src/package/jsp.cpp \
    src/dialog/dialogslsettings.cpp

HEADERS += \
    src/client/aux-skills.h \
    src/client/client.h \
    src/client/clientplayer.h \
    src/client/clientstruct.h \
    src/core/audio.h \
    src/core/banpair.h \
    src/core/card.h \
    src/core/compiler-specific.h \
    src/core/engine.h \
    src/core/general.h \
    src/core/json.h \
    src/core/lua-wrapper.h \
    src/core/player.h \
    src/core/protocol.h \
    src/core/settings.h \
    src/core/skill.h \
    src/core/structs.h \
    src/core/util.h \
    src/dialog/cardeditor.h \
    src/dialog/cardoverview.h \
    src/dialog/choosegeneraldialog.h \
    src/dialog/configdialog.h \
    src/dialog/connectiondialog.h \
    src/dialog/customassigndialog.h \
    src/dialog/distanceviewdialog.h \
    src/dialog/generaloverview.h \
    src/dialog/mainwindow.h \
    src/dialog/playercarddialog.h \
    src/dialog/roleassigndialog.h \
    src/dialog/scenario-overview.h \
    src/package/exppattern.h \
    src/package/god.h \
    src/package/maneuvering.h \
    src/package/nostalgia.h \
    src/package/package.h \
    src/package/standard.h \
    src/package/standard-equips.h \
    src/package/standard-skillcards.h \
    src/scenario/boss-mode-scenario.h \
    src/scenario/couple-scenario.h \
    src/scenario/guandu-scenario.h \
    src/scenario/miniscenarios.h \
    src/scenario/scenario.h \
    src/scenario/scenerule.h \
    src/scenario/zombie-scenario.h \
    src/server/ai.h \
    src/server/gamerule.h \
    src/server/generalselector.h \
    src/server/room.h \
    src/server/roomthread.h \
    src/server/server.h \
    src/server/serverplayer.h \
    src/ui/button.h \
    src/ui/cardcontainer.h \
    src/ui/carditem.h \
    src/ui/chatwidget.h \
    src/ui/clientlogbox.h \
    src/ui/dashboard.h \
    src/ui/indicatoritem.h \
    src/ui/magatamas-item.h \
    src/ui/photo.h \
    src/ui/pixmapanimation.h \
    src/ui/qsanbutton.h \
    src/ui/rolecombobox.h \
    src/ui/roomscene.h \
    src/ui/sprite.h \
    src/ui/startscene.h \
    src/ui/window.h \
    src/util/detector.h \
    src/util/nativesocket.h \
    src/util/recorder.h \
    src/util/socket.h \
    src/core/record-analysis.h \
    src/package/hegemony.h \
    src/scenario/fancheng-scenario.h \
    src/package/bgm.h \
    src/package/fire.h \
    src/package/h-formation.h \
    src/package/h-momentum.h \
    src/package/mountain.h \
    src/package/sp.h \
    src/package/yjcm.h \
    src/package/yjcm2012.h \
    src/package/yjcm2013.h \
    src/package/yjcm2014.h \
    src/core/room-state.h \
    src/core/wrapped-card.h \
    src/ui/bubblechatbox.h \
    src/ui/generic-cardcontainer-ui.h \
    src/ui/qsan-selectable-item.h \
    src/ui/skin-bank.h \
    src/ui/table-pile.h \
    src/ui/timed-progressbar.h \
    src/ui/ui-utils.h \
    src/package/thicket.h \
    src/package/wind.h \
    src/dialog/banipdialog.h \
    src/package/jsp.h \
    src/pch.h \
    src/dialog/dialogslsettings.h \
    src/core/defines.h

FORMS += \
    src/dialog/cardoverview.ui \
    src/dialog/configdialog.ui \
    src/dialog/connectiondialog.ui \
    src/dialog/generaloverview.ui \
    src/dialog/mainwindow.ui \
    src/dialog/dialogslsettings.ui


CONFIG(buildbot) {
    DEFINES += USE_BUILDBOT
    SOURCES += src/bot_version.cpp
}


INCLUDEPATH += include
INCLUDEPATH += src/client
INCLUDEPATH += src/core
INCLUDEPATH += src/dialog
INCLUDEPATH += src/package
INCLUDEPATH += src/scenario
INCLUDEPATH += src/server
INCLUDEPATH += src/ui
INCLUDEPATH += src/util

win32{
    RC_FILE += resource/icon.rc
}

macx{
    ICON = resource/icon/sgs.icns
}

LIBS += -L.
win32-g++{
    DEFINES += WIN32
    LIBS += -L"$$_PRO_FILE_PWD_/lib/win/MinGW"
    DEFINES += GPP
}
macx{
    DEFINES += MAC
    LIBS += -L"$$_PRO_FILE_PWD_/lib/mac/lib"
}
ios{
    DEFINES += IOS
    CONFIG(iphonesimulator){
        LIBS += -L"$$_PRO_FILE_PWD_/lib/ios/simulator/lib"
    }
    else {
        LIBS += -L"$$_PRO_FILE_PWD_/lib/ios/device/lib"
    }
}
linux{
    android{
        DEFINES += ANDROID
        ANDROID_LIBPATH = $$_PRO_FILE_PWD_/lib/android/$$ANDROID_ARCHITECTURE/lib
        LIBS += -L"$$ANDROID_LIBPATH"
    }
    else {
        DEFINES += LINUX
        !contains(QMAKE_HOST.arch, x86_64) {
            LIBS += -L"$$_PRO_FILE_PWD_/lib/linux/x86"
            QMAKE_LFLAGS += -Wl,--rpath=lib/linux/x86
        }
        else {
            LIBS += -L"$$_PRO_FILE_PWD_/lib/linux/x64"
            QMAKE_LFLAGS += -Wl,--rpath=lib/linux/x64
        }
    }
}

CONFIG(audio){
    DEFINES += AUDIO_SUPPORT
    INCLUDEPATH += include/fmod
    CONFIG(debug, debug|release): LIBS += -lfmodexL
    else:LIBS += -lfmodex
    SOURCES += src/core/audio.cpp

    android{
        CONFIG(debug, debug|release):ANDROID_EXTRA_LIBS += $$ANDROID_LIBPATH/libfmodexL.so
        else:ANDROID_EXTRA_LIBS += $$ANDROID_LIBPATH/libfmodex.so
    }
}

CONFIG(lua){
    LIBS += -llua -ldl
    INCLUDEPATH += include/lua
}


!build_pass{
    system("lrelease $$_PRO_FILE_PWD_/builds/sanguosha.ts -qm $$_PRO_FILE_PWD_/sanguosha.qm")

    SWIG_bin = "swig"
    contains(QMAKE_HOST.os, "Windows"): SWIG_bin = "$$_PRO_FILE_PWD_/tools/swig/swig.exe"

    system("$$SWIG_bin -c++ -lua $$_PRO_FILE_PWD_/swig/sanguosha.i")
}

TRANSLATIONS += builds/sanguosha.ts

CONFIG(debug, debug|release): LIBS += -lfreetype_D
else:LIBS += -lfreetype

INCLUDEPATH += $$_PRO_FILE_PWD_/include/freetype
DEPENDPATH += $$_PRO_FILE_PWD_/include/freetype

ANDROID_PACKAGE_SOURCE_DIR = $$_PRO_FILE_PWD_/resource/android