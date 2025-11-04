<%
%>
<div id="template_wizardFrame">
<%
_G.dofile("../page_mgr/wizard_page_deps/wizardFrame_refreshAction.lua")
%>
<script type="text/javascript">
<%
cgilua_lp.include("../template/commpage_status_comm.lp", getfenv(1))
%>
</script>
<%
cgilua_lp.include("../template/common_eventtriggering.lp", getfenv(1))
cgilua_lp.include("../template/wizardFrame_js.lp", getfenv(1))
%>
<div id="wizard_wrapper">
<div id="wizardTitle" class="wizardTitle">
<span id="span_stepBar"></span>
</div>
<div id="wizardContainer" class="wizardContainer">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div id="wizardChildPage" class="wizardChildPage">
<%
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local entryPage = wizardModuleMgr:getWizardEntryPage()
cgilua_lp.include("../page_mgr/wizard_page_deps/"..entryPage, getfenv(1))
%>
</div>
</div>
<div id="wizardSubmitArea" class="wizardSubmitArea">
</div>
</div>
</div>
