import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property double bmi: 0.0;
    property string bmi_text;
    property double height_bmi: 0.0;
    property double weight_bmi: 0.0;
    property double recommended_min_weight: 0.0;
    property double recommended_max_weight: 0.0;
    property string category_bmi;
    property string category_bmi_description;
    property string recommended_weight_description;
    property double height_square: 0.0;

    function calculate() {
        weight_bmi = weightField.value
        height_bmi = heightField.value / 100

        height_square = (height_bmi * height_bmi)

        if ((weight_bmi > 0) && (height_bmi > 0)) {
            bmi = weight_bmi / height_square;
            recommended_min_weight = 18.5 * height_square
            recommended_max_weight = 24.9 * height_square
            recommended_weight_description = "The recommended weight for your height is between " + recommended_min_weight.toFixed(2) + " kg and " + recommended_max_weight.toFixed(2) + " kg"
            calculate_bmi_category();
        }

        bmi_text = "Your BMI is: " + bmi.toFixed(2);
    }

    function calculate_bmi_category() {
        if (bmi < 18.5) {
            category_bmi = "Underweight";
            category_bmi_description = "Your weight is under the recommended values. Talk to your doctor for medical advice."
        } else if (bmi < 25) {
            category_bmi = "Normal weight";
            category_bmi_description = "Your weight is in the normal category for adults of your height."
        } else if (bmi < 30) {
            category_bmi = "Overweight (pre-obesity)";
            category_bmi_description = "Your weight is above the recommended values. Talk to your doctor for medical advice."
        } else if (bmi < 35) {
            category_bmi = "Obese Class I";
            category_bmi_description = "Your weight is high above the recommended values. People who are overweight or obese are at higher risk for chronic conditions such as high blood pressure, diabetes, and high cholesterol. Talk to your doctor for medical advice."
        } else if (bmi < 40) {
            category_bmi = "Obese Class II";
            category_bmi_description = "Your weight is high above the recommended values. People who are overweight or obese are at higher risk for chronic conditions such as high blood pressure, diabetes, and high cholesterol. Talk to your doctor for medical advice."
        } else if (bmi >= 40) {
            category_bmi = "Obese Class III";
            category_bmi_description = "Your weight is high above the recommended values. People who are overweight or obese are at higher risk for chronic conditions such as high blood pressure, diabetes, and high cholesterol. Talk to your doctor for medical advice."
        } else {
            category_bmi = "Unkown category";
            category_bmi_description = ""
        }
    }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Simple BMI Calculator")
            }

            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: "Simple BMI Calculator for Adults"
            }

            // Height in cm
            /*TextField {
                id: heightField
                width: page.width
                label: "Your height (in cm)"
                placeholderText: "Your height (in cm)"
                validator: RegExpValidator { regExp: /^[0-9]{1,3}$/ }
                color: Theme.primaryColor
                inputMethodHints: Qt.ImhDigitsOnly
                EnterKey.enabled: text.length > 0
            }*/

            // Height in cm
            Slider {
                id: heightField// Height in cm
                width: page.width
                minimumValue: 100
                maximumValue: 220
                value: 170
                valueText: value + " cm"
                stepSize: 1
                label: "Height"
                onValueChanged: calculate()
            }

            // Weight in kg
            Slider {
                id: weightField
                width: page.width
                minimumValue: 40
                maximumValue: 150
                value: 70
                valueText: value + " kg"
                stepSize: 1
                label: "Weight"
                onValueChanged: calculate()
            }

            // Weight in kg
            /*TextField {
                id: weightField
                width: page.width
                label: "Your weight (in kg)"
                placeholderText: "Your weight (in kg)"
                validator: RegExpValidator { regExp: /^(\d{1,3})([\.|,]\d{1,2})?$/}
                color: Theme.primaryColor
                inputMethodHints: Qt.ImhDigitsOnly
                EnterKey.enabled: text.length > 0
            }*/

            // BMI value
            Label {
                text: bmi_text
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                anchors.left: parent.left
                anchors.leftMargin: 30
            }

            // BMI category
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: category_bmi
            }

            // Recommended weight
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: recommended_weight_description
            }

            // BMI category description
            LinkedLabel {
                x: Theme.horizontalPageMargin
                width: parent.width - 2*x
                plainText: category_bmi_description
            }

            Label {
                id: separatorLabel
                x: Theme.horizontalPageMargin
                width: parent.width  - ( 2 * Theme.horizontalPageMargin )
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.Wrap
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Component.onCompleted: calculate()
        }
    }

    // Functions

}
