import QtQuick 2.9
import assets 1.0

Item {
    id:root
    width: parent.width
    height: Style.wHeight * 0.08

    signal ellipsisPressed()


    Rectangle{
        anchors.fill: parent
        color: Style.titleBarBackground
    }

    Text {
        id:apptitle
        color: Style.titleBarForeground
        text: "My Room"
        font.family: Style.corsiva
        font.bold: true
        style: Text.Outline
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Style.bigFontSize
        anchors{
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: Style.margin
        }
    }


    Rectangle{
        id:mousearea
        anchors{
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            rightMargin: Style.margin
            margins: 5
        }
        width: Style.wWidth * 0.1
        radius: 360
        color:Style.titleBarBackground



        Text {
            id: menu
            text: qsTr("\uf142")
            font.family: Style.corsiva
            color: Style.titleBarForeground
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Style.hugeFontSize
            anchors.fill: parent
            font.weight: Font.Light

        }

        MouseArea{
            anchors.fill: parent
            onPressed: root.state = "pressed"
            onReleased: root.state = ""
            onClicked: ellipsisPressed()

        }
    }


    states: [
        State {
            name: "pressed"
            PropertyChanges {
                target: mousearea
                color: "lightgrey"
                opacity:0.4
            }
        } ]

}
