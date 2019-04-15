namespace Models {
    public class Post : Object {
        public string post_title {get;set;}
        public string post_author {get;set;}
        public string post_link {get;set;}

        public Post(string title, string author, string link) {
            post_title = title;
            post_author = author;
            post_link = link;
        }
    }
}


