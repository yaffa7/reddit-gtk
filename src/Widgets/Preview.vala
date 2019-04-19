using Gtk;

class Preview : Window {

    Image post_image {get;set;}
    private Services.RedditJsonService _service = new  Services.RedditJsonService();

    public Preview(string url, string name) {

        this.title = url;
        this.border_width = 0;
        this.window_position = Gtk.WindowPosition.CENTER;
        this.set_default_size(1920,1080);
        this.destroy.connect(() => { this.destroy; });

        var hiname = name + "_hi";
        _service.download_file(url, hiname);
        string filename = "/home/bren/Downloads/" + hiname + ".jpg";

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
