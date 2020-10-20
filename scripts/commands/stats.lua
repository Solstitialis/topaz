---------------------------------------------------------------------------------------------------
-- func: stats
-- desc: Display hidden stats for the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = ""
};

function onTrigger(player)
    -- Phalanx
    local enhskill = player:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local phalanx = 0
    if enhskill <= 300 then
        phalanx = math.max(enhskill / 10 - 2, 0)
    elseif enhskill > 300 then
        phalanx = (enhskill - 300) / 29 + 28
    else
        print("Warning: Unknown enhancing magic skill for phalanx.")
    end

    -- Cap at 35
    phalanx = math.min(phalanx, 35)

    -- Phalanx II
    local phalanx2 = 0
    local phalanxMerits = player:getMerit(tpz.merit.PHALANX_II)
    -- Buff for GMlevel >= 5    
    if(player:getObjType() == tpz.objType.PC and player:getGMLevel() >= 5) then
        --local before = phalanxMerits;
        phalanxMerits = 15;
        --player:PrintToPlayer( string.format( "Phalanx II (Before,After): %s,%s", before, phalanxMerits ) )
    end
    phalanx2 = enhskill / 25 + phalanxMerits + 1

    -- Stoneskin
    local pMod = player:getSkillLevel(tpz.skill.ENHANCING_MAGIC) / 3 + player:getStat(tpz.mod.MND)
    local pAbs = 0;
    local pEquipMods = player:getMod(tpz.mod.STONESKIN_BONUS_HP)
    local duration = 300
    if pMod < 80 then
        pAbs = pMod
    elseif pMod <= 130 then
        pAbs = 2 * pMod - 60
    elseif pMod > 130 then
        pAbs = 3 * pMod - 190
    end

    -- hard cap of 350 from natural power
    -- pAbs = utils.clamp(1, STONESKIN_CAP) This just always sets it to 350, let's use the actual value, shall we?
    pAbs = utils.clamp(pAbs, 1, STONESKIN_CAP)

    local stoneskin = pAbs + pEquipMods

    -- Buff for GMlevel >= 5
    if(player:getObjType() == tpz.objType.PC and player:getGMLevel() >= 5) then
        phalanx = phalanx * 2;
        phalanx2 = phalanx2 *2;
        stoneskin = stoneskin *2;
    end

    local message = "";
    message = message .. string.format("Evasion: %s     M.Evasion: %s\n", player:getEVA(), player:getMod(tpz.mod.MEVA));
    message = message .. string.format("Enmity: %s\n", player:getMod(tpz.mod.ENMITY));
    message = message .. string.format("Accuracy: %s   R.Accuracy: %s   M.Accuracy: %s\n", player:getACC(), player:getRACC(), player:getMod(tpz.mod.MACC));
    message = message .. string.format("Crit%%: %s          Enemy Crit%%: %s\n", player:getMod(tpz.mod.CRITHITRATE), player:getMod(tpz.mod.ENEMYCRITRATE));
    player:PrintToPlayer(message);

    message = "";
    local delaySeconds = player:getDelay()/1000;
    local rDelaySeconds = player:getRDelay()/1000;
    local delay = math.floor(delaySeconds*60+0.5); -- Shows weapon delay with all mods applied. Debug: Should show same delay as single-handed weapon when there are no mods.
    local rDelay = math.floor(rDelaySeconds*120+0.5);   
    message = message .. string.format("Delay: %s(%ss)\n", delay, delaySeconds);
    message = message .. string.format("R.Delay: %s(%ss)\n", rDelay, rDelaySeconds);
    message = message .. string.format("Delay Mod: %s      Delay%% Mod: %s\n", player:getMod(tpz.mod.DELAY), player:getMod(tpz.mod.DELAYP));
    message = message .. string.format("R. Delay Mod: %s   R. Delay%% Mod: %s\n", player:getMod(tpz.mod.RANGED_DELAY), player:getMod(tpz.mod.RANGED_DELAYP));
    player:PrintToPlayer(message);

    message = "";
    message = message .. string.format("Dual Wield: %s\n", player:getMod(tpz.mod.DUAL_WIELD));
    message = message .. string.format("Haste Gear: %s%%   Haste Magic: %s%%   Haste Ability: %s%%\n", player:getMod(tpz.mod.HASTE_GEAR)/100, player:getMod(tpz.mod.HASTE_MAGIC)/100, player:getMod(tpz.mod.HASTE_ABILITY)/100);
    message = message .. string.format("Fast Cast: %s   Conserve MP: %s   Death Resist: %s\n", player:getMod(tpz.mod.FASTCAST), player:getMod(tpz.mod.CONSERVE_MP), player:getMod(tpz.mod.DEATHRES));
    player:PrintToPlayer(message);
    
    message = "";
    message = message .. string.format("Damage Taken Mod: %s\n", player:getMod(tpz.mod.DMG));
    message = message .. string.format("Phy Dmg Taken (#/1000): %s   Mag Dmg Taken (#/1000): %s\n", player:physicalDmgTaken(1000), player:magicDmgTaken(1000));
    message = message .. string.format("Rng Dmg Taken (#/1000): %s   Breath Dmg Taken (#/1000): %s\n", player:rangedDmgTaken(1000), player:breathDmgTaken(1000));
    player:PrintToPlayer(message);

    message = "";
    message = message .. string.format("Phalanx I: %s   Phalanx II: %s\n", phalanx, phalanx2);
    message = message .. string.format("Stoneskin: %s\n", stoneskin);
    player:PrintToPlayer(message);

    message = "";
    message = message .. string.format("Spell Interruption Rate: %s%%\n", player:getMod(tpz.mod.SPELLINTERRUPT));
    message = message .. string.format("Shadows: %s\n", player:getMod(tpz.mod.UTSUSEMI));
    player:PrintToPlayer(message);
end