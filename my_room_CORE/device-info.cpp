#include "device-info.h"

DeviceInfo::DeviceInfo(QObject *parent, const QString &name, const QString &mac) : QObject(parent),
    Name(name),Mac(mac)
{

}

DeviceInfo::~DeviceInfo()
{

}

const QString &DeviceInfo::name()
{
    return Name;

}

const QString &DeviceInfo::macAddress()
{
    return Mac;
}
