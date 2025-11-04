<script type="text/javascript">
<% if "98" == CountryCode then %>
(function(){
$(document).ready(function(){
$("[id^='BandsteerRssiLmt24G").show();
$("[id^='BandsteerRssiLmt5G").show();
});
})();
<%
end
%>
</script><script type="text/javascript">
<% if "2008" == CountryCode then %>
(function(){
$(document).ready(function(){
$("[id^='BsEnable']").attr("disabled","disabled");
$("[id^='BandsteerRssiLmt24G']").show();
$("[id^='BandsteerRssiLmt5G']").show();
});
})();
<%
end
%>
</script>
