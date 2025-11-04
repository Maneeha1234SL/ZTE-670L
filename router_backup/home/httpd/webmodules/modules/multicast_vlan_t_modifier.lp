<script type="text/javascript">
<%
local uRight = session_get(sess_id, "Right")
%>
var uRight = <%=uRight%>;
function softModify(e,subTemplate,b,c)
{
<% if env.getenv("CountryCode") == "68" then %>
$("[id^='PortViewName'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.BRIDGING.BR1.BRPORT13" )
{
$(this).hide();
}
});
<%end%>
}
$.subscribe("/some/softVersionModify", softModify);
</script>
