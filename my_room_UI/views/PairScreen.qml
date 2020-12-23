


////                                This is the main program page


import QtQuick 2.9
import components 1.0 as Custom
import assets 1.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import StatusNavigationBar 0.1



Item {
    id:root
    anchors.fill: parent
    focus: true

    Keys.onEscapePressed: {
        exit.sourceComponent=closer
        exit.item.forceActiveFocus()
        exitTimer.start()
        titlebar.ellipsisPressed()  /////////////////////////////
    }

    Keys.onBackPressed: {
        exit.sourceComponent=closer
        exit.item.forceActiveFocus()
        exitTimer.start()

    }


    Loader{
        id:exit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Component{
        id:closer
        Text {
            text: qsTr("press again to exit")
            color: "blue"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Style.tinyFontSize
            font.bold : true
            Keys.onBackPressed: Qt.quit()
            Keys.onEscapePressed: Qt.quit()
            SequentialAnimation on opacity {  NumberAnimation {  to: 0; duration: 2000; }}
        }

    }

    Timer {
        id: exitTimer
        interval: 2000
        onTriggered: exit.setSource("")
    }



    Custom.TitleBar{
        id:titlebar
        onEllipsisPressed:{
            contextmenu.source = "qrc:/components/ContextMenu.qml"
            locker.enabled = true
        }

    }

    /// Menu Commands
    Loader{
        id:contextmenu
        anchors{
            top: parent.top
            right: parent.right
            margins: Style.margin * .5
        }
        z:2
    }


    /// Connecting Device Dialog
    Loader{
        id:connectingDialog
        anchors.fill: parent
        z:2
    }

    Loader{
        id:exitDialog
        anchors.fill: parent
        z:5
    }
 // bluetooth check Dialog listener
    Connections{
        target: connectingDialog.item
        onBluetoothThrow:{
            colorBar.navigationBarColor="white"
            colorBar.statusBarColor=Style.titleBarBackground
             connectingDialog.setSource("")
        }
    }

    Connections{
        target: contextmenu.item
        onScanPressed:{
            devices.model = 0
            bluetoothManager.scan_for_devices()
            time.start()
            contextmenu.setSource("")
            locker.enabled = false
        }
    }


    Connections{
        target: bluetoothManager
        onAgreed:{
            connectingDialog.setSource("")
        }
    }

  ////// exit Dialog
    Connections{
        target: bluetoothManager
        onExitNotification:{
            exitDialog.setSource("qrc:/components/ExitDialog.qml")
            exitDialog.forceActiveFocus()
        }
    }

    Connections{
        target: exitDialog.item
        onExit:{
            exitDialog.setSource("")
            bluetoothManager.agreed()
            colorBar.statusBarColor = Style.titleBarBackground
            colorBar.navigationBarColor = "white"
        }
        onCancel:{
            exitDialog.setSource("")
            connectingDialog.forceActiveFocus()
        }
    }

    /// bluetooth adapter is off
    Connections{
        target: bluetoothManager
        onDeviceIsOff:connectingDialog.setSource("qrc:/components/BluetoothCheck.qml")
    }

    /// connection to device has been successful
    Connections{
        target: bluetoothManager
        onUi_conn_Success:{
            connectingDialog.source = "qrc:/views/MyRoom.qml"
            connectingDialog.item.init()
        }
    }
    ///  connections to device unsuccessful
    Connections{
        target: bluetoothManager
        onUi_conn_Error:{
            connectingDialog.source = "qrc:/components/ErrorDialog.qml"
        }

    }

    Connections{
        target: bluetoothManager
        onScanCompleted:{
            time.stop()
            devices.model = bluetoothManager.foundDevices
        }
    }

    Connections{
        target: bluetoothManager
        onConnectLastDevice:{
            connectingDialog.source = "qrc:/components/ConnectingDialog.qml"
            connectingDialog.item.description = id
        }
    }

    MouseArea{
        id:locker
        anchors.fill: parent
        enabled: false
        z:1
        onClicked: {contextmenu.setSource("");enabled = false}

    }

    Custom.Header{
        id:header
        anchors{
            top:titlebar.bottom

        }

    }


    ListView{
        id:devices
        anchors{
            top: header.bottom
            topMargin: Style.margin * 2
            margins: Style.margin
            left: parent.left
            right: parent.right
            bottom: parent.bottom

        }
        clip: true
        delegate: Custom.FoundDevicesDelegate{
            devices: modelData
            onSelectedDevice: {
                connectingDialog.source = "qrc:/components/ConnectingDialog.qml"
                connectingDialog.item.description = id
                bluetoothManager.device_selected(id,mac)
            }
        }


    }



    BusyIndicator{
        running: !devices.model
        implicitHeight: Style.wHeight * 0.2
        implicitWidth: Style.wWidth * 0.2
        x: 1/2*Style.wWidth - 1/2*implicitWidth
        y: 1/2*Style.wHeight - 1/2*implicitHeight
        Universal.accent: Style.titleBarBackground
    }


    Timer{
        id:time
        interval: 500
        repeat: true
        onTriggered: devices.model = bluetoothManager.foundDevices
    }

    Timer{
        id:checksomtin
        interval: 1998
        onTriggered: bluetoothManager.scan_for_devices()
    }

    Timer{
        id:connectlast
        interval: 2000
        onTriggered: bluetoothManager.connect_last_device()
    }

    Component.onCompleted:{

        time.start()
        checksomtin.start()
        connectlast.start()
    }


}



