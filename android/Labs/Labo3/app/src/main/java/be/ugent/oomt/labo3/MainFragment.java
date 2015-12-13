package be.ugent.oomt.labo3;


import android.app.ListFragment;
import android.app.LoaderManager;
import android.content.CursorLoader;
import android.content.Intent;
import android.content.Loader;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.UserDictionary;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;

import be.ugent.oomt.labo3.contentprovider.MessageProvider;
import be.ugent.oomt.labo3.contentprovider.database.DatabaseContract;

/**
 * Created by elias on 12/01/15.
 */
public class MainFragment extends ListFragment implements LoaderManager.LoaderCallbacks<Cursor> {

    boolean mDuelPane;
    int mCurCheckPosition = 0;
    SimpleCursorAdapter mCursorAdapter;
    String[] props = { DatabaseContract.Contact.COLUMN_NAME_CONTACT, DatabaseContract.Contact.COLUMN_NAME_STATE, DatabaseContract.Contact.COLUMN_NAME_LAST_UPDATE};


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // TODO: initialize asynchronous loader

        getLoaderManager().initLoader(0, null,this);




        Cursor mCursor = getActivity().getContentResolver().query(
                MessageProvider.CONTACTS_CONTENT_URL,   // The content URI of the words table
                props,                        // The columns to return for each row
                null,                    // Selection criteria
                null,                     // Selection criteria
                null);


         mCursorAdapter = new SimpleCursorAdapter(
                getActivity(),               // The application's Context object
                android.R.layout.simple_list_item_activated_2,                  // A layout in XML for one row in the ListView
                mCursor,                               // The result from the query
                props,                      // A string array of column names in the cursor
                new int[]{android.R.id.text1, android.R.id.text2},                        // An integer array of view IDs in the row layout
                0);

        // TODO: Change ArrayAdapter to SimpleCursorAdapter to access the ContentProvider
        /*ListAdapter listAdapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_activated_1,
                getResources().getStringArray(R.array.superheroes_names));
        setListAdapter(listAdapter);*/
        setListAdapter(mCursorAdapter);
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        if (savedInstanceState != null) {
            mCurCheckPosition = savedInstanceState.getInt("curChoice", 0);
        }

        View detailsFrame = getActivity().findViewById(R.id.detail_container);
        mDuelPane = detailsFrame != null && detailsFrame.getVisibility() == View.VISIBLE;
        if (mDuelPane) {
            getListView().setChoiceMode(ListView.CHOICE_MODE_SINGLE);
            Cursor s = (Cursor)getListView().getItemAtPosition(0);

            showDetails(0,s.getString(0));
        }
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putInt("curChoice", mCurCheckPosition);
    }

    @Override
    public void onListItemClick(ListView l, View v, int position, long id) {
        Cursor s = (Cursor)l.getItemAtPosition(position);

        showDetails(position, s.getString(0));



    }

    private void showDetails(int index, String s) {
        mCurCheckPosition = index;

        if (mDuelPane) {
            getListView().setItemChecked(index, true);

            DetailFragment details = (DetailFragment) getFragmentManager().findFragmentById(R.id.detail_container);
            if (details == null || !details.getShownContact().equals(s)) {
                details = DetailFragment.newInstance(s);
                getFragmentManager()
                        .beginTransaction()
                        .replace(R.id.detail_container, details)
                        .commit();
            }
        } else {
            Intent intent = new Intent(getActivity(), DetailActivity.class);
            intent.putExtra("contact", s);
            startActivity(intent);
        }
    }

    @Override
    public Loader<Cursor> onCreateLoader(int id, Bundle args) {




        return new CursorLoader(getActivity(), MessageProvider.CONTACTS_CONTENT_URL,
               props, null, null,null);
    }

    @Override
    public void onLoadFinished(Loader<Cursor> loader, Cursor data) {
        mCursorAdapter.swapCursor(data);
    }

    @Override
    public void onLoaderReset(Loader<Cursor> loader) {
        mCursorAdapter.swapCursor(null);
    }

    // TODO: implement LoaderManager.LoaderCallbacks<Cursor> interface
}
