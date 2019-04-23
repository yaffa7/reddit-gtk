using Gtk;

public class RedditHeader : HeaderBar {

        Label subreddit_name {get;set;}

        construct {
        	set_title("Header");
        	set_show_close_button(true);
        	set_subtitle("Subtitle here");
        	spacing = 0;
        	//Get image from icon theme
        	Gtk.Image img = new Image.from_icon_name ("gtk-refresh", IconSize.MENU);
        	Gtk.ToolButton button2 = new ToolButton (img, null);
            pack_start(button2);


            Gtk.Image menu_img = new Image.from_icon_name ("open-menu-symbolic", IconSize.MENU);
        	Gtk.ToolButton menu_button = new ToolButton (menu_img, null);
            pack_end(menu_button);

        	//Add a search entry to the header
        	pack_start(new Gtk.SearchEntry());
        }


        public void update_header(string subreddit) {
            Services.RedditJsonService.get_subreddit_details(subreddit);


        }
    }
