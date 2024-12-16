package playlist;

public class SongService {
    private SongDao songDao;

    public SongService() {
        this.songDao = new SongDao();
    }

    public boolean addSongToPlaylist(String songId, int playlistId) throws Exception {
        if (songId == null || songId.isEmpty()) {
            throw new IllegalArgumentException("Song ID cannot be null or empty");
        }

        return songDao.insertSong(songId, playlistId);
    }
}
