using Gee;

namespace Services {

    public class SettingsManager : Object {


        public SettingsManager _instance {get;set;}
        private Models.Settings _settings {get;set;}

        public static string get_temp_dir() {
            return "/tmp/reddit-gtk";
        }

        public static Models.Settings get_settings() {
            return new Models.Settings("vlc", false);
        }


    }
}
