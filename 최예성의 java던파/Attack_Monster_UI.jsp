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
        // 세션에서 앞서 생성한 캐릭터 가져오기
        캐릭터 나의캐릭터 = (캐릭터) session.getAttribute("myCharacter");
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
    if ("POST".equalsIgnoreCase(request.getMethod()) && "attack".equals(request.getParameter("action")) && 나의캐릭터 != null) {
        String playerId = request.getParameter("playerId");
        
        전투 전투시스템 = new 전투();
        
        // 1. 유효성 검사 (플레이어체크 포함 관계 수행)
        if (전투시스템.플레이어체크(playerId)) {
            // 2. 스킬 발동 및 데미지 계산 (다형성 작동)
            float 데미지 = 나의캐릭터.스킬발동();
            String 등급 = 전투시스템.공격등급판정(데미지);
%>
            <div class="result">
                <h3>💥 공격 결과 출력</h3>
                <p><strong>발동 스킬:</strong> [<%= 나의캐릭터.get스킬명() %>]</p>
                <p><strong>최종 데미지:</strong> <span style="color:blue; font-size:18px; font-weight:bold;"><%= 데미지 %></span></p>
                <p><strong>공격 판정 등급:</strong> <span style="color:purple; font-size:18px; font-weight:bold;"><%= 등급 %></span></p>
            </div>
<%
        } else {
%>
            <p class="error">❌ 플레이어 인증 실패: 올바른 플레이어 ID가 아닙니다.</p>
<%
        }
    }
%>

</body>
</html>