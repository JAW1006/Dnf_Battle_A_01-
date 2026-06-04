package 던파;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int hp;
    protected int 공격력;
    protected 인벤토리 인벤토리; // ◆ Composition

    public 캐릭터(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = 레벨 <= 0 ? 1 : 레벨;
        this.인벤토리 = new 인벤토리(); // 캐릭터 생성 시 빈 인벤토리 자동 생성 (Composition)
    }

    // [PPT 클래스 다이어그램 명시 행위 구현]
    public void 인벤토리멤버추가(String 아이템명, String 타입, int 가치) {
        아이템 새아이템 = new 아이템(아이템명, 타입, 가치);
        this.인벤토리.아이템추가(새아이템);
    }

    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHp() { return hp; }
    public int get공격력() { return 공격력; }
    public 인벤토리 get인벤토리() { return 인벤토리; }

    public abstract float 스킬발동();
    public abstract String get스킬명();
}