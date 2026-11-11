import QtQuick 2.0
import Sailfish.Silica 1.0

/*
 * Types a height or a weight exactly, with one decimal at most. The value is refused
 * outside `minimum` to `maximum`, with the range said under the field.
 */
Dialog {
    id: dialog

    allowedOrientations: Orientation.All

    property string title
    property string unit
    property real value
    property real minimum
    property real maximum

    // What is typed, or NaN. A comma or a point is the decimal separator.
    readonly property real typedValue: {
        var text = field.text.replace(",", ".");
        return /^\d{1,3}(\.\d?)?$/.test(text) ? parseFloat(text) : NaN;
    }
    readonly property bool inRange: !isNaN(typedValue) && typedValue >= minimum && typedValue <= maximum

    canAccept: inRange

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            DialogHeader {
                title: dialog.title
                acceptText: qsTr("Set")
            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                TextField {
                    id: field
                    width: parent.width
                    //: Field label: a measurement and its unit, as in "Weight (kg)"
                    label: qsTr("%1 (%2)").arg(dialog.title).arg(dialog.unit)
                    placeholderText: label
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    validator: RegExpValidator { regExp: /^\d{1,3}([.,]\d?)?$/ }
                    focus: true
                    EnterKey.enabled: dialog.canAccept
                    EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                    EnterKey.onClicked: dialog.accept()
                }

                Label {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * Theme.horizontalPageMargin
                    visible: field.text !== "" && !dialog.inRange
                    wrapMode: Text.Wrap
                    //: Under the field: %1 and %2 are the limits, %3 the unit
                    text: qsTr("Enter a value from %1 to %2 %3")
                          .arg(appWindow.formatMeasure(dialog.minimum))
                          .arg(appWindow.formatMeasure(dialog.maximum))
                          .arg(dialog.unit)
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.errorColor
                }
            }
        }

        VerticalScrollDecorator {}
    }

    Component.onCompleted: {
        field.text = appWindow.formatMeasure(dialog.value);
        field.selectAll();
    }
}

// vim:et:ts=4:sw=4
