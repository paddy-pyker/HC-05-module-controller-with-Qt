import QtQuick 2.9
import assets 1.0
import QtGraphicalEffects 1.0

Item {
    id:root
    anchors.fill: parent

    signal bluetoothThrow()

    Rectangle{
        anchors.fill: parent
        color: "#7f000000"

        MouseArea{
            anchors.fill: parent
            onClicked: bluetoothThrow()
        }
        Component.onCompleted:{
            colorBar.statusBarColor ="#1c4d71"
            colorBar.navigationBarColor= "#7f000000"
        }

        Rectangle{
            id:glow
            anchors.centerIn: parent
            height: Style.wHeight*0.17
            width: Style.wWidth*0.7
            radius:Style.margin*.8
            z:root.z +1

            Text {
                anchors.fill: parent
                id: name
                text: qsTr("Please Turn On Bluetooth and Location")
                font.pixelSize: Style.smallFontSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                color: "#a0000000"
                font.bold: true
            }
        }

        Glow{
            anchors.fill: glow
            radius: 45
            samples: 91
            color: "#7fffffff"
            source: glow

        }

    }
}
