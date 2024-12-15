package playlist;
//플레이리스트 모델 클래스
public class Playlist {
    private int id;
    private String title;
    private String thumbnail;
    private int trackCount;
    
    // 기본 생성자 추가
    public Playlist() {
    }

    public Playlist(int id, String title, String thumbnail, int trackCount) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.trackCount = trackCount;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }

    public int getTrackCount() { return trackCount; }
    public void setTrackCount(int trackCount) { this.trackCount = trackCount; }
}

