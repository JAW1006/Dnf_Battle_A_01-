package 던파;

import java.util.ArrayList;
import java.util.List;

public class 길드 {
    private String 길드명;
    private List<캐릭터> 캐릭터리스트;
    private final int 최대인원 = 5;

    public 길드(String 길드명) {
        this.길드명 = 길드명;
        this.캐릭터리스트 = new ArrayList<>();
    }

    // 캐릭터 가입 (Aggregation: 외부에서 생성된 캐릭터 객체의 참조를 받음)
    public boolean 캐릭터가입(캐릭터 가입캐릭터) {
        if (캐릭터리스트.size() < 최대인원) {
            캐릭터리스트.add(가입캐릭터);
            return true; // 가입 성공
        }
        return false; // 정원 초과
    }

    public String get길드명() { return 길드명; }
    public int get현재인원() { return 캐릭터리스트.size(); }
    public int get최대인원() { return 최대인원; }
}