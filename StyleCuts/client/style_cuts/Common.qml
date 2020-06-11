pragma Singleton

import QtQuick 2.13

Item {
    property real scaleFactor: 1.0
    property var snellFont: fSnellloader.name
    property var  font: fGarmondloader.name
    property var isPotrait: false
    signal pushMenu(var url)
    signal toHome()
    FontLoader{
        id: fSnellloader
        source: "fonts/Snell_Roundhand_Script.ttf"
    }
    FontLoader{
        id: fGarmondloader
        source: "fonts/GaramondRetrospectiveSSKItalic.ttf"
    }
    function dpiSize (value) {
        return scaleFactor * value
    }
}
