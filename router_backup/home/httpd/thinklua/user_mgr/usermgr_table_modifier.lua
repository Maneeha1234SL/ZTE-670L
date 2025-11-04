local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if "21" == env.getenv("CountryCode") then
usermgrTableMgr:setUserMgrAttr("autofillUsername", "value", 2)
usermgrTableMgr:setUserMgrAttr("autofillPassword", "value", 2)
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "21" then
usermgrTableMgr:setUserMgrAttr("autofillUsername", "value", 4)
usermgrTableMgr:setUserMgrAttr("autofillPassword", "value", 4)
end
end)usermgrTableMgr:addModifier(function ()
end)usermgrTableMgr:addModifier(function ()
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "136" then
usermgrTableMgr:setUserMgrAttr("lockTimeout", "value", 600)
usermgrTableMgr:setUserMgrAttr("lockMaxTime", "value", 5)
end
end)local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "156" then
local function LoginCtr()
local accessPort = cgilua.servervariable("SERVER_PORT")
if accessPort==265 or accessPort==266 or accessPort==300 then
return 1
else
return 2
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", LoginCtr)
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value", "required")
usermgrTableMgr:setUserMgrAttr("userMax", "value", 25)
usermgrTableMgr:setUserMgrAttr("needAuth", "value", "LAN")
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "2009" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 1
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "79" then
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value","optional")
:setUserMgrAttr("chpwdMode", "opts",{typeofOptional="one-off"})
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "2008" then
usermgrTableMgr:setUserMgrAttr("lockMaxTime", "value", 5)
end
end)local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "154" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 5
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "68" then
local function isLogin()
local accessFrom = cmapi.IsWANAccess(cgilua.remote_addr)
if accessFrom == 2 then
return 0
else
return 1
end
end
usermgrTableMgr:setUserMgrAttr("userLevel", "func", isLogin)
end
end)
local cgilua = require("cgilua.cgilua")
usermgrTableMgr:addModifier(function ()
end)
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "128" or env.getenv("CountryCode") == "185" or env.getenv("CountryCode") == "204" then
usermgrTableMgr:setUserMgrAttr("chpwdMode", "value", "required")
end
end)local usermgrTableMgr = require("user_mgr.usermgr_table_mgr")
usermgrTableMgr:addModifier(function ()
if env.getenv("CountryCode") == "14" then
usermgrTableMgr:setUserMgrAttr("lockTimeout", "value", 1800)
end
end)
