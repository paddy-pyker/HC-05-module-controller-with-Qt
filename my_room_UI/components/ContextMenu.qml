import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import assets 1.0
import QtGraphicalEffects 1.0
import QtQml 2.13


Rectangle{

    height: 0.165 * Style.wHeight
    width: 0.4 * Style.wWidth
    radius: 8
    signal scanPressed()

    Rectangle {
        id:root


        radius: 8
        height: parent.height
        width:parent.width



        Rectangle{
            id:m1
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 1/3 * parent.height
            radius: 8
            opacity: 0.7



            Text {
                anchors.fill: parent
                anchors.leftMargin: Style.margin
                text: qsTr("Scan")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Style.smallTinyFontSize


                MouseArea{
                    anchors.fill: parent
                    onPressed: root.state = "pressed"
                    onReleased: root.state = ""
                    onClicked: scanPressed()

                }

            }

        }



        Rectangle{
            id:m2
            anchors{
                top: m1.bottom
                left: parent.left
                right: parent.right
            }
            height: 1/3 * parent.height
            radius: 8
            opacity: 0.7

            Text {
                id:na
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: Style.margin
                }
                width: 0.5 *parent.width

                text: qsTr("R.L.D")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Style.smallTinyFontSize

                MouseArea{
                    anchors.fill: parent
                }
            }

            Switch{
                id:toggle
                anchors{
                    left: na.right
                    bottom: parent.bottom
                    top: parent.top
                    right: parent.right
                    rightMargin: .9* Style.margin

                }
                position: bluetoothManager.toggler



                Binding{
                    target: bluetoothManager
                    property: "toggler"
                    value: toggle.position
                }

                onPositionChanged: {

                    console.log(position)
                    if(toggle.position == 0){
                        time.start()
                    }
                }

                Timer{
                    id:time
                    interval: 0
                    onTriggered: bluetoothManager.connection_reviewed()
                }


                Binding {
                    target: toggle.indicator
                    property: 'width'
                    value: toggle.width
                }

                Binding {
                    target: toggle.indicator
                    property: 'height'
                    value: toggle.height *.4
                }

                Binding{
                    target: (toggle.indicator ? toggle.indicator.children[0] : null)
                    property: 'width'
                    value: toggle.width
                }
            }

        }



        Rectangle{
            id:m3
            anchors{
                top: m2.bottom
                left: parent.left
                right: parent.right
            }
            height: 1/3 * parent.height
            radius: 8
            opacity: 0.7


            Text {
                anchors.fill: parent
                anchors.leftMargin: Style.margin
                text: qsTr("Quit")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize:  Style.smallTinyFontSize


            }

            MouseArea{
                anchors.fill: parent
                onPressed: root.state = "pressed1"
                onReleased: root.state = ""
                onClicked: Qt.quit()

            }

        }





        states: [
            State {
                name: "pressed1"
                PropertyChanges {
                    target: m3
                    color: "lightgrey"

                }
            },
            State {
                name: "pressed"
                PropertyChanges {
                    target: m1
                    color: "lightgrey"

                }
            }]

    }

    DropShadow{
        anchors.fill: root
        cached: true
        horizontalOffset: -5
        verticalOffset: 5
        radius: 10
        samples: 21
        color: "#aa000000"
        source: root
    }



}
