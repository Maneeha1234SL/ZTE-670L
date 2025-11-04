require "data_assemble.common_lua"
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local menuPageLogic = require("page_mgr.menu_page_logic")
local tError = {
IF_ERRORID = 0,
IF_ERRORTYPE = "SUCC",
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC"
}
tError = cmapi.dev_action({CmdId = "cmd_devrestart"})
local ErrorXML = outputErrorXML(tError)
local OutXML = ErrorXML
outputXML(OutXML)
