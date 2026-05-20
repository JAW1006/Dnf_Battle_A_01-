package 던파;

public class 전투 {
    private 플레이어 플레이어매니저 = new 플레이어();
    
    // 순차도 2번: 캐릭터 생성 비즈니스 로직
    public 캐릭터 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        // 1. 플레이어 체크 필수 (포함 관계)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            return null; 
        }
        
        // 2. 직업에 따른 동적 생성 (다형성)
        if ("전사".equals(직업)) {
            return new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            return new 마법사(캐릭터명, 레벨);
        }
        return null;
    }

    // 순차도 1번: 플레이어 체크 대리 호출
    public boolean 플레이어체크(String 플레이어id) {
        return 플레이어매니저.플레이어체크(플레이어id);
    }

    // 순차도 1번: 데미지에 따른 등급 부여 로직
    public String 공격등급판정(float 데미지) {
        if (데미지 >= 200) {
            return "S급 공격";
        } else if (데미지 >= 100) {
            return "A급 공격";
        } else {
            return "B급 공격";
        }
    }
}