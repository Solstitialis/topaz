---------------------------------------------------------------------------------------------------
-- func: heal
-- desc: Restores all HP and MP to the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
};

function onTrigger(player)
    if (player:getHP() > 0) then
        player:setHP(9999);
        player:setMP(9999);
    end
end