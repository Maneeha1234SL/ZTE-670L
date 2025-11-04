<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("[id^='Alias:StaticRoute']").attr("disabled",true);
$("[id^='Interface:StaticRoute']").attr("disabled",true);
$(".ip").attr("disabled",true);
$(".instDelete").remove();
$(".addInstBar").remove();
$("[id^='Btn_apply_StaticRoute']").remove();
$("[id^='Btn_cancel_StaticRoute']").remove();
})();
<%
end
%>
</script><script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcIPv4StaticRoutingModify(e,subTemplate,b,c)
{
$("[id^='Interface:StaticRoute'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/softVersionModify", ctcIPv4StaticRoutingModify);
<% end %>
</script>
