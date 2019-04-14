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
	private int click_counter = 0;

	public Application () {
		// Prepare Gtk.Window:
		this.title = "Download Japan Names";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.destroy.connect (Gtk.main_quit);
		this.set_default_size (350, 400);


		// The button:
		Gtk.Label top_label = new Gtk.Label("Top Label");
		Gtk.Button button = new Gtk.Button.with_label ("Get GIS data");
		Gtk.Button button2 = new Gtk.Button.with_label ("dont click me! [0]");

		Gtk.Box top_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
		Gtk.Box bottom_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

		bottom_box.spacing = 10;


		top_box.pack_start(top_label);
		bottom_box.pack_start (button, false, false, 2);
		bottom_box.pack_start (button2, false, true, 2);
        //this.add(top_box);
        //this.add(bottom_box);
		button.clicked.connect (() => {
			// Emitted when the button has been activated:
			//button.label = "Click This! [%d]".printf (++this.click_counter);
			stdout.printf("getting data!");
            new Helpers.RedditJsonService().get_response();

		});

		button2.clicked.connect(() => {
		    button2.label = "Click This! [%d]".printf (++this.click_counter);
		});

		var toolbar = new Toolbar ();
        toolbar.get_style_context ().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

        var open_icon = new Gtk.Image.from_icon_name ("document-open",
            IconSize.SMALL_TOOLBAR);
        var find_icon = new Gtk.Image.from_icon_name ("gtk-find", IconSize.SMALL_TOOLBAR);

        var open_button = new Gtk.ToolButton (open_icon, "Download");
        var find_button = new Gtk.ToolButton (find_icon, "Find");



        open_button.is_important = true;
        toolbar.add (open_button);
        toolbar.add (find_button);
        var scroll_view = new MyScrollWindow();
        open_button.clicked.connect(() => {
           var name_list = new Helpers.RedditJsonService().get_response();
           foreach(var name in name_list) {
               scroll_view.text_view.buffer.text += name + "\n";
           }
        });
        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (toolbar, false, true, 2);
        vbox.pack_start (scroll_view , true, true, 0);
        this.add(vbox);


	}

	public static int main (string[] args) {
		Gtk.init (ref args);

		Application app = new Application ();
		app.show_all ();
		Gtk.main ();
		return 0;
	}
}
