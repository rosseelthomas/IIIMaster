package be.trosseel.android.lab7;

import android.app.Service;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.os.IBinder;
import android.util.Log;

import java.util.ArrayList;

public class MyService extends Service implements SensorEventListener {
    public final static int SAMPLEPERIOD = 20;


    double steps = 0;
    double vorige_magnitude = 0;

    double top_threshold = 0.5;
    double bottom_threshold = -0.5;
    double time_top = 0;

    public MyService() {



    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }

    @Override
    public void onDestroy() {
        Log.i("lifecycle", "destroy");
        super.onDestroy();


    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i("lifecycle", "create");

    }

    @Override
    public void onSensorChanged(SensorEvent event) {

        float x = event.values[0];
        float y = event.values[1];
        float z = event.values[2];

        double magnitude = Math.sqrt(x*x + y*y + z*z);



        double alpha=0.1;


        double current = vorige_magnitude + alpha*(vorige_magnitude-magnitude);

        alpha=0.01;
        double trend = vorige_magnitude + alpha*(vorige_magnitude-magnitude);
        vorige_magnitude = magnitude;



       double res = current-trend;

            //Log.i("res",""+res);

            if(res > top_threshold){
                time_top = event.timestamp;
               //Log.i("time_top",""+time_top);
            }else if( res < bottom_threshold && event.timestamp - time_top < 150000000){
                steps++;
                time_top = 0;
                Log.i("stap","stap gezet");
            }


        //
        //Log.i("steps","aantal stappen : "+steps);
       // Log.i("magnitudes size",""+magnitudes.size());


    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
}
