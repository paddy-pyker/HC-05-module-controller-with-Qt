#include "bluetooth-manager.h"
#include <QFile>
#include <QDataStream>
#include <QVariant>
#include <QtAndroid>
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#include <jni.h>
#include <QMetaObject>

BluetoothManager* BluetoothManager::m_instance = nullptr;

static void callFromJavalight(JNIEnv */*env*/, jobject /*obj*/)
{

    QMetaObject::invokeMethod(BluetoothManager::instance(), "turn_on_light" , Qt::QueuedConnection);

}

static void callFromJavafan(JNIEnv */*env*/, jobject /*obj*/)
{

    QMetaObject::invokeMethod(BluetoothManager::instance(), "turn_on_fan" , Qt::QueuedConnection);

}

static void clearNotifier(JNIEnv */*env*/, jobject /*obj*/)
{

    QMetaObject::invokeMethod(BluetoothManager::instance(), "clearNotification" , Qt::QueuedConnection);

}

static JNINativeMethod methods[] {
    {"onTurnOnLight", "()V", reinterpret_cast<void *>(callFromJavalight)},
    {"onTurnOnFan", "()V", reinterpret_cast<void *>(callFromJavafan)}
};

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /*reserved*/)
{
    JNIEnv* env;
    // get the JNIEnv pointer.
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6)
           != JNI_OK) {
        return JNI_ERR;
    }

    // step 3
    // search for Java class which declares the native methods
    jclass javaClass = env->FindClass("enterprise/paddy/pyker/NativeFunctions");
    if (!javaClass)
        return JNI_ERR;

    // step 4
    // register our native methods
    if (env->RegisterNatives(javaClass, methods,
                            sizeof(methods) / sizeof(methods[0])) < 0) {
        return JNI_ERR;
    }
    return JNI_VERSION_1_6;
}




class BluetoothManager::Implementation
{
public:
    Implementation(BluetoothManager* _manager) : manager(_manager)
    {
        agent = new QBluetoothDeviceDiscoveryAgent(manager);
        socket = new QBluetoothSocket(QBluetoothServiceInfo::RfcommProtocol);

        connect(agent,SIGNAL(deviceDiscovered(QBluetoothDeviceInfo)),manager,SLOT(deviceDiscovered(QBluetoothDeviceInfo)));
        connect(agent,SIGNAL(error(QBluetoothDeviceDiscoveryAgent::Error)),manager,SIGNAL(deviceIsOff()));
        connect(agent,SIGNAL(finished()),manager,SIGNAL(scanCompleted()));

        connect(socket,SIGNAL(connected()),manager,SIGNAL(ui_conn_Success()));
        connect(socket,SIGNAL(error(QBluetoothSocket::SocketError)),manager,SIGNAL(ui_conn_Error()));

        connect(manager,SIGNAL(ui_conn_Success()),manager,SLOT(connection_successful()));
        connect(manager,SIGNAL(ui_conn_Error()),manager,SLOT(stopNotificationService()));
    }

    BluetoothManager* manager{nullptr};


    QBluetoothDeviceDiscoveryAgent * agent{nullptr};
    QBluetoothSocket *socket{nullptr};


    DeviceInfo* deviceinfo;                      /// stores the found devices info
    QList<DeviceInfo*> deviceNames;         /// found devices in a list

    QString selectedDevice = "";           /// selected device mac from the ui for socket connection
    QString selectedDevice_name = "";     /// selected device name from the ui for serialization

    int TOGGLER = 0;
    QStringList stored_device_info;
};




BluetoothManager::BluetoothManager(QObject * parent) : QObject(parent)
{

    m_instance = this;
    implementation.reset(new Implementation(this));
    reload();
}

BluetoothManager::~BluetoothManager()
{

}

void BluetoothManager::scan_for_devices()
{
    if(!implementation->deviceNames.empty())
        implementation->deviceNames.clear();
    implementation->agent->stop();
    implementation->agent->start();

}

void BluetoothManager::turn_on_fan()
{
    implementation->socket->write("F");
}

void BluetoothManager::disconnectSocket()
{

    implementation->socket->disconnectFromService();
    emit ui_conn_Error();


}

void BluetoothManager::connection_successful()
{

    if(implementation->TOGGLER){
        implementation->stored_device_info<<implementation->selectedDevice_name<<implementation->selectedDevice;
        QFile file("config.dat");
        file.open(QFile::WriteOnly);
        QDataStream dataStream(&file);
        QVariant variant(implementation->stored_device_info);
        dataStream << variant;
        file.close();
    }
    else {
        if(QFile::exists("config.dat"))
            QFile::remove("config.dat");
    }


    QAndroidJniObject description = QAndroidJniObject::fromString("Connected to "
                                       + implementation->selectedDevice_name);


    QtAndroid::androidActivity().callMethod<void>("igniteService",
                                                  "(Ljava/lang/String;)V",
                                                  description.object<jstring>());


}

void BluetoothManager::connection_reviewed()
{


    if(implementation->TOGGLER){
        implementation->stored_device_info<<implementation->selectedDevice_name<<implementation->selectedDevice;
        QFile file("config.dat");
        file.open(QFile::WriteOnly);
        QDataStream dataStream(&file);
        QVariant variant(implementation->stored_device_info);
        dataStream << variant;
        file.close();
    }
    else {
        if(QFile::exists("config.dat"))
            QFile::remove("config.dat");
    }


}

void BluetoothManager::connect_last_device()
{
    if(!implementation->TOGGLER || implementation->stored_device_info.size() == 0)
        return;

    emit connectLastDevice(implementation->selectedDevice_name);
    device_selected(implementation->selectedDevice_name,implementation->selectedDevice);

}

bool BluetoothManager::filterDiscoveredDevice(const DeviceInfo &info) const
{
    if(info.Name == "")
        return false;

    for(int i = 0; i < implementation->deviceNames.size(); i++)
    {
        if(info.Mac == implementation->deviceNames.at(i)->macAddress())
            return false;
    }

    return true;


}

const QString &BluetoothManager::_device_selected()
{
    return implementation->selectedDevice;
}

const int &BluetoothManager::toggler()
{

    return implementation->TOGGLER;

}

void BluetoothManager::toggler1(const int &toggle)
{
    implementation->TOGGLER = toggle;

    QFile file("config1.dat");
    file.open(QFile::WriteOnly);
    QDataStream dataStream(&file);
    QVariant variant(implementation->TOGGLER);
    dataStream << variant;
    file.close();

    emit togglerChanged();
}

void BluetoothManager::reload()
{


    if (QFile::exists("config.dat"))
    {
        QFile file1("config.dat");

        file1.open(QFile::ReadOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1;
        dataStream1 >> variant1;
        implementation->stored_device_info=variant1.toStringList();
        implementation->selectedDevice_name = implementation->stored_device_info[0];
        implementation->selectedDevice = implementation->stored_device_info[1];
        file1.close();
        implementation->TOGGLER = 1;
    }

    if (QFile::exists("config1.dat"))
    {
        QFile file1("config1.dat");

        file1.open(QFile::ReadOnly);
        QDataStream dataStream1(&file1);
        QVariant variant1;
        dataStream1 >> variant1;
        implementation->TOGGLER=variant1.toInt();
        file1.close();
    }
}



void BluetoothManager::stopNotificationService()
{
    QtAndroid::androidActivity().callMethod<void>("quenchService","()V");

}

void BluetoothManager::device_selected(const QString& name, const QString &mac)
{
    static const QString serviceUuid(QStringLiteral("00001101-0000-1000-8000-00805F9B34FB"));

    implementation->selectedDevice_name = name;
    implementation->selectedDevice = mac;
    implementation->socket->connectToService(QBluetoothAddress(implementation->selectedDevice),QBluetoothUuid(serviceUuid));
    emit valueChanged();



}



QQmlListProperty<DeviceInfo> BluetoothManager::foundDevices()
{
    return QQmlListProperty<DeviceInfo>(this, implementation->deviceNames);
}

void BluetoothManager:: turn_on_light()
{

    implementation->socket->write("L");
}


void BluetoothManager::deviceDiscovered(const QBluetoothDeviceInfo &device)
{


    implementation->deviceinfo = new DeviceInfo(implementation->manager,device.name(),device.address().toString());

    if(filterDiscoveredDevice(*implementation->deviceinfo))
        implementation->deviceNames.append(implementation->deviceinfo);

    else {
        delete implementation->deviceinfo;
    }


}




