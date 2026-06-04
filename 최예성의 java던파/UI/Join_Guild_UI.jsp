<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터, 던파.길드" %>
<!DOCTYPE html>
<html>
<head>
    <title>Join Guild UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 450px; border-radius: 5px; margin-bottom: 15px;}
        .result { padding: 15px; background-color: #e6f2ff; border: 1px solid #b6d4fe; border-radius: 5px; max-width: 450px;}
        .guild-info { background-color: #f8f9fa; border: 1px solid #dee2e6; padding: 10px; margin-top: 10px;}
    </style>
</head>
<body>

<div class="box">
    <h2>🛡️ 길드 가입 신청 시스템</h2>
    <%
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 나의캐릭터 = (전투시스템 != null) ? 전투시스템.get현재캐릭터() : null;

        // [최초 1회 선언]: 상단에서 변수를 선언하고 값을 채웁니다.
        길드 전설의길드 = (길드) application.getAttribute("globalGuild");
        if (전설의길드 == null) {
            전설의길드 = new 길드("아라드 수호대");
            application.setAttribute("globalGuild", 전설의길드); // 서버 공유 객체 등록
        }

        if (나의캐릭터 == null) {
    %>
            <p style="color:red;">생성된 캐릭터가 없습니다! 캐릭터 생성을 완료해 주세요.</p>
    <%
        } else {
    %>
            <p><strong>가입 신청 캐릭터명:</strong> <%= 나의캐릭터.get캐릭터명() %></p>
            <p><strong>가입 대상 길드명:</strong> <span style="color:blue; font-weight:bold;"><%= 전설의길드.get길드명() %></span></p>
            
            <form method="POST">
                <p>플레이어 ID: <input type="text" name="playerId" value="hero" required></p>
                <button type="submit" name="action" value="joinGuild">🛡️ 길드 가입 신청하기</button>
            </form>
    <%
        }
    %>
</div>

<%
    if ("POST".equalsIgnoreCase(request.getMethod()) && "joinGuild".equals(request.getParameter("action")) && 전투시스템 != null) {
        String playerId = request.getParameter("playerId");
        
        // ❌ 문제의 중복 선언 줄 삭제 완료!
        // 상단에서 이미 선언된 '전설의길드' 변수를 그대로 사용합니다.

        // 1. 길드 가입 전 현재 인원수 저장
        int 가입전인원 = 전설의길드.get현재인원();
        
        // 2. 다이어그램 스펙 완벽 일치
        전투시스템.길드가입(playerId, 전설의길드);
        
        // 3. UI 단에서 가입 후 인원수 증가 여부로 성공/실패 자체 판단
        boolean 성공여부 = (전설의길드.get현재인원() > 가입전인원);
        String 결과메시지 = 성공여부 ? "[" + 전설의길드.get길드명() + "] 길드에 성공적으로 가입되었습니다!" : "가입 실패! (ID 불일치 또는 정원 초과)";
%>
        <div class="result">
            <h3>길드 처리 결과</h3>
            <p style="font-weight:bold; color: <%= 성공여부 ? "blue" : "red" %>;"><%= 결과메시지 %></p>
            
            <div class="guild-info">
                <h4>[<%= 전설의길드.get길드명() %>] 길드원 현황 (<%= 전설의길드.get현재인원() %> / <%= 전설의길드.get최대인원() %> 명)</h4>
                <ul>
                <%
                    for(캐릭터 member : 전설의길드.get캐릭터리스트()) {
                %>
                    <li><%= member.get캐릭터명() %> (Lv.<%= member.get레벨() %>)</li>
                <%
                    }
                %>
                </ul>
            </div>
            <br>
            <a href="Add_Item_UI.jsp"><button>🎁 다시 아이템 주우러 가기</button></a>
        </div>
<%
    }
%>

</body>
</html>