import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Image{
        source: "harbour-simple-bmi-calculator.png"
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0.5
    }

    Label {
        id: label
        anchors.centerIn: parent
        text: "BMI Calculator"
    }
}
