-----------------------------------------
-- Spell: Utsusemi: San
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
    local numShadows = 5 + target:getMod(tpz.mod.UTSUSEMI_BONUS)

    -- Add extra shadow at GM level    
    if(target:getObjType() == tpz.objType.PC and target:getGMLevel() >= GMLEVEL_UTSUSEMI_SAN_EXTRA_SHADOW) then 
        numShadows = numShadows + 1
        -- caster:PrintToPlayer(string.format("Shadows: %s", numShadows))
    end

    if (effect == nil or effect:getPower() <= 3) then
        target:addStatusEffectEx(tpz.effect.COPY_IMAGE, tpz.effect.COPY_IMAGE_4, numShadows, 0, 900, 0, numShadows)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.COPY_IMAGE
end
