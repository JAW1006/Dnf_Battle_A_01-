<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.아이템, game.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add_Item_UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; margin: 30px; }
        .card { background: white; padding: 20px; border-radius: 8px; border: 1px solid #dcdfe6; max-width: 500px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        h2 { color: #67c23a; border-bottom: 2px solid #67c23a; padding-bottom: 8px; margin-top: 0; }
        .row { margin-bottom: 12px; }
        label { display: inline-block; width: 110px; font-weight: bold; }
        input, select { padding: 6px; width: 200px; }
        button { padding: 8px 16px; background-color: #67c23a; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .info-box { background-color: #f0f9eb; border-left: 5px solid #67c23a; padding: 12px; margin-top: 15px; border-radius: 4px; }
        .err-box { background-color: #fef0f0; border-left: 5px solid #f56c6c; padding: 12px; margin-top: 15px; color: #f56c6c; font-weight: bold; border-radius: 4px; }
        .menu { margin-top: 20px; border-top: 1px solid #eee; padding-top: 10px; }
        .menu a { color: #67c23a; text-decoration: none; font-weight: bold; margin-right: 15px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>&lt;&lt;boundary&gt;&gt; Add_Item_UI</h2>
        <form action="battle" method="post">
            <input type="hidden" name="action" value="아이템획득">
            <div class="row">
                <label>플레이어 ID:</label>
                <input type="text" name="플레이어id" required>
            </div>
            <div class="row">
                <label>아이템명:</label>
                <input type="text" name="아이템명" required>
            </div>
            <div class="row">
                <label>아이템타입:</label>
                <select name="아이템타입">
                    <option value="무기">무기</option>
                    <option value="방어구">방어구</option>
                    <option value="물약">물약</option>
                </select>
            </div>
            <div class="row">
                <label>아이템가치:</label>
                <input type="number" name="아이템가치" min="1" value="650" required>
            </div>
            <button type="submit">아이템 획득 요청</button>
        </form>

        <%
            String errorMsg = (String) session.getAttribute("errorMsg");
            아이템 최근템 = (아이템) session.getAttribute("최근획득아이템");
            캐릭터 캐릭터객체 = (캐릭터) session.getAttribute("생성된캐릭터");
            if (errorMsg != null) {
        %>
            <div class="err-box">⚠️ <%= errorMsg %></div>
        <% } else if (최근템 != null) { %>
            <div class="info-box">
                <strong>🎁 아이템 Composition 적재 완료:</strong><br>
                • 획득품: <%= 최근템.get아이템명() %> (<%= 최근템.get타입() %>)<br>
                • 부여 등급: <span style="color:#67c23a; font-weight:bold;"><%= 최근템.get등급() %></span><br>
                • 현재 인벤토리 정원: <strong><%= 캐릭터객체.get인벤토리멤버().get현재수량() %> / <%= 캐릭터객체.get인벤토리멤버().get최대용량() %> 개</strong>
            </div>
        <% } %>

        <div class="menu">
            <a href="Create_Character_UI.jsp">◀ 캐릭터생성 UI</a>
            <a href="Attack_Monster_UI.jsp">몬스터공격 UI ▶</a>
            <a href="Join_Guild_UI.jsp">길드가입 UI ▶</a>
        </div>
    </div>
</body>
</html>