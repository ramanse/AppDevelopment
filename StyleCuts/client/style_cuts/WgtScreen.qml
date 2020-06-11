import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Utils 1.0
import Common 1.0
Page {
    id: root
    anchors.fill: parent
    background: Rectangle{color:"transparent"}
    property alias pageContent: content.sourceComponent
    property bool isHeaderFooter: false
    WgtImage{
        id: header
        visible: isHeaderFooter
        anchors.top:parent.top
        source: "assets/footerBg.png"
    }
    WgtImage{
        id: footer
        visible: isHeaderFooter
        anchors.bottom:parent.bottom
        source: "assets/footerBg.png"
    }

    Loader{
        id: content
        width: parent.width - parent.width * 0.2
        height: parent.height - 2 * footer.height
        anchors.centerIn: parent
        onLoaded: {
            if(item){
                item.anchors.fill = content
            }
        }

    }

}
