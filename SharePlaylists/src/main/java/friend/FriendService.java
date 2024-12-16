package friend;

import java.util.List;

import playlist.Playlist;

public class FriendService {
    private FriendDao dao;

    public FriendService() {
        this.dao = new FriendDao();
    }

    public boolean addFriend(String userId, String friendId) {
        return dao.addFriend(new Friend(userId, friendId));
    }

    public List<Playlist> getFriendPlaylists(String friendId) {
        return dao.getFriendPlaylists(friendId);
    }
}