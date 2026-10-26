if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {};
// Critical reservations/rewards flush immediately. A settled transaction can be
// replayed from its durable reservation, so its final snapshot may be batched.
params [["_immediate", true]];
MSL_saveDirty = true;
if (!_immediate) exitWith {};
profileNamespace setVariable [MSL_saveKey, [1, MSL_accounts, MSL_destroyedTowers, MSL_supplyPressure]];
saveProfileNamespace;

MSL_saveDirty = false;
