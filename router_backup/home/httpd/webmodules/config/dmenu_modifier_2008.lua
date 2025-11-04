dmenu:addModifierLoader( function ()
dmenu:removeList({
menuList = {'remoteMgr'}
})
if dmenu:findMenu("mmTopology") ~= nil then
dmenu:newPage(
{
id="conntracks",
name=lang.Conntracks_001,
right=3,
pageHelp=lang.Conntracks_002,
extData=lang.publichelp,
areas={
{area="firewall_conntrack_t.lp", backendFile="firewall_conntrack_lua.lua"},
}
})
:insertAfter("l2tpStatus")
end
if dmenu:findMenu("rebootAndReset") ~= nil then
if dmenu:findMenu("rebootAndReset"):findArea("devmgr_restartmgr_t.lp") ~= nil then
dmenu:newArea({area="devmgr_ScheReboot_t.lp", backendFile={"devmgr_ScheReboot_lua.lua"},right=3})
:insertAfter("rebootAndReset", "devmgr_restartmgr_t.lp")
end
end
end)
