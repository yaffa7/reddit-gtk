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
    Box comment_container {get;set;}
    Box side_container {get;set;}
    Models.Post _post {get;set;}

    public Post(Models.Post post) {
        _post = post;
        orientation = Orientation.HORIZONTAL;
        setup_post_title();
        post_author = new Label("Posted by u/" + post.post_author);
        post_flair = new Label(post.post_flair);

        post_details = new Box(Orientation.VERTICAL, 0);
        post_details.get_style_context().add_class("details");

        vote_container = new Box(Orientation.HORIZONTAL, 0);

        comment_container = new Box(Orientation.HORIZONTAL, 0);
        side_container = new Box(Orientation.VERTICAL, 0);
        side_container.get_style_context().add_class("votes");

        image_container = new EventBox();
        image_container.get_style_context().add_class("image");

        setup_post_events();

        // Download and get image async
        GLib.MainLoop mainloop = new GLib.MainLoop();
        get_image.begin((obj, res) => {
                              post_image = get_image.end(res);
                              post_image.xalign = 0;
                              post_image.margin_end = 10;
                              image_container.add(post_image);
                              mainloop.quit();
                          });
        mainloop.run();

        post_author.xalign = 0;
        post_author.get_style_context().add_class("post-author");

        post_flair.xalign = 0;
        post_flair.margin_start = 10;

        post_details.pack_start(post_title, false, false ,5);
        post_details.pack_start(post_author, true, false, 5);
        if (post.post_flair != "") {
            post_details.pack_start(post_flair, false, false, 5);
        }


        var ups_label = new Label(post.post_ups.to_string());
        var arrow_up_image = new Gtk.Image.from_icon_name ("arrow-up", Gtk.IconSize.MENU);
        arrow_up_image.get_style_context().add_class("arrow-up");
        vote_container.pack_start(arrow_up_image, false, false , 0);
        vote_container.pack_start(ups_label, false, false, 0);


        var message_image = new Gtk.Image.from_icon_name ("dialog-messages", Gtk.IconSize.MENU);
        message_image.get_style_context().add_class("message");
        comment_container.pack_start(message_image);
        comment_container.pack_start(new Label(post.post_comments.to_string()));

        side_container.pack_start(vote_container);
        side_container.pack_start(comment_container);

        pack_start(image_container, false, false ,0);
        pack_start(post_details, false , false, 0);
        pack_end(side_container, false, false, 0);

        get_style_context().add_class("post");
        show_all();
    }

    //
    // Async Image Getter
    //
    private async Image get_image() {
        GLib.Idle.add(this.get_image.callback);
        yield;
        Services.RedditJsonService.download_file(_post.post_thumbnail, _post.post_name);
        var image = new Image();
        try {
            string file_extension = "";
            if (".jpg" in _post.post_thumbnail) {
                file_extension = ".jpg";
            } else if (".png" in _post.post_thumbnail) {
                file_extension = ".png";
            }
            var file_path = Services.SettingsManager.get_data_dir() + _post.post_name + file_extension;
            stdout.printf("Opening file from path: " + file_path + "\n");
            var loader = new Gdk.Pixbuf.from_file(file_path);
            image = new Image.from_pixbuf(loader);

        } catch (Error e) {stdout.printf("Failed loading image!: " + _post.post_title);}
        return image;
    }

    //
    // Post Events
    //
    private void setup_post_events() {
        image_container.button_release_event.connect(() => {
        stdout.printf(_post.post_url);
            if(".jpg" in _post.post_url || ".png" in _post.post_url) {
                // Show Image Preview
                image_container.opacity = 0.5;
                var preview = new Preview(_post.post_url, _post.post_name, _post.post_title);
                preview.show_all();
            } else if ("youtube" in _post.post_url) {
            try {
                image_container.opacity = 0.5;
                Process.spawn_command_line_async("mpv " + _post.post_url);
            } catch(Error e) {}

            }
            return false;
        });
    }

    //
    // Labels
    //

    private void setup_post_title() {
        post_title = new Label(_post.post_title);
        post_title.xalign = 0;
        //post_title.margin_start = 10;
        post_title.get_style_context().add_class("post-title");
        post_title.max_width_chars = 60;
        post_title.wrap = true;
    }



}
