using Gee;

namespace Services {

public class RedditJsonService : Object {


    public static ArrayList<Models.Post> get_response(string subreddit) {
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

                post_list.add(new Models.Post(title, author, link));
            }

            } catch (Error e) {
                stderr.printf ("I guess something is not working...\n");
        }
        return post_list;
    }
}
}
