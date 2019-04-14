using Gtk;

public class MainToolbar : Toolbar {

    public Gtk.ToolButton open_button {get;set;}
    public Gtk.ToolButton find_button {get;set;}

    construct {
        get_style_context ().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

        // Get Icons
        var open_icon = new Gtk.Image.from_icon_name ("document-open",
            IconSize.SMALL_TOOLBAR);
        var find_icon = new Gtk.Image.from_icon_name ("gtk-find",
            IconSize.SMALL_TOOLBAR);

        // Create Toolbar buttons
        open_button = new Gtk.ToolButton (open_icon, "Download");
        find_button = new Gtk.ToolButton (find_icon, "Find");

        open_button.is_important = true;
        find_button.is_important = true;

        add(open_button);
        add(find_button);
    }
}



