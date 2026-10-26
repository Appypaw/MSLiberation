# MS Liberation

## English

MS Liberation is an Arma 3 cooperative multiplayer CTI (Capture the Island) mission based on KP Liberation 0.96.7a. Capture territory, build FOBs, manage resources, and weaken enemy forces in a persistent PvE campaign.

### MS Liberation features

- **Personal economy and progression:** Earn money and XP through combat and objectives. Unlock equipment by level, buy gear, sell eligible loot, and transfer funds to teammates through the main base terminal.
- **Equipment and survival:** Choose from six free kits covering rifleman, machine gunner, anti-tank, and anti-air roles. Death removes carried equipment while preserving money and XP; reconnecting alive restores saved gear.
- **Reworked capture rules:** Clear and hold the sector core to capture territory. One or two remaining enemies can be overcome through sustained suppression, while combat-capable enemy armor blocks capture. Map markers show connected and isolated friendly sectors.
- **Operations driven by player actions:** Capturing major cities or building new FOBs can trigger defensive operations. Existing convoy interception, enemy FOB search, and pilot rescue missions remain part of the campaign.
- **Physical air support:** Request signal-guided ammunition, medical supplies, or team resources delivered by transport aircraft. Call a helicopter for extraction from behind enemy lines and board it for the flight home.
- **Enemy logistics and AI:** Capturing factories and military bases, destroying communications towers, and intercepting convoys reduce enemy reinforcement capacity. Separate CAS and CAP roles and special forces add variety to enemy responses.
- **Custom factions and recovery:** PRACS-based friendly forces face SLA enemies, with AIS Wounding integrated. Recover enemy dog tags for additional money and XP.
- **Persistent player records:** Player funds, progression, statistics, and equipment are stored separately from the existing KP campaign save.

### Setup

1. Install the terrain and mods referenced by `mission.sqm` and the selected faction and arsenal presets. The current configuration references PRACS, PRACS SLA, RHS, and 3CB assets, among others.
2. Pack the mission into a PBO with the appropriate terrain suffix and place it in the server's `mpmissions` directory.
3. Load the required mods on the server and clients, then select the mission.

Configure MS Liberation in [`scripts/msl/config.sqf`](scripts/msl/config.sqf), the KP framework in [`kp_liberation_config.sqf`](kp_liberation_config.sqf), and factions and equipment in `presets/` and `arsenal_presets/`.

Implementation notes and in-game test procedures are available in the documents below. Engine and multiplayer validation of the recent campaign changes is still pending.

## 한국어

MS Liberation은 KP Liberation 0.96.7a를 기반으로 제작한 Arma 3 협동 멀티플레이 CTI(Capture the Island) 미션입니다. 지역 점령, FOB 건설, 자원 관리와 적 전력 약화를 중심으로 진행하는 저장형 PvE 캠페인입니다.

### MS Liberation의 특징

- **개인 경제와 성장:** 전투와 임무로 자금과 XP를 획득합니다. 레벨에 따라 장비 구매 권한을 해금하고, 장비 구매와 노획품 판매, 본진 단말기를 통한 아군 송금을 이용할 수 있습니다.
- **장비와 생존:** 소총수, 기관총수, 대전차, 대공 역할을 위한 무료 키트 6종을 제공합니다. 사망하면 휴대 장비를 잃지만 자금과 XP는 유지되며, 생존 상태로 재접속하면 저장된 장비를 복원합니다.
- **점령 규칙 개편:** 지역 중심을 확보하고 유지해야 점령할 수 있습니다. 잔적 1~2명은 장시간 제압으로 대응할 수 있지만, 전투 가능한 적 장갑차가 남아 있으면 점령할 수 없습니다. 지도에는 아군 지역의 연결과 고립 상태를 표시합니다.
- **플레이에 반응하는 작전:** 대도시 점령이나 신규 FOB 건설을 계기로 방어전이 발생할 수 있습니다. 기존 수송대 탈취, 적 FOB 수색, 조종사 구출 임무도 함께 진행합니다.
- **실제 항공 보급과 철수:** 신호를 보내 수송기로 탄약, 의료품, 팀 자원을 공중 보급받습니다. 적 후방에서는 철수 헬기를 요청하고 직접 탑승해 본진으로 복귀합니다.
- **적 군수망과 AI:** 공장·군사기지 점령, 통신탑 파괴, 수송대 탈취로 적 증원 능력을 약화시킵니다. CAS와 CAP의 역할 분리, 특수부대 운용으로 적의 대응을 다양화했습니다.
- **커스텀 진영과 회수 보상:** PRACS 기반 아군과 SLA 적군을 구성하고 AIS Wounding을 적용했습니다. 적 독택을 회수하면 추가 자금과 XP를 받습니다.
- **개인 기록 저장:** 자금, 성장 진행도, 통계와 장비를 기존 KP 캠페인 저장 데이터와 별도로 보관합니다.

### 설치 및 설정

1. `mission.sqm`과 선택한 진영·무기고 프리셋에 필요한 지형과 모드를 설치합니다. 현재 설정은 PRACS, PRACS SLA, RHS, 3CB 등의 에셋을 참조합니다.
2. 지형에 맞는 접미사를 포함해 미션을 PBO로 패킹한 뒤 서버의 `mpmissions` 폴더에 넣습니다.
3. 서버와 클라이언트에 필요한 모드를 적용하고 미션을 선택합니다.

MS Liberation 기능은 [`scripts/msl/config.sqf`](scripts/msl/config.sqf), KP 기본 설정은 [`kp_liberation_config.sqf`](kp_liberation_config.sqf), 진영과 장비는 `presets/`와 `arsenal_presets/`에서 조정합니다.

세부 구현과 인게임 확인 절차는 아래 문서를 참고하세요. 최근 캠페인 변경사항의 엔진 및 멀티플레이 검증은 아직 완료되지 않았습니다.

## Documentation / 문서

- [Campaign systems / 캠페인 시스템](docs/MSL_CAMPAIGN.md)
- [Contextual operations / 사건 기반 작전](docs/MSL_SCENARIOS.md)
- [Performance and verification / 성능 및 검증](docs/MSL_PERFORMANCE.md)

## Credits and license / 크레딧 및 라이선스

Based on KP Liberation and the Liberation framework. Includes AIS Wounding and GREUH components.

KP Liberation 및 Liberation 프레임워크를 기반으로 하며, AIS Wounding과 GREUH 구성요소를 포함합니다.

The bundled KP license is [GNU GPL v3](KP/LICENSE). See the notices in individual files for component-specific attribution and terms.

저장소에 포함된 KP 라이선스는 [GNU GPL v3](KP/LICENSE)입니다. 구성요소별 저작권과 이용 조건은 각 파일의 고지를 참고하세요.
