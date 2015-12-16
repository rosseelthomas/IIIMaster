package be.ugent.oomt.labo5;

import android.app.Activity;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;

public class PongActivity extends Activity {

    Sensor gyro;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_pong);

        SensorManager sm = (SensorManager)getSystemService(SENSOR_SERVICE);

        // TODO: list all sensors available for this device in Logcat

        for(Sensor s : sm.getSensorList(Sensor.TYPE_ALL)){
            Log.i("sensor",s.getName());
        }

        // TODO: get the sensor

         gyro = sm.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR);

    }

    @Override
    protected void onResume() {
        super.onResume();
        SensorManager sm = (SensorManager)getSystemService(SENSOR_SERVICE);
        GameView g = (GameView)findViewById(R.id.gv);


        sm.registerListener(g, gyro, SensorManager.SENSOR_DELAY_GAME);
    }

    @Override
    protected void onPause() {
        super.onPause();
        GameView g = (GameView)findViewById(R.id.gv);
        SensorManager sm = (SensorManager)getSystemService(SENSOR_SERVICE);
        sm.unregisterListener(g);
    }




// TODO: override onResume and onPause to register and unregister the listener for the sensor
}
