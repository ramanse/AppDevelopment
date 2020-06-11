import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import Utils 1.0
import Common 1.0
import Utils 1.0
WgtScreen {
    id: root
    isHeaderFooter:true
    property var components: [calendarItem,timePicker,submitForm,endForm]
    property var hourSelected:"00"
    property var minuteSelected:"00"
    property var daySelected:""
    DBHandler{
        id: dbHandle
    }
    CustomerModel{
        id: customerModel
    }

    pageContent: Component{
        StackView{
            id: view
            initialItem: components[currentIndex]
            property int currentIndex:0

            WgtButton{
                btnText: view.currentIndex == 0?"Home":"Back"
                width:100
                height: 100
                anchors.top: parent.bottom
                anchors.left: parent.left

                onTriggered: {
                    if(view.currentIndex == 0)
                        Common.toHome()
                    else{
                        view.currentIndex -= 1
                        view.pop()
                    }
                }
            }

            WgtButton{
                btnText: view.currentIndex == components.length - 2?"Submit":view.currentIndex == components.length - 1?"Home":"Next"
                width:100
                height: 100
                anchors.top: parent.bottom
                anchors.right: parent.right
                onTriggered: {
                    if(view.currentIndex < components.length){
                        if(view.currentIndex == components.length - 1){
                            Common.toHome()
                        }

                        else{
                            if(view.currentIndex == components.length - 2){
                                customerModel.doa  = daySelected + hourSelected + ":"+minuteSelected+":00"
                                dbHandle.appointmentRequest(customerModel)
                            }

                            view.currentIndex += 1
                            view.push(components[view.currentIndex])
                        }
                    }
                }
            }
        }


    }

    Component{
        id: calendarItem
        Calendar {
            id: cal
            anchors.centerIn: parent
            width: 560
            height: 480
            onSelectedDateChanged: {
                const day = selectedDate.getDate();
                const month = selectedDate.getMonth() + 1; //assuming you want 1..12, getMonth()'s return value is zero-based!
                const year = selectedDate.getFullYear();
                daySelected = year+"-"+month+"-"+day + " "

            }
            style: CalendarStyle {
                gridVisible: false

                navigationBar: Rectangle {
                         height: Math.round(TextSingleton.implicitHeight * 2.73)
                         color: "#f9f9f9"

                         Rectangle {
                             color: Qt.rgba(1,1,1,0.6)
                             height: 1
                             width: parent.width
                         }

                         Rectangle {
                             anchors.bottom: parent.bottom
                             height: 1
                             width: parent.width
                             color: "#ddd"
                         }

                         WgtButton {
                             id: previousMonth
                             width: parent.height
                             height: width
                             anchors.verticalCenter: parent.verticalCenter
                             anchors.left: parent.left
                             btnImageSource: "./assets/leftanglearrow.png"
                             onTriggered: control.showPreviousMonth()
                         }
                         WgtText {
                             id: dateText
                             text: styleData.title
                             elide: Text.ElideRight
                             horizontalAlignment: Text.AlignHCenter
                             font.pixelSize: 30
                             anchors.verticalCenter: parent.verticalCenter
                             anchors.left: previousMonth.right
                             anchors.leftMargin: 2
                             anchors.right: nextMonth.left
                             anchors.rightMargin: 2
                         }
                         WgtButton {
                             id: nextMonth
                             width: parent.height
                             height: width
                             anchors.verticalCenter: parent.verticalCenter
                             anchors.right: parent.right
                             btnImageSource: "./assets/rightanglearrow.png"
                             onTriggered: control.showNextMonth()
                         }
                }

                dayDelegate: Rectangle {
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00
                            color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                        }
                        GradientStop {
                            position: 1.00
                            color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                        }
                        GradientStop {
                            position: 1.00
                            color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                        }
                    }

                    WgtText {
                        text: styleData.date.getDate()
                        anchors.centerIn: parent
                        color: styleData.valid ? "#eec715" : "grey"
                        font.pixelSize: 20
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#555"
                        anchors.bottom: parent.bottom
                    }

                    Rectangle {
                        width: 1
                        height: parent.height
                        color: "#555"
                        anchors.right: parent.right
                    }
                }
            }
        }

    }
    Component{
        id: timePicker
        Rectangle{
            anchors.centerIn: parent
            width: 300
            height: 400
            color: "red"
            radius: 15
            property var hrModel: ['1','2','3','4','5','6','7','8','9','10','11','12']
            property var minuteModel: ['15','30','45','00']
            property var ampmModel: ["AM","PM"]
            property var timerModel: [hrModel, minuteModel, ampmModel]
            Row{
                id:timesRow
                anchors.fill: parent
                Repeater{

                    model: timerModel.length
                    Column{
                        id: hrSelect
                        property var listModel: timerModel[index]
                        Image {
                            id: up
                            source: "assets/upArrow.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {

                                    if(hrList.currentIndex < listModel.length)
                                        hrList.currentIndex++
                                }
                            }

                        }
                        ListView{
                            id: hrList
                            model: hrSelect.listModel.length
                            width:30
                            height: 30
                            delegate: WgtText{
                                text:hrSelect.listModel[index]
                                font.pointSize: 40
                                onTextChanged: {
                                    if(hrList.index==0){
                                        hourSelected = text
                                    }
                                    else if(hrList.index==1){
                                        minuteSelected = text
                                    }
                                    else{
                                        if(hrList.index ==2 && text == "PM")
                                            hourSelected += 12
                                    }
                                }
                            }
                        }
                        Image {
                            id: down
                            source: "assets/downArrow.png"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {

                                    if(hrList.currentIndex > 0)
                                        hrList.currentIndex--
                                }
                            }
                        }
                    }
                }
            }

        }
    }

    Component{
        id: submitForm
        Rectangle{
            anchors.centerIn: parent
            width: 560
            height: 480
            color:"white"
            property var formModel:[{'title':'Name', 'model':function(){ return customerModel.name}}, {'title':'Phone'}, {'title':'Message'}]
            Column{
                anchors.fill: parent
                Repeater{
                    model: formModel
                    Row{
                        width: parent.width
                        WgtText{
                            id: title
                            text:formModel[index].title+"*"
                        }
                        TextInput {
                            text: ""
                            width: 150
                            height: 100
                            cursorVisible: false
                            font.family: title.font.family
                            font.pointSize: title.font.pointSize
                            onTextChanged: {
                                switch(index){
                                case 0: customerModel.name = text;
                                    break;
                                case 1: customerModel.contact = text;
                                    break;
                                case 2: customerModel.message = text;
                                    break;
                                }
                            }
                        }
                    }
                }
            }

        }
    }

    Component{
        id: endForm
        Rectangle{
            anchors.centerIn: parent
            width: 300
            height: 400
            color:"white"
            WgtText{
                id: title
                text: "We will reach you soon to confirm your appointment"
            }
        }
    }

}
