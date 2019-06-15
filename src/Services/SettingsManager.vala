using Gee;

namespace Services {

    public class SettingsManager : Object {

        private static string app_name = "reddit-gtk";
        private Models.Settings _settings {get;set;}


        public static Models.Settings get_settings() {
            return new Models.Settings("vlc", false);
        }

        public static string get_data_dir() {
        var cache_dir = Environment.get_user_cache_dir() + "/reddit-gtk/";
            if (FileUtils.test(cache_dir, FileTest.EXISTS) == false) {
            // create cache directory if one does not exist
                try {
                    var file = File.new_for_path(cache_dir);
                    file.make_directory();
                } catch (Error e) { print ("Error: %s\n", e.message); }
            }
            return cache_dir;
        }
    }
}
