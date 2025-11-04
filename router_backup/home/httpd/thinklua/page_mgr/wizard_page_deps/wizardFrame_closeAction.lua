require "data_assemble.common_lua"
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local menuPageLogic = require("page_mgr.menu_page_logic")
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
wizardModuleMgr:clearWizardContext()
local cgilua = require("cgilua.cgilua")
local redirectPage = cgilua.POST.IF_CLOSE_REDIRECTPAGE
if nil ~= redirectPage and "" ~= redirectPage then
menuPageLogic:changeCurrentPage(redirectPage)
end
local ErrorXML = outputErrorXML(tError)
local OutXML = ErrorXML
outputXML(OutXML)
