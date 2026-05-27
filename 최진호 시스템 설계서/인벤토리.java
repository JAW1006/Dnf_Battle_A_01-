package 던파;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트;
    private final int 최대용량 = 10;

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
    }

    // 아이템 추가 (Composition: 캐릭터 내부에서 생성 및 관리됨)
    public boolean 아이템추가(아이템 신규아이템) {
        if (아이템리스트.size() < 최대용량) {
            아이템리스트.add(신규아이템);
            return true; // 획득 성공
        }
        return false; // 가득 참
    }

    public List<아이템> get아이템리스트() { return 아이템리스트; }
    public int get최대용량() { return 최대용량; }
    public int get현재용량() { return 아이템리스트.size(); }
}