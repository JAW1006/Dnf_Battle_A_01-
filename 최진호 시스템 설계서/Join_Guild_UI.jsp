<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터, 던파.길드" %>
<!DOCTYPE html>
<html>
<head>
    <title>Join Guild UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 400px; border-radius: 5px; }
        .result { margin-top: 20px; padding: 15px; background-color: #fffacd; border: 1px solid #eee8aa; border-radius: 5px; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>

<div class="box">
    <h2>길드 가입 시스템</h2>
    <%
        // 기존 방식 완벽 동일: 세션에서 전투 인스턴스 획득
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 나의캐릭터 = (전투시스템 != null) ? 전투시스템.get현재캐릭터() : null;

        // 서버 공용 공간(application)에서 '이미 다른 곳에서 만들어진 길드 객체' 확보
        길드 공용길드 = (길드) application.getAttribute("globalGuild");
        if (공용길드 == null) {
            공용길드 = new 길드("초보자길드");
            application.setAttribute("globalGuild", 공용길드); // 서버 최초 실행 시 1회 등록
        }

        if (나의캐릭터 == null) {
    %>
            <p class="error">생성된 캐릭터가 없습니다! 캐릭터를 먼저 생성해주세요.</p>
            <a href="Create_Character_UI.jsp"><button>캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <p><strong>현재 캐릭터:</strong> <%= 나의캐릭터.get캐릭터명() %></p>
            <form method="POST">
                <p>인증 플레이어 ID: <input type="text" name="playerId" value="hero" required></p>
                <p>가입할 길드명: <input type="text" name="guildName" value="<%= 공용길드.get길드명() %>" readonly></p>
                <button type="submit" name="action" value="joinGuild">🛡️ 길드 가입 요청</button>
            </form>
    <%
        }
    %>
</div>

<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod()) && "joinGuild".equals(request.getParameter("action")) && 전투시스템 != null) {
        String playerId = request.getParameter("playerId");
        
        // 서버 공용 공간에 저장되어 있던 길드 객체를 컨트롤러에 인자로 던져줍니다. (Aggregation 관계 만족)
        길드 대상길드 = (길드) application.getAttribute("globalGuild");
        String 결과메시지 = 전투시스템.길드가입(playerId, 대상길드);
%>
        <div class="result">
            <h3>처리 결과</h3>
            <p><%= 결과메시지 %></p>
            <hr>
            <a href="Add_Item_UI.jsp">아이템 획득 화면으로 이동</a>
        </div>
<%
    }
%>

</body>
</html>