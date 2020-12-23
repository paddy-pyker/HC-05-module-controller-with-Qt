package enterprise.paddy.pyker;

import android.app.Activity;
import android.content.Intent;
import android.content.IntentFilter;

//--> slide
public class RegisterReceiverRunnable implements Runnable
{
    private Activity m_activity;
    public RegisterReceiverRunnable(Activity activity) {
        m_activity = activity;
    }
    // this method is called on Android Ui Thread
    @Override
    public void run() {
        IntentFilter filter = new IntentFilter();
                filter.addAction("light");
                filter.addAction("fan");

        // this method must be called on Android Ui Thread
        m_activity.registerReceiver(new IntentReceiver(), filter);
    }
}
//<-- slide
