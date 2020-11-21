---------------------------------------------------------------------------------------------------
-- func: sneak
-- desc: Adds Invisible, Sneak, and Deodorize with infinite duration to the player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    player:addStatusEffect(tpz.effect.INVISIBLE, 1, 0, 0)
    player:addStatusEffect(tpz.effect.SNEAK, 1, 0, 0)
    player:addStatusEffect(tpz.effect.DEODORIZE, 1, 0, 0)
end
