<script type="text/javascript">
<%
local uRight = session_get(sess_id, "Right")
%>
var uRight = <%=uRight%>;
function megasoftModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" then %>
if (uRight == "2")
{
$("#div_MulticastAddressRule_9",subTemplate).hide();
$("#div_MulticastAddressRule_5",subTemplate).hide();
}
$("#div_MulticastAddressRule_11",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", megasoftModify);
</script>
