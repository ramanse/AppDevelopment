import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Window 2.13
import Utils 1.0
import Common 1.0

ApplicationWindow {
    id: window
    visible: true
    title: qsTr("Style Cuts")
    onWidthChanged: {
        console.error("Width is " + width)
    }
    onHeightChanged: {
        console.error("Height is "+ height)
    }

    QtObject {
        id: resources
        property string mainBg: "assets/Background.png"
        readonly property real refWidth: 1334
        readonly property real refHeight: 720
        property real scaleFact: Math.min(height/refHeight, width/refWidth);
        onScaleFactChanged: {
            Common.scaleFactor = 0.6
            Common.isPotrait = window.inPortrait
        }
    }

    WgtImage{
        id: _bg
        anchors.fill: parent
        source: resources.mainBg
    }
    Connections{
        target: Common
        onPushMenu:{
            screens.push(url)
        }
        onToHome:{
            screens.pop()
        }
    }

    StackView{
        id: screens
        anchors.fill: parent
        initialItem: MainPage{ anchors.fill: parent
        }

    }
}
