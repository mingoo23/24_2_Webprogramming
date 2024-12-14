package playlist;
//플레이리스트 모델 클래스
public class Playlist {
    private int id;
    private String title;
    private String thumbnail;
    private int trackCount;

    public Playlist(int id, String title, String thumbnail, int trackCount) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.trackCount = trackCount;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getThumbnail() { return thumbnail; }
    public int getTrackCount() { return trackCount; }
}
