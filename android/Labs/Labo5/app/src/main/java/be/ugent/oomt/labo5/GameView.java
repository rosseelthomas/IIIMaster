package be.ugent.oomt.labo5;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;

import be.ugent.oomt.labo5.GameLogic.GameState;
import be.ugent.oomt.labo5.GameLogic.GameThread;

/**
 * Created by elias on 21/09/15.
 */
public class GameView extends SurfaceView implements SurfaceHolder.Callback, SensorEventListener {

    private final GameState gameState;
    private GameThread _thread;
    private float ref=100;
    public GameView(Context context, AttributeSet attrs) {
        super(context, attrs);
        getHolder().addCallback(this);
        gameState = new GameState();
        setFocusable(true);


    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        _thread = new GameThread(getHolder(), gameState);
        _thread.start();
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {}

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) {
        // we have to tell thread to shut down & wait for it to finish
        _thread.stopAndWait();
        _thread = null;
    }



    // TODO: Override onTouchEvent to start the game and control the paddle

    @Override
    public boolean onTouchEvent(MotionEvent event){

        gameState.play();
        gameState.movePaddleTo((int)event.getX());
        return true;
    }

    // TODO: implement SensorEventListener and implement its methods

    @Override
    public void onSensorChanged(SensorEvent event) {
        float[] matrix = new float[16];
        float[] vals = new float[3];
        SensorManager.getRotationMatrixFromVector(matrix, event.values);
        SensorManager.getOrientation(matrix, vals);

        //Log.i("0", "" + vals[0]);
        //Log.i("1",""+vals[1]);
        Log.i("2", "" + vals[2]);

        if(ref==100){
            ref = vals[2];
        }

        if(vals[2]>ref+0.1){
            gameState.movePaddle(20);
        }else if(vals[2]<ref-0.1){
            gameState.movePaddle(-20);
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

}
