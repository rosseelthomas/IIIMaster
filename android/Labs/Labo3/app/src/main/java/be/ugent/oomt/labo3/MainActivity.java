package be.ugent.oomt.labo3;

import android.app.Activity;
import android.os.Bundle;

import be.ugent.oomt.labo3.contentprovider.MessageProvider;


public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //MessageProvider.addTestData(this);
    }
}
