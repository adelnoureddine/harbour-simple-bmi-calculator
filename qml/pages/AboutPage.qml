import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            Label {
                text: "Simple BMI Calculator"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Label {
                wrapMode: Text.Wrap
                x: Theme.horizontalPageMargin
                width: parent.width - ( 2 * Theme.horizontalPageMargin )
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("A Simple BMI Calculator")
                font.pixelSize: Theme.fontSizeSmall
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Label {
                text: qsTr("Author: Adel Noureddine © 2019-2022")
                font.pixelSize: Theme.fontSizeSmall
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Label {
                text: qsTr("Licensed under GNU GPL v3")
                font.pixelSize: Theme.fontSizeSmall
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Icon {
                 source: "image://theme/icon-s-cloud-download"
                 anchors {
                     horizontalCenter: parent.horizontalCenter
                 }
             }

            Text {
                text: "<a href=\"https://gitlab.com/adelnoureddine/harbour-simple-bmi-calculator\">" + qsTr("View source code on GitLab") + "</a>"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor

                onLinkActivated: Qt.openUrlExternally("https://gitlab.com/adelnoureddine/harbour-simple-bmi-calculator")
            }

            SectionHeader {
                text: qsTr("Health sources")
            }

            LinkedLabel {
                x: Theme.horizontalPageMargin
                text: "<a href=\"http://www.euro.who.int/en/health-topics/disease-prevention/nutrition/a-healthy-lifestyle/body-mass-index-bmi\">World Heath Organisation Europe</a>"
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                width: parent.width - 2*x

                onLinkActivated: Qt.openUrlExternally("http://www.euro.who.int/en/health-topics/disease-prevention/nutrition/a-healthy-lifestyle/body-mass-index-bmi")
            }

            LinkedLabel {
                x: Theme.horizontalPageMargin
                text: "<a href=\"https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/metric_bmi_calculator/bmi_calculator.html\">Centers for Disease Control and Prevention (USA)</a>"
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                width: parent.width - 2*x

                onLinkActivated: Qt.openUrlExternally("https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/metric_bmi_calculator/bmi_calculator.html")
            }
        }
    }
}
