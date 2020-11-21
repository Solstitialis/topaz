---------------------------------------------------------------------------------------------------
-- func: nodamage
-- desc: Toggles god mode on the player, granting them several special abilities.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    if (player:getCharVar("GodMode") ~= 2) then
        -- Toggle GodMode on..
        player:setCharVar("GodMode", 2)

        -- Add bonus effects to the player..
        player:addStatusEffect(tpz.effect.PERFECT_DODGE, 1, 0, 0)
        player:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
        player:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO, 1, 0, 0)
        player:addStatusEffect(tpz.effect.REFRESH, 99, 0, 0)
        player:addStatusEffect(tpz.effect.REGEN, 99, 0, 0)

        -- Add bonus mods to the player..
        player:addMod(tpz.mod.RDEF, 2500)
        player:addMod(tpz.mod.DEF, 2500)
        player:addMod(tpz.mod.MDEF, 2500)

        -- Heal the player from the new buffs..
        player:addHP( 50000 )
        player:setMP( 50000 )
    elseif (player:getCharVar("GodMode") == 2) then
        -- Toggle GodMode off..
        player:setCharVar("GodMode", 0)

        -- Remove bonus effects..
        player:delStatusEffect(tpz.effect.PERFECT_DODGE)
        player:delStatusEffect(tpz.effect.INVINCIBLE)
        player:delStatusEffect(tpz.effect.ELEMENTAL_SFORZO)
        player:delStatusEffect(tpz.effect.REFRESH)
        player:delStatusEffect(tpz.effect.REGEN)

        -- Remove bonus mods..
        player:delMod(tpz.mod.RDEF, 2500)
        player:delMod(tpz.mod.DEF, 2500)
        player:delMod(tpz.mod.MDEF, 2500)
    end
end
