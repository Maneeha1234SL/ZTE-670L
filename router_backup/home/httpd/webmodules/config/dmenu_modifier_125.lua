dmenu:addModifierLoader( function ()
if env.getenv("CountryCode") == "125" then
dmenu:newArea({area="trunkmode_t.lp", backendFile="trunkmode_lua.lua", right=1}):insertAfter("portBinding", "portbinding_t.lp")
end
end)
