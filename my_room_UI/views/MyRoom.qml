import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Controls.Universal 2.3
import assets 1.0

Item {
    anchors.fill: parent

    function init()
    {
        opacity = 1.0
    }

    opacity: 0

    Behavior on opacity { NumberAnimation { duration: 800 } }



     TabBar {
        id: tabBar
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: Style.wHeight * 0.08
        Universal.theme: Universal.Dark

        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Light")
            font.bold: true
            font.family: Style.fontAwesome
            font.pixelSize: Style.mediumFontSize
        }
        TabButton {
            text: qsTr("Fan")
            font.bold: true
            font.family: Style.fontAwesome
            font.pixelSize: Style.mediumFontSize

        }
    }



    SwipeView{
        id: swipeView
        anchors{
            top: tabBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        currentIndex: tabBar.currentIndex
        onCurrentItemChanged: currentItem.forceActiveFocus()

        Light {


        }

        Fan {


        }



        Component.onCompleted: {

            currentItem.forceActiveFocus()
            colorBar.statusBarColor = "black"
            colorBar.navigationBarColor ="#15202b"
        }

    }

}





