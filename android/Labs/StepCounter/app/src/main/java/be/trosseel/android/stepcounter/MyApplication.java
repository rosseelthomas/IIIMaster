package be.trosseel.android.stepcounter;

import android.app.Application;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.util.Log;

/**
 * Created by thomasrosseel on 15/12/15.
 */
public class MyApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i("app", "application created");
        startService(new Intent(this, StepCounterService.class));
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
        stopService(new Intent(this, StepCounterService.class));
    }
}
