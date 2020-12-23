import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import assets 1.0
import QtGraphicalEffects 1.0

Item {
    id:root
    anchors.fill: parent


    Rectangle{
        anchors.fill: parent
        color: "black"
        opacity: .8

        MouseArea{
            anchors.fill: parent
        }
    Component.onCompleted: colorBar.statusBarColor="#c2ff0000"
    }


    Glow{
        anchors.fill: dialog
        radius: 45
        samples: 91
        color: "#7fc80000"
        source: dialog

    }



    Rectangle{
        id:dialog
        anchors.centerIn: parent
        height: 1/4 * Style.wHeight
        width: 0.7 * Style.wWidth
        radius: 10


        Rectangle{
            id:first
            anchors{
                top: dialog.top
                left: parent.left
                right: parent.right

            }
            height:1/3* parent.height

            Image {
                id: errorImage
                source: "qrc:/assets/download.png"
                anchors{
                    top: parent.top
                    left: parent.left
                    leftMargin: Style.margin
                    topMargin: Style.margin
                    bottomMargin: Style.margin
                    bottom: parent.bottom
                }
                width: Style.widthForHeight(height,sourceSize)

            }

                        Text {
                            id: name
                            text: qsTr("Error!")
                            anchors{
                                top: parent.top
                                left: errorImage.right
                                leftMargin: Style.margin* .5
                                right: parent.right
                                bottom: parent.bottom
                            }

                            color: "grey"
                            font.pixelSize: Style.largeFontSize
                            verticalAlignment: Text.AlignVCenter
                        }


        }


        Rectangle{
            id:second
            anchors{
                top: first.bottom
                left: parent.left
                right: parent.right

            }
            height:1/3* parent.height

            Text {
                text: qsTr("Failed To Connect")
                anchors.centerIn: parent
                font.pixelSize: Style.bigFontSize
                font.bold: true
                color: "#c8000000"
            }
        }


        Rectangle{
            id:third
            anchors{
                top: second.bottom
                left: parent.left
                right: parent.right
            }
            height:1/3* parent.height

            Rectangle{
               anchors.centerIn: parent
               radius: 10
               height: parent.height
               width: 1/4 *parent.width

               RoundButton{

                   Text{
                       text: "OK"
                       color: "#ffc80000"
                       anchors.centerIn: parent
                       font.pixelSize: Style.smallFontSize
                       font.bold: true
                   }

                   anchors.fill: parent
                   onClicked:{
                       colorBar.statusBarColor=Style.titleBarBackground
                       colorBar.navigationBarColor="white"
                       bluetoothManager.agreed()
                   }

               }
            }
        }



    }

}








