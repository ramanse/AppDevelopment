import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Utils 1.0
import Common 1.0
Item {
    id: root
    anchors.fill: parent

    property var menuModel: [
        {'name': 'Appointment', 'url':'SchedulingPage.qml'},
        {'name': 'Catalogue', 'url':''},
        {'name': 'About us', 'url':''},
        {'name': 'Contact us', 'url':''},
        {'name': 'Feedback', 'url':''}]

    Item{
        id: logo
        width: parent.width
        height: lady.height
        anchors.top:parent.top
        anchors.topMargin: Common.dpiSize(100)
        anchors.horizontalCenter: parent.horizontalCenter
        WgtText {
            id: style
            anchors.left:parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: lady.verticalCenter
            font.family: "GaramondRetrospectiveSSK"
            font.pointSize: Common.dpiSize(110)
            text: qsTr("Style")
            color: "black"

        }
        WgtImage{
            id: lady
            anchors.top: parent.top
            anchors.left: style.right
            source: "assets/logo.png"
        }
        WgtText {
            id: cuts
            anchors.left: lady.right
            anchors.leftMargin: Common.dpiSize(-20)
            anchors.verticalCenter: lady.verticalCenter
            text: qsTr("Cuts")
            color: "black"
            font.pointSize: Common.dpiSize(110)
        }

        WgtText{
            id: subTxt
            anchors.left:cuts.left
            anchors.leftMargin: -20
            anchors.bottom: cuts.bottom
            anchors.bottomMargin: -30
            font.family: Common.snellFont
            text: qsTr("a family salon")
            color:"black"
            font.pointSize: Common.dpiSize(45)
        }
    }
    Column{
        id: grid
        property int itemWidth: 240
        property int itemHeight: 50

        width:parent.width
        height: (itemHeight + spacing) * menuModel.length
        anchors.top: logo.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15
        Repeater {
            model: menuModel.length
            WgtButton {
                width: grid.itemWidth; height: grid.itemHeight
                anchors.horizontalCenter: parent.horizontalCenter
                btnText: menuModel[index].name
                onTriggered: Common.pushMenu(menuModel[index].url)

            }
        }
    }
}

