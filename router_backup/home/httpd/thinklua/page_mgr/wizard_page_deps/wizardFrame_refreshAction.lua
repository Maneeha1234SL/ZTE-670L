require "data_assemble.common_lua"
require "page_mgr.wizard_page_deps.common_form_lua"
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1"
}
create_form_start("fSubmit", "")
create_ctrl_fields()
local pages = wizardModuleMgr:getWizardGraphConf()
for _, page in pairs(pages) do
local infos = page.info
local funcFile = infos.funcFile
local styleFile = infos.styleFile
if styleFile ~= "wizard_wlancfg1_t.lp" then
dofile ("../page_mgr/wizard_page_deps/"..funcFile)
tError = wizardOperation("GET")
if tError.IF_ERRORID ~= 0 then
end
end
end
output_form_error(tError)
create_form_end()
