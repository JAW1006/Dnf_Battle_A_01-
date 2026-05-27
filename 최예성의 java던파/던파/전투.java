package 던파;

public class 전투 {
    private 플레이어 플레이어매니저 = new 플레이어();
    private 캐릭터 현재캐릭터; // 클래스 내부에 캐릭터를 보관할 필드 추가

    // 다이어그램 원형 그대로 유지 (void 반환형, 순수 파라미터)
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        // 1. 플레이어 체크 (순차도 요구사항)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            this.현재캐릭터 = null;
            return; 
        }

        // 2. 직업에 따른 동적 객체 생성 후 멤버 변수에 저장 (다형성)
        if ("전사".equals(직업)) {
            this.현재캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            this.현재캐릭터 = new 마법사(캐릭터명, 레벨);
        }
    }

    // 다이어그램 원형 그대로 유지 (void 반환형, 플레이어id만 받음)
    public void 몬스터공격(String 플레이어id) {
        // 1. 플레이어 체크
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            return;
        }

        // 2. 내부에 저장된 캐릭터가 있다면 스킬 발동 (UI가 직접 호출하던 로직을 컨트롤러 내부로 완전히 흡수)
        if (this.현재캐릭터 != null) {
            float 데미지 = this.현재캐릭터.스킬발동();
            
            // 등급 판정 로직
            String 등급;
            if (데미지 >= 200) {
                등급 = "S급 공격";
            } else if (데미지 >= 100) {
                등급 = "A급 공격";
            } else {
                등급 = "B급 공격";
            }

            // 실시간 콘솔 출력 혹은 필요 시 주석 처리 가능합니다.
            System.out.println("데미지: " + 데미지 + " / 등급: " + 등급);
        }
    }

    // JSP(UI) 영역에서 캐릭터 정보를 출력하거나 세션에 넘겨주기 위한 필수 Getter
    public 캐릭터 get현재캐릭터() {
        return this.현재캐릭터;
    }
}