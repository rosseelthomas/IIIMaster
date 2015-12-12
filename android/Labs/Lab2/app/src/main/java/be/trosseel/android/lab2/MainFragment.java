package be.trosseel.android.lab2;


import android.app.FragmentTransaction;
import android.app.ListFragment;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

/**
 * A simple {@link Fragment} subclass.
 */
public class MainFragment extends ListFragment {



int i;
    public MainFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View v = super.onCreateView(inflater,container,savedInstanceState);
        ArrayAdapter<String> arr = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_activated_1, getResources().getStringArray(R.array.superheroes_names));

        setListAdapter(arr);

        Log.i("lifecycle-fragment", "createview");
        if(savedInstanceState != null && savedInstanceState.containsKey("index")){

            int index = savedInstanceState.getInt("index");
            startdetail(index);
            savedInstanceState.clear();
        }
        return v;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        getListView().setChoiceMode(ListView.CHOICE_MODE_SINGLE);
    }

    @Override
    public void onDetach() {
        super.onDetach();
        Log.i("lifecycle-fragment", "detach");
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i("lifecycle-fragment", "destroy");
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        Log.i("lifecycle-fragment", "destroyview");
    }

    @Override
    public void onStop() {
        super.onStop();
        Log.i("lifecycle-fragment", "stop");
    }

    @Override
    public void onPause() {
        super.onPause();
        Log.i("lifecycle-fragment", "pause");
    }

    @Override
    public void onStart() {
        super.onStart();
        Log.i("lifecycle-fragment", "start");
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        Log.i("lifecycle-fragment", "attach");
    }



    @Override
    public void onListItemClick(ListView l, View v, int position, long id) {
        super.onListItemClick(l, v, position, id);
        startdetail(position);
        i=position;
    }


    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putInt("index",i);
    }

    private void startdetail(int index){
        if(getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE){
            DetailFragment d = new DetailFragment();
            Bundle b = new Bundle();
            b.putInt("index",index);
            d.setArguments(b);
            FragmentTransaction transaction = getFragmentManager().beginTransaction();

            transaction.replace(R.id.container, d);
            transaction.addToBackStack(null);

            transaction.commit();
        }else{
            Intent intent = new Intent(getActivity(), DetailActivity.class);
            intent.putExtra("index", index);
            startActivity(intent);
        }
    }
}
