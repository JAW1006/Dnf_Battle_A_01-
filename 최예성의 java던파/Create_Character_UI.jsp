<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="던파.전투, 던파.캐릭터" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Character UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; }
        .box { border: 1px solid #ccc; padding: 20px; max-width: 400px; border-radius: 5px; }
        .result { margin-top: 20px; padding: 15px; background-color: #f0f8ff; border-radius: 5px; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>

<div class="box">
    <h2>캐릭터 생성 시스템</h2>
    <form method="POST">
        <p>플레이어 ID: <input type="text" name="playerId" value="hero" required> <small>(체크용: hero)</small></p>
        <p>캐릭터명: <input type="text" name="charName" required></p>
        <p>직업: 
            <select name="job">
                <option value="전사">전사</option>
                <option value="마법사">마법사</option>
            </select>
        </p>
        <p>레벨: <input type="number" name="level" value="1" min="1" required></p>
        <button type="submit" name="action" value="create">캐릭터 생성</button>
    </form>
</div>

<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod()) && "create".equals(request.getParameter("action"))) {
        String playerId = request.getParameter("playerId");
        String charName = request.getParameter("charName");
        String job = request.getParameter("job");
        int level = Integer.parseInt(request.getParameter("level"));

        // 오타 수정: '전환'을 '전투' 클래스로 올바르게 생성
        전투 전투시스템 = new 전투();
        
        // 다이어그램 void 스펙을 준수하며 비즈니스 로직 요청
        전투시스템.캐릭터생성(playerId, charName, job, level, request);
        
        // request 컨텍스트에 공유된 결과 객체 획득
        캐릭터 생성된캐릭터 = (캐릭터) request.getAttribute("생성된캐릭터");
        
        if (생성된캐릭터 != null) {
            // 다른 페이지(공격 UI)에서 공유할 수 있도록 session에 바인딩
            session.setAttribute("myCharacter", 생성된캐릭터);
%>
            <div class="result">
                <h3>[안내] 캐릭터 생성 완료!</h3>
                <p><strong>캐릭터명:</strong> <%= 생성된캐릭터.get캐릭터명() %> (<%= job %>)</p>
                <p><strong>레벨:</strong> <%= 생성된캐릭터.get레벨() %></p>
                <p><strong>초기 HP:</strong> <%= 생성된캐릭터.getHp() %></p>
                <p><strong>초기 공격력:</strong> <%= 생성된캐릭터.get공격력() %></p>
                <hr>
                <a href="Attack_Monster_UI.jsp"><button>몬스터 공격 화면으로 이동</button></a>
            </div>
<%
        } else {
%>
            <p class="error">❌ 캐릭터 생성 실패: 플레이어 ID를 확인하세요. (허용 ID: hero)</p>
<%
        }
    }
%>

</body>
</html>