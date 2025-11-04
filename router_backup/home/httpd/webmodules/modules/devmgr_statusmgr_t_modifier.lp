<script type="text/javascript">
<%
if "77" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("#div_CpuUse").showIt(true);
});
})();
<%
end
%>
</script><script type="text/javascript">
<%
if env.getenv("CountryCode") == "1" then
%>
function SNToUpper(e,subTemplate,b,c)
{
var SNText = $("#SerialNumber",subTemplate).text();
var SNSplit = SNText.split('-');
SNText = SNSplit[1].toUpperCase();
$("#SerialNumber",subTemplate).html(SNText);
}
$.unsubscribe("/some/SNShow");
$.subscribe("/some/SNShow", SNToUpper);
<%
end
%>
</script>
<script type="text/javascript">
<% if "39" == CountryCode then %>
(function(){
$(document).ready(function(){
$("#div_CpuUse,#div_MemUse").showIt(true);
});
})();
<% end %>
</script><script>
<%
local sess_id = cgilua.getCurrentSessID()
local uRight = session_get(sess_id, "Right")
if "68" == env.getenv("CountryCode") and uRight == "2" then
%>
(function(){
$(document).ready(function(){
$("#div_HardwareVer").hide();
$("#div_SoftwareVer").hide();
$("#div_BootVer").hide();
return;
});
})();
<%
end
%>
</script>
<script type="text/javascript">
<% if env.getenv("CountryCode") == "131" then %>
$(document).ready(function(){
<%
local retTable = nil
local Sn
retTable = cmapi.getinst("OBJ_SN_INFO_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
Sn = retTable["Sn"]
end
%>
$("#div_BootVer").after("<div id='div_Ponsn' class='colorTblRow' ><span class='w250 emFont' title='&?StatusManag_ponsn;'>&?StatusManag_ponsn;</span><span class='w250' id='ponsn' title='<%=Sn%>'><%=Sn%></span></div>")
$("#SerialNumber").parent().hide();
return;
});
<% end %>
</script><script type="text/javascript">
<% if CountryCode == "120" then %>
$(document).ready(function(){
<%
local retTable = nil
local Sn
retTable = cmapi.getinst("OBJ_SN_INFO_ID", "")
if type(retTable) ~= "table" then
g_logger:warn("retTable is not a table!")
end
if retTable.IF_ERRORID == 0 then
Sn = string.upper(retTable["Sn"])
end
%>
$.addModifier("ManagStatus/paramsCtr",function(data){
$("#SerialNumber").html("<%=Sn%>")
})
return;
});
<% end %>
</script><script type="text/javascript">
<%
if "2008" == env.getenv("CountryCode") then
%>
(function(){
$(document).ready(function(){
$("#div_CpuUse").showIt(true);
$("#div_MemUse").showIt(true);
$("#div_Time").showIt(true);
$("#PoweronTime").prev().text("&?ftp_systemUp_001;");
});
})();
<%
end
%>
</script>
