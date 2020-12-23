QT += quick qml quickcontrols2 bluetooth



CONFIG += c++14

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += main_source \
    $$PWD/../my_room_CORE
	
include(theme/statusbar.pri)

SOURCES += \
        main_source/main.cpp

RESOURCES += views.qrc \
    assets.qrc \
    components.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../my_room_CORE/release/ -lmy_room_CORE
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../my_room_CORE/debug/ -lmy_room_CORE
else:unix: LIBS += -L$$OUT_PWD/../my_room_CORE/ -lmy_room_CORE



# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/src/enterprise/paddy/pyker/QtAndroidService.java \
    android/src/enterprise/paddy/pyker/MainActivity.java




contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}



