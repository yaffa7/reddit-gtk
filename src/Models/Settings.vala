
namespace Models {
    public class Settings : Object {


    public string media_player {get;set;}
    public bool low_data {get;set;}

    public Settings(string media_player, bool low_data) {
        this.media_player = media_player;
        this.low_data = low_data;
    }

    }
}
