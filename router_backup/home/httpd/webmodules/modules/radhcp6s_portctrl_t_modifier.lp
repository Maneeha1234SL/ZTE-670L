<script type="text/javascript">
<%
local uRight = session_get(sess_id, "Right")
%>
var uRight = <%=uRight%>;
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" then %>
if (uRight == "2")
{
$("#div_PortCtlRule_9",subTemplate).hide();
$("#div_PortCtlRule_5",subTemplate).hide();
}
$("#div_PortCtlRule_11",subTemplate).hide();
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script>
