package be.trosseel.android.stepcounter;

import android.app.Service;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.IBinder;
import android.util.Log;

public class StepCounterService extends Service implements SensorEventListener{

    private double vorige;

    private boolean first=true;

    private static double TOP_THRESHOLD = 1.5;
    private static double BOTTOM_THRESHOLD = -0.5;
    private long time_top = 0;
    private int steps = 0;

    public StepCounterService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        Log.i("service", "bind");
        // TODO: Return the communication channel to the service.
        throw new UnsupportedOperationException("Not yet implemented");
    }


    @Override
    public void onCreate() {
        super.onCreate();
        Log.i("service", "create");
        SensorManager manager = (SensorManager)getSystemService(SENSOR_SERVICE);
        Sensor acc = manager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        manager.registerListener(this, acc, SensorManager.SENSOR_DELAY_NORMAL);

    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i("service", "destroy");
        SensorManager manager = (SensorManager)getSystemService(SENSOR_SERVICE);
        manager.unregisterListener(this);
    }

    @Override
    public boolean onUnbind(Intent intent) {

        Log.i("service", "unbind");
        return super.onUnbind(intent);
    }

    @Override
    public void onRebind(Intent intent) {
        super.onRebind(intent);

        Log.i("service", "rebind");
    }


    @Override
    public void onSensorChanged(SensorEvent event) {

        double huidig = getMagnitude(event.values);

        if(!first){
            double result = lowpass(vorige,huidig,0.1);
            double trend = lowpass(vorige,huidig,0.01);
            result-=trend;


            if(result>TOP_THRESHOLD){
                time_top = event.timestamp;
            }else if(result<BOTTOM_THRESHOLD && event.timestamp-time_top<150000000){
                steps++;
                time_top=0;
                Log.i("stap","stap gezet: "+steps);


                if(steps%1==0){


                    try {
                        Intent i = new Intent();
                        i.addFlags(Intent.FLAG_INCLUDE_STOPPED_PACKAGES);
                        i.putExtra("steps", "" + steps);
                        i.setAction("steps");
                        sendBroadcast(i);
                    }catch(Exception e){
                        e.printStackTrace();
                    }
                }
            }


        }else{
            first = false;
        }

        vorige = huidig;

    }

    private double getMagnitude(float[] vals){
        return Math.sqrt(Math.pow(vals[0],2) + Math.pow(vals[1],2) + Math.pow(vals[2],2));
    }

    private double lowpass(double vorig, double huidig, double alpha){
        return vorig + alpha*(huidig-vorig);
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }
}
