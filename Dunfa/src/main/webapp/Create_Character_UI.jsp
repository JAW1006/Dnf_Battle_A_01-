<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 클래스 로드를 위해 위에서 지정한 패키지명(df)을 사용합니다 --%>
<jsp:useBean id="전투시스템" class="game.전투" scope="session" />
<%
    request.setCharacterEncoding("UTF-8");
    String 플레이어id = request.getParameter("playerId");
    String 캐릭터명 = request.getParameter("charName");
    String 직업 = request.getParameter("job");
    String levelStr = request.getParameter("level");

    if (플레이어id != null && 캐릭터명 != null && 직업 != null) {
        int 레벨 = 1;
        if (levelStr != null && !levelStr.trim().isEmpty()) {
            레벨 = Integer.parseInt(levelStr.trim());
        }

        // 공백 제거 후 메소드 실행
        전투시스템.캐릭터생성(플레이어id.trim(), 캐릭터명, 직업, 레벨);

        if (전투시스템.캐릭터생성성공) {
            response.sendRedirect("Attack_Monster_UI.jsp?playerId=" + 플레이어id.trim());
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>캐릭터 생성</title>
</head>
<body>
    <h2>캐릭터 생성 폼</h2>
    <% if (플레이어id != null && !전투시스템.캐릭터생성성공) { %>
        <p style="color:red;"><%= 전투시스템.메시지 %></p>
    <% } %>

    <form action="Create_Character_UI.jsp" method="post">
        플레이어 ID: <input type="text" name="playerId" required placeholder="hero 입력"><br><br>
        캐릭터명: <input type="text" name="charName" required><br><br>
        직업: 
        <select name="job">
            <option value="전사">전사</option>
            <option value="마법사">마법사</option>
        </select><br><br>
        레벨: <input type="number" name="level" min="1" value="1" required><br><br>
        
        <input type="submit" value="캐릭터 생성">
    </form>
</body>
</html>