<%
%>
<div id="SummarizeDiag" class="HeadDIV">
<h1 class="collapsibleBar" id="SummarizeDiagBar">&?DiagnosisManag_001;</h1>
<div id="SummarizeDiag_container" style="display:none;">
<div class="sceneTip">
<div id="sceneTip1" class="sceneTipLink"><a>&?DiagnosisManag_042;</a></div>
<div class="sceneTip_container">
<p>&?DiagnosisManag_040;</p>
<p>&?DiagnosisManag_041;</p>
<p class="sceneTip_close"><a>&?public_020;</a></p>
</div>
</div>
<%
cgilua_lp.include("../../webmodules/modules/networkdiag_ping_t.lp", getfenv(1))
cgilua_lp.include("../../webmodules/modules/networkdiag_ping_js.lp", getfenv(1))
if "41" ~= env.getenv("CountryCode") or "2" ~= session_get(sess_id, "Right") then
cgilua_lp.include("../../webmodules/modules/networkdiag_traceroute_t.lp", getfenv(1))
cgilua_lp.include("../../webmodules/modules/networkdiag_traceroute_js.lp", getfenv(1))
if "108" ~= env.getenv("CountryCode") then
cgilua_lp.include("../../webmodules/modules/networkdiag_svcsimulation_t.lp", getfenv(1))
cgilua_lp.include("../../webmodules/modules/networkdiag_svcsimulation_js.lp", getfenv(1))
end
end
%>
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
var Head = $("#SummarizeDiag");
$("#SummarizeDiagBar", Head).click();
});
</script>
