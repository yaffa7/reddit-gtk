/* main.vala
 *
 * Copyright 2019 yaffa7
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE X CONSORTIUM BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name(s) of the above copyright
 * holders shall not be used in advertising or otherwise to promote the sale,
 * use or other dealings in this Software without prior written
 * authorization.
 */
using Gtk;

public class Application : Window {

	public Application () {
		// Prepare Gtk.Window:
		this.title = "Vala Reddit";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (700, 1000);


        var scroll_view = new ScrollWindow();
        var header = new RedditHeader();

        // Search Field
        var search_field = new Gtk.SearchEntry();
        search_field.get_style_context().add_class("scroll");
        search_field.placeholder_text = "Search Subreddit";

        // Search Field events
        search_field.activate.connect(() => {
            scroll_view.clear_content();
            GLib.MainLoop mainloop = new GLib.MainLoop();
            scroll_view.load_content.begin(search_field.get_text(), "",
                (obj,res) => {
                    mainloop.quit();
                });
            mainloop.run();
            //header.update_header(search_field.get_text());
        });
        // Refresh button event
        header.button2.clicked.connect(() => {
            scroll_view.clear_content();
            GLib.MainLoop mainloop = new GLib.MainLoop();
            scroll_view.load_content.begin(search_field.get_text(), "",
                (obj,res) => {
                    mainloop.quit();
                });
            mainloop.run();
            //header.update_header(search_field.get_text());
        });

        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start(header, false, true, 0);
        vbox.pack_start(search_field, false, true, 5);
        vbox.pack_start (scroll_view , true, true, 0);
        this.add(vbox);

        var css_provider = new CssProvider();
        try {
            css_provider.load_from_path("/home/bren/Projects/reddit-gtk/src/Styles/style.css");
        } catch (Error e) {
            warning("nope");
        }
        StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            css_provider,
            STYLE_PROVIDER_PRIORITY_APPLICATION);

            var default_subreddit = "linux_gaming";
            GLib.MainLoop mainloop = new GLib.MainLoop();
            scroll_view.load_content.begin(default_subreddit, "",
                (obj,res) => {
                    mainloop.quit();
                });
            mainloop.run();
            //header.update_header(default_subreddit);

	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
