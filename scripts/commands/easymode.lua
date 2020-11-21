---------------------------------------------------------------------------------------------------
-- func: easymode
-- desc: Toggles god mode on the player, granting them several special abilities.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function onTrigger(player)
    if (player:getCharVar("GodMode") ~= 3) then
        -- Toggle GodMode on..
        player:setCharVar("GodMode", 3)

        -- Add bonus effects to the player..
        player:addStatusEffect(tpz.effect.REFRESH, 1, 0, 0)
        player:addStatusEffect(tpz.effect.REGEN, 2, 0, 0)
    elseif (player:getCharVar("GodMode") == 3) then
        -- Toggle GodMode off..
        player:setCharVar("GodMode", 0)

        -- Remove bonus effects..
        player:delStatusEffect(tpz.effect.REFRESH)
        player:delStatusEffect(tpz.effect.REGEN)
    end
end
