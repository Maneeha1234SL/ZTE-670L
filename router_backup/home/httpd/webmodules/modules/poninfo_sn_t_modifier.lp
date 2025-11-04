<script>
<%
if env.getenv("CountryCode") == "173" and "2" == env.getenv("Right") then
%>
(function(){
$("#Pwd").attr("disabled",true);
$("#Btn_apply").remove();
$("#Btn_cancel").remove();
})();
<%
end
%>
</script><script>
<% if env.getenv("CountryCode") == "124" then %>
(function(){
$(document).ready(function(){
$("[for^='Pwd']").text("&?SN_Orang_004;");
});
})();
<%
end
%>
</script>
