package game;

public abstract class Character {
	protected String characterName;
    protected int level;
    protected int hp;
    protected int attackPower;

    public Character(String characterName, int level) {
        this.characterName = characterName;
        this.level = level;
    }

    // 다형성을 위한 스킬발동 추상 메서드
    public abstract float useSkill();
    public abstract String getSkillName();

    // Getter 메서드들
    public String getCharacterName() { return characterName; }
    public int getLevel() { return level; }
    public int getHp() { return hp; }
    public int getAttackPower() { return attackPower; }
}
