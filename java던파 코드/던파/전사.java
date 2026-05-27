package 던파;

public class 전사 extends 캐릭터 {
    
    public 전사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        // 전사 기본 능력치 설정 규칙
        this.hp = 레벨 * 100;
        this.공격력 = 레벨 * 15;
    }

    @Override
    public float 스킬발동() {
        // 전사 스킬: "검 휘두르기!" -> 데미지 = 공격력 * 1.5
        return this.공격력 * 1.5f;
    }

    @Override
    public String get스킬명() {
        return "검 휘두르기!";
    }
}