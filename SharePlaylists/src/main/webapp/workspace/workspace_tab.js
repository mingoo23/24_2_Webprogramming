$(document).ready(function () {
  const cache = {}; // 데이터를 저장할 캐시 객체

  // 초기설정 - 활성화된 탭 콘텐츠 로드
  const defaultFile = $(".workspace-header.active").data("file");
  loadContent(defaultFile);

  // 탭 클릭 시 콘텐츠 로드
  $(".workspace-header").click(function (e) {
    e.preventDefault();

    // 탭 활성화 상태 변경
    $(".workspace-header").removeClass("active");
    $(this).addClass("active");

    // 해당 파일을 로드
    const fileName = $(this).data("file");
    loadContent(fileName);
  });

  // 콘텐츠를 동적으로 로드하는 함수
  function loadContent(file) {
    // 캐시에 데이터가 있다면 바로 사용
    if (cache[file]) {
      console.log(`캐시에서 로드: ${file}`);
      $("#workspace-content").html(cache[file]);

      // 기존 콘텐츠를 비활성화하고 새 콘텐츠 삽입
      $("#workspace-content")
        .empty()
        .html(cache[file])
        .find(".workspace-tab-content")
        .addClass("active");
    } else {
      // AJAX 요청으로 데이터 가져오기
      console.log(`서버에서 로드: ${file}`);
      $("#workspace-content").load(file, function (response, status, xhr) {
        if (status === "success") {
          // 성공적으로 로드하면 캐시에 저장
          cache[file] = response;
          // 기존 콘텐츠를 비활성화하고 새 콘텐츠 삽입
          $("#workspace-content")
            .empty()
            .html(response)
            .find(".workspace-tab-content")
            .addClass("active");
        } else if (status === "error") {
          console.error(
            "콘텐츠를 로드하는 중 오류 발생:",
            xhr.status,
            xhr.statusText
          );
          $("#workspace-content").html(
            "<p>콘텐츠를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.</p>"
          );
        }
      });
    }
  }
});

//hmtl에 id="clear-cache-btn" 버튼 추가해 캐시 초기화 테스트에 사용
$("#clear-cache-btn").click(function () {
  cache = {}; // 캐시 초기화
  console.log("캐시가 초기화되었습니다.");
});
