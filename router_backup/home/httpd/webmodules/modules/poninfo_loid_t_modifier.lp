<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("#PonLoid").attr("disabled",true);
$("#LoidPasswd").attr("disabled",true);
$("#Btn_apply").remove();
$("#Btn_cancel").remove();
})();
<%
end
%>
</script>
