package game;

public class Warrior extends Character {
    public Warrior(String characterName, int level) {
        super(characterName, level);
        // 직업별 능력치 공식 반영
        this.hp = level * 100;
        this.attackPower = level * 15;
    }

    @Override
    public float useSkill() {
        // 데미지 = 공격력 * 1.5
        return this.attackPower * 1.5f;
    }

    @Override
    public String getSkillName() {
        return "검 휘두르기!";
    }
}
