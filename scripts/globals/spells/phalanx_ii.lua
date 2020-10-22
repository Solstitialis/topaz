-----------------------------------------
-- Spell: Phalanx II
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    local final = 0
    local duration = calculateDuration(PHALANX_II_DURATION, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 75, target:getMainLvl())

    if enhskill <= 300 then
        final = math.floor(enhskill / 25) + 16
    else
        final = math.floor((enhskill - 300.5) / 28.5) + 28
    end

    -- Apply resistance multiplier at GM level
    --local before = final
    if(caster:getObjType() == tpz.objType.PC and caster:getGMLevel() >= GMLEVEL_PHALANX_MULTIPLIER and target:getObjType() == tpz.objType.PC and target:getGMLevel() >= GMLEVEL_PHALANX_MULTIPLIER) then
        final = final * PHALANX_MULTIPLIER
    end
    --caster:PrintToPlayer(string.format("Phalanx (Before,After): %s,%s", before, final))

    if target:addStatusEffect(tpz.effect.PHALANX, final, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PHALANX
end
