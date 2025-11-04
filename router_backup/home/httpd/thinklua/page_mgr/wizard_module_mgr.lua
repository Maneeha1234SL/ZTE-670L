local oopclass = require("common_lib.oop_class")
local class = oopclass.class
local assertlib = require("common_lib.assert_utils")
local typeAssert = assertlib.typeAssert
local valueAssert = assertlib.valueAssert
local cgilua = require("cgilua.cgilua")
local sessmgr = require("user_mgr.session_mgr")
local WizardModuleMgrClass = class()
WizardModuleMgrClass.__loadWizardGraphConf = function (self, confPath)
typeAssert(confPath, "string")
local wizardGraphConf = require(confPath)
self.wizardGraphConf = wizardGraphConf
return wizardGraphConf
end
WizardModuleMgrClass.__setDefaultShowFlag = function (self)
local IsAutoShowWizard = nil
local t = cmapi.getinst("OBJ_USERIF_ID", "")
if type(t) == "table" then
IsAutoShowWizard = t.IsAutoShowWizard
end
local needShowWizard = nil
if IsAutoShowWizard == "1" then
needShowWizard = "y"
else
needShowWizard = "n"
end
sessmgr.SetCurrentSessAttr("needShowWizard", needShowWizard)
end
WizardModuleMgrClass.initialize = function ( self, confPath )
local needShowWizard = sessmgr.GetCurrentSessAttr("needShowWizard")
if needShowWizard == nil then
self:__setDefaultShowFlag()
self:__loadWizardGraphConf(confPath)
end
end
WizardModuleMgrClass.setWizardShowFlag = function (self, flag)
typeAssert(flag, "boolean")
local needShowWizard = nil
if flag then
needShowWizard = "y"
else
needShowWizard = "n"
end
sessmgr.SetCurrentSessAttr("needShowWizard", needShowWizard)
end
WizardModuleMgrClass.needShowWizard = function (self)
local needShowWizard = sessmgr.GetCurrentSessAttr("needShowWizard");
local right = sessmgr.GetCurrentSessAttr("login_right");
if needShowWizard == "y" and right == "2" then
return true
else
return false
end
end
WizardModuleMgrClass.__clearWizardPushFlag = function (self)
local tabResult = cmapi.getinst("OBJ_USERIF_ID", "")
local IsAutoShowWizard = tabResult.IsAutoShowWizard
if IsAutoShowWizard == "1" then
local tData = {IsAutoShowWizard=0}
cmapi.nocsrf.setinst("OBJ_USERIF_ID", "", tData)
end
end
WizardModuleMgrClass.clearWizardContext = function (self)
sessmgr.SetCurrentSessAttr("needShowWizard", "n")
sessmgr.UnsetCurrentSessAttr("wizardVisitedPages")
end
WizardModuleMgrClass.getWizardGraphConf = function (self)
return self.wizardGraphConf
end
WizardModuleMgrClass.getWizardEntryPage = function (self)
local wizardGraphConf = self:getWizardGraphConf()
for _,page in pairs(wizardGraphConf) do
if true == page.isBeginning then
return page.info.styleFile
end
end
g_logger:warn("wizard graph not set isBeginning")
return nil
end
WizardModuleMgrClass.convertConf2JSArray = function (self)
local wizardGraphConf = self:getWizardGraphConf()
local jsStrTab = {}
table.insert(jsStrTab, "var wizardGraphConf = [];")
for pName,page in pairs(wizardGraphConf) do
local pageArrHead = "wizardGraphConf['"..pName.."']"
local pageArr = pageArrHead.." = [];"
table.insert(jsStrTab, pageArr)
local infosArr = pageArrHead.."['info'] = [];"
table.insert(jsStrTab, infosArr)
for infoName,infoVal in pairs(page.info) do
local infoEle = pageArrHead.."['info']['"..infoName.."'] = '".. infoVal .."';"
table.insert(jsStrTab, infoEle)
end
local successorsArr = pageArrHead.."['successor'] = [];"
table.insert(jsStrTab, successorsArr)
for i,successor in pairs(page.successor) do
local successorEle = pageArrHead.."['successor']['"..(i-1).."'] = '".. successor .."';"
table.insert(jsStrTab, successorEle)
end
if true == page.isBeginning then
local isBeginningArr = pageArrHead.."['isBeginning'] = true;"
table.insert(jsStrTab, isBeginningArr)
end
end
local jsStr = table.concat(jsStrTab)
return jsStr
end
local wizardModuleMgr = WizardModuleMgrClass()
return wizardModuleMgr
