require "data_assemble.cmapi"
_G.ssidConf = {}
_G.ssidConf["BSDisableSSID"] = "DEV.WIFI.AP5"
_G.wanConf = {
selfCfgIP = "1,1,1,0",
requiredF = "1,1,1,1"
}
_G.lanConf = {}
_G.commConf = {
getEncode = true,
setEncode = true,
IntegCheck = true,
webEnable = true,
ValidateCode = false,
fwscServCtl = "",
fwPortServHidden = "",
oneWholePage = {},
wizard = {},
ChgpwdStrong = false,
passCanSee = "",
elementControl = {}
}
local cver = env.getenv("CountryCode")
local configFile = string.format("template/config_%s.lua",cver)
local configModule = string.format("template/config_%s",cver)
if cmapi.file_exists(configFile) == 1 then
require(configModule)
end
if _G.commConf.IntegCheck ~= true then
cmapi.set_webParams("IntegCheck", "false")
end
if _G.commConf.webEnable ~= true then
cmapi.set_webParams("webEnable", "false")
end
