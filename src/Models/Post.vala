namespace Models {
    public class Post : Object {
        public string post_title {get;set;}
        public string post_author {get;set;}
        public string post_link {get;set;}
        public string post_name {get;set;}
        public string post_flair {get;set;}
        public Post(string title, string author, string link, string name) {
            post_title = title;
            post_author = author;
            post_link = link;
            post_name = name;
        }
    }
}



