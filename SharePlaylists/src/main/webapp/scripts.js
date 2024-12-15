$(document).ready(function () {
    // 초기설정 - 활성화된 탭 콘텐츠 로드
    const defaultFile = $(".tab-header.active").data("file");
    loadContent(defaultFile);

    // 탭 클릭 시 콘텐츠 로드
    $(".tab-header").click(function (e) {
        e.preventDefault();

        // 탭 활성화 상태 변경
        $(".tab-header").removeClass("active");
        $(this).addClass("active");

        // 해당 파일을 로드
        const fileName = $(this).data("file");
        loadContent(fileName);
    });

    // 콘텐츠를 동적으로 로드하는 함수
    function loadContent(file) {
        console.log(`서버에서 로드: ${file}`);
        // AJAX 요청으로 데이터 가져오기
        $("#main-content").load(file, function (response, status, xhr) {
            if (status === "success") {
                // 성공적으로 로드한 경우 콘텐츠 삽입
                $("#main-content").empty().html(response).find(".tab-content").addClass("active");
            } else if (status === "error") {
                console.error("콘텐츠를 로드하는 중 오류 발생:", xhr.status, xhr.statusText);
                $("#main-content").html("<p>콘텐츠를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.</p>");
            }
        });
    }
});
