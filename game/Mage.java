package game;

public class Mage extends Character {
    public Mage(String characterName, int level) {
        super(characterName, level);
        // 직업별 능력치 공식 반영
        this.hp = level * 60;
        this.attackPower = level * 25;
    }

    @Override
    public float useSkill() {
        // 데미지 = 공격력 * 2.0
        return this.attackPower * 2.0f;
    }

    @Override
    public String getSkillName() {
        return "파이어볼!";
    }
}