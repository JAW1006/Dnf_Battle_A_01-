<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create_Character_UI</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; margin: 30px; }
        .card { background: white; padding: 20px; border-radius: 8px; border: 1px solid #dcdfe6; max-width: 500px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        h2 { color: #409EFF; border-bottom: 2px solid #409EFF; padding-bottom: 8px; margin-top: 0; }
        .row { margin-bottom: 12px; }
        label { display: inline-block; width: 110px; font-weight: bold; }
        input, select { padding: 6px; width: 200px; }
        button { padding: 8px 16px; background-color: #409EFF; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .info-box { background-color: #f0f9eb; border-left: 5px solid #67c23a; padding: 12px; margin-top: 15px; border-radius: 4px; }
        .err-box { background-color: #fef0f0; border-left: 5px solid #f56c6c; padding: 12px; margin-top: 15px; color: #f56c6c; font-weight: bold; border-radius: 4px; }
        .menu { margin-top: 20px; border-top: 1px solid #eee; padding-top: 10px; }
        .menu a { color: #409EFF; text-decoration: none; font-weight: bold; margin-right: 15px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>&lt;&lt;boundary&gt;&gt; Create_Character_UI</h2>
        <form action="battle" method="post">
            <input type="hidden" name="action" value="캐릭터생성">
            <div class="row">
                <label>플레이어 ID:</label>
                <input type="text" name="플레이어id" value="hero" required>
            </div>
            <div class="row">
                <label>캐릭터명:</label>
                <input type="text" name="캐릭터명" required>
            </div>
            <div class="row">
                <label>직업 선택:</label>
                <select name="직업">
                    <option value="전사">전사</option>
                    <option value="마법사">마법사</option>
                </select>
            </div>
            <div class="row">
                <label>레벨:</label>
                <input type="number" name="레벨" min="1" value="1" required>
            </div>
            <button type="submit">캐릭터 생성 요청</button>
        </form>

        <%
            String errorMsg = (String) session.getAttribute("errorMsg");
            캐릭터 캐릭터객체 = (캐릭터) session.getAttribute("생성된캐릭터");
            if (errorMsg != null) {
        %>
            <div class="err-box">⚠️ <%= errorMsg %></div>
        <% } else if (캐릭터객체 != null) { %>
            <div class="info-box">
                <strong>✨ 캐릭터 생성 성공 (능력치 일관 규칙 확인):</strong><br>
                • 이름: <%= 캐릭터객체.get캐릭터명() %> (<%= 캐릭터객체.getClass().getSimpleName() %>)<br>
                • 레벨: <%= 캐릭터객체.get레벨() %><br>
                • 연산 HP: <%= 캐릭터객체.getHP() %><br>
                • 연산 공격력: <%= 캐릭터객체.get공격력() %>
            </div>
        <% } %>
        
        <div class="menu">
            <a href="Attack_Monster_UI.jsp">몬스터공격 UI ▶</a>
            <a href="Add_Item_UI.jsp">아이템획득 UI ▶</a>
            <a href="Join_Guild_UI.jsp">길드가입 UI ▶</a>
        </div>
    </div>
</body>
</html>