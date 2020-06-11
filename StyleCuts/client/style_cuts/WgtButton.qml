import QtQuick 2.13
import QtQuick.Controls 2.13
import Common 1.0

Item {
    id: btn
    property alias btnText:btnLabel.text
    property alias showBtnBg: btnBg.visible
    property alias btnImageSource: btnImg.source

    signal triggered()
    WgtImage{
        id: btnBg
        anchors.fill: parent
        source: "assets/buttonBg.png"
    }
    WgtText{
        id: btnLabel
        anchors.centerIn: parent
        font.pointSize : 35
        color: "#eec715"
    }
    WgtImage{
        id: btnImg
        anchors.centerIn: parent
        visible: source !== ""
    }

    Behavior on scale{
        NumberAnimation{}
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            btn.scale = 0.9
        }
        onReleased: {
            btn.scale = 1.0
            triggered()
        }
    }

}
