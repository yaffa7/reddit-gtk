using Gtk;
using GLib;

public class Post : Box {

    Label post_title {get;set;}
    Label post_author {get;set;}
    Label post_flair {get;set;}
    Image post_image {get;set;}
    Box post_details {get;set;}
    EventBox image_container {get;set;}
    Box vote_container {get;set;}

    public Post(string title, string author, string link, string name, string flair, string url,string thumbnail, int64 ups, int64 downs) {
        orientation = Orientation.HORIZONTAL;
        post_title = new Label(title);
        post_author = new Label("Posted by u/" + author);
        post_flair = new Label(flair);

        post_details = new Box(Orientation.VERTICAL, 0);
        post_details.get_style_context().add_class("details");

        vote_container = new Box(Orientation.VERTICAL, 0);
        vote_container.get_style_context().add_class("votes");

        image_container = new EventBox();
        image_container.get_style_context().add_class("image");
        image_container.button_release_event.connect(() => {
        stdout.printf(url);
            if(".jpg" in url || ".png" in url) {
                // Show Image Preview
                var preview = new Preview(url, name);
                preview.show_all();
                image_container.opacity = 0.5;
            } else if ("youtube" in url) {
            try {
                Process.spawn_command_line_async("mpv " + url);
                image_container.opacity = 0.5;
            } catch(Error e) {}

            }
            return false;
        });
        try {
            string file_extension = "";
            if (".jpg" in thumbnail) {
                file_extension = ".jpg";
            } else if (".png" in thumbnail) {
                file_extension = ".png";
            }

            stdout.printf("Opening file from path: /home/bren/Downloads/" + name + file_extension + "\n");
            var loader = new Gdk.Pixbuf.from_file("/home/bren/Downloads/" + name + file_extension);
            post_image = new Image.from_pixbuf(loader);
            post_image.xalign = 0;
            post_image.margin_end = 10;
            image_container.add(post_image);
        } catch (Error e) {stdout.printf("Failed loading image!: " + title);}


        post_title.xalign = 0;
        //post_title.margin_start = 10;
        post_title.get_style_context().add_class("post-title");
        post_title.max_width_chars = 60;
        post_title.wrap = true;

        post_author.xalign = 0;
        post_author.get_style_context().add_class("post-author");

        post_flair.xalign = 0;
        post_flair.margin_start = 10;

        post_details.pack_start(post_title, false, false ,5);
        post_details.pack_start(post_author, true, false, 5);
        if (flair != "") {
            post_details.pack_start(post_flair, false, false, 5);
        }


        int votes_max_width = 5;
        var ups_label = new Label(ups.to_string());
        ups_label.width_chars = votes_max_width;
        var period_label = new Label(".");
        period_label.width_chars = votes_max_width;
        var downs_label = new Label(downs.to_string());
        downs_label.width_chars = votes_max_width;
        vote_container.pack_start(ups_label);
        vote_container.pack_start(period_label);
        vote_container.pack_start(downs_label);

        pack_start(image_container, false, false ,0);
        pack_start(post_details, false , false, 0);
        pack_end(vote_container, false, false, 0);

        get_style_context().add_class("post");
    }
}
