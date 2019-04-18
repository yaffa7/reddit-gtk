using Gtk;

public class Post : Box {

    Label post_title {get;set;}
    Label post_author {get;set;}
    Label post_link {get;set;}
    Image post_image {get;set;}
    Box post_details {get;set;}
    Box image_container {get;set;}

    public Post(string title, string author, string link, string name) {
        orientation = Orientation.HORIZONTAL;
        post_title = new Label(title);
        post_author = new Label("Posted by u/" + author);
        post_link = new Label(link);
        post_details = new Box(Orientation.VERTICAL, 0);
        image_container = new Box(Orientation.VERTICAL, 0);
        image_container.get_style_context().add_class("image");

        post_image = new Image.from_file("/home/bren/Downloads/" + name + ".jpg");
        post_title.xalign = 0;
        post_title.margin_start = 10;
        post_title.get_style_context().add_class("post-title");
        post_author.xalign = 0;
        post_author.margin_start = 10;
        post_author.get_style_context().add_class("post-author");
        post_link.xalign = 0;
        post_link.margin_start = 10;
        post_image.xalign = 0;

        post_details.pack_start(post_title, false, false ,5);
        post_details.pack_start(post_author, true, true, 5);
        post_details.pack_start(post_link, false, false, 5);

        image_container.pack_start(post_image, false, false, 0);
        pack_start(image_container, false, false ,0);
        pack_start(post_details, false , false, 0);

        get_style_context().add_class("post");
    }
}
