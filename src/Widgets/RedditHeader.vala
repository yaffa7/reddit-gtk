using Gtk;
using Services;

public class RedditHeader : HeaderBar {

        private Label _subreddit_name {get;set;}
        private Image _subreddit_image {get;set;}

        construct {
        	set_title("Header");
        	set_show_close_button(true);
        	set_subtitle("Subtitle here");
        	spacing = 0;
        	//Get image from icon theme
        	Image img = new Image.from_icon_name ("gtk-refresh", IconSize.MENU);
        	ToolButton button2 = new ToolButton (img, null);
            pack_end(button2);


            Image menu_img = new Image.from_icon_name ("open-menu-symbolic", IconSize.MENU);
        	ToolButton menu_button = new ToolButton (menu_img, null);
            pack_end(menu_button);

        	//Add a search entry to the header
        	//pack_start(new SearchEntry());
        }


        public void update_header(string subreddit) {
            this.remove(_subreddit_image);
            this.remove(__subreddit_name);
            RedditJsonService.get_subreddit_details(subreddit);
            RedditJsonService.download_file(RedditJsonService.header_img_url, subreddit );
            stdout.printf("header image!!!!! " + RedditJsonService.header_img_url);
            try {
                _subreddit_image = new Image.from_pixbuf(new Gdk.Pixbuf.from_file_at_size("/home/bren/Downloads/" + subreddit + ".png", 50, 50));
                pack_start(_subreddit_image);
            } catch (Error e) {}
            _subreddit_name = new Label(RedditJsonService.subreddit_title);
            __subreddit_name.get_style_context().add_class("subreddit-title");
            pack_start(_subreddit_name);

            show_all();
        }
    }
