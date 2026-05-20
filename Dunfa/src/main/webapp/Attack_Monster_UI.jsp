<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="전투시스템" class="game.전투" scope="session" />
<%
    request.setCharacterEncoding("UTF-8");
    String 플레이어id = request.getParameter("playerId");
    String 행동 = request.getParameter("action");

    if ("attack".equals(행동) && 플레이어id != null) {
        전투시스템.몬스터공격(플레이어id.trim());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>몬스터 공격</title>
</head>
<body>
    <h2>전투 필드</h2>
    
    <% if (전투시스템.현재캐릭터 != null) { %>
        <p>
            현재 캐릭터: <strong><%= 전투시스템.현재캐릭터.캐릭터명 %></strong> (레벨 <%= 전투시스템.현재캐릭터.레벨 %>)<br>
            [ HP: <%= 전투시스템.현재캐릭터.HP %> / 공격력: <%= 전투시스템.현재캐릭터.공격력 %> ]
        </p>

        <form action="Attack_Monster_UI.jsp" method="post">
            <input type="hidden" name="playerId" value="<%= 플레이어id %>">
            <input type="hidden" name="action" value="attack">
            <input type="submit" value="몬스터 공격하기!" style="color: red;">
        </form>

        <% if ("attack".equals(행동)) { %>
            <hr>
            <% if (전투시스템.공격성공여부) { %>
                <h3>전투 결과</h3>
                <ul>
                    <li>발동 스킬: <strong><%= 전투시스템.결과_스킬명 %></strong></li>
                    <li>가한 데미지: <strong><%= 전투시스템.결과_데미지 %></strong></li>
                    <li>최종 등급: <strong><%= 전투시스템.결과_등급 %></strong></li>
                </ul>
            <% } else { %>
                <p style="color:red;"><%= 전투시스템.메시지 %></p>
            <% } %>
        <% } %>

    <% } else { %>
        <p style="color:red;">생성된 캐릭터 데이터가 없습니다.</p>
        <a href="Create_Character_UI.jsp">캐릭터 생성으로 돌아가기</a>
    <% } %>
</body>
</html>