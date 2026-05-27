package 던파;

public class 캐릭터 {
    protected String 캐릭터명;
    protected String 직업; // 직업 필드 추가
    protected int 레벨;
    protected int hp;
    protected int 공격력;
    protected 인벤토리 인벤토리객체;

    public 캐릭터(String 캐릭터명, String 직업, int 레벨) {
        this.캐릭터명 = 캐릭터명;
        this.직업 = 직업;
        this.레벨 = levelvalidation(레벨);
        this.인벤토리객체 = new 인벤토리();

        // 직업에 따른 능력치 자동 세팅
        if ("전사".equals(직업)) {
            this.hp = this.레벨 * 100;
            this.공격력 = this.레벨 * 15;
        } else if ("마법사".equals(직업)) {
            this.hp = this.레벨 * 60;
            this.공격력 = this.레벨 * 25;
        } else {
            // 예외 처리 (기본값)
            this.hp = this.레벨 * 10;
            this.공격력 = this.레벨 * 10;
        }
    }

    private int levelvalidation(int 레벨) {
        return 레벨 <= 0 ? 1 : 레벨;
    }

    public String get캐릭터명() { return 캐릭터명; }
    public String get직업() { return 직업; }
    public int get레벨() { return 레벨; }
    public int getHp() { return hp; }
    public int get공격력() { return 공격력; }
    public 인벤토리 get인벤토리() { return 인벤토리객체; }

    // 직업에 따른 스킬 발동 데미지 분기
    public float 스킬발동() {
        if ("전사".equals(this.직업)) {
            return this.공격력 * 1.5f;
        } else if ("마법사".equals(this.직업)) {
            return this.공격력 * 2.0f;
        }
        return 0;
    }

    // 직업에 따른 스킬명 분기
    public String get스킬명() {
        if ("전사".equals(this.직업)) {
            return "검 휘두르기!";
        } else if ("마법사".equals(this.직업)) {
            return "파이어볼";
        }
        return "기본 공격";
    }
}