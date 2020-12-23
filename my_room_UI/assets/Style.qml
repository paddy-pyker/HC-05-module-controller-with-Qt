pragma Singleton
import QtQuick 2.9

Item {
    property alias fontAwesome: fontAwesomeLoader.name
    property alias corsiva: corsivaLoader.name


    property int wHeight
    property int wWidth




    // colors
    readonly property color titleBarBackground: "#3899e2"
    readonly property color titleBarForeground: "white"
    readonly property color pairedDevicesColor: "slategrey"
    readonly property color foundDevicesColor: "black"


    // Font sizes
    property real microFontSize: hugeFontSize * 0.2
    property real tinyFontSize: hugeFontSize * 0.4
    property real smallTinyFontSize: hugeFontSize * 0.5
    property real smallFontSize: hugeFontSize * 0.6
    property real mediumFontSize: hugeFontSize * 0.7
    property real bigFontSize: hugeFontSize * 0.8
    property real largeFontSize: hugeFontSize * 0.9
    property real hugeFontSize: (wWidth + wHeight) * 0.03
    property real giganticFontSize: (wWidth + wHeight) * 0.04
    property real margin: 0.02 * wHeight


    // Some help functions for images
    function widthForHeight(h, ss)
    {
        return h/ss.height * ss.width;
    }

    function heightForWidth(w, ss)
    {
        return w/ss.width * ss.height;
    }


   // font
    FontLoader {
        id: fontAwesomeLoader
        source: "qrc:/assets/fontawesome.ttf"
    }

    FontLoader {
        id: corsivaLoader
        source: "qrc:/assets/corsiva.ttf"
    }
}
