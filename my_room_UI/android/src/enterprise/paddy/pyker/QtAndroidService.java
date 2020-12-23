package enterprise.paddy.pyker;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.app.Service;
import android.os.IBinder;
import android.widget.Toast;
import android.app.Notification;
import android.app.NotificationManager;
import android.support.v4.app.NotificationCompat;
import android.app.PendingIntent;
import android.graphics.Color;
import android.graphics.BitmapFactory;
import android.app.NotificationChannel;

public class QtAndroidService extends Service
{
    private static final String TAG = "QtAndroidService";
    private static final int NOTIFICATION_ID = 1;
    private  NotificationManager m_notificationManager;
    private  NotificationCompat.Builder m_builder;

    public  Notification activityNotification (String message)   {

        m_notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                int importance = NotificationManager.IMPORTANCE_DEFAULT;
                NotificationChannel notificationChannel = new NotificationChannel("My Room", "My Room Status", importance);
                notificationChannel.enableVibration(true);


                m_notificationManager.createNotificationChannel(notificationChannel);
                m_builder = new NotificationCompat.Builder(this, notificationChannel.getId());
            } else {
                m_builder = new NotificationCompat.Builder(this);
            }


        Intent light = new Intent(this,CustomActivity.class);
        PendingIntent plight = PendingIntent.getActivity(this,0,light,0);

        Intent fan = new Intent(this,CustomActivity2.class);
        PendingIntent pfan = PendingIntent.getActivity(this,0,fan,0);

            m_builder.setSmallIcon(R.drawable.icon)
                    .setLargeIcon(BitmapFactory.decodeResource(this.getResources(), R.drawable.image))
                    .setContentTitle(message)
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setColor(0xff061729)
                    .addAction(R.drawable.icon,"LIGHT",plight)
                    .addAction(R.drawable.icon,"FAN",pfan)
                    .setWhen(System.currentTimeMillis())
                    .setAutoCancel(true);

        return m_builder.build();
    }






    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Creating Service");
        this.startForeground();
    }

    private void startForeground() {
        startForeground(NOTIFICATION_ID,activityNotification("testing...lol"));
    }

    
    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, "Destroying Service");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
 
        String name = intent.getStringExtra("value");
        m_notificationManager.notify(NOTIFICATION_ID,activityNotification(name));

        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
