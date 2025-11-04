<script type="text/javascript">
</script>
<script type="text/javascript">
</script>
<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
$.unsubscribe("/some/SNTPModify");
function ctcSNTP(e,subTemplate,b,c)
{
$("#_DevCurrTime").text(currTimeNotSec.replace("T"," "));
var TimeValue = $('#CurrentLocalTime', subTemplate).val();
$("#CCurrentLocalTime").text(TimeValue.replace("T"," "));
$("#TipSntp",subTemplate).text("&?public_086;");
}
$.subscribe("/some/SNTPModify", ctcSNTP);
<%end%>
</script><script type="text/javascript">
$(document).ready(function(){
<% if CountryCode == "128" or CountryCode == "185" or CountryCode == "124" then %>
$("#LocalTimeZoneandName option[value='13']").text("&?Kama_Sntp_001;");
<%end%>
<% if CountryCode == "204" then %>
$("#LocalTimeZoneandName option[value='45']").text("&?Kama_Sntp_002;");
<%end%>
});
</script>
