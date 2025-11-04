require "page_mgr.wizard_page_deps.common_form_lua"
function wizardOperation(operation)
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local MNames =
{
"OBJ_WLANAP_ID",
"OBJ_WLANSETTING_ID",
"OBJ_WLANPSK_ID"
};
local MPrefixs =
{
"AP_",
"SET_",
"PSK_"
};
local MPara_AP = {
"Enable",
"ESSID",
"BeaconType",
"WPAAuthMode",
"WPAEncryptType",
"11iAuthMode",
"11iEncryptType"
};
local MPara_SET = {
"RadioStatus"
};
local PSK = {
"KeyPassphrase"
};
local MPara_PSK = {}
MPara_PSK.para = PSK
MPara_PSK.encrypt = {"KeyPassphrase"}
local MParas = {
MPara_AP,
MPara_SET,
MPara_PSK
};
if operation == "SET" then
tError = ModuleAction(MPrefixs, MParas);
return tError;
else
tError = ModuleOutput(MNames, MPrefixs, MParas);
create_hidden_input("hidden_EncryptionType","");
create_hidden_input("hidden_EncryptionType5G","");
return tError;
end
return tError
end
