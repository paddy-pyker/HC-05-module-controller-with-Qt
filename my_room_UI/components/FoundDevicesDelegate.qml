import QtQuick 2.9
import assets 1.0
import BT 1.0

Rectangle {
    id:root
    anchors{
        left: parent.left
        right: parent.right
      }
    height:Style.wHeight * 0.08 + 5
    opacity: .75
    radius: 10

    property DeviceInfo devices
    signal selectedDevice(string mac,string id)



    Text {
        id:name
        text: devices.name
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        anchors{
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            margins: Style.margin
        }
        width: 1/2* parent.width
        font.pixelSize:Style.smallTinyFontSize
        elide: Text.ElideRight
    }






        Text {
            id:mac
              text: devices.macAddress
              verticalAlignment: Text.AlignBottom
              horizontalAlignment: Text.AlignRight
              anchors{
                 bottom: parent.bottom
                 right: parent.right
                 left: name.right
                 margins: Style.margin
              }
              height: parent.height
              font.pixelSize: Style.tinyFontSize
              elide: Text.ElideRight
        }



        MouseArea{
            anchors.fill: parent
            onPressed: parent.state = "pressed"
            onCanceled: parent.state = ""
            onReleased: parent.state = ""
            onClicked: selectedDevice(mac.text,name.text)

        }




        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: root
                    color: "lightgrey"

                }
            }]







    }







