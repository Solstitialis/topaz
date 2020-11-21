---------------------------------------------------------------------------------------------------
-- func: heal
-- desc: Restores all HP and MP to the player and pet
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
};

function onTrigger(player)
    if (player:getHP() > 0) then
        player:setHP(9999);
        player:setMP(9999);

        local pet = player:getPet()
        if pet then
            pet:setHP(9999)
            pet:setMP(9999)
        end
    end
end