<script>
<%
if env.getenv("CountryCode") == "48" then
%>
(function(){
$(document).ready(function(){
$("#PortLocateFormat").attr("disabled","disabled");
$("#DHCPv6Enable").parent().parent().remove();
});
})();
<%
end
%>
</script>
