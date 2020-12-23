package enterprise.paddy.pyker;


import org.qtproject.qt5.android.bindings.QtActivity;

public class CustActivityCopy extends QtActivity
{
    // this method is called by C++ to register the BroadcastReceiver.
    public void registerBroadcastReceiver() {
        // Qt is running on a different thread than Android.
        // In order to register the receiver we need to execute it in the UI thread
        runOnUiThread(new RegisterReceiverRunnable(this));

    }

   }


