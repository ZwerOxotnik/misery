--custom_controls.lua

-- 'consuming'
-- available options:
-- none: default if not defined
-- all: if this is the first input to get this key sequence then no other inputs listening for this sequence are fired
-- script-only: if this is the first *custom* input to get this key sequence then no other *custom* inputs listening for this sequence are fired. Normal game inputs will still be fired even if they match this sequence.
-- game-only: The opposite of script-only: blocks game inputs using the same key sequence but lets other custom inputs using the same key sequence fire.
    
data:extend({
  {
    type = "custom-input",
    name = "f-a-c-t-o-r-i-o_Inventory_key",
    key_sequence = "I",
    consuming = "game-only"
  },
  {
    type = "custom-input",
    name = "f-a-c-t-o-r-i-o_PDA_main_key",
    key_sequence = "E",
    consuming = "game-only"
  },
  {
    type = "custom-input",
    name = "f-a-c-t-o-r-i-o_PDA_map_key",
    key_sequence = "M",
    consuming = "game-only"
  },
  {
    type = "custom-input",
    name = "f-a-c-t-o-r-i-o_PDA_quests_key",
    key_sequence = "J",
    consuming = "game-only"
  },
  {
    type = "custom-input",
    name = "f-a-c-t-o-r-i-o_PDA_encyclopedia_key",
    key_sequence = "B",
    consuming = "game-only"
  },
})