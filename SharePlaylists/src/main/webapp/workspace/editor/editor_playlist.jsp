<link rel="stylesheet" href="./workspace/workspace_styles.css" />
<section id="workspace-edit" class="workspace-tab-content">
  <div align="center">
    <form id="playlist-form">
      <table border="0" width="70%">
        <tr style="height: 80px">
          <th class="title-category">Playlist 이름</th>
          <td class="td-container">
            <input
              type="text"
              name="title"
              class="input-window"
              placeholder="플레이리스트 이름을 입력해주세요."
            />
            <input
              class="button btnPush btnOrange"
              type="submit"
              value="수정 완료"
            />
          </td>
        </tr>
        <tr>
          <th rowspan="3" class="category">Playlist에 추가할 음악</th>
          <td class="td-container">
            <div id="songs-list">
              <!-- 노래 추가 항목이 여기 쌓이게 됩니다. -->
            </div>
            <div class="plus-button" id="add-song-button">
              <span class="icon">+</span> 노래 추가
            </div>
          </td>
        </tr>
        <tr>
          <th rowspan="3" class="category">Playlist를 공유할 친구</th>
          <td class="td-container">
            <div>ID 1234</div>
            <div class="delete-button">
              <span class="icon">X</span>
            </div>
          </td>
        </tr>
        <tr>
          <td class="td-container">
            <div>ID 1234</div>
            <div class="delete-button">
              <span class="icon">X</span>
            </div>
          </td>
        </tr>
      </table>
    </form>
  </div>
</section>





<script>
  document.getElementById('add-song-button').addEventListener('click', function() {
    // 새로운 노래 항목을 추가하는 함수
    const songDiv = document.createElement('div');
    songDiv.classList.add('song-item');
    
    // 노래 제목과 가수명 (예시로 추가)
    songDiv.innerHTML = `
      <div class="thumnail-container">
        <img src="thumnail.png" width="50" height="50" alt="썸네일" />
        <div>
          Up (Solo Karina)
        </div>
      </div>
      <div class="singer-container">
        <div>aespa</div>
        <div class="delete-button">
          <span class="icon">X</span>
        </div>
      </div>
    `;
    
    // 노래 항목을 페이지에 추가
    document.getElementById('songs-list').appendChild(songDiv);
  });
</script>