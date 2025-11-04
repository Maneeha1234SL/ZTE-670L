<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("#DefRTInterface").attr("disabled",true);
$("#Btn_apply_RouteDefault").remove();
$("#Btn_cancel_RouteDefault").remove();
})();
<%
end
%>
</script>
