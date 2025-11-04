dmenu:addModifierLoader( function ()
local sipslc = dmenu:findMenu("sipslc")
if sipslc then
dmenu:newArea({area="Columbia_voip_slctime_t.lp", backendFile="voip_slctime_lua.lua", right=1}):appendTo("sipslc")
end
dmenu:removeList({
menuList = {
'wifibandsteer'
},
})
dmenu:replaceArea({
{
"localNetStatus",
"wlan_wlanstatus_t.lp",
"claro_wlan_wlanstatus_t.lp",
"claro_wlan_wlanstatus_lua.lua"
}
})
dmenu:newPage(
{
id="localNetGuestwifi",
name=lang.GuestWifi_04,
right=3,
pageHelp=lang.GuestWifi_05,
areas={
{area="claro_wlan_guestwifi_t.lp", backendFile="claro_wlan_guestwifi_lua.lua"},
}
})
:insertAfter("wlanBasic")
if dmenu:findMenu("ddns") ~= nil then
dmenu:newPage({
id="TimerMACFilter",
right=0,
name=lang.TimerMACFilter_003,
pageHelp=lang.TimerMACFilter_002,
areas={
{area="timer_mac_filter_model.lua"},
{area="timer_mac_filter_rules_t.lp", backendFile="timer_mac_filter_rules_lua.lua"},
},
})
:insertBefore("ddns")
end
end)
