using Gtk;

public class Post : Box {

    Label post_title {get;set;}
    Label post_author {get;set;}
    Label post_link {get;set;}

    public Post(string title, string author, string link) {
        orientation = Orientation.VERTICAL;
        post_title = new Label(title);
        post_author = new Label(author);
        post_link = new Label(link);

        post_title.xalign = 0;
        post_title.margin_start = 10;
        post_author.xalign = 0;
        post_author.margin_start = 10;
        post_link.xalign = 0;
        post_link.margin_start = 10;


        pack_start(post_title, false, false ,5);
        pack_start(post_author, false, false, 5);
        pack_start(post_link, false, false, 5);
    }
}