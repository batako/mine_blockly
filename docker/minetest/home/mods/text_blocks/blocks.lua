node_keys = {
  'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
  'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
  '0', '1','2','3','4','5','6','7','8','9'
}

for _, node_key in pairs(node_keys) do
  minetest.register_node("text_blocks:" .. node_key, {
    description = ("Block " .. node_key),
    tiles = {node_key:gsub("%l", string.upper):gsub("0", "O") .. ".png"},
    paramtype = "light",
    sunlight_propagates = true,
    light_source = 14,
    groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
    sounds = default.node_sound_stone_defaults(),
  })
end

minetest.register_node("text_blocks:empty", {
  description = ("Block empty"),
  tiles = {"empty.png"},
  paramtype = "light",
  sunlight_propagates = true,
  light_source = 14,
  groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3},
  sounds = default.node_sound_stone_defaults(),
})
