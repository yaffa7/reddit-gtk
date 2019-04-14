using Gtk;

public class ScrollWindow : ScrolledWindow {

    public TextView text_view {get;set;}

    construct {
        text_view = new TextView();
        text_view.editable = true;
        text_view.cursor_visible = false;

        set_policy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        add(text_view);
    }

}
