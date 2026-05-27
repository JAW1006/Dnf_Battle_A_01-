package 던파;

public class 플레이어 {
    // 플레이어 id 체크 메서드 (요구사항: "hero"일 때만 true)
	public boolean 플레이어체크(String 플레이어id) {
	    return "hero".equalsIgnoreCase(플레이어id); // 대소문자 무시 (Hero, HERO 다 가능)
	}
}