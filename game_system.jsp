<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="game.BattleController, game.Character" %>
<%
    request.setCharacterEncoding("UTF-8");
    BattleController battleCtrl = new BattleController();
    
    // 세션을 통해 생성된 캐릭터 정보를 유지 (가상의 메모리 데이터베이스 역할)
    Character myChar = (Character) session.getAttribute("userCharacter");
    String errorMessage = null;
    String attackResult = null;

    // 액션 서브밋 처리
    String action = request.getParameter("action");
    
    if ("create".equals(action)) {
        try {
            String playerId = request.getParameter("playerId");
            String characterName = request.getParameter("characterName");
            String job = request.getParameter("job");
            int level = Integer.parseInt(request.getParameter("level"));

            // 순차도대로 캐릭터 생성 제어 호출
            myChar = battleCtrl.createCharacter(playerId, characterName, job, level);
            session.setAttribute("userCharacter", myChar);
            session.setAttribute("currentPlayerId", playerId); // 공격시 검증용 저장
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    } else if ("attack".equals(action)) {
        try {
            String attackPlayerId = request.getParameter("attackPlayerId");
            String savedPlayerId = (String) session.getAttribute("currentPlayerId");
            
            // 몬스터 공격 순차도 상의 플레이어 체크 검증
            if (myChar == null || !attackPlayerId.equals(savedPlayerId)) {
                throw new Exception("플레이어 체크 실패! 올바른 플레이어 ID를 입력하거나 캐릭터를 먼저 생성하세요.");
            }

            // 다형성을 이용한 스킬발동 및 데미지 계산 수신
            float damage = myChar.useSkill();
            // 등급 판정
            String grade = battleCtrl.evaluateAttackGrade(damage);

            attackResult = "발동 스킬: <strong>" + myChar.getSkillName() + "</strong><br>" +
                           "최종 데미지: <strong>" + damage + "</strong><br>" +
                           "공격 등급: <span style='color:red; font-weight:bold;'>" + grade + "</span>";
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
    } else if ("reset".equals(action)) {
        session.invalidate();
        response.sendRedirect("game_system.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게임 시스템 통합 테스트 UI</title>
    <style>
        body { font-family: sans-serif; margin: 30px; background-color: #f9f9f9; }
        .container { display: flex; gap: 30px; }
        .box { flex: 1; border: 2px solid #ccc; padding: 20px; border-radius: 8px; background: white; }
        .box-title { font-size: 1.2em; font-weight: bold; margin-bottom: 15px; color: #333; border-bottom: 2px solid #666; padding-bottom: 5px; }
        .form-group { margin-bottom: 12px; }
        label { display: inline-block; width: 110px; font-weight: bold; }
        input[type="text"], input[type="number"], select { padding: 5px; width: 150px; }
        button { padding: 6px 12px; background-color: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button.btn-attack { background-color: #f44336; }
        .status, .result { background-color: #eef; padding: 10px; border-radius: 5px; margin-top: 15px; border-left: 5px solid #00a; }
        .error { color: red; font-weight: bold; margin-bottom: 15px; padding: 10px; background: #fee; border: 1px solid #fcc; border-radius: 5px; }
    </style>
</head>
<body>

    <h2>🎮 게임 시스템 (순차도 구현 가동 환경)</h2>
    
    <% if (errorMessage != null) { %>
        <div class="error">⚠️ 오류 발생: <%= errorMessage %></div>
    <% } %>

    <div class="container">
        
        <div class="box">
            <div class="box-title">Create_Character_UI (캐릭터 생성)</div>
            <form action="game_system.jsp" method="post">
                <input type="hidden" name="action" value="create">
                <div class="form-group">
                    <label>플레이어 ID:</label>
                    <input type="text" name="playerId" value="hero" required> (인증 ID: hero)
                </div>
                <div class="form-group">
                    <label>캐릭터명:</label>
                    <input type="text" name="characterName" required>
                </div>
                <div class="form-group">
                    <label>직업 선택:</label>
                    <select name="job">
                        <option value="전사">전사</option>
                        <option value="마법사">마법사</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>레벨(int):</label>
                    <input type="number" name="level" min="1" value="1" required>
                </div>
                <button type="submit">캐릭터 생성 요청</button>
            </form>

            <% if (myChar != null) { %>
                <div class="status">
                    <strong>현재 생성된 캐릭터 정보:</strong><br>
                    • 캐릭터명: <%= myChar.getCharacterName() %><br>
                    • 직업: <%= myChar instanceof game.Warrior ? "전사" : "마법사" %><br>
                    • 레벨: <%= myChar.getLevel() %><br>
                    • HP: <%= myChar.getHp() %><br>
                    • 기본 공격력: <%= myChar.getAttackPower() %>
                </div>
            <% } %>
        </div>

        <div class="box">
            <div class="box-title">Attack_Monster_UI (몬스터 공격)</div>
            <form action="game_system.jsp" method="post">
                <input type="hidden" name="action" value="attack">
                <div class="form-group">
                    <label>플레이어 ID 체크:</label>
                    <input type="text" name="attackPlayerId" placeholder="인증 ID 입력" required>
                </div>
                <button type="submit" class="btn-attack">몬스터 공격 요청</button>
            </form>

            <% if (attackResult != null) { %>
                <div class="result">
                    <strong>⚔️ 공격 결과 출력:</strong><br>
                    <%= attackResult %>
                </div>
            <% } %>
        </div>

    </div>

    <div style="margin-top: 20px;">
        <form action="game_system.jsp" method="post">
            <input type="hidden" name="action" value="reset">
            <button type="submit" style="background-color: #555;">데이터 초기화</button>
        </form>
    </div>

</body>
</html>