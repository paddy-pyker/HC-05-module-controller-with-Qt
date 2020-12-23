package enterprise.paddy.pyker;

import android.app.Notification;
import android.app.NotificationManager;
import android.support.v4.app.NotificationCompat;
import android.content.Context;
import android.content.Intent;
import android.app.PendingIntent;
import android.graphics.Color;
import android.graphics.BitmapFactory;
import android.app.NotificationChannel;

public class Notifications
{
    private static NotificationManager m_notificationManager;
    private static NotificationCompat.Builder m_builder;

    public Notifications() {}



    public static void notify(Context context, String message) {
        try {
            m_notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                int importance = NotificationManager.IMPORTANCE_DEFAULT;
                NotificationChannel notificationChannel = new NotificationChannel("My Room", "My Room Status", importance);
                notificationChannel.enableVibration(true);


                m_notificationManager.createNotificationChannel(notificationChannel);
                m_builder = new NotificationCompat.Builder(context, notificationChannel.getId());
            } else {
                m_builder = new NotificationCompat.Builder(context);
            }


        Intent light = new Intent(context,CustomActivity.class);
        PendingIntent plight = PendingIntent.getActivity(context,0,light,0);

        Intent fan = new Intent(context,CustomActivity2.class);
        PendingIntent pfan = PendingIntent.getActivity(context,0,fan,0);

            m_builder.setSmallIcon(R.drawable.icon)
                    .setLargeIcon(BitmapFactory.decodeResource(context.getResources(), R.drawable.image))
                    .setContentTitle(message)
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setColor(0xff061729)
                    .addAction(R.drawable.icon,"LIGHT",plight)
                    .addAction(R.drawable.icon,"FAN",pfan)
                    .setWhen(System.currentTimeMillis())
                    .setAutoCancel(true);


            m_notificationManager.notify(1, m_builder.build());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
