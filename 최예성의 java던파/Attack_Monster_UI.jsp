<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attack Monster UI</title>
</head>
<body>

<div>
    <h2>몬스터 공격 시스템</h2>
    <%
        캐릭터 나의캐릭터 = (캐릭터) session.getAttribute("myCharacter");
        if (나의캐릭터 == null) {
    %>
            <p>생성된 캐릭터가 없습니다. 캐릭터를 먼저 생성해주세요.</p>
    <%
        } else {
    %>
            <p>현재 캐릭터: <%= 나의캐릭터.get캐릭터명() %> (Lv.<%= 나의캐릭터.get레벨() %>)</p>
            <form method="POST">
                플레이어 ID: <input type="text" name="playerId" value="hero" required>
                <button type="submit">⚔️ 몬스터 공격</button>
            </form>
    <%
        }
    %>
</div>

<%
    if ("POST".equalsIgnoreCase(request.getMethod()) && 나의캐릭터 != null) {
        String playerId = request.getParameter("playerId");
        
        전투 전투시스템 = new 전투();
        // 클래스 다이어그램 인터페이스 가이드 준수하며 로직 위임
        전투시스템.몬스터공격(playerId, 나의캐릭터, request);
        
        Boolean 인증성공 = (Boolean) request.getAttribute("인증성공");
        if (인증성공 != null && 인증성공) {
            float 데미지 = (Float) request.getAttribute("최종데미지");
            String 등급 = (String) request.getAttribute("공격등급");
%>
            <div>
                <h3>공격 결과</h3>
                <p>발동 스킬: [<%= 나의캐릭터.get스킬명() %>]</p>
                <p>최종 데미지: <%= 데미지 %></p>
                <p>공격 등급: <%= 등급 %></p>
            </div>
<%
        } else {
%>
            <p style="color:red;">플레이어 인증 실패</p>
<%
        }
    }
%>

</body>
</html>