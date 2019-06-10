using Gtk;
using Services;

class Preview : Window {

    Image post_image {get;set;}

    public Preview(string url, string name, string title) {

        this.title = title;
        this.border_width = 0;
        this.window_position = Gtk.WindowPosition.NONE;
        this.destroy.connect(() => { this.destroy; });

        var hiname = name + "_hi";
        RedditJsonService.download_file(url, hiname);

        string file_extension = "";
        if (".jpg" in url) {
            file_extension = ".jpg";
        } else if (".png" in url) {
            file_extension = ".png";
        }

        string filename = "/home/bren/Downloads/" + hiname + file_extension;

        stdout.printf(filename);
        try {
            var loader = new Gdk.Pixbuf.from_file_at_size(filename, 1920, 1080);
            post_image = new Image.from_pixbuf(loader);
            post_image.xalign = 0;
            var event_box = new EventBox();
            event_box.button_release_event.connect(() => {
                this.destroy;
                return true;
            });
            event_box.add(post_image);
            this.add(event_box);

        } catch (Error e) {stdout.printf(e.message);}

    }
}
