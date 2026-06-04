```mermaid

classDiagram
    %% UI (Boundary) 클래스
    class Create_Character_UI {
        <<boundary>>
    }
    class Attack_Monster_UI {
        <<boundary>>
    }
    class Add_Item_UI {
        <<boundary>>
    }
    class Join_Guild_UI {
        <<boundary>>
    }

    %% 기존 코어 클래스
    class 플레이어 {
        + 플레이어체크(플레이어id: String)  boolean
    }

    class 캐릭터 {
        <<abstract>>
        + 캐릭터명 : String
        + 레벨 : int
        + HP : int
        + 공격력 : int
        + 스킬발동()  float
        + 인벤토리멤버추가(아이템명: String, 타입: String, 가치: int)  void
    }

    class 전사 {
        + 스킬발동()  float
    }

    class 마법사 {
        + 스킬발동()  float
    }

    class 전투 {
        - 플레이어매니저 : 플레이어
        - 현재캐릭터 : 캐릭터
        + 캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int)  void
        + 몬스터공격(플레이어id: String)  void
        + 아이템획득(플레이어id: String, 아이템명: String, 아이템타입: String, 가치: int)  void
        + 길드가입(플레이어id: String, 대상길드: 길드)  void
    }

    %% 신규 추가 클래스
    class 아이템 {
        - 아이템명 : String
        - 타입 : String
        - 가치 : int
        - 등급 : String
    }

    class 인벤토리 {
        - 아이템리스트 : List~아이템~
        - 최대용량 : int
        + 아이템추가(신규아이템: 아이템)  boolean
    }

    class 길드 {
        - 길드명 : String
        - 캐릭터리스트 : List~캐릭터~
        - 최대인원 : int
        + 캐릭터가입(대상캐릭터: 캐릭터)  boolean
    }

    %% 상속(일반화) 관계
    전사 --|> 캐릭터
    마법사 --|> 캐릭터
    
    %% 복합 객체 관계 (핵심 학습 포인트 적용)
    캐릭터 *-- 인벤토리 : Composition
    인벤토리 *-- 아이템 : Composition
    길드 o-- 캐릭터 : Aggregation
    
    %% 의존 및 연관 관계
    Create_Character_UI --> 전투
    Attack_Monster_UI --> 전투
    Add_Item_UI --> 전투
    Join_Guild_UI --> 전투
    
    전투 --> 플레이어
    전투 --> 캐릭터