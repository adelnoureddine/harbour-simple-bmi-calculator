import QtQuick 2.0
import Sailfish.Silica 1.0

/*
 * The BMI of what is on the page, with its category, without opening the app.
 */
CoverBackground {
    id: cover

    Column {
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingMedium

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            //: Cover header: the app's short name
            text: qsTr("BMI")
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.highlightColor
        }

        Label {
            width: parent.width
            text: appWindow.bmi === null ? "—" : appWindow.formatNumber(appWindow.bmi, 1)
            font.pixelSize: Theme.fontSizeHuge
            color: Theme.primaryColor
        }

        // A dot and the category, wrapped: "Obesity class III" does not fit a pill here.
        Row {
            width: parent.width
            spacing: Theme.paddingSmall
            visible: appWindow.category >= 0

            Rectangle {
                y: (categoryLabel.font.pixelSize - height) / 2 + Theme.paddingSmall / 2
                width: Theme.paddingMedium
                height: width
                radius: width / 2
                color: appWindow.categoryColor
            }
            Label {
                id: categoryLabel
                width: parent.width - Theme.paddingMedium - parent.spacing
                wrapMode: Text.Wrap
                maximumLineCount: 2
                text: appWindow.categoryName
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }
        }

        Label {
            width: parent.width
            truncationMode: TruncationMode.Fade
            //: Cover: height in centimetres and weight in kilograms
            text: qsTr("%1 cm · %2 kg").arg(appWindow.formatMeasure(appWindow.heightCm))
                                       .arg(appWindow.formatMeasure(appWindow.weightKg))
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
        }
    }
}

// vim:et:ts=4:sw=4
