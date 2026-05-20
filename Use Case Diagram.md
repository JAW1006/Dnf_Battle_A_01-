```mermaid

graph LR
    %% 액터 정의 (사람 모양 대신 원형으로 표현)
    Player((플레이어))

    %% 시스템 경계 및 유스케이스 정의
    subgraph 게임 시스템
        UC1([캐릭터 생성])
        UC2([몬스터 공격])
        UC3([플레이어체크])
    end

    %% 액터와 유스케이스 간의 관계
    Player --> UC1
    Player --> UC2

    %% 유스케이스 간의 포함(Include) 관계
    UC1 -. "&lt&ltinclude&gt&gt" .-> UC3
    UC2 -. "&lt&ltinclude&gt&gt" .-> UC3