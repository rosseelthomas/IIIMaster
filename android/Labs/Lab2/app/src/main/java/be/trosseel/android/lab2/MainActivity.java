package be.trosseel.android.lab2;

import android.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.FrameLayout;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.i("lifecycle", "create");



/*
        if(findViewById(R.id.container) != null){
            DetailFragment d = new DetailFragment();
            FragmentTransaction transaction = getFragmentManager().beginTransaction();

            transaction.replace(R.id.container, d);
            transaction.addToBackStack(null);

            transaction.commit();
        }
*/


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


    @Override
    protected void onStop() {
        super.onStop();
        Log.i("lifecycle", "stop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.i("lifecycle", "destroy");
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.i("lifecycle", "restart");
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.i("lifecycle", "pause");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.i("lifecycle", "resume");
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.i("lifecycle", "stop");
    }
}
