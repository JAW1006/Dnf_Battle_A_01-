```mermaid
graph LR
    %% 액터(사용자)는 원형 노드로 표현합니다.
    Player((플레이어))
    
    subgraph 게임시스템
        UC1(캐릭터생성)
        UC2(몬스터공격)
        UC3(아이템획득)
        UC4(길드가입)
        UC5(플레이어체크)
    end
    
    Player --> UC1
    Player --> UC2
    Player --> UC3
    Player --> UC4
    
    %% 특수기호가 포함된 텍스트는 파싱 에러 방지를 위해 따옴표로 감쌉니다.
    UC1 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC2 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC3 -. "&lt&ltinclude&gt&gt" .-> UC5
    UC4 -. "&lt&ltinclude&gt&gt" .-> UC5