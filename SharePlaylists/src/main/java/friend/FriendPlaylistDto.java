package friend;

public class FriendPlaylistDto {
    private String friendId;
    private String friendName;
    private String playlistTitle;
    private String thumbnail;
    private int trackCount;

    public FriendPlaylistDto(String friendId, String friendName, String playlistTitle, String thumbnail, int trackCount) {
        this.friendId = friendId;
        this.friendName = friendName;
        this.playlistTitle = playlistTitle;
        this.thumbnail = thumbnail;
        this.trackCount = trackCount;
    }

    public String getFriendId() {
        return friendId;
    }

    public void setFriendId(String friendId) {
        this.friendId = friendId;
    }

    public String getFriendName() {
        return friendName;
    }

    public void setFriendName(String friendName) {
        this.friendName = friendName;
    }

    public String getPlaylistTitle() {
        return playlistTitle;
    }

    public void setPlaylistTitle(String playlistTitle) {
        this.playlistTitle = playlistTitle;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public int getTrackCount() {
        return trackCount;
    }

    public void setTrackCount(int trackCount) {
        this.trackCount = trackCount;
    }
    public String toJson() {
        return String.format(
            "{\"friendId\":\"%s\",\"friendName\":\"%s\",\"playlistTitle\":\"%s\"}",
            friendId, friendName, playlistTitle
        );
    }
}