using Gtk;

public class MainToolbar : Toolbar {

    public Gtk.ToolButton clear_button {get;set;}

    construct {
        get_style_context ().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

        // Get Icons
        var clear_icon = new Gtk.Image.from_icon_name ("gtk-clear",
            IconSize.SMALL_TOOLBAR);

        // Create Toolbar buttons
        clear_button = new Gtk.ToolButton (clear_icon, "Clear");

        clear_button.is_important = true;

        add(clear_button);
    }
}

