package game;

public class BattleController {
	private Player playerService = new Player();

    // 1. 캐릭터 생성 로직 (Create_Character_UI 요청 처리)
    public Character createCharacter(String playerId, String characterName, String job, int level) throws Exception {
        // 플레이어 체크 검증
        if (!playerService.checkPlayer(playerId)) {
            throw new Exception("존재하지 않거나 권한이 없는 플레이어 ID입니다. (ID: hero 만 가능)");
        }

        // 직업에 따른 동적 생성 (alt 분기)
        if ("전사".equals(job)) {
            return new Warrior(characterName, level);
        } else if ("마법사".equals(job)) {
            return new Mage(characterName, level);
        } else {
            throw new Exception("올바르지 않은 직업 선택입니다.");
        }
    }

    // 2. 공격 등급 판정 로직 (Monster_Attack_UI 연산 처리)
    public String evaluateAttackGrade(float damage) {
        if (damage >= 200) {
            return "S급 공격";
        } else if (damage >= 100) {
            return "A급 공격";
        } else {
            return "B급 공격";
        }
    }
}
