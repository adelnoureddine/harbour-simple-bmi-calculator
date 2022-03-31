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

CONFIG += sailfishapp

SOURCES += src/harbour-simple-bmi-calculator.cpp

DISTFILES += qml/harbour-simple-bmi-calculator.qml \
    LICENSE \
    qml/cover/CoverPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/MainPage.qml \
    rpm/harbour-simple-bmi-calculator.changes.in \
    rpm/harbour-simple-bmi-calculator.changes.run.in \
    rpm/harbour-simple-bmi-calculator.spec \
    rpm/harbour-simple-bmi-calculator.yaml \
    harbour-simple-bmi-calculator.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172
