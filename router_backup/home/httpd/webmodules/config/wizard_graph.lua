local wizardGraphConf =
{
CSPWAN = {
info = {
styleFile="wizard_wancfg_t.lp",
funcFile="wizard_wancfg_lua.lua",
},
successor = {
"wizard_wlancfg_t.lp"
},
isBeginning = true;
},
CSPWLAN = {
info = {
styleFile="wizard_wlancfg_t.lp",
funcFile="wizard_wlancfg_lua.lua",
},
successor = {
"wizard_wlancfg1_t.lp"
}
},
CSPWLAN1 = {
info = {
styleFile="wizard_wlancfg1_t.lp",
funcFile="wizard_wlancfg_lua.lua",
},
successor = {
"wizard_over_t.lp"
}
},
congratulationPage = {
info = {
styleFile="wizard_over_t.lp",
funcFile="wizard_over_lua.lua",
},
successor = {
nil
}
}
}
return wizardGraphConf
