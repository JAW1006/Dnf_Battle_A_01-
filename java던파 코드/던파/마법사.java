package 던파;

public class 마법사 extends 캐릭터 {

    public 마법사(String 캐릭터명, int 레벨) {
        super(캐릭터명, 레벨);
        // 마법사 기본 능력치 설정 규칙
        this.hp = 레벨 * 60;
        this.공격력 = 레벨 * 25;
    }

    @Override
    public float 스킬발동() {
        // 마법사 스킬: "파이어볼" -> 데미지 = 공격력 * 2.0
        return this.공격력 * 2.0f;
    }

    @Override
    public String get스킬명() {
        return "파이어볼";
    }
}