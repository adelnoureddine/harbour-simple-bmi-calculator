import QtQuick 2.0
import Sailfish.Silica 1.0

/*
 * A measurement with a slider for quick changes and its value, which opens a dialog to
 * type it exactly. A typed value may lie outside the slider's range: the slider then
 * rests at its end, and the value shown is the one typed.
 *
 * Version 0.3 had sliders alone, in whole steps from 40 to 150 kg: anyone heavier could
 * not enter their weight.
 */
Column {
    id: root

    property string label
    property string unit
    property real value
    // The slider's range and step.
    property real sliderMinimum
    property real sliderMaximum
    property real stepSize: 1
    // What can be typed.
    property real minimum
    property real maximum

    width: parent ? parent.width : 0

    // Follow a typed value; while the slider is dragged, it is the one setting `value`.
    onValueChanged: {
        if (!slider.down) {
            slider.value = value;
        }
    }
    Component.onCompleted: slider.value = value

    BackgroundItem {
        id: header

        width: parent.width
        height: headerColumn.height + 2 * Theme.paddingSmall
        onClicked: {
            var dialog = pageStack.push(Qt.resolvedUrl("../pages/EnterValueDialog.qml"), {
                title: root.label,
                unit: root.unit,
                value: root.value,
                minimum: root.minimum,
                maximum: root.maximum
            });
            dialog.accepted.connect(function () {
                root.value = dialog.typedValue;
            });
        }

        Column {
            id: headerColumn
            x: Theme.horizontalPageMargin
            width: editIcon.x - x - Theme.paddingMedium
            anchors.verticalCenter: parent.verticalCenter

            Label {
                width: parent.width
                truncationMode: TruncationMode.Fade
                text: root.label
                font.pixelSize: Theme.fontSizeSmall
                color: header.highlighted ? Theme.highlightColor : Theme.secondaryHighlightColor
            }

            Row {
                spacing: Theme.paddingSmall

                Label {
                    id: valueLabel
                    text: appWindow.formatMeasure(root.value)
                    font.pixelSize: Theme.fontSizeExtraLarge
                    color: header.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Label {
                    anchors.baseline: valueLabel.baseline
                    text: root.unit
                    font.pixelSize: Theme.fontSizeMedium
                    color: header.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                }
            }
        }

        // Says the value can be typed.
        Icon {
            id: editIcon
            anchors.right: parent.right
            anchors.rightMargin: Theme.horizontalPageMargin
            anchors.verticalCenter: parent.verticalCenter
            source: "image://theme/icon-m-edit"
            highlighted: header.highlighted
        }
    }

    Slider {
        id: slider

        width: parent.width
        minimumValue: root.sliderMinimum
        maximumValue: root.sliderMaximum
        stepSize: root.stepSize
        onValueChanged: {
            if (down) {
                root.value = value;
            }
        }
        onDownChanged: {
            if (!down) {
                root.value = value;
            }
        }
    }
}

// vim:et:ts=4:sw=4
