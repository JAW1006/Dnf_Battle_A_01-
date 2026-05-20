package game;

public class Player {
	// 플레이어체크 기능 구현 (순차도 3, 4번 반영)
    public boolean checkPlayer(String playerId) {
        // 요구사항: 플레이어 id는 "hero"여야 함
        return "hero".equals(playerId);
    }
}
