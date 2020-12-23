import QtQuick 2.9
import assets 1.0
import QtGraphicalEffects 1.0

Item {
    id:root
    anchors.fill: parent
    property alias  description: name2.text

    Rectangle{
        anchors.fill: parent
        color: "black"
        opacity: .8

        MouseArea{
            anchors.fill: parent
        }
        Component.onCompleted:{
            colorBar.statusBarColor = "#0b1f2d"
            colorBar.navigationBarColor = "#cc000000"
        }
    }



    Glow{
        anchors.fill: dialog
        radius: 45
        samples: 91
        color: "#7f3899e2"
        source: dialog

    }



    Rectangle{
        id:dialog
        anchors.centerIn: parent
        height: 1/4 * Style.wHeight
        width: 0.7 * Style.wWidth
        radius: 10



        Text {
            id: name
            text: qsTr("Connecting to")
            anchors{
                left: parent.left
                right: parent.right
            }
            color: "#50000000"
            font.pixelSize: Style.smallFontSize
            height: 1/5* parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: name2
            anchors{
                left: parent.left
                right: parent.right
                top: name.bottom
            }
            color: "#c8000000"
            height: name.height
            font.pixelSize: Style.bigFontSize
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle{
            anchors{
                top: name2.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: Style.margin
            }
            radius: 10


            Image {
                id: bluetoothImage
                source: "qrc:/assets/default.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit

                RotationAnimation on rotation{
                    id: ranimation
                    target: bluetoothImage
                    easing.type: Easing.InOutBack
                    property: "rotation"
                    from: 0
                    to: 360
                    duration: 1500
                    loops: Animation.Infinite
                    alwaysRunToEnd: true
                    running: true
                }
            }
        }




    }

}








