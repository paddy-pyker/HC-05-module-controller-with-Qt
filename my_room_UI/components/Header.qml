import QtQuick 2.9
import assets 1.0

Item {

    height: Style.wHeight * .06 + baseline.height
    anchors.left: parent.left
    anchors.right: parent.right

    Rectangle{
        id:header
        anchors{
            top: parent.top
            topMargin: Style.margin *.5
            left: parent.left
            right: parent.right
        }
        height: Style.wHeight * .06

        Text {
            id: name
            text: qsTr(" \uf294  Found Devices")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: Style.mediumFontSize
            font.family: Style.fontAwesome
            color: "dimgrey"
        }

    }

    Rectangle{
        id:baseline
        anchors{
            top: header.bottom
            topMargin: Style.margin * .5
            left: parent.left
            right: parent.right
            leftMargin: Style.wWidth * 0.1
            rightMargin: Style.wWidth * 0.1
        }
        height: 2
        color: Style.titleBarBackground
    }

}
