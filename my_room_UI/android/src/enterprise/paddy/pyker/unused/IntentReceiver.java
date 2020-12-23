package enterprise.paddy.pyker;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;
import android.util.Log;

//--> slide
public class IntentReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        // call the native method when it receives a new notification

            if(intent.getAction().equals("light")){
               NativeFunctions.onTurnOnLight();
               Toast.makeText(context,"Light Changed State", Toast.LENGTH_SHORT).show();
            }
            if(intent.getAction().equals("fan")) {
                NativeFunctions.onTurnOnFan();
                Toast.makeText(context,"Fan Changed State", Toast.LENGTH_SHORT).show();
                }

    }
}
//<-- slide
