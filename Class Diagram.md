```mermaid
classDiagram
    class Create_Character_UI {
        <<boundary>>
    }
    
    class Attack_Monster_UI {
        <<boundary>>
    }

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
    }

    class 전사 {
        + 스킬발동()  float
    }

    class 마법사 {
        + 스킬발동()  float
    }

    class 전투 {
        + 캐릭터생성(플레이어id: String, 캐릭터명: String, 직업: String, 레벨: int)  void
        + 몬스터공격(플레이어id: String, 현재캐릭터:캐릭터, request: HttpServletRequest)  void
    }

    전사 --|> 캐릭터
    마법사 --|> 캐릭터
    
    Create_Character_UI --> 전투
    Attack_Monster_UI --> 전투
    전투 --> 플레이어
    전투 --> 캐릭터