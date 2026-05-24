
SMODS.Atlas{
    key = 'jokerpng',
    path = 'joker.png',
    px = 71,
    py = 95
}


SMODS.Joker {
    key = "joker1",
    atlas = "jokerpng",
    allow_duplicates = true,
    cost = 1,
    rarity = 1,
    pos = { x = 0, y = 0 }, 

    loc_txt = {
        name = 'DEATH FLUSH',

        text = {
            "when flush is scored add",
            '{X:mult,C:white}+#1#{} mult',
            "and increses mult,",
            '{X:mult,C:white} 1.25X',
            "and awards you",  
            '{C:money,}$#2#{}'
        },
    },

    config = {
        extra = {
            mult = 10,
            dollars = 10
        }
    },

  

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult,
                center.ability.extra.dollars
                
            }
        }
    end,
    
    calculate = function(self, card, context)
        if  context.joker_main and next(context.poker_hands['Flush']) then

             card.ability.extra.mult = card.ability.extra.mult * 1.25

            return {
                
                mult = card.ability.extra.mult,
                dollars = card.ability.extra.dollars,
                message = "UPGRADE",
                colour = G.C.RED
 
            }

        end
    end

    

 
}

-- Automatically spawns the card into your inventory at the start of a run
local game_start_ref = Game.start_run
function Game.start_run(self, args)
    game_start_ref(self, args) -- Run the game's normal startup logic first

    -- Check to make sure we aren't loading a saved challenge or tutorial state
    if not args.savestate then
        -- Create the card using your mod's prefix and key
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_xmpl_joker1', nil)
        
        -- Add it directly to your active Joker inventory area
        card:add_to_deck()
        G.jokers:emplace(card)
    end
end