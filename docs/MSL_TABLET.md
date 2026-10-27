# FIELDNET tactical tablet

The tablet is packaged in the mission, with no additional client mod. Open through
the existing player action. `ESC` and the sidebar close button dismiss it.

## Size and appearance

The outer tablet is 3:2 in physical pixels and uses 78% of screen height. Width is
calculated with `pixelW / pixelH`, never as a percentage of the monitor width.
It is centered and capped at 92% of available width for narrow screens.

At 3440×1440, the outer frame is approximately **1685×1123 pixels** (49% of
monitor width). At 1920×1080 it is approximately **1264×842 pixels**. These are
layout calculations, not verified Arma engine captures. UI scale and fonts still
need checking in Arma. The inner display uses the image's flat black aperture.

The generated minimal graphite tablet with a slim rugged case is `res/tablet/fieldnet_tablet_v2_source.png`.
The mission loads `res/tablet/fieldnet_tablet_v2_ca.paa`: DXT5 with interpolated alpha,
power-of-two GPU dimensions, nine mip levels, and a mip offset table. Rebuild with
`python3 tools/build_tablet_texture.py` using Pillow >= 11. The texture's GPU aspect
ratio is restored to 3:2 by the display rectangle.

`docs/previews/tablet.html` is a browser design preview with example data, not the
Arma runtime. Its overview and career tabs illustrate layout only.

The display uses a simple dark app theme with neutral panels and blue selection,
without the previous tactical grid or olive accents. The earlier v1 artwork is
preserved in `res/tablet` but is not referenced by the mission.

## Progression audit

The server owns cumulative XP and derives the level using `fn_progress.sqf`.
Clients receive the six-stat slice through `MSL_stats`; level is not a separately
editable player field. Each Steam UID's cash/XP/stats persist in the server profile
under `GRLIB_save_key + "_MSL_V1"`. A different server profile or save key means a
different campaign record. This audit has not read a running server's save.

| Level | Total XP | Title |
|---|---:|---|
| 1 | 0 | RECRUIT |
| 2 | 500 | OPERATOR |
| 3 | 1,200 | SPECIALIST |
| 4 | 2,200 | VETERAN |
| 5 | 3,600 | NIGHT OPS |
| 6 | 5,500 | PATHFINDER |
| 7 | 8,000 | ELITE |
| 8 | 11,000 | VANGUARD |
| 9 | 15,000 | COMMANDO |
| 10 | 20,000 | LEGEND |

Configured rewards: enemy infantry kill $200/10 XP, dogtag collection $300/30 XP; vehicle destruction uses `MSL_vehicleRewards` (see MSL_CAMPAIGN.md). Sector capture
150, successful defense 250. Participation requirements
remain in their existing server handlers. A kill now marks the save dirty for the
existing two-second commit batch instead of relying on the periodic 60-second
snapshot. This reduces the loss window; it does not promise crash-proof storage.

Current explicit presets have 496 weapon rows and 389 attachment rows before
runtime mod filtering and free-family overrides. Weapon rows span LV.1–7 and
attachment rows span LV.1–5 and LV.7. Category tiers also top out at LV.7. There are
currently no explicit LV.8–10 unlocks: those levels extend the rank ladder, with
no new equipment milestone. The balance has not been changed by this UI work.
At 150 XP per capture alone, LV.7 needs 54 captures and LV.10 needs 134; other
awards reduce those counts.

Starter CETME/HK33/M16/M60 families, RACS basic clothing and essential utilities
have free exceptions. Other upgraded gear still requires payment after unlock.
The server derives basic magazine levels from compatible weapons; special ammo
keeps its additional tier requirements. Runtime catalog counts depend on installed
mods, so the career screen counts actual `MSL_shopEntries` rather than static
preset rows. The level roadmap opens the matching tier in the equipment browser.

The virtual arsenal filters by level, and the server rechecks unknown/locked
additions and balance when settling the loadout. Catalog display, arsenal preview
and settlement share the server catalog. Existing locked gear may be retained;
new locked additions are rejected.

## Validation

- `python3 tools/verify_msl.py --sqflint-path /tmp/msl-sqflint`: syntax/integration.
- `tools/msl_selftest.sqf`: now includes every XP threshold and the point one XP
  below each threshold; these assertions must run inside Arma.
- Texture builder validates DXT5 payload sizes and decodes all mip levels before
  packaging; the PAA still requires visual loading verification inside Arma.
- In-engine acceptance: UWQHD/FHD and UI scale; long names; LV.1/7/10; no catalog
  while initializing; locked purchase rejection; XP reward, disconnect/reconnect
  and server restart persistence; base/FOB/field navigation; support permissions.

## Per-player language setting

The sidebar language dropdown offers **한국어 / English** and saves the choice in
that client's `profileNamespace` under `MSL_language`. It updates the tablet shell,
career/catalog filters and details, transfers, sales, player action titles and
custom arsenal feedback immediately. Existing page/filter selections are retained.
The display preference is shared with the server only for translating personal
economy and airdrop feedback for each recipient; it has no gameplay authority.
Base-game menus and mod-provided item names follow their own engine localization.

The custom extraction feature has been removed: UI, dispatcher branch, queue,
aircraft script, reward settings, function registration and dedicated cleanup loop.
Airdrops retain their own existing aircraft cleanup. Existing KP transport and
rescue missions are separate. No extra kill/vehicle statistics were added.

Acceptance checks still needed in Arma: change language while each tab is open,
restart/rejoin to confirm the preference, use mixed-language clients to verify
per-recipient messages, confirm action titles update, and confirm only ammunition,
medical and resource supply actions remain.

## Squad command and personal settings

The tablet has a **Command** workspace with **Supply requests** and **Group
management** subtabs. It replaces the separate Support and Groups tabs.

Command is restricted to the current living friendly player squad leader. A
campaign commander appointment by itself grants no exception. The sidebar and
overview shortcut are disabled for members, every command action rechecks current
leadership, and the server airdrop dispatcher checks the same predicate. Losing
leadership while Command is open removes its controls on the next UI refresh;
a click before refresh still fails the permission check.

- Supply requests: ammunition, medical supplies and shared team resources.
- Group management: list player-led allied groups, join, create and rename. This
  subtab retains KP Player Menu's CBA/mission-parameter requirement. Renaming also
  requires leadership of the selected live group. The list refreshes on demand
  and after confirming a group join; no background scan is added. Joining another
  group can naturally remove leadership and therefore Command access.
- Settings remains a separate tab accessible to every player: on-foot/land-sea/
  air view distances, terrain detail, automatic third person, radio suppression
  and in-vehicle volume. Apply writes the existing seven-field `KPPLM_Settings`
  and invokes `KPPLM_fnc_apply`. Get-in/out behavior and difficulty constraints are
  retained. Zero view distance retains KP's 1600 m default.
- Optional KP Ranks rank/score/playtime moved to Overview, so ordinary members can
  still read their own data. MSL career level/XP remains in Career.
- The standalone KP action is hidden when MSL is enabled; calls to the old dialog
  open Settings. With MSL disabled the original KP dialog remains available.

In-engine acceptance still needed: leader/member/commander-only roles; leadership
loss with Command open; stale request rejection at the server; join/create/rename
permissions and refreshed leadership; KO/EN layouts; saved KP settings across
reconnect and all three vehicle contexts; optional KP Ranks. No new kill or vehicle
statistics were added.
