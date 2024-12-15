package playlist;

import java.util.List;

public class Playlist {
    private int id;
    private String title;
    private int trackCount;
    private List<String> songs;  // 곡 목록 추가

    public Playlist() {
        // 기본 생성자
    }

    // 생성자
    public Playlist(int id, String title, int trackCount, List<String> songs) {
        this.id = id;
        this.title = title;
        this.trackCount = trackCount;
        this.songs = songs;
    }

    // Getter/Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter/Setter for title
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    // Getter/Setter for trackCount
    public int getTrackCount() {
        return trackCount;
    }

    public void setTrackCount(int trackCount) {
        this.trackCount = trackCount;
    }

    // Getter/Setter for songs
    public List<String> getSongs() {
        return songs;
    }

    public void setSongs(List<String> songs) {
        this.songs = songs;
    }
}
