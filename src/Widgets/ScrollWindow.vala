using Gtk;
using Gee;

public class ScrollWindow : ScrolledWindow {

    private Box _content_area {get;set;}
    private Services.RedditJsonService _service = new  Services.RedditJsonService();

    private string _saved_reddit = "wallpapers";
    private ArrayList<Models.Post> _post_list;

    public ScrollWindow() {
        _content_area = new Box (Orientation.VERTICAL, 0);
        add(_content_area);
        edge_reached.connect((pos) => {
            switch (pos)
            {
                case PositionType.BOTTOM:
                {
                    stdout.printf("Hit bottom!");
                    load_content("wallpapers", _post_list.last().post_name);
                    break;
                }
                default:
                    break;
            }
        });
    }

    public void load_content(string subreddit, string after) {
        _saved_reddit = subreddit;
        _post_list = _service.get_posts(subreddit, after);

        foreach(Models.Post post_model in _post_list) {
            _content_area.pack_start(new Post(post_model), false, false, 0);
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
