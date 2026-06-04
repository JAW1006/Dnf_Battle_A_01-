<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <title>Attack Monster UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 400px; border-radius: 5px; }
        .result { margin-top: 20px; padding: 15px; background-color: #fff0f5; border-radius: 5px; border: 1px solid #ffb6c1; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>

<div class="box">
    <h2>몬스터 공격 시스템</h2>
    <%
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 나의캐릭터 = (전투시스템 != null) ? 전투시스템.get현재캐릭터() : null;

        if (나의캐릭터 == null) {
    %>
            <p class="error">생성된 캐릭터가 없습니다! 캐릭터를 먼저 생성해주세요.</p>
            <a href="Create_Character_UI.jsp"><button>캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <p><strong>현재 보유 캐릭터:</strong> <%= 나의캐릭터.get캐릭터명() %> (레벨 <%= 나의캐릭터.get레벨() %>)</p>
            <form method="POST">
                <p>인증 플레이어 ID: <input type="text" name="playerId" value="hero" required></p>
                <button type="submit" name="action" value="attack">⚔️ 몬스터 공격 요청</button>
            </form>
    <%
        }
    %>
</div>

<%
    if ("POST".equalsIgnoreCase(request.getMethod()) && "attack".equals(request.getParameter("action")) && 전투시스템 != null) {
        String playerId = request.getParameter("playerId");
        
        boolean 성공여부 = false;
        String 결과메시지 = "";
        
        try {
            // 다이어그램 스펙 완전 일치: 오직 playerId만 넘기며 void 처리
            전투시스템.몬스터공격(playerId);
            성공여부 = true;
        } catch (IllegalArgumentException e) {
            // [핵심]: 전투.java에서 던진 실패 메시지를 여기서 캐치하여 화면에 띄웁니다.
            성공여부 = false;
            결과메시지 = e.getMessage();
        }
%>
        <div class="result">
            <% if (성공여부) { %>
                <h3>💥 공격 완료</h3>
                <p><strong>발동 스킬:</strong> [<%= 나의캐릭터.get스킬명() %>]</p>
                <p style="color:blue; font-weight:bold;">몬스터 공격 연산 및 등급 판정이 완료되었습니다!</p>
                <br>
                <a href="Add_Item_UI.jsp"><button>🎁 몬스터 처치! 아이템 획득하러 가기</button></a>
            <% } else { %>
                <h3>❌ 공격 실패</h3>
                <p style="color:red; font-weight:bold;"><%= 결과메시지 %></p>
            <% } %>
        </div>
<%
    }
%>

</body>
</html>