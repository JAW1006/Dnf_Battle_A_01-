package game;

public class 전투 {
    private 플레이어 플레이어클래스 = new 플레이어();
    public 캐릭터 현재캐릭터;

    // JSP 뷰어 출력용 변수
    public String 결과_스킬명 = "";
    public float 결과_데미지 = 0.0f;
    public String 결과_등급 = "";
    public boolean 캐릭터생성성공 = false;
    public boolean 공격성공여부 = false;
    public String 메시지 = "";

    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        this.캐릭터생성성공 = false;
        
        // 요구사항: 반드시 플레이어체크를 한다.
        if (플레이어클래스.플레이어체크(플레이어id)) {
            if ("전사".equals(직업)) {
                전사 새전사 = new 전사();
                새전사.능력치설정(캐릭터명, 레벨, 레벨 * 100, 레벨 * 15);
                this.현재캐릭터 = 새전사;
                this.캐릭터생성성공 = true;
            } else if ("마법사".equals(직업)) {
                마법사 새마법사 = new 마법사();
                새마법사.능력치설정(캐릭터명, 레벨, 레벨 * 60, 레벨 * 25);
                this.현재캐릭터 = 새마법사;
                this.캐릭터생성성공 = true;
            }
        } else {
            this.메시지 = "권한 없음: 플레이어 ID가 일치하지 않습니다.";
        }
    }

    public void 몬스터공격(String 플레이어id) {
        this.공격성공여부 = false;
        
        // 요구사항: 반드시 플레이어체크를 한다.
        if (플레이어클래스.플레이어체크(플레이어id)) {
            if (this.현재캐릭터 != null) {
                // 직업에 따른 스킬명 할당
                if (this.현재캐릭터 instanceof 전사) {
                    this.결과_스킬명 = "검 휘두르기!";
                } else if (this.현재캐릭터 instanceof 마법사) {
                    this.결과_스킬명 = "파이어볼!";
                }
                
                // 다형성을 활용한 스킬 발동 (데미지 산출)
                this.결과_데미지 = this.현재캐릭터.스킬발동();

                // 데미지에 따른 등급 부여
                if (this.결과_데미지 >= 200.0f) {
                    this.결과_등급 = "S급 공격";
                } else if (this.결과_데미지 >= 100.0f) {
                    this.결과_등급 = "A급 공격";
                } else {
                    this.결과_등급 = "B급 공격";
                }
                
                this.공격성공여부 = true;
            } else {
                this.메시지 = "생성된 캐릭터가 없습니다.";
            }
        } else {
            this.메시지 = "권한 없음: 플레이어 ID가 일치하지 않습니다.";
        }
    }
}