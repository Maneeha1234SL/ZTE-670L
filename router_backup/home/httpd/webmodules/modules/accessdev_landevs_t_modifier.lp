<script type="text/javascript">
<% if env.getenv("CountryCode") == "156" then %>
function ctcLANFilterModify(e,xmlModify,b,c)
{
var AccessObj = $("OBJ_ACCESSDEV_ID",xmlModify);
$("Instance",AccessObj).each(function(){
var inst = $(this);
var AliasName = "";
$("ParaName",inst).each(function(){
var curr = $(this);
if(curr.text() == "AliasName")
{
AliasName = curr.next().text();
return false;
}
});
if(AliasName.indexOf("SSID") != -1 )
{
inst.remove();
}
});
}
$.subscribe("/some/xmlchange", ctcLANFilterModify);
<% end %>
</script>
