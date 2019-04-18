using Gtk;

public class ScrollWindow : ScrolledWindow {

    private Box _content_area {get;set;}
    private Services.RedditJsonService _service = new  Services.RedditJsonService();

    public ScrollWindow() {
        _content_area = new Box (Orientation.VERTICAL, 0);
        add(_content_area);
    }

    public void load_content(string subreddit) {
         var post_list = _service.get_response(subreddit);
           foreach(Models.Post post in post_list) {
               _content_area.pack_start(
               new Post(post.post_title,post.post_author,post.post_link, post.post_name)
               , false, false, 0);
           }
           _content_area.show_all();
    }

    public void clear_content() {
        var children = _content_area.get_children();
        foreach(var child in children) {
            _content_area.remove(child);
        }
    }

}
