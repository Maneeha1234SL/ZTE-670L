<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("[id^='Alias:PolicyRoute']").attr("disabled",true);
$("[id^='DestInterface']").attr("disabled",true);
$("[id^='Protocol']").attr("disabled",true);
$(".ip").attr("disabled",true);
$(".mac").attr("disabled",true);
$(".instDelete").remove();
$("[id^='Btn_apply_PolicyRoute']").remove();
$("[id^='Btn_cancel_PolicyRoute']").remove();
})();
<%
end
%>
</script><script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcIPv4PolicyRoutingModify(e,subTemplate,b,c)
{
$("[id^='DestInterface'] option",subTemplate).each(function(){
if( $(this).val() == "DEV.IP.IF3" || $(this).val() == "DEV.IP.IF5" || $(this).val() == "DEV.IP.IF6")
{
$(this).remove();
}
});
}
$.subscribe("/some/softVersionModify", ctcIPv4PolicyRoutingModify);
<% end %>
</script>
