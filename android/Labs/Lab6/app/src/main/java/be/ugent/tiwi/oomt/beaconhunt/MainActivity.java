package be.ugent.tiwi.oomt.beaconhunt;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.ListView;

import java.util.HashMap;

import be.ugent.tiwi.oomt.beaconhunt.model.Beacon;


public class MainActivity extends Activity implements BluetoothAdapter.LeScanCallback {
    private static final long SCAN_PERIOD = 60000;
    private BluetoothAdapter mBluetoothAdapter;
    private Handler handler = new Handler();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        HashMap<String, Beacon> beacons = new HashMap<>();
        beacons.put("D8:18:AF:89:AE:8D", new Beacon("Estimote I","D8:18:AF:89:AE:8D",R.drawable.beacon1, false ));
        beacons.put("DA:C7:AC:D8:86:31", new Beacon("Estimote II","DA:C7:AC:D8:86:31",R.drawable.beacon3, false ));
        beacons.put("CC:9E:65:5C:6A:09", new Beacon("Estimote III", "CC:9E:65:5C:6A:09", R.drawable.beacon2, false));

        BeaconListAdapter adapter = new BeaconListAdapter(beacons,this);
        ListView beaconList = (ListView)findViewById(R.id.listView);
        beaconList.setAdapter(adapter);


        final BluetoothManager bluetoothManager =
                (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);
         mBluetoothAdapter = bluetoothManager.getAdapter();

        if (mBluetoothAdapter == null || !mBluetoothAdapter.isEnabled()) {
            Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableBtIntent,1);
        }
    }

    public void btnclick(View v){
        Log.i("click", "btn clicked");

        mBluetoothAdapter.startLeScan(this);
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Log.i("run", "scan stop");
                mBluetoothAdapter.stopLeScan(MainActivity.this);
            }
        },SCAN_PERIOD);

    }

    @Override
    public void onLeScan(BluetoothDevice device, int rssi, byte[] scanRecord) {
        Log.i("bledevice",device.getName()+" at "+device.getAddress());
    }
}
