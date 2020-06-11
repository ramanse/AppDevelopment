#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <dpihandling.h>
#include <dbhandler.h>
#include <customermodel.h>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<DPIHandling>("Utils", 1, 0, "DPI");
    qmlRegisterType<DBHandler>("Utils",1,0,"DBHandler");
    qmlRegisterType<CustomerModel>("Utils",1,0,"CustomerModel");
    qmlRegisterSingletonType(QUrl("qrc:/Common.qml"), "Common", 1, 0, "Common");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
