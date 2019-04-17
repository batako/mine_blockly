local old_node_dig = minetest.node_dig

function minetest.node_dig(pos, node, digger)
    if(pos.y <= -5)then
       return
    else
       return old_node_dig(pos, node, digger)
    end
end

local old_node_punch= minetest.node_punch

function minetest.node_punch(pos, node, player, pointed_thing)
     return
end

local old_item_use = minetest.item_use

function minetest.item_use(itemstack, user, pointed_thing)
     return
end


local old_item_place = minetest.item_place

function minetest.item_place(itemstack, placer, pointed_thing, param2)

     if
       (string.sub(itemstack:get_name(),1,17) == "default:sign_wall") or
       (string.sub(itemstack:get_name(),1,8) == "flowers:") or
       (string.sub(itemstack:get_name(),1,13) == "default:torch") or
       (string.sub(itemstack:get_name(),1,13) == "default:grass") or
       (string.sub(itemstack:get_name(),1,8) == "mesecons") or
       (string.sub(itemstack:get_name(),1,23) == "default:mese_post_light")
     then
       return old_item_place(itemstack, placer, pointed_thing, param2)
     else
       return
     end
end


local old_item_drop = minetest.item_drop

function minetest.item_drop(itemstack, dropper, pos)
     return old_item_drop(itemstack, dropper, pos)
end
