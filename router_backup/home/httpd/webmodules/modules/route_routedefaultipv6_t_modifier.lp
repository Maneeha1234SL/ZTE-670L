<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("#DefRTInterface").attr("disabled",true);
$("#Btn_apply_RouteDefaultIpv6").remove();
$("#Btn_cancel_RouteDefaultIpv6").remove();
})();
<%
end
%>
</script>
