package 던파;

public class 전투 {
    private 플레이어 플레이어매니저 = new 플레이어();
    
    // 설계(클래스 다이어그램)의 void 반환 타입을 충족하면서 
    // UI(JSP)와 데이터를 주고받기 위한 내부 상태 필드 정의
    private 캐릭터 생성된캐릭터;
    private 캐릭터 현재캐릭터;
    private float 최종데미지;
    private String 공격등급;
    private boolean 인증성공;

    public 전투() {}

    // 비즈니스 로직(몬스터공격) 수행 전, 대상을 지정하기 위한 세터
    public void set현재캐릭터(캐릭터 캐릭터) {
        this.현재캐릭터 = 캐릭터;
    }

    // UI에서 결과를 조회하기 위한 게터 메서드들
    public 캐릭터 get생성된캐릭터() { return 생성된캐릭터; }
    public float get최종데미지() { return 최종데미지; }
    public String get공격등급() { return 공격등급; }
    public boolean is인증성공() { return 인증성공; }

    // [순차도_캐릭터생성 & 클래스 다이어그램] 일치: 반환 타입 void로 변경
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        this.생성된캐릭터 = null;
        
        // 1. 플레이어 체크 필수 (포함 관계)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            this.인증성공 = false;
            return; 
        }
        this.인증성공 = true;
        
        // 2. 직업에 따른 동적 생성 (다형성)
        if ("전사".equals(직업)) {
            this.생성된캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            this.생성된캐릭터 = new 마법사(캐릭터명, 레벨);
        }
    }

    // [순차도_몬스터공격 & 클래스 다이어그램] 일치: 누락되었던 메서드 구현 및 void 처리
    public void 몬스터공격(String 플레이어id) {
        // 1. 플레이어 체크 필수 (<<include>> 포함 관계 수행)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            this.인증성공 = false;
            return;
        }
        this.인증성공 = true;
        
        // 2. 다형성을 이용한 스킬 발동 (전사 or 마법사)
        if (현재캐릭터 != null) {
            this.최종데미지 = 현재캐릭터.스킬발동();
            
            // 3. 데미지 수치에 따른 등급 처리 로직 (컨트롤러 내부 제어 로직)
            this.공격등급 = 공격등급판정(this.최종데미지);
        }
    }

    // 내부 등급 판정 로직 (순차도_몬스터공격의 alt 분기문 구현)
    private String 공격등급판정(float 데미지) {
        if (데미지 >= 200) {
            return "S급 공격";
        } else if (데미지 >= 100) {
            return "A급 공격";
        } else {
            return "B급 공격";
        }
    }
}
