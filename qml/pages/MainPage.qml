import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import "../js/bmi.js" as Bmi

/*
 * The calculator: height and weight, and the BMI with its category, which follows both
 * as they change.
 */
Page {
    id: page

    allowedOrientations: Orientation.All

    // Lines stay a readable length in landscape and on tablets.
    readonly property real contentWidth: Math.min(width, Screen.width)
    readonly property var healthy: Bmi.healthyRange(appWindow.heightCm)

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.animatorPush(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Column {
            id: column

            anchors.horizontalCenter: parent.horizontalCenter
            width: page.contentWidth
            spacing: Theme.paddingLarge

            PageHeader {
                //: The app's name, as the page title
                title: qsTr("BMI Calculator")
                description: qsTr("For adults")
            }

            Column {
                width: parent.width

                ValueSlider {
                    label: qsTr("Height")
                    //: Unit: centimetres
                    unit: qsTr("cm")
                    value: appWindow.heightCm
                    sliderMinimum: 100
                    sliderMaximum: 220
                    stepSize: 1
                    minimum: 50
                    maximum: 250
                    onValueChanged: appWindow.heightCm = value
                }

                ValueSlider {
                    label: qsTr("Weight")
                    //: Unit: kilograms
                    unit: qsTr("kg")
                    value: appWindow.weightKg
                    sliderMinimum: 30
                    sliderMaximum: 200
                    stepSize: 0.5
                    minimum: 20
                    maximum: 350
                    onValueChanged: appWindow.weightKg = value
                }
            }

            Card {
                spacing: Theme.paddingMedium

                Column {
                    width: parent.width

                    Label {
                        width: parent.width
                        text: qsTr("Your BMI")
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryHighlightColor
                    }

                    Row {
                        spacing: Theme.paddingSmall

                        Label {
                            id: bmiLabel
                            text: appWindow.bmi === null ? "—" : appWindow.formatNumber(appWindow.bmi, 1)
                            font.pixelSize: Theme.fontSizeHuge
                            color: Theme.primaryColor
                        }
                        Label {
                            anchors.baseline: bmiLabel.baseline
                            //: Unit of the BMI: kilograms per square metre
                            text: qsTr("kg/m²")
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.secondaryColor
                        }
                    }
                }

                StatusPill {
                    text: appWindow.categoryName
                    dotColor: appWindow.categoryColor
                    maximumWidth: parent.width
                }

                BmiScale {
                    bmi: appWindow.bmi
                }

                Column {
                    width: parent.width
                    visible: page.healthy !== null

                    Label {
                        width: parent.width
                        wrapMode: Text.Wrap
                        text: qsTr("Healthy weight for your height")
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.Wrap
                        //: %1 and %2 are weights in kilograms, with one decimal
                        text: page.healthy === null ? ""
                              : qsTr("%1 to %2 kg")
                                .arg(appWindow.formatNumber(page.healthy.min, 1))
                                .arg(appWindow.formatNumber(page.healthy.max, 1))
                        font.pixelSize: Theme.fontSizeMedium
                        color: Theme.primaryColor
                    }
                }
            }

            Card {
                visible: appWindow.category >= 0

                Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: appWindow.categoryName
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryHighlightColor
                }

                Label {
                    width: parent.width
                    wrapMode: Text.Wrap
                    text: appWindow.categoryDescription(appWindow.category)
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                }
            }

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - 2 * Theme.horizontalPageMargin
                wrapMode: Text.Wrap
                text: qsTr("The BMI is a screening measure for adults: it does not tell fat from muscle, and is not medical advice.")
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
            }
        }

        VerticalScrollDecorator {}
    }
}

// vim:et:ts=4:sw=4
