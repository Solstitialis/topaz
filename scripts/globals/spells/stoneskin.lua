-----------------------------------------
-- Spell: Stoneskin
-----------------------------------------
-- http://wiki.ffxiclopedia.org/wiki/Stoneskin
-- Max 350 damage absorbed
-- (before cap bonus gear, with no settings.lua adjustment)
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local pMod = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC) / 3 + caster:getStat(tpz.mod.MND)
    local pAbs = 0
    local pEquipMods = caster:getMod(tpz.mod.STONESKIN_BONUS_HP)
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

    local duration = calculateDuration(STONESKIN_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 28, target:getMainLvl())

    local final = pAbs + pEquipMods

    -- Apply damage absorption multiplier at GM level
    --local before = final
    if(caster:getObjType() == tpz.objType.PC and caster:getGMLevel() >= GMLEVEL_STONESKIN_ABSORB_MULTIPLIER and target:getObjType() == tpz.objType.PC and target:getGMLevel() >= GMLEVEL_STONESKIN_ABSORB_MULTIPLIER) then
        final = final * STONESKIN_ABSORB_MULTIPLIER
    end
    --caster:PrintToPlayer(string.format("Stoneskin (Before,After): %s,%s", before, final))

    -- Auto remove Stoneskin for recast
    target:delStatusEffect(tpz.effect.STONESKIN)

    if target:addStatusEffect(tpz.effect.STONESKIN, final, 0, duration, 0, 0, 4) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.STONESKIN
end
