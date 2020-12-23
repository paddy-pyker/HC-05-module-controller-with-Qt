#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <bluetooth-manager.h>
#include <device-info.h>
#include <QQuickStyle>
#include "statusbar.h"

int main(int argc, char *argv[])
{

    QQuickStyle::setStyle("Universal");

    QGuiApplication app(argc, argv);

    qmlRegisterType<BluetoothManager>("BT", 1, 0, "BluetoothManager");
    qmlRegisterType<DeviceInfo>("BT", 1, 0, "DeviceInfo");
    qmlRegisterType<StatusNavigationBar>("StatusNavigationBar", 0, 1, "StatusNavigationBar");

    StatusNavigationBar color;
    BluetoothManager * manager = new BluetoothManager(&app);


    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.rootContext()->setContextProperty("colorBar", &color);
    engine.rootContext()->setContextProperty("bluetoothManager", manager);


    const QUrl url(QStringLiteral("qrc:/views/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);


    return app.exec();
}
