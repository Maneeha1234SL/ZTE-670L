<%
require "data_assemble.common_lua"
cgilua_lp.include("../page_mgr/wizard_page_deps/wizard_start_js.lp", getfenv(1))
%>
<form class="formForValidate">
<div id="welcomeHint" class="welcomeHint emFont">
&?wizardStart_001;
</div>
<p class="wizardIntroP">
&?wizardStart_002;
</p>
</form>
