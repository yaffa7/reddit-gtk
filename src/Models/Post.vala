namespace Models {
    public class Post : Object {
        public string post_title {get;set;}
        public string post_author {get;set;}
        public string post_link {get;set;}
        public string post_name {get;set;}
        public string post_flair {get;set;}
        public string post_url {get;set;}
        public string post_thumbnail {get;set;}
        public int64 post_ups {get;set;}
        public int64 post_downs {get;set;}

        public Post(string title, string author, string link, string name,string flair, string url,
        string thumbnail, int64 ups, int64 downs) {
            post_title = title;
            post_author = author;
            post_link = link;
            post_name = name;
            post_flair = flair;
            post_url = url;
            post_thumbnail = thumbnail;
            post_ups = ups;
            post_downs = downs;
        }
    }
}



