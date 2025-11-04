local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local fileutils = require"common_lib.file_utils"
local isFileExist = fileutils.isFileExist
local usermgr = require("user_mgr.usermgr_logic_impl")
local sessmgr = require("user_mgr.session_mgr")
local WizardPageMgrClass = class()
WizardPageMgrClass.getFramePageFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
if not usermgr:isLogined() then
return false
end
local viewFiles = {file="../template/wizardFrame_t.lp"}
return true, {viewFiles}, nil
end
WizardPageMgrClass.getStepPageFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
local stepPage = resourceTag
local refreshPage = "../template/NotFoundPage_reload.html"
local refreshFiles = {{file=refreshPage}}
if not usermgr:isLogined() then
return false, refreshFiles
end
local path = "../page_mgr/wizard_page_deps/"
local file = path .. stepPage
if not isFileExist(file) then
return false
end
sessmgr.UpdateCurrentSess()
return true, {{file=file}}, nil
end
WizardPageMgrClass.getDataFiles = function ( routerType, resourceTag )
g_logger:debug("routerType="..routerType)
if not usermgr:isLogined() then
return false
end
sessmgr.UpdateCurrentSess()
local file = ""
if resourceTag == "setshowflag" then
file = "../page_mgr/wizard_page_deps/wizard_setshowflag_lua.lua"
elseif resourceTag == "closeaction" then
file = "../page_mgr/wizard_page_deps/wizardFrame_closeAction.lua"
elseif resourceTag == "rebootaction" then
file = "../page_mgr/wizard_page_deps/wizardFrame_rebootAction.lua"
elseif resourceTag == "finishaction" then
file = "../page_mgr/wizard_page_deps/wizardFrame_finishAction.lua"
elseif resourceTag == "refreshaction" then
file = "../page_mgr/wizard_page_deps/wizardFrame_refreshAction.lua"
end
if _G.commConf.wizard[resourceTag] ~= nil then
file = "../page_mgr/wizard_page_deps/" .. _G.commConf.wizard[resourceTag]
end
return true, {{file=file}}, nil
end
local wizardPageMgr = WizardPageMgrClass()
return wizardPageMgr
