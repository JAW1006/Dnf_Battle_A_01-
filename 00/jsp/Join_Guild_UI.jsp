<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.길드" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Join_Guild_UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; margin: 30px; }
        .card { background: white; padding: 20px; border-radius: 8px; border: 1px solid #dcdfe6; max-width: 500px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        h2 { color: #e6a23c; border-bottom: 2px solid #e6a23c; padding-bottom: 8px; margin-top: 0; }
        .row { margin-bottom: 12px; }
        label { display: inline-block; width: 110px; font-weight: bold; }
        input { padding: 6px; width: 200px; }
        button { padding: 8px 16px; background-color: #e6a23c; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .info-box { background-color: #fdf6ec; border-left: 5px solid #e6a23c; padding: 12px; margin-top: 15px; border-radius: 4px; }
        .err-box { background-color: #fef0f0; border-left: 5px solid #f56c6c; padding: 12px; margin-top: 15px; color: #f56c6c; font-weight: bold; border-radius: 4px; }
        .menu { margin-top: 20px; border-top: 1px solid #eee; padding-top: 10px; }
        .menu a { color: #e6a23c; text-decoration: none; font-weight: bold; margin-right: 15px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>&lt;&lt;boundary&gt;&gt; Join_Guild_UI</h2>
        <form action="battle" method="post">
            <input type="hidden" name="action" value="길드가입">
            <div class="row">
                <label>플레이어 ID:</label>
                <input type="text" name="플레이어id" required>
            </div>
            <div class="row">
                <label>길드명 입력:</label>
                <input type="text" name="길드명" placeholder="아발론 또는 하이퍼 입력" required>
            </div>
            <button type="submit">길드 가입 요청</button>
        </form>

        <%
            String errorMsg = (String) session.getAttribute("errorMsg");
            길드 가입길드 = (길드) session.getAttribute("가입완료길드");
            if (errorMsg != null) {
        %>
            <div class="err-box">⚠️ <%= errorMsg %></div>
        <% } else if (가입길드 != null) { %>
            <div class="info-box">
                <strong>🏰 길드 Aggregation 연결 성공:</strong><br>
                • 소속 길드명: <strong><%= 가입길드.get길드명() %></strong><br>
                • 길드 총원 상태: <strong><%= 가입길드.get현재인원() %> / <%= 가입길드.get최대인원() %> 명</strong>
            </div>
        <% } %>

        <div class="menu">
            <a href="Create_Character_UI.jsp">◀ 캐릭터생성 UI</a>
            <a href="Attack_Monster_UI.jsp">몬스터공격 UI ▶</a>
            <a href="Add_Item_UI.jsp">아이템획득 UI ▶</a>
        </div>
    </div>
</body>
</html>