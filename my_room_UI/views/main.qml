import QtQuick 2.9
import QtQuick.Window 2.1
import QtQuick.Controls 2.5
import assets 1.0
import QtQuick.Controls.Universal 2.3

ApplicationWindow {
    id: wroot
    visible: true
    title: qsTr("My Room")
    color: "#ffffff"
    width: 720 * .7
    height: 1240 * .7
    maximumWidth: width
    minimumWidth: width
    minimumHeight: height
    maximumHeight: height


    Component.onCompleted: {
        Style.wWidth = Qt.binding(function() {return width})
        Style.wHeight = Qt.binding(function() {return height})
    }

    Loader {
        id: splashLoader
        anchors.fill: parent
        source: "SplashScreen.qml"
        asynchronous: false
        visible: true


        onStatusChanged: {
            if (status === Loader.Ready) {
                appLoader.setSource("PairScreen.qml");
            }
        }
    }

    Connections {
        target: splashLoader.item
        onReadyToGo: {
            appLoader.visible = true
            colorBar.navigationBarColor="white"
            splashLoader.visible = false
            splashLoader.setSource("")
            appLoader.item.forceActiveFocus();
        }
    }

    Loader {
        id: appLoader
        anchors.fill: parent
        visible: false
        asynchronous: true
        onStatusChanged: {
            if (status === Loader.Ready)
                splashLoader.item.appReady()

        }
    }
}
