<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터, 던파.아이템" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Item UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 450px; border-radius: 5px; margin-bottom: 15px;}
        .result { padding: 15px; background-color: #f0fff0; border: 1px solid #98fb98; border-radius: 5px; max-width: 450px;}
        .inv-box { background-color: #fafafa; border: 1px dashed #aaa; padding: 10px; margin-top: 10px;}
        .button-group { margin-top: 15px; display: flex; gap: 10px; } /* 버튼들을 나란히 배치하기 위한 스타일 */
    </style>
</head>
<body>

<div class="box">
    <h2>🎁 신규 아이템 획득 시스템</h2>
    <%
        전투 전투시스템 = (전투) session.getAttribute("battleSystem");
        캐릭터 나의캐릭터 = (전투시스템 != null) ? 전투시스템.get현재캐릭터() : null;

        if (나의캐릭터 == null) {
    %>
            <p style="color:red;">생성된 캐릭터가 없습니다! 캐릭터 생성을 먼저 진행해 주세요.</p>
            <a href="Create_Character_UI.jsp"><button>캐릭터 생성하러 가기</button></a>
    <%
        } else {
    %>
            <p><strong>현재 캐릭터:</strong> <%= 나의캐릭터.get캐릭터명() %></p>
            <form method="POST">
                <p>플레이어 ID: <input type="text" name="playerId" value="hero" required></p>
                <p>아이템명: <input type="text" name="itemName" placeholder="예: 엑스칼리버" required></p>
                <p>타입: 
                    <select name="itemType">
                        <option value="무기">무기</option>
                        <option value="방어구">방어구</option>
                        <option value="물약">물약</option>
                    </select>
                </p>
                <p>가치 수치: <input type="number" name="itemValue" value="600" min="1" required></p>
                <button type="submit" name="action" value="addItem">💎 아이템 획득 요청</button>
            </form>
    <%
        }
    %>
</div>

<%
    // 폼에서 넘어오는 한글(아이템명 등)이 깨지지 않도록 UTF-8 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod()) && "addItem".equals(request.getParameter("action")) && 전투시스템 != null) {
        String playerId = request.getParameter("playerId");
        String itemName = request.getParameter("itemName");
        String itemType = request.getParameter("itemType");
        int itemValue = Integer.parseInt(request.getParameter("itemValue"));

        // 1. 아이템 획득 전 인벤토리 수량 확인
        int 획득전수량 = 나의캐릭터.get인벤토리().get아이템리스트().size();

        // 2. 다이어그램 스펙 완벽 일치
        전투시스템.아이템획득(playerId, itemName, itemType, itemValue);
        
        // 3. UI 단에서 획득 후 수량 비교로 성공/실패 자체 판단
        int 획득후수량 = 나의캐릭터.get인벤토리().get아이템리스트().size();
        boolean 성공여부 = (획득후수량 > 획득전수량);
        
        String 결과메시지 = 성공여부 ? "아이템 획득 성공!" : "획득 실패! (ID 불일치 또는 인벤토리 가득 참)";
%>
        <div class="result">
            <h3>처리 결과 안내</h3>
            <p style="font-weight:bold; color: <%= 성공여부 ? "green" : "red" %>;"><%= 결과메시지 %></p>
            
            <div class="inv-box">
                <h4>현재 내 가방 상태 (<%= 획득후수량 %> / <%= 나의캐릭터.get인벤토리().get최대용량() %> 칸)</h4>
                <ul>
                <%
                    for(아이템 item : 나의캐릭터.get인벤토리().get아이템리스트()) {
                %>
                    <li>[<%= item.get타입() %>] <%= item.get아이템명() %> - 등급: <strong><%= item.get등급() %></strong> (가치:<%= item.get가치() %>)</li>
                <%
                    }
                %>
                </ul>
            </div>
            
            <div class="button-group">
                <a href="Attack_Monster_UI.jsp"><button>⚔️ 다시 몬스터 사냥하기</button></a>
                <a href="Join_Guild_UI.jsp"><button>🛡️ 길드 가입 화면으로 가기</button></a>
            </div>
        </div>
<%
    }
%>

</body>
</html>