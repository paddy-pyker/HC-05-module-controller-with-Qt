#ifndef BLUETOOTHMANAGER_H
#define BLUETOOTHMANAGER_H

#include <QObject>
#include <QtBluetooth/QBluetoothDeviceDiscoveryAgent>
#include <QtBluetooth/QBluetoothSocket>
#include <QScopedPointer>
#include <QDebug>
#include "my_room_CORE_global.h"
#include <QtQml/QQmlListProperty>
#include <device-info.h>



class MY_ROOM_CORE_EXPORT BluetoothManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<DeviceInfo> foundDevices READ foundDevices CONSTANT)
    Q_PROPERTY(QString ui_device_selected READ _device_selected WRITE device_selected)
    Q_PROPERTY(int toggler READ toggler WRITE toggler1 NOTIFY togglerChanged)

public:
    BluetoothManager(QObject* parent = nullptr);

    ~BluetoothManager();


    const QString& _device_selected();
    const int& toggler();
    void toggler1(const int& toggle);
    void reload();
    static BluetoothManager* instance(){return m_instance;}




    QQmlListProperty<DeviceInfo> foundDevices();

signals:
    void valueChanged();
    void ui_conn_Success();
    void ui_conn_Error();
    void agreed();
    void scanCompleted();
    void deviceIsOff();
    void exitNotification();
    void togglerChanged();
    void connectLastDevice(const QString& id);


public slots:

    void deviceDiscovered(const QBluetoothDeviceInfo &device);

    void device_selected(const QString &name, const QString& mac);

    void scan_for_devices();

    void turn_on_light();

    void turn_on_fan();

    void disconnectSocket();

    void connection_successful(); // for serialization

    void connection_reviewed();

    void connect_last_device();

    void stopNotificationService();



private:

    bool filterDiscoveredDevice(const DeviceInfo& info) const;
    static BluetoothManager* m_instance;
    class Implementation;
    QScopedPointer<Implementation> implementation;




};

#endif // BLUETOOTHMANAGER_H
