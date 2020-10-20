-----------------------------------------
-- Spell: Utsusemi: Ni
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)

    -- Get extras shadows
    local numShadows = 3
    local icon = tpz.effect.COPY_IMAGE_3

    if (caster:getMainJob() == tpz.job.NIN) then
        numShadows = 4 + target:getMod(tpz.mod.UTSUSEMI_BONUS)
        icon = tpz.effect.COPY_IMAGE_4
    end

    -- Add extra shadow at GM level
    -- Icon is intentionally not increased
    if(target:getObjType() == tpz.objType.PC and target:getGMLevel() >= GMLEVEL_UTSUSEMI_NI_EXTRA_SHADOW) then 
        numShadows = numShadows + 1
        -- caster:PrintToPlayer(string.format("Shadows: %s", numShadows))
    end

    -- Auto remove higher tier Utsusemi
    if (effect ~= nil and effect:getPower() > 2 and target:getMod(tpz.mod.UTSUSEMI) < numShadows) then
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        effect = nil
    end

    if (effect == nil or effect:getPower() <= 2) then
        target:addStatusEffectEx(tpz.effect.COPY_IMAGE, icon, 2, 0, 900, 0, numShadows)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.COPY_IMAGE
end
