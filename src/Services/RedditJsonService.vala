using Gee;

namespace Services {

public class RedditJsonService : Object {

    public static string _subreddit_display_name = "";
    public static string _header_img_url = "";
    public static string _subreddit_title = "";
    public static int64 _subscribers;

    private static int count = 0;
    private static string _subreddit = "";

    public static void download_file(string url, string filename) {
        string file_extension = "";
        if (".jpg" in url) {
            file_extension = ".jpg";
        } else if (".png" in url) {
            file_extension = ".png";
        }
        stdout.printf("URL: " + url + "\n" + "filename: " + filename + "\n");
        if(".jpg" in url || ".png" in url) {
            string fullpath = "/home/bren/Downloads/" + filename + file_extension ;

            // Only download file if it does not exist
            if (FileUtils.test(fullpath, FileTest.EXISTS) == false) {
                var uri = url;
                stdout.printf("Downloading file: " + uri + "\n");
                var session = new Soup.Session ();
                var message = new Soup.Message ("GET", uri);
                try {
                    count++;
                    session.send_message (message);
                    FileUtils.set_data(fullpath, message.response_body.data);
                } catch (Error e) { stderr.printf("error happend downloading resource: " + url + "\n");}
            }

        }
    }

    public static ArrayList<Models.Post> get_posts(string subreddit, string after) {

        if (subreddit != "")
            _subreddit = subreddit;

        var uri = "https://www.reddit.com/r/" + _subreddit + ".json?after=" + after;
        stdout.printf("Request URI: " + uri + "\n");
        var post_list = new ArrayList<Models.Post>();
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", uri);
        session.send_message (message);

        try {
            var parser = new Json.Parser ();
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);

            var root_object = parser.get_root ().get_object ();
            var data = root_object.get_object_member ("data");
            var children = data.get_array_member ("children");
            int64 count = children.get_length ();
            int64 total = data.get_int_member ("dist");
            stdout.printf ("got %lld out of %lld results:\n\n", count, total);


            foreach(var child in children.get_elements()) {
                var child_object = child.get_object();
                var child_data = child_object.get_object_member("data");

                var title = child_data.get_string_member("title");
                var author = child_data.get_string_member("author");
                var link = child_data.get_string_member("url");
                var ups = child_data.get_int_member("ups");
                var downs = child_data.get_int_member("downs");
                var thumbnail = child_data.get_string_member("thumbnail");
                var name = child_data.get_string_member("name");
                var raw_flair = child_data.get_object_member("link_flair_css_class");
                var num_comments = child_data.get_int_member("num_comments");
                var flair = "";
                if (raw_flair != null) {
                    flair = child_data.get_string_member("link_flair_css_class");

                }

                var url = child_data.get_string_member("url");

                download_file(thumbnail, name);
                post_list.add(new Models.Post(title, author, link, name, flair, url, thumbnail, ups, downs, num_comments));
            }

            } catch (Error e) {
                stderr.printf ("I guess something is not working...\n");
        }
        return post_list;
    }

    public static void get_subreddit_details(string subreddit) {
        var uri = "https://www.reddit.com/r/" + subreddit + "/about.json";
        stdout.printf("Request URI: " + uri + "\n");
        var post_list = new ArrayList<Models.Post>();
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", uri);
        session.send_message (message);

        try {
            var parser = new Json.Parser ();
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);
            var root_object = parser.get_root ().get_object ();
            var data = root_object.get_object_member ("data");

            _subreddit_display_name = data.get_string_member ("display_name_prefixed");
            _header_img_url = data.get_string_member ("header_img");
            _subreddit_title = data.get_string_member("title");
            _subscribers = data.get_int_member("subscribers");
        } catch (Error e) {}
    }
}
}

