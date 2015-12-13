package be.ugent.oomt.labo4;

import android.content.ContentValues;
import android.content.Context;
import android.util.Log;

import org.eclipse.paho.android.service.MqttAndroidClient;
import org.eclipse.paho.android.service.MqttTraceHandler;
import org.eclipse.paho.client.mqttv3.IMqttActionListener;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.IMqttToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.MqttTopic;

import java.util.Date;

import be.ugent.oomt.labo4.contentprovider.MessageProvider;
import be.ugent.oomt.labo4.contentprovider.database.DatabaseContract;

/**
 * Created by elias on 19/01/15.
 */
public class MqttHandler implements MqttCallback, MqttTraceHandler, IMqttActionListener {

    private static final String TAG = MqttHandler.class.getCanonicalName();
    private static MqttHandler instance;
    private MqttAndroidClient client;

    // TODO: fill in IP or public Mqtt server
    // Mqtt server address
    //public static final String serverURI = "tcp://<IP>:1883";
    public static final String serverURI = "tcp://iot.eclipse.org:1883"; //public mqtt server

    // TODO: fill in client id (unique user email)
    // unique client id for identifying to Mqtt server
    public static final String clientId = "ditwerkt@ugent.be";

    // TODO: fill in start topics
    // topics to subscribe to on application start
    public static final String[] start_topics = new String[]{"ugent/+/state"};

    // Quality Of Service levels
    // 0: msg are only delivered when online, 1: msg are send once, 2: msg are send and checked
    public static final int qos = 2;

    // when connection is lost do not clean up the subscriptions of the user
    private final boolean cleanSession = false;
    private final Context context;

    private MqttHandler(Context context) {
        this.context = context;
        createClient();
    }

    // TODO: Create singleton class with the application context (to start the MqttHandler when your application starts, create instance of this class in MyApplication)

    public static MqttHandler getInstance(Context c){

        if(instance == null) instance = new MqttHandler(c);
        return instance;

    }

    private void createClient() {
        // TODO: Create MqttAndroidClient, set callback, set tracecallback, set options and connect the client
        client = new MqttAndroidClient(context, serverURI, clientId);

        client.setCallback(this);
        client.setTraceCallback(this);


        MqttConnectOptions connOpts = new MqttConnectOptions();

        String msg = "I'm offline: ";
        connOpts.setWill("ugent/"+clientId+"/state", msg.getBytes(), qos, true);

        connOpts.setCleanSession(cleanSession);


        try {
            client.connect(connOpts, context, this);

        } catch (MqttException e) {
            e.printStackTrace();
        }
    }

    /*
        Use this method to get the Mqtt client from anywhere in your application. The client can be used to send messages and subscribe to new topics.
     */
    public MqttAndroidClient getClient() {

        return client;
    }

    @Override
    public void connectionLost(Throwable throwable) {

    }

    @Override
    public void messageArrived(String s, MqttMessage mqttMessage) throws Exception {
        Log.i("iot-msg", s);
        String data = new String(mqttMessage.getPayload());
        Log.i("iot-msg-content",data);

        if(s.split("/").length != 3) return;

        String name = s.split("/")[1];

        if(context.getContentResolver().query(MessageProvider.CONTACTS_CONTENT_URL,new String[]{DatabaseContract.Contact.COLUMN_NAME_CONTACT},
                DatabaseContract.Contact.COLUMN_NAME_CONTACT+"='"+name+"'",null,null).getCount()<=0){
            ContentValues cv2 = new ContentValues();
            cv2.put(DatabaseContract.Contact.COLUMN_NAME_CONTACT,name);
            cv2.put(DatabaseContract.Contact.COLUMN_NAME_STATE,"created");
            context.getContentResolver().insert(MessageProvider.CONTACTS_CONTENT_URL,cv2);

        }
        Date d =new Date();
        if(s.endsWith("wall")){
            ContentValues cv = new ContentValues();



            cv.put(DatabaseContract.Message.COLUMN_NAME_CONTACT,name);

            cv.put(DatabaseContract.Message.COLUMN_NAME_DATE,d.toString());
            cv.put(DatabaseContract.Message.COLUMN_NAME_MESSAGE,data);

            context.getContentResolver().insert(MessageProvider.MESSAGES_CONTENT_URL, cv);
        }else if(s.endsWith("state")){

            ContentValues cv = new ContentValues();
            cv.put(DatabaseContract.Contact.COLUMN_NAME_STATE,data);
            cv.put(DatabaseContract.Contact.COLUMN_NAME_LAST_UPDATE,d.toString());
            cv.put(DatabaseContract.Contact.COLUMN_NAME_CONTACT,name);

            context.getContentResolver().update(MessageProvider.CONTACTS_CONTENT_URL,cv,DatabaseContract.Contact.COLUMN_NAME_CONTACT+"='"+name+"'",null);
        }






    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {

    }

    @Override
    public void traceDebug(String source, String message) {

    }

    @Override
    public void traceError(String source, String message) {

    }

    @Override
    public void traceException(String source, String message, Exception e) {

    }

    @Override
    public void onSuccess(IMqttToken iMqttToken) {
        String msg = "I'm online";
        MqttMessage m = new MqttMessage(msg.getBytes());
        m.setQos(qos);
        try {
            getClient().publish("ugent/" + clientId + "/state", m);

            Log.i("iot","message sent to : "+"ugent/" + clientId + "/state");
            for(String topic : start_topics){
                getClient().subscribe(topic,qos);
            }
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onFailure(IMqttToken iMqttToken, Throwable throwable) {
        Log.i("iot","failure ");
        throwable.printStackTrace();

    }

    // TODO: implement IMqttActionListener, MqttCallback interfaces and MqttTraceHandler
}
