package enterprise.paddy.pyker;


import org.qtproject.qt5.android.bindings.QtActivity;
import android.content.Intent;

public class MainActivity extends QtActivity
{
    // this method is called by C++ to register the BroadcastReceiver.
    public void igniteService(String description) {
        // Qt is running on a different thread than Android.
        // In order to register the receiver we need to execute it in the UI thread
        Intent i = new Intent(this,QtAndroidService.class);
        i.putExtra("value",description);
        startService(i);

    }


    public void quenchService() {

        Intent i = new Intent(this,QtAndroidService.class);
        stopService(i);
     }

   }


