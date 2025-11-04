local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local json = require("common_lib.json")
wizardModuleMgr:setWizardShowFlag(true)
local cgilua = require("cgilua.cgilua")
cgilua.put( json.encode({need_refresh=true}) )
cgilua.contentheader ("application", "json; charset="..lang.CHARSET)
