package game;

public abstract class 캐릭터 {
    public String 캐릭터명;
    public int 레벨;
    public int HP;
    public int 공격력;

    public void 속성초기화(String 캐릭터명, int 레벨, int HP, int 공격력) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨;
        this.HP = HP;
        this.공격력 = 공격력;
    }

    public abstract float 스킬발동();
}