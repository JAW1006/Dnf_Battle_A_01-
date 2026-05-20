package game;

public class 마법사 extends 캐릭터 {
    public void 능력치설정(String 캐릭터명, int 레벨, int HP, int 공격력) {
        super.속성초기화(캐릭터명, 레벨, HP, 공격력);
    }

    @Override
    public float 스킬발동() {
        // 마법사: 데미지 = 공격력 * 2.0
        return (float) (this.공격력 * 2.0);
    }
}