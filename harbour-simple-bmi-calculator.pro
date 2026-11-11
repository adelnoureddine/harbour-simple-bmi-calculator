# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-simple-bmi-calculator

# The version shown on the About page. A package build passes the RPM's own version
# (QMakeOptions in rpm/harbour-simple-bmi-calculator.yaml), so the two cannot differ;
# the value here is only for a build run by hand.
isEmpty(APP_VERSION): APP_VERSION = 1.0

# It reaches the code through a header written into the build folder (see
# src/version.h.in for why it is not a -D option).
version_header.input = $$PWD/src/version.h.in
version_header.output = $$OUT_PWD/version.h
QMAKE_SUBSTITUTES += version_header
INCLUDEPATH += $$OUT_PWD
DEPENDPATH += $$OUT_PWD

CONFIG += sailfishapp sailfishapp_i18n c++11

SOURCES += src/harbour-simple-bmi-calculator.cpp

OTHER_FILES += \
    src/version.h.in

TRANSLATIONS += \
    translations/harbour-simple-bmi-calculator.ts \
    translations/harbour-simple-bmi-calculator-fr.ts

DISTFILES += \
    qml/harbour-simple-bmi-calculator.qml \
    qml/cover/CoverPage.qml \
    qml/components/BmiScale.qml \
    qml/components/Card.qml \
    qml/components/CardBackground.qml \
    qml/components/LinkRow.qml \
    qml/components/StatusPill.qml \
    qml/components/ValueSlider.qml \
    qml/js/bmi.js \
    qml/pages/AboutPage.qml \
    qml/pages/EnterValueDialog.qml \
    qml/pages/MainPage.qml \
    rpm/harbour-simple-bmi-calculator.changes \
    rpm/harbour-simple-bmi-calculator.spec \
    rpm/harbour-simple-bmi-calculator.yaml \
    harbour-simple-bmi-calculator.desktop \
    LICENSE

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172
