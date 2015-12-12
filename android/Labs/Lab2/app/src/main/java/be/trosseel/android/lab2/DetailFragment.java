package be.trosseel.android.lab2;


import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 */
public class DetailFragment extends Fragment {


    public DetailFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_detail, container, false);
        int index = getArguments().getInt("index");
        String name = getResources().getStringArray(R.array.superheroes_names)[index];
        String history = getResources().getStringArray(R.array.superheroes_history)[index];

        ((TextView)v.findViewById(R.id.txtName)).setText(name);
        ((TextView)v.findViewById(R.id.txtHistory)).setText(history);

        return v;
    }


}

