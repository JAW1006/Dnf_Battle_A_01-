<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attack_Monster_UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; margin: 30px; }
        .card { background: white; padding: 20px; border-radius: 8px; border: 1px solid #dcdfe6; max-width: 500px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        h2 { color: #f56c6c; border-bottom: 2px solid #f56c6c; padding-bottom: 8px; margin-top: 0; }
        .row { margin-bottom: 12px; }
        label { display: inline-block; width: 110px; font-weight: bold; }
        input { padding: 6px; width: 200px; }
        button { padding: 8px 16px; background-color: #f56c6c; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .info-box { background-color: #fdf6ec; border-left: 5px solid #e6a23c; padding: 12px; margin-top: 15px; border-radius: 4px; }
        .err-box { background-color: #fef0f0; border-left: 5px solid #f56c6c; padding: 12px; margin-top: 15px; color: #f56c6c; font-weight: bold; border-radius: 4px; }
        .menu { margin-top: 20px; border-top: 1px solid #eee; padding-top: 10px; }
        .menu a { color: #f56c6c; text-decoration: none; font-weight: bold; margin-right: 15px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>&lt;&lt;boundary&gt;&gt; Attack_Monster_UI</h2>
        <form action="battle" method="post">
            <input type="hidden" name="action" value="몬스터공격">
            <div class="row">
                <label>플레이어 ID:</label>
                <input type="text" name="플레이어id" required>
            </div>
            <button type="submit">몬스터 공격 요청</button>
        </form>

        <%
            String errorMsg = (String) session.getAttribute("errorMsg");
            String 공격등급 = (String) session.getAttribute("공격등급");
            if (errorMsg != null) {
        %>
            <div class="err-box">⚠️ <%= errorMsg %></div>
        <% } else if (공격등급 != null) { 
            float 데미지 = (Float) session.getAttribute("공격데미지");
            String 스킬명 = (String) session.getAttribute("공격스킬명");
        %>
            <div class="info-box">
                <strong>⚔️ 다형성 스킬 연산 출력:</strong><br>
                • 시전 스킬명: <%= 스킬명 %><br>
                • 산출 데미지: <%= 데미지 %><br>
                • 부여된 등급: <span style="color:#e6a23c; font-weight:bold;"><%= 공격등급 %></span>
            </div>
        <% } %>

        <div class="menu">
            <a href="Create_Character_UI.jsp">◀ 캐릭터생성 UI</a>
            <a href="Add_Item_UI.jsp">아이템획득 UI ▶</a>
            <a href="Join_Guild_UI.jsp">길드가입 UI ▶</a>
        </div>
    </div>
</body>
</html>