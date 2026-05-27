<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Item UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 400px; border-radius: 5px; }
        .result { margin-top: 20px; padding: 15px; background-color: #f0fff0; border: 1px solid #90ee90; border-radius: 5px; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>

<div class="box">
    <h2>아이템 획득 시스템</h2>
    <%
        // 기존 방식 완벽 동일: 세션에서 전투 인스턴스 획득
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 나의캐릭터 = (전투시스템 != null) ? 전투시스템.get현재캐릭터() : null;

        if (나의캐릭터 == null) {
    %>
            <p class="error">생성된 캐릭터가 없습니다! 캐릭터를 먼저 생성해주세요.</p>
            <a href="Create_Character_UI.jsp"><button>캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <p><strong>현재 캐릭터:</strong> <%= 나의캐릭터.get캐릭터명() %> (인벤토리 량: <%= 나의캐릭터.get인벤토리().get현재용량() %>/10)</p>
            <form method="POST">
                <p>인증 플레이어 ID: <input type="text" name="playerId" value="hero" required></p>
                <p>아이템명: <input type="text" name="itemName" required></p>
                <p>타입: 
                    <select name="itemType">
                        <option value="무기">무기</option>
                        <option value="방어구">방어구</option>
                        <option value="물약">물약</option>
                    </select>
                </p>
                <p>가치: <input type="number" name="itemValue" value="500" required></p>
                <button type="submit" name="action" value="addItem">🎁 아이템 획득 요청</button>
            </form>
    <%
        }
    %>
</div>

<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod()) && "addItem".equals(request.getParameter("action")) && 전투시스템 != null) {
        String playerId = request.getParameter("playerId");
        String itemName = request.getParameter("itemName");
        String itemType = request.getParameter("itemType");
        int itemValue = Integer.parseInt(request.getParameter("itemValue"));

        // 기존 스타일대로 세션에서 꺼낸 전투시스템의 메서드 직접 호출
        String 결과메시지 = 전투시스템.아이템획득(playerId, itemName, itemType, itemValue);
%>
        <div class="result">
            <h3>처리 결과</h3>
            <p><%= 결과메시지 %></p>
            <hr>
            <a href="Join_Guild_UI.jsp">길드 가입 화면으로 이동</a>
        </div>
<%
    }
%>

</body>
</html>