<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
//플레이리스트 생성 페이지
<!DOCTYPE html>
<html>
<head>
    <title>새 플레이리스트 추가</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; }
        .form-group input[type="text"], .form-group input[type="url"] {
            width: 100%; padding: 8px; box-sizing: border-box;
        }
        .form-group button {
            padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;
        }
        .form-group button:hover { background-color: #45a049; }
        .error { color: red; margin-bottom: 15px; }
    </style>
</head>
<body>
    <h1>새 플레이리스트 추가</h1>

    <!-- 오류 메시지 출력 -->
    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>

    <!-- 플레이리스트 생성 폼 -->
    <form action="createPlaylist" method="post">
        <div class="form-group">
            <label for="title">플레이리스트 제목</label>
            <input type="text" id="title" name="title" required placeholder="제목을 입력하세요">
        </div>
        <div class="form-group">
            <label for="thumbnail">썸네일 URL (선택)</label>
            <input type="url" id="thumbnail" name="thumbnail" placeholder="썸네일 URL을 입력하세요">
        </div>
        <div class="form-group">
            <label for="trackCount">트랙 수</label>
            <input type="number" id="trackCount" name="trackCount" required min="1" value="1">
        </div>
        <div class="form-group">
            <button type="submit">생성</button>
        </div>
    </form>
</body>
</html>
