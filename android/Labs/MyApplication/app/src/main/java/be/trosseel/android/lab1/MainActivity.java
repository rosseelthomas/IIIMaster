package be.trosseel.android.lab1;

import android.content.Intent;
import android.os.PersistableBundle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.format.Time;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import org.w3c.dom.Text;

import java.util.Calendar;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        ((Button) findViewById(R.id.btn2)).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //start new activity with name current as argument

                Main2Activity m = new Main2Activity();
               // new Intent(MainActivity.class,MainActivity.class);

                Intent i = new Intent(getBaseContext(), Main2Activity.class);
                i.putExtra("class","MainActivity");
                startActivity(i);
                ((TextView) findViewById(R.id.textv2)).setText(i.getStringExtra("ret"));



            }


        });
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        Log.i("lifecycle","activity result");
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

        Log.i("lifecycle","stop");

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.i("lifecycle", "destroy");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.i("lifecycle", "resume");
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.i("lifecycle", "pause");
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.i("lifecycle", "start");
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.i("lifecycle", "restart");
    }



    public void btnclick(View v){


        ((TextView)findViewById(R.id.textv)).setText(getString(R.string.hw) + Calendar.getInstance().getTime());
        Toast.makeText(MainActivity.this,getString(R.string.toast), Toast.LENGTH_SHORT).show();

    }
}
