# Virtual arsenal and personal tablet

With MSL enabled, the existing armory action and the supply-area wheel action open
the vanilla BIS virtual arsenal in restricted mode, including when ACE is loaded.
The server catalog and the player's XP level determine the available weapons,
attachments, magazines, explosives, clothing and equipment. Starter weapons are
individual catalog entries; the free-kit UI and free-kit request are disabled.

Each equipment row shows its unit price. The upper panel shows current cash,
the estimated purchase total, and remaining cash. Keeping existing gear costs
nothing. Additional copies cost their unit price. Refilled ammunition is charged
in magazine equivalents rounded up. Removing equipment generates no refund;
use the tablet's equipment sale page for eligible purchased or looted items.

The arsenal edits a separate preview actor. On closing it, the server normalizes
the loadout, validates level and whitelist restrictions, calculates the bill and
reserves payment before issuing equipment through the existing settlement path.
Insufficient cash or invalid equipment cancels the whole change. Actual player
equipment stays unchanged during preview. Purchases retain resale credit and
removed items lose that credit. Saved loadouts are also checked at settlement.

Every player can open the wheel-menu tablet to view level unlocks or sell gear.
Sales and the arsenal require a base/FOB supply area. Transfers still require the
main terminal. AI supply requests require current group leadership, and the server rechecks
that permission. A commander appointment alone does not grant access.

Validation: run `python -X utf8 tools/verify_msl.py --sqflint-path D:/Arma3Server/tools/python-libs`.
The in-engine `tools/msl_selftest.sqf` includes quote cases for extra magazines,
unchanged gear, removals, level restrictions, ammunition refills and invalid items.
Client acceptance must check category filtering, weapon/attachment and explosive
selection, price visibility, saved loadouts, insufficient funds, sale/rebuy,
disconnect/rejoin and two simultaneous players. Static checks do not prove these
UI or multiplayer behaviors.

## Equipment browser

The wheel-menu tablet now uses one navigation shell: equipment browser, native
arsenal, sales, support requests, and transfers. Support remains restricted to
current squad leaders. Opening the tablet defaults to Overview.

The browser filters by weapon type/equipment category, exact unlock level, unlock
state, and a name/class search. Results sort by level and name, with 50 entries per
page. Filter and selection state remain while changing tablet tabs. Level-zero
starter clothing appears under level one. These filters do not change prices,
XP requirements, or server permissions.

Selecting a weapon displays its compatible, catalog-whitelisted magazines beside
it, including every muzzle's ammunition and magazine-well compatibility through
the engine's compatibleMagazines command. Class comparisons ignore case. Each
magazine shows price, unlock level and current unlock state. Double-clicking a
magazine jumps to its entry and level in the browser. Tooltip text exposes full
names when long mod equipment names exceed the row width. Weapons and ammunition
still unlock automatically at their individually configured levels.


## 2026-10-26 탄창 해금 및 메뉴 수정

- 서버가 무기 호환 탄창과 무기 해금 레벨을 연결합니다. 일반 기본 탄창 하나는 해당 무기와 동시에 해금되며, 탄창 구매 가격은 유지합니다. 일반탄 후보 중 기본 용량을 우선합니다.
- 다른 탄창은 기존 탄약 등급과 호환 무기의 최소 해금 레벨을 함께 적용합니다. 특별탄 전체를 기본탄과 함께 해금하지 않습니다.
- 서버는 클라이언트가 보낸 원본 장비와 엔진 정규화 후 장비를 모두 검사하여 잠긴 탄창이나 미등록 장비의 추가·재충전을 차단합니다.
- 무기고 표의 아이콘/데이터 열과 이름 열을 구분하고, 긴 이름은 줄여 표시합니다. 전체 이름·가격·레벨은 툴팁에서 확인합니다.
- 행동 메뉴에서 MSL이 켜진 경우 기존 KP 무기고 항목을 숨기고, MSL 무기고와 태블릿을 각각 하나씩 표시합니다.
- 변경 사항은 다음 서버 시작 시 미션을 다시 빌드하면서 반영됩니다. 실행 중인 미션에는 자동 반영되지 않습니다.
