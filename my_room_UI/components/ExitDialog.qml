import QtQuick 2.9
import QtQuick.Controls 2.5
import assets 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Universal 2.3

Item {
    id:root
    anchors.fill: parent
    focus: true

    signal cancel()
    signal exit()

    Keys.onBackPressed: cancel()
    Keys.onEscapePressed: cancel()
    Keys.onEnterPressed: okbutton.clicked()

    Rectangle{
        anchors.fill: parent
        color: "#7f000000"

        MouseArea{
            anchors.fill: parent
            onClicked: {cancel();colorBar.navigationBarColor = "#15202b"}
        }
        Component.onCompleted:{
            colorBar.statusBarColor ="black"
            colorBar.navigationBarColor= "#0b1016"
        }

        Rectangle{
            id:glow
            anchors.centerIn: parent
            height: Style.wHeight*0.25
            width: Style.wWidth*0.7
            radius:Style.margin*.8
            z:root.z +1

            Text {
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 0.7*parent.height

                id: name
                text: qsTr("Are You Sure You Want To Disconnect")
                font.pixelSize: Style.smallFontSize
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                color: "#c8000000"
            }

            RoundButton{
                id:okbutton
                anchors{
                    top: name.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                Text{
                    text: "OK"
                    anchors.centerIn: parent
                    font.pixelSize: Style.smallFontSize
                    font.bold: true
                }

                height: 0.3 * parent.height
                width:height
                onClicked: {bluetoothManager.disconnectSocket();exit()}


            }
        }

        Glow{
            anchors.fill: glow
            radius: 45
            samples: 91
            color: "#7fddb976"
            source: glow

        }

    }
}
