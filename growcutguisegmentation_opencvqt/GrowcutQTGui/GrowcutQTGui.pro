#-------------------------------------------------
#
# Project created by QtCreator 2015-07-15T11:39:01
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = GrowcutQTGui
TEMPLATE = app

win32 { # qt su windows 7 #-----------------------------

    INCLUDEPATH += C:\Programs\opencv2411\install\include # giusta
    LIBS += C:\Windows\SysWOW64\libopencv_core2411.dll \
            C:\Windows\SysWOW64\libopencv_highgui2411.dll \
            C:\Windows\SysWOW64\libopencv_imgproc2411.dll


} #----------------------------------------------------

unix { # qt su linux mint #----------------------------

    INCLUDEPATH += /usr/local/include/opencv
    LIBS += `pkg-config opencv --libs`

} #----------------------------------------------------




SOURCES += main.cpp\
        growcutgui.cpp \
    cvmatandqimage.cpp \
    clickablelabel.cpp

HEADERS  += growcutgui.h \
    cvmatandqimage.h \
    clickablelabel.h \
    import_libraries.h

FORMS    += growcutgui.ui

DISTFILES += \
    vecchimetodi.txt \
    mouserelease.txt \
    grabcut_guida \
    guidaInstallazioneOpenCVQT
