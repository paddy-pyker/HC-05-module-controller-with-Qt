#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QObject>
#include <my_room_CORE_global.h>

class MY_ROOM_CORE_EXPORT  DeviceInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QString macAddress READ macAddress CONSTANT)

public:
    explicit DeviceInfo(QObject *parent = nullptr,const QString& name = "amagapupu",const QString& mac = "00:00:00:00:00:00");
    ~DeviceInfo();


    const QString& name();
    const QString& macAddress();


    //Intentionally left as a public member variables
   QString Name;
   QString Mac;

};

#endif // DEVICEINFO_H
