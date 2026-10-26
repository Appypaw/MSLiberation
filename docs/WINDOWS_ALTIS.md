# Local Windows deployment

Deployment directory: `D:\Arma3Server`. Double-click `Server.cmd` for start, settings, RPT, backup and graceful shutdown.
Mission sources remain in this repository. The deployment builds an uncompressed `MSLiberation.Altis.pbo` on each start.
Runtime, mods, settings, profiles and test profiles are separate from the Steam client installation.

`mission.sqm` comes from KP Liberation v0.96.7a, commit `696c395f68987762d34928371c2cf8ec3a5b50d8`, `Missionbasefiles/kp_liberation.Altis/mission.sqm`.
The original repository contained a Taunus mission layout with CUP/xCam dependencies; renaming it to Altis would leave invalid sector/base placement.
The original file was backed up to `D:\Arma3Server\backups\mission.original-taunus.sqm`.
The Altis layout replaces the original decorated base and sector positions while retaining the MS Liberation scripts and custom faction/arsenal presets.

Loaded mods: CBA_A3, RHS AFRF/USAF/GREF/SAF, 3CB Factions, PRACS, PRACS SLA. No CUP or xCam.
The custom air unlock building now uses the vanilla Altis airport tower.

Runtime fixes:

- Vehicle-to-base assignment stops when no unassigned candidates remain, even when the elite vehicle preset repeats a classname.
- The server preflight reports the configured six free kits instead of referencing the nonexistent `MSL_defaultKit`.
- Server-local `initServer.sqf` logs boot status and health. Empty `[TEST]` instances additionally run the existing self-test suite.

Server bootstrap and mod compatibility have been checked in-engine; player joining, gameplay, persistence round trips and 20-player combat still require client testing.
The RHS MELB model emits a `HitEngine`/`hithull` config warning in this installed mod set; it does not stop mission initialization. Keep it on the vehicle test list.
Missing optional mod candidates in KP's preset filtering logs do not imply those mods must be installed.

Do not commit local deployment settings: they contain generated join/admin credentials.
