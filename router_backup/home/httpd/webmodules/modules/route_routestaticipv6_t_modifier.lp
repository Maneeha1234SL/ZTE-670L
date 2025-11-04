<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("[id*='StaticRoute']").attr("disabled",true);
$(".instDelete").remove();
$(".addInstBar").remove();
$("[id^='Btn_apply_StaticRoute']").remove();
$("[id^='Btn_cancel_StaticRoute']").remove();
})();
<%
end
%>
</script>
