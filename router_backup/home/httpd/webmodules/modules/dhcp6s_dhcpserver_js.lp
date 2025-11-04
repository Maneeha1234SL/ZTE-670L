<script type="text/javascript">
(function () {
function initial_template_IPv6DHCPServer(templateID)
{
var template = $("#"+templateID);
var instForm = template.find("form");
instForm.validate({
"rules": {
"DnsRefreshTime": {
"required": true,
"integer": true,
"range":[600, 4294967295]
},
"DNSAddr1": {
"banValue": ["::"],
"IPv6Addr": true
},
"DNSAddr2": {
"banValue": ["::"],
"IPv6Addr": true
},
"DNSAddr3": {
"banValue": ["::"],
"IPv6Addr": true
}
},
"messages": {
}
});
var Btn_PrefixUpd = $("#Btn_PrefixUpd_IPv6DHCPServer", template);
Btn_PrefixUpd.unbind("click");
Btn_PrefixUpd.click(function(){
var PrefixPoolHead = $("#PrefixPool");
var SelfHead = $(this).parents(".HeadDIV");
var IANAManualPrefixes = $("#IANAManualPrefixes", SelfHead).val();
$("#Btn_PrefixPool", PrefixPoolHead).trigger("click",[IANAManualPrefixes]);
var PrefixContent = $("#PrefixPool_container",PrefixPoolHead).html();
$("#DHCPPrefixZone",SelfHead).html(PrefixContent);
});
$("[id^='ManualDNSEnable'][type='radio']",template).each(function(){
$(this).click(function(){
var radioChangeOBJ = $(this);
var ContainerOBJ = radioChangeOBJ.parents("[id^='template_']");
if ( radioChangeOBJ.val() == "1" )
{
$("#div_dnsGroup", ContainerOBJ).showIt(true);
$("#div_Ipv6DnsOrigin",ContainerOBJ).hide();
$("#Ipv6DnsOrigin").addClass("PostIgnore");
}
else
{
$("#div_dnsGroup", ContainerOBJ).showIt(false);
$("#div_Ipv6DnsOrigin",ContainerOBJ).show();
$("#Ipv6DnsOrigin",ContainerOBJ).removeClass("PostIgnore");
}
})
});
$("[id^='PrefixMode:']",template).change(function(){
var template = $("#template_IPv6DHCPServer");
var PrefixModeVal = $(this).val();
var PrefixModeTrans = {
"Auto" : false,
"Manual" : true,
"Disabled" : false
};
if( PrefixModeTrans[PrefixModeVal] == undefined )
{
PrefixModeVal = "Auto";
}
$("#DHCPPrefixZone",template).showIt(PrefixModeTrans[PrefixModeVal]);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var PrefixMode = $("[id^='PrefixMode:']",template).val();
var IANAEnableOBJ = $("[id^='IANAEnable']",template);
var IsPrefixAutoModeOBJ = $("[id^='IsPrefixAutoMode']",template);
var IANAManualPrefixesOBJ = $("[id^='IANAManualPrefixes']",template);
var PrefixModeTrans = {
"Auto" : {"IANAEnable": 1, "IsPrefixAutoMode" : 1, "IANAManualPrefixes": false},
"Manual" : {"IANAEnable": 1, "IsPrefixAutoMode" : 0, "IANAManualPrefixes": true},
"Disabled" : {"IANAEnable": 0, "IsPrefixAutoMode" : 0, "IANAManualPrefixes": false}
};
IANAEnableOBJ.val(PrefixModeTrans[PrefixMode]["IANAEnable"]);
IsPrefixAutoModeOBJ.val(PrefixModeTrans[PrefixMode]["IsPrefixAutoMode"]);
if (PrefixModeTrans[PrefixMode]["IANAManualPrefixes"])
{
IANAManualPrefixesOBJ.removeClass("PostIgnore");
var DHCPPrefixZone = $("#DHCPPrefixZone",template);
var PrefixChosedArr = [];
var PrefixChosedNum = 0;
$("[id^='template_PrefixPool_']",DHCPPrefixZone).each(function(){
var PrefixPool = $(this);
var IsDelegation = $("[id^='IsDelegation']",PrefixPool);
var InstViewName = $("[id^='PrefixPoolInst']",PrefixPool).val();
if (IsDelegation.is(':checked'))
{
PrefixChosedArr[PrefixChosedNum] = InstViewName;
PrefixChosedNum = PrefixChosedNum + 1;
}
});
var PrefixChosedStr = PrefixChosedArr.join(",");
IANAManualPrefixesOBJ.val(PrefixChosedStr);
}
else
{
IANAManualPrefixesOBJ.addClass("PostIgnore");
}
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var IANAEnable = $("[id^='IANAEnable']",ContainerOBJ).val();
var IANAManualPrefixes = $("[id^='IANAManualPrefixes']",ContainerOBJ).val();
var PrefixModeOBJ = $("[id^='PrefixMode:']",ContainerOBJ);
var PrefixModeTrans = {
"Auto" : {"IANAEnable": (1==IANAEnable), "ManualPreResult" : (IANAManualPrefixes == "")},
"Manual" : {"IANAEnable": (1==IANAEnable), "ManualPreResult" : (IANAManualPrefixes != "")},
"Disabled" : {"IANAEnable": (0==IANAEnable), "ManualPreResult" : true}
};
for (var PrefixMode in PrefixModeTrans)
{
if (PrefixModeTrans[PrefixMode]["IANAEnable"]
&& PrefixModeTrans[PrefixMode]["ManualPreResult"])
{
PrefixModeOBJ.val(PrefixMode);
break;
}
}
$("[id^='PrefixMode:']",ContainerOBJ).change();
$.publish("/some/Ipv6Prefix", [ContainerOBJ]);
$("#Btn_PrefixUpd_IPv6DHCPServer", ContainerOBJ).click();
$("[name='ManualDNSEnable']:checked", ContainerOBJ).click();
});
template.bind("fillDataByApplyResult", function(event, xml, template){
if (ActionByApplyResult(xml, template) == 0)
{
var OBJID = ["OBJ_DHCP6S_ID","OBJ_LANDNS_ID"];
g_ChanegeDataByCustom(xml);
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0,template]);
}
});
template.bind("fillDataByCancelResult", function(event, xml, template){
var OBJID = ["OBJ_DHCP6S_ID","OBJ_LANDNS_ID"];
g_ChanegeDataByCustom(xml);
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0,template]);
});
}
function g_ChanegeDataByCustom(xml)
{
var OBJ = $(xml).find("OBJ_LANDNS_ID");
var instances = $("Instance ", OBJ);
instances.each(function(){
var inst = $(this);
inst.find("ParaName").each(function(){
var ParaName = $(this).text();
if ( ParaName == "_InstID" )
{
$(this).text("_InstID_DNS");
}
});
});
}
$(document).ready(function(){
var HeadID = "IPv6DHCPServer";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_IPv6DHCPServer(templateID);
Head.succfunction = function(xml){
var HeadID = Head.attr("id");
g_ChanegeDataByCustom(xml);
var template = $("[id^='template_" + HeadID + "']", Head);
$.publish("/some/Ipv6DnsControlA", [template]);
Head.hasError(xml,"externErrorHint");
var OBJID = ["OBJ_DHCP6S_ID","OBJ_LANDNS_ID"];
Head.fillDataByOBJID(xml ,OBJID, template, 0);
template.trigger("fillDataByCustom",[0,template]);
};
if ( $(".collapBarWithDataTrans",Head).length <= 0 )
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction);
}
else
{
initial_collapBarWithDataTrans(Head);
}
var Btn_SelfUpd = $("#Btn_SelfUpd_IPv6DHCPServer", Head);
Btn_SelfUpd.unbind("click");
Btn_SelfUpd.click(function(){
var ServerAddr = $("address span", Head).text();
if ( $(".collapBarWithDataTrans",Head).length > 0
&& $("#DataHasBeenGot",Head).val() == 0)
{
}
else
{
Head.dataTransfer(ServerAddr,
"GET",
Head.succfunction,
Head.failfunction,
false,
false);
}
});
});
})();
</script>
