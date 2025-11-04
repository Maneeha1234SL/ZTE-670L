require "page_mgr.wizard_page_deps.common_form_lua"
require "data_assemble.common_lua"
function wizardOperation(operation)
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local MPara_PPP = {
"UserName",
"Password"
};
local FP_OBJNAME = "OBJ_QUICK_SETUP_ID"
local function decodePass(inputStr)
local decodePass = ""
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.cgilua.POST.encode)
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
if inputStr ~= nil and string.len(inputStr) > 0 then
decodePass = cmapi.nocsrf.aes_decrypt(inputStr, key, iv)
if decodePass == strpass then
decodePass = nil
end
end
return decodePass
end
if operation == "SET" then
local t_Data = {}
if decodePass(cgilua.cgilua.POST.hidden_InternetPassword) ~= nil then
t_Data.Password = decodePass(cgilua.cgilua.POST.hidden_InternetPassword)
end
t_Data.UserName = cgilua.cgilua.POST.hidden_InternetUserName
tError = cmapi.setinst(FP_OBJNAME, "DEV.IP.IF3", t_Data)
else
tError = cmapi.getinst(FP_OBJNAME, "DEV.IP.IF3")
create_hidden_input("hidden_InternetUserName",tError["UserName"]);
create_hidden_input("hidden_InternetPassword","						", 1);
end
return tError;
end
