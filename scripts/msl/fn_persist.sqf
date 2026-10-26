if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {};
profileNamespace setVariable [MSL_saveKey, [1, MSL_accounts, MSL_destroyedTowers, MSL_supplyPressure]];
saveProfileNamespace;
