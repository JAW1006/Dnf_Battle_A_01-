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
        // 세션에서 기존에 생성된 전투 시스템 인스턴스 획득
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
        
        // 다이어그램 스펙 완전 일치: 오직 playerId만 넘기며 void 처리
        전투시스템.몬스터공격(playerId);
        
        // 실행 후 내부 상태 값을 통해 성공/실패 여부를 판단할 수 있습니다.
        // (만약 상세 데미지 화면 수치를 명확히 찍어주고 싶다면 기존의 전투.java 판정 로직 결과를 
        //  UI 가독성을 위해 필드나 보조 함수로 읽어오도록 구성하면 됩니다.)
%>
        <div class="result">
            <h3>💥 공격 완료</h3>
            <p><strong>발동 스킬:</strong> [<%= 나의캐릭터.get스킬명() %>]</p>
            <p>컨트롤러 내부에서 몬스터 공격 연산 및 등급 판정이 완료되었습니다.</p>
        </div>
<%
    }
%>

</body>
</html>