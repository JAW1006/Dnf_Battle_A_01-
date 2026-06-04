package 던파;

import java.util.ArrayList;
import java.util.List;

public class 인벤토리 {
    private List<아이템> 아이템리스트; // PPT 명시 속성
    private int 최대용량 = 10;         // PPT 명시 속성 (필드로 변경)

    public 인벤토리() {
        this.아이템리스트 = new ArrayList<>();
    }

    public boolean 아이템추가(아이템 신규아이템) {
        if (아이템리스트.size() >= 최대용량) {
            return false; // 10개 제한 방어
        }
        return 아이템리스트.add(신규아이템);
    }

    public List<아이템> get아이템리스트() { return 아이템리스트; }
    public int get최대용량() { return 최대용량; }
}