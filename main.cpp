#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "helper.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine; //движок сцены qml
    const QUrl url(QStringLiteral("qrc:/main.qml")); //главный файл
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    Helper helper; //экземпляр класса helper
    engine.rootContext()->setContextProperty("helper", &helper); //&helper - адрес объекта, "helper" - название объекта

    engine.load(url); //подгрузка главного файла

    return app.exec(); //запуск игры
}
