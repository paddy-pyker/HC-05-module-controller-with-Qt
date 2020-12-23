import QtQuick 2.9
import assets 1.0

Item {
    id:root
    width: Style.wWidth - Style.wWidth * 0.05
    height: Style.wHeight - Style.wHeight * 0.05


    Keys.onEscapePressed: bluetoothManager.exitNotification()
    Keys.onBackPressed: bluetoothManager.exitNotification()



    Rectangle{
        id:test
        anchors.fill: parent
        color:  "#15202b"

        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: th.top
            anchors.top: parent.top
            anchors.margins:Style.margin*5
            width: Style.widthForHeight(height,sourceSize)
            source: "qrc:/assets/light.png"

            opacity: 0

            NumberAnimation on opacity { to: 1; duration: 1700; easing.type:Easing.InQuint}


        }


        Rectangle{
            id:th
            anchors.centerIn: parent
            width: Style.wWidth * .5
            height: Style.wHeight * .25
            radius: 360
            color: "#3f1dd6"

            Text {
                id:name
                anchors.centerIn: parent
                text: qsTr("\uf011")
                font.bold: true
                font.family: Style.fontAwesome
                font.pixelSize: Style.giganticFontSize * 2.4
            }

            MouseArea{
                anchors.fill: parent
                onPressed: root.state = "pressed"
                onReleased: root.state = ""
                onCanceled: root.state = ""
                onClicked:{
                    bluetoothManager.turn_on_light()
                }
            }

        }


    }

    states: [
        State {
            name: "pressed"
            PropertyChanges {
                target: name
                font.pixelSize: Style.giganticFontSize * 1.8
            }
            PropertyChanges {
                target: th
                color:Qt.darker("#3f1dd6")
            }
        } ]



}
