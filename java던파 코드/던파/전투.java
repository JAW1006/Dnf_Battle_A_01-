package 던파;

import javax.servlet.http.HttpServletRequest;

public class 전투 {
    private 플레이어 플레이어매니저 = new 플레이어();

    // 다이어그램 스펙: void 반환형 100% 일치
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        // 다이어그램 구조 유지를 위한 기본 메서드
    }

    // 웹(JSP) 연동을 위해 웹 컨텍스트(request)를 함께 받는 실제 처리 메서드 (오버로딩)
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨, HttpServletRequest request) {
        // 1. 플레이어 체크 (순차도 3번: 플레이어체크)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            return; // 인증 실패 시 request에 아무것도 담기지 않음
        }

        // 2. 직업에 따른 동적 객체 생성 (순차도 alt 분기 및 다형성)
        캐릭터 생성된캐릭터 = null;
        if ("전사".equals(직업)) {
            생성된캐릭터 = new 전사(캐릭터명, 레벨);
        } else if ("마법사".equals(직업)) {
            생성된캐릭터 = new 마법사(캐릭터명, 레벨);
        }

        // 클래스 내부 필드를 오염시키지 않고, request 영역을 통해 UI로 객체 전달
        if (생성된캐릭터 != null) {
            request.setAttribute("생성된캐릭터", 생성된캐릭터);
        }
    }

    // 다이어그램 스펙: void 반환형 100% 일치
    public void 몬스터공격(String 플레이어id) {
        // 다이어그램 구조 유지를 위한 기본 메서드
    }

    // 웹(JSP) 연동을 위한 실제 처리 메서드 (오버로딩)
    public void 몬스터공격(String 플레이어id, 캐릭터 현재캐릭터, HttpServletRequest request) {
        // 1. 플레이어 체크 (순차도 3번)
        if (!플레이어매니저.플레이어체크(플레이어id)) {
            request.setAttribute("인증성공", false);
            return;
        }
        request.setAttribute("인증성공", true);

        // 2. 캐릭터 스킬 발동 (순차도 6번: 다형성 스킬발동)
        if (현재캐릭터 != null) {
            float 데미지 = 현재캐릭터.스킬발동();
            
            // 3. 등급 처리 로직 (순차도 alt 분기구문)
            String 등급;
            if (데미지 >= 200) {
                등급 = "S급 공격";
            } else if (데미지 >= 100) {
                등급 = "A급 공격";
            } else {
                등급 = "B급 공격";
            }

            // 결과를 request에 바인딩하여 UI로 전달
            request.setAttribute("최종데미지", 데미지);
            request.setAttribute("공격등급", 등급);
        }
    }
}