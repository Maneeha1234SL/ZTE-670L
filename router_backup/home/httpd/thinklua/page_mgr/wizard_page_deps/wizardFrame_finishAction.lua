require "data_assemble.common_lua"
require "page_mgr.wizard_page_deps.common_form_lua"
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local menuPageLogic = require("page_mgr.menu_page_logic")
local cgilua = require("cgilua.cgilua")
local wizardPath = cgilua.POST.IF_WIZARDPATH;
g_logger:debug("wizardPagePath="..wizardPath)
if nil == wizardPath or "" == wizardPath then
return;
end
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
local pages = wizardModuleMgr:getWizardGraphConf()
local setFailedStyleFile = ""
for _, page in pairs(pages) do
local infos = page.info
local funcFile = infos.funcFile
local styleFile = infos.styleFile
if styleFile ~= "wizard_wlancfg1_t.lp" then
if string.find(wizardPath, styleFile) then
g_logger:debug("styleFile("..styleFile..")'s lua ModuleSet is executing.")
dofile ("../page_mgr/wizard_page_deps/"..funcFile)
tError = wizardOperation("SET")
if tError.IF_ERRORID ~= 0 then
g_logger:warn("page("..funcFile..") set fail.")
setFailedStyleFile = styleFile
break
end
end
end
end
if tError.IF_ERRORID == 0 then
wizardModuleMgr:clearWizardContext()
local redirectPage = cgilua.POST.IF_FINISH_REDIRECTPAGE
if nil ~= redirectPage and "" ~= redirectPage then
g_logger:debug("redirectPage="..redirectPage)
menuPageLogic:changeCurrentPage(redirectPage)
end
end
local ERRPAGEXML = getXMLNodeEntity("IF_ERRORPAGE", setFailedStyleFile);
local ErrorXML = outputErrorXML(tError)
local OutXML = ErrorXML .. ERRPAGEXML
outputXML(OutXML)
