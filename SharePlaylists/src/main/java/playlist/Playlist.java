package playlist;

import java.util.List;

public class Playlist {
	private int playlistId;
    private String playlistTitle;
    private int trackCount;
    private int id;
    private String title;
    private List<String> songs;
    

    public Playlist(int id, String title, int trackCount, List<String> songs) {
        this.id = id;
        this.title = title;
        this.trackCount = trackCount;
        this.songs = songs;
    }
    
    public Playlist(String title) {
    	this.playlistTitle = title;
    };
    
    public Playlist(String title, int trackCount, String thumbnail) {
        this.title = title;
        this.trackCount = trackCount;
        this.songs = null;  // 썸네일만 추가, 곡 목록은 null로 설정 (필요에 따라 수정 가능)
    }
    

    // Getter/Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;

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

    // toJson() 메서드 추가
    public String toJson() {
        StringBuilder json = new StringBuilder("{");
        json.append("\"id\":").append(id).append(",");
        json.append("\"title\":\"").append(title).append("\",");
        json.append("\"trackCount\":").append(trackCount);

        if (songs != null && !songs.isEmpty()) {
            json.append(",\"songs\":[");
            for (int i = 0; i < songs.size(); i++) {
                json.append("\"").append(songs.get(i)).append("\"");
                if (i < songs.size() - 1) json.append(",");
            }
            json.append("]");
        }

        json.append("}");
        return json.toString();
    }
}

