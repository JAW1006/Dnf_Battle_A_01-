package 던파;

public class 전투 {
    private 플레이어 플레이어객체 = new 플레이어();
    private 캐릭터 현재캐릭터; 

    // 하위 클래스(전사, 마법사) 없이 캐릭터 단일 객체로 생성
    public void 캐릭터생성(String 플레이어id, String 캐릭터명, String 직업, int 레벨) {
        if (!플레이어객체.플레이어체크(플레이어id)) {
            this.현재캐릭터 = null;
            return; 
        }

        // 넘어온 정보(직업 포함)를 토대로 캐릭터 객체 즉시 생성
        this.현재캐릭터 = new 캐릭터(캐릭터명, 직업, 레벨);
    }

    // 이하 기존 코드 완벽하게 동일
    public void 몬스터공격(String 플레이어id) {
        if (!플레이어객체.플레이어체크(플레이어id)) return;

        if (this.현재캐릭터 != null) {
            float 데미지 = this.현재캐릭터.스킬발동();
            
            String 등급;
            if (데미지 >= 200) 등급 = "S급 공격";
            else if (데미지 >= 100) 등급 = "A급 공격";
            else 등급 = "B급 공격";

            System.out.println("데미지: " + 데미지 + " / 등급: " + 등급);
        }
    }

    public String 아이템획득(String 플레이어id, String 아이템명, String 타입, int 가치) {
        if (!플레이어객체.플레이어체크(플레이어id)) return "실패: 플레이어 인증 오류";
        if (this.현재캐릭터 == null) return "실패: 생성된 캐릭터가 없습니다.";

        아이템 신규아이템 = new 아이템(아이템명, 타입, 가치);
        boolean 결과 = this.현재캐릭터.get인벤토리().아이템추가(신규아이템);

        if (결과) return "성공: [" + 신규아이템.get등급() + "] " + 아이템명 + " 획득! (인벤토리: " + this.현재캐릭터.get인벤토리().get현재용량() + "/10)";
        else return "실패: 인벤토리 용량이 가득 찼습니다.";
    }

    public String 길드가입(String 플레이어id, 길드 대상길드) {
        if (!플레이어객체.플레이어체크(플레이어id)) return "실패: 플레이어 인증 오류";
        if (this.현재캐릭터 == null) return "실패: 생성된 캐릭터가 없습니다.";
        if (대상길드 == null) return "실패: 존재하지 않는 길드입니다.";

        boolean 결과 = 대상길드.캐릭터가입(this.현재캐릭터);

        if (결과) return "성공: [" + 대상길드.get길드명() + "] 길드 가입 완료! (정원: " + 대상길드.get현재인원() + "/5)";
        else return "실패: 길드 정원이 가득 찼습니다.";
    }

    public 캐릭터 get현재캐릭터() {
        return this.현재캐릭터;
    }
}