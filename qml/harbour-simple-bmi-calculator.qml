import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "js/bmi.js" as Bmi

/*
 * Height, weight and the BMI live here rather than on the page, so the cover shows the
 * same result as the page.
 */
ApplicationWindow {
    id: appWindow

    property real heightCm: 170
    property real weightKg: 70
    readonly property var bmi: Bmi.compute(heightCm, weightKg)
    readonly property int category: Bmi.category(bmi)
    readonly property color categoryColor: Bmi.categoryColor(category)
    readonly property string categoryName: categoryNameOf(category)

    // A number with `decimals` decimals in the phone's format ("24,6" in French).
    function formatNumber(value, decimals) {
        return Number(value).toLocaleString(Qt.locale(), "f", decimals);
    }

    // Shown with its decimal only when it has one: "170", "170.5".
    function formatMeasure(value) {
        return formatNumber(value, Math.round(value * 10) % 10 === 0 ? 0 : 1);
    }

    function categoryNameOf(index) {
        switch (index) {
        case 0: return qsTr("Underweight");
        case 1: return qsTr("Normal weight");
        //: The WHO calls it pre-obesity
        case 2: return qsTr("Overweight");
        case 3: return qsTr("Obesity class I");
        case 4: return qsTr("Obesity class II");
        case 5: return qsTr("Obesity class III");
        default: return "";
        }
    }

    function categoryDescription(index) {
        switch (index) {
        case 0: return qsTr("Your weight is below the healthy range for adults of your height. Talk to your doctor for medical advice.");
        case 1: return qsTr("Your weight is in the healthy range for adults of your height.");
        case 2: return qsTr("Your weight is above the healthy range for adults of your height. Talk to your doctor for medical advice.");
        case 3:
        case 4:
        case 5: return qsTr("Your weight is well above the healthy range for adults of your height. People with obesity are at higher risk of conditions such as high blood pressure, diabetes and high cholesterol. Talk to your doctor for medical advice.");
        default: return "";
        }
    }

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}

// vim:et:ts=4:sw=4
