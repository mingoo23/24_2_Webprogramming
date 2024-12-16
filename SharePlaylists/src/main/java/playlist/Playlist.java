package playlist;

public class Playlist {
	private int playlistId;
    private String playlistTitle;
    private int trackCount;

    public Playlist(int playlistId, String playlistTitle, int trackCount) {
        this.playlistId = playlistId;
        this.playlistTitle = playlistTitle;
        this.trackCount = trackCount;
    }

    public int getPlaylistId() {
        return playlistId;
    }
    
    public String getPlaylistTitle() {
        return playlistTitle;
    }
    
    public int getTrackCount() {
        return trackCount;
    }
}
