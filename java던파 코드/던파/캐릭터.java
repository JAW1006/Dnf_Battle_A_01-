package 던파;

public abstract class 캐릭터 {
    protected String 캐릭터명;
    protected int 레벨;
    protected int hp;
    protected int 공격력;

    public 캐릭터(String 캐릭터명, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.레벨 = levelvalidation(레벨);
    }

    private int levelvalidation(int 레벨) {
        return 레벨 <= 0 ? 1 : 레벨; // 레벨 기본값 방어 코드
    }

    // Getter
    public String get캐릭터명() { return 캐릭터명; }
    public int get레벨() { return 레벨; }
    public int getHp() { return hp; }
    public int get공격력() { return 공격력; }

    // 추상 메서드: 직업별로 스킬 발동 데미지가 다름
    public abstract float 스킬발동();
    public abstract String get스킬명();
}