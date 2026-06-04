package 던파;

public class 전투 {
    private 플레이어 플레이어매니저 = new 플레이어();
    private 캐릭터 현재캐릭터; // 클래스 다이어그램에 맞춰 전투가 캐릭터를 가집니다.

    // PPT 명세 행위 4가지 정의 (반환타입 void, 파라미터 일치)
    
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        if (!플레이어매니저.플레이어체크(플레이어id)) return;

        if ("전사".equals(직업)) {
            this.현재캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            this.현재캐릭터 = new 마법사(캐릭터명, 레벨);
        }
    }

    public void 몬스터공격(String 플레이어id) {
        if (!플레이어매니저.플레이어체크(플레이어id)) return;

        if (this.현재캐릭터 != null) {
            float 데미지 = this.현재캐릭터.스킬발동();
            String 등급;
            if (데미지 >= 200) {
                등급 = "S급 공격";
            } else if (데미지 >= 100) {
                등급 = "A급 공격";
            } else {
                등급 = "B급 공격"; // 100 미만 판정 완수
            }
            // 내부 연산 결과 저장은 자율 (필요시 콘솔 출력 등 가능)
            System.out.println("데미지 : " +데미지 + "\t 등급 : " + 등급);
        }
    }

    public void 아이템획득(String 플레이어id, String 아이템명, String 아이템타입, int 가치) {
        if (!플레이어매니저.플레이어체크(플레이어id)) return;
        if (this.현재캐릭터 == null) return;


        // PPT 요구사항: 캐릭터가 인벤토리 멤버 추가 행위를 주도하도록 변경
        this.현재캐릭터.인벤토리멤버추가(아이템명, 아이템타입, 가치);
    }

    public void 길드가입(String 플레이어id, 길드 대상길드) {
        if (!플레이어매니저.플레이어체크(플레이어id)) return;
        if (this.현재캐릭터 == null || 대상길드 == null) return;

        // Aggregation형 가입 처리
        대상길드.캐릭터가입(this.현재캐릭터);
    }

    // UI 연결을 위한 최소한의 현재캐릭터 Getter
    public 캐릭터 get현재캐릭터() { return 현재캐릭터; }
}