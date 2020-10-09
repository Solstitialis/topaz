---------------------------------------------------------------------------------------------------
-- func: levelsyncoff
-- desc: Turns off level sync
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
};

function onTrigger(player)
    if(player:hasStatusEffect(tpz.effect.LEVEL_SYNC) == true and player:hasStatusEffect(tpz.effect.BATTLEFIELD) == false) then
        player:levelRestriction(0);
        player:disableLevelSync();
    end
end