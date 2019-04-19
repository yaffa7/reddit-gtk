using Gee;

namespace Services {

public class RedditJsonService : Object {

    private static int count = 0;

    public static void download_file(string url, string filename) {
        if (".jpg" in url) {
            stdout.printf("Downloading file: " + url + "\n");
            var uri = url;
            var session = new Soup.Session ();
            var message = new Soup.Message ("GET", uri);
            try {
                count++;
                session.send_message (message);
                FileUtils.set_data("/home/bren/Downloads/" + filename + ".jpg" , message.response_body.data);
            } catch (Error e) { stderr.printf("error happend downloading resource: " + url + "\n");}
        }
    }

    public static ArrayList<Models.Post> get_posts(string subreddit) {
        var uri = "https://www.reddit.com/r/" + subreddit + ".json";
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
                var flair = "";
                if (raw_flair != null) {
                    flair = child_data.get_string_member("link_flair_css_class");

                }
                var url = child_data.get_string_member("url");


                if (FileUtils.test("/home/bren/Downloads/" + name + ".jpg", FileTest.EXISTS) == false) {
                    download_file(thumbnail, name );
                }
                post_list.add(new Models.Post(title, author, link, name, flair, url, ups, downs));
            }

            } catch (Error e) {
                stderr.printf ("I guess something is not working...\n");
        }
        return post_list;
    }
}
}

