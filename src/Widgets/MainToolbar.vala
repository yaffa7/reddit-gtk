using Gtk;

public class MainToolbar : Toolbar {

    public Gtk.ToolButton clear_button {get;set;}

    construct {
        get_style_context ().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

        // Get Icons
        var clear_icon = new Gtk.Image.from_icon_name ("gtk-refresh",
            IconSize.SMALL_TOOLBAR);

        // Create Toolbar buttons
        clear_button = new Gtk.ToolButton (clear_icon, "Refresh");

        clear_button.is_important = true;

        add(clear_button);
    }

    public void get_details(string subreddit) {
        Services.RedditJsonService.get_subreddit_details(subreddit);
        var clear_icon = new Gtk.Image.from_icon_name ("gtk-refresh",
            IconSize.SMALL_TOOLBAR);

        var title  = new Gtk.ToolButton (clear_icon, Services.RedditJsonService._subreddit_display_name +
        Services.RedditJsonService._subscribers.to_string());

        title.is_important = true;
        this.add(title);
        this.show_all();
    }
}

