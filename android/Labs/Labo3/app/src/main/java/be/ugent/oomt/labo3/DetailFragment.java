package be.ugent.oomt.labo3;

import android.app.Fragment;
import android.app.LoaderManager;
import android.content.ContentValues;
import android.content.CursorLoader;
import android.content.Loader;
import android.database.Cursor;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import be.ugent.oomt.labo3.contentprovider.MessageProvider;
import be.ugent.oomt.labo3.contentprovider.database.DatabaseContract;

/**
 * Created by elias on 12/01/15.
 */
public class DetailFragment extends Fragment implements LoaderManager.LoaderCallbacks<Cursor> {

    public String getShownContact() {
        return getArguments().getString("contact", "");
    }

    public static DetailFragment newInstance(String c) {
        DetailFragment f = new DetailFragment();

        Bundle args = new Bundle();
        args.putString("contact", c);
        f.setArguments(args);
        return f;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        // TODO: change DetailFragment to show selected user feed and initialize loader

        getLoaderManager().initLoader(1,null,this);

        View view = inflater.inflate(R.layout.fragment_detail, container, false);
        TextView title = (TextView) view.findViewById(R.id.detail_title);
        TextView summary = (TextView) view.findViewById(R.id.detail_summary);
        title.setText(getShownContact());

        Button b = (Button) view.findViewById(R.id.editbtn);
        b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                posttofeed(v);
            }
        });
        //summary.setText(getResources().getStringArray(R.array.superheroes_history)[getShownIndex()]);
        return view;
    }

    @Override
    public Loader<Cursor> onCreateLoader(int id, Bundle args) {

        // Now create and return a CursorLoader that will take care of
        // creating a Cursor for the data being displayed.
        String select = (DatabaseContract.Message.COLUMN_NAME_CONTACT+"='"+getShownContact()+"'");

        Log.i("select",select);
        return new CursorLoader(getActivity(), MessageProvider.MESSAGES_CONTENT_URL,
                new String[]{DatabaseContract.Message.COLUMN_NAME_CONTACT, DatabaseContract.Message.COLUMN_NAME_MESSAGE}, select, null,
               null);


    }

    @Override
    public void onLoadFinished(Loader<Cursor> loader, Cursor data) {

        TextView summary = (TextView) getView().findViewById(R.id.detail_summary);

        String summ ="";

            while(data.moveToNext()){

                summ+=data.getString(1)+"\n";
            }


        summary.setText(summ);



    }

    @Override
    public void onLoaderReset(Loader<Cursor> loader) {

    }

    // TODO: implement LoaderManager.LoaderCallbacks<Cursor> interface

    // TODO: on cursor load finish append all messages to text view

    public void posttofeed(View v){


            EditText e = (EditText) getView().findViewById(R.id.edit);

            ContentValues values = new ContentValues();
            values.put(DatabaseContract.Message.COLUMN_NAME_CONTACT, getShownContact());
            values.put(DatabaseContract.Message.COLUMN_NAME_MESSAGE, e.getText().toString());
            getActivity().getContentResolver().insert(MessageProvider.MESSAGES_CONTENT_URL, values);
            e.setText("");

    }

}
