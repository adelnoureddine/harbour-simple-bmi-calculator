/*
 * Simple BMI Calculator for SailfishOS
 * Copyright (C) 2019-2026 Adel Noureddine
 * Licensed under the GNU GPL 3 license only (GPL-3.0-only).
 */

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QCoreApplication>
#include <QGuiApplication>
#include <QLocale>
#include <QQmlContext>
#include <QQuickView>
#include <QScopedPointer>
#include <QTranslator>

#include <sailfishapp.h>

// APP_VERSION, written by qmake into the build folder (src/version.h.in).
#include "version.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    // These must match [X-Sailjail] in harbour-simple-bmi-calculator.desktop: Sailjail
    // only grants the app its own ~/.local/share/<OrganizationName>/<ApplicationName>.
    QCoreApplication::setOrganizationName(QStringLiteral("org.noureddine"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("org.noureddine"));
    QCoreApplication::setApplicationName(QStringLiteral("SimpleBMICalculator"));
    QCoreApplication::setApplicationVersion(QStringLiteral(APP_VERSION));

    // sailfishapp_i18n installs the compiled catalogues next to the QML. Without one for
    // the phone's language, the base catalogue still gives the English plural forms
    // ("3 days", not "3 day(s)"): the other English texts are the source texts.
    const QString translations = SailfishApp::pathTo(QStringLiteral("translations")).toLocalFile();
    QScopedPointer<QTranslator> translator(new QTranslator);
    if (translator->load(QStringLiteral("harbour-simple-bmi-calculator-") + QLocale::system().name(), translations)
            || translator->load(QStringLiteral("harbour-simple-bmi-calculator"), translations)) {
        app->installTranslator(translator.data());
    }

    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->rootContext()->setContextProperty(QStringLiteral("appVersion"),
                                            QStringLiteral(APP_VERSION));
    view->setSource(SailfishApp::pathToMainQml());
    view->show();

    return app->exec();
}
