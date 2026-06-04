package 던파;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명;
    private List<캐릭터> 캐릭터리스트; // Aggregation: 캐릭터들을 참조 형태로 집합 관리
    private final int 최대인원 = 5;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
        this.캐릭터리스트 = new ArrayList<>();
    }

    public boolean 캐릭터가입(캐릭터 대상캐릭터) {
        if (캐릭터리스트.size() >= 최대인원) {
            return false; // 길드 정원 초과 (최대 5명)
        }
        // 외부에서 이미 만들어진 캐릭터의 주소값(참조)만 받아 리스트에 등록 (Aggregation)
        return 캐릭터리스트.add(대상캐릭터);
    }

    public String get길드명() { return 길드명; }
    public List<캐릭터> get캐릭터리스트() { return 캐릭터리스트; }
    public int get현재인원() { return 캐릭터리스트.size(); }
    public int get최대인원() { return 최대인원; }
}