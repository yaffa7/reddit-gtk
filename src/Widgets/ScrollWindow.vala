using Gtk;
using Gee;
using Services;

public class ScrollWindow : ScrolledWindow {

    private Box _content_area {get;set;}
    private bool fetching = false;
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
                    GLib.MainLoop mainloop = new GLib.MainLoop();
                    load_content.begin("", _post_list.last().post_name,
                        (obj,res) => {
                            mainloop.quit();
                    });
                    mainloop.run();
                    break;
                }
                default:
                    break;
            }
        });
    }

    public async bool load_content(string subreddit, string after) {
        GLib.Idle.add(this.load_content.callback);
        yield;
        if(!fetching) {
            fetching = true;
            _post_list = RedditJsonService.get_posts(subreddit, after);
            fetching = false;

            foreach(Models.Post post_model in _post_list) {
                _content_area.pack_start(new Post(post_model), false, false, 0);
            }
            _content_area.show_all();
        }
        return true;
    }

    public void clear_content() {
        var children = _content_area.get_children();
        foreach(var child in children) {
            _content_area.remove(child);
        }
        scroll_to_top();
    }

    private void scroll_to_top() {
        var adj = get_vadjustment();
        adj.set_value(0);
    }

}
