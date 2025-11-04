<script type="text/javascript">
(function(){
function SeviceValueCombineOrSplit(ipmode,action,template)
{
var attrValue = "";
var serviceOption = {
};
if ( ipmode == "IPv4" )
{
$("input[type='checkbox']", "#ServiceControlList").each(function(){
attrValue = $(this).attr("serviceName");
serviceOption["Servise_"+attrValue] = attrValue;
});
}
else if ( ipmode == "IPv6" )
{
$("input[type='checkbox']", "#ServiceControlList6").each(function(){
attrValue = $(this).attr("serviceName");
serviceOption["Servise_"+attrValue] = attrValue;
});
}
if ( action == "Combine" )
{
var combinValue = "";
for ( var servTmp in serviceOption )
{
var servTmpOBJ = $("[id^='"+servTmp+":']",template);
servTmpOBJ.addClass("PostIgnore");
if ( servTmpOBJ && (servTmpOBJ.is(':checked')))
{
if(combinValue.length > 0)
{
combinValue = combinValue+",";
}
combinValue = combinValue + serviceOption[servTmp];
}
}
$("[id^='ServiceList:']",template).val(combinValue);
}
else if ( action == "Split" )
{
var cmpStr = $("[id^='ServiceList:']",template).val().split(",");
for ( var servTmp in serviceOption )
{
var splitValue = serviceOption[servTmp];
var IsMatch = false;
var servTmpOBJ = $("[id^='"+servTmp+"']",template);
for (var i in cmpStr)
{
if (cmpStr[i] == splitValue)
{
IsMatch = true;
break;
}
}
if (IsMatch )
{
servTmpOBJ.prop("checked", true);
}
else
{
servTmpOBJ.prop("checked", false);
}
}
}
else
{
}
}
function Customize_serviceCtl(paramsOBJ)
{
var ContainerOBJ = paramsOBJ["ContainerOBJ"];
ContainerOBJ.collapsibleInstTitleChange("Name");
SeviceValueCombineOrSplit("IPv4","Split",ContainerOBJ);
var ruleName = $("[id^='Name']", ContainerOBJ).val();
if ( 0 == ruleName.indexOf("_SC_") )
{
$(".Btn_delete", ContainerOBJ).remove();
$(".Btn_cancel,.Btn_apply", ContainerOBJ)
.attr("disabled","disabled")
.addClass("disableBtn");
$("input,select", ContainerOBJ).attr("disabled","disabled");
}
}
function initial_template_serviceCtl(templateID)
{
var template = $("#"+templateID);
jQuery.validator.addMethod("fwSCNamePrefix", function(value, element) {
return ( this.optional(element) || value.match(/^_SC_/) == null );
}, $.validator.format("<%=_G.encodeJS(lang.Security_084)%>"));
var IPCheckRules = {
"required": true,
"integer": true,
"range":[0,255]
};
template.bind("applyPromptCheckJSON", function(event, template){
var checkJSONTempObj = {
"groups": {
SrcIp: "sub_MinSrcIp0 sub_MinSrcIp1 sub_MinSrcIp2 sub_MinSrcIp3 sub_MaxSrcIp0 sub_MaxSrcIp1 sub_MaxSrcIp2 sub_MaxSrcIp3"
},
"rules": {
"Name:serviceCtl": {
"utf8": true,
"required": true,
"utf8LengthRange":[1,32],
"fwSCNamePrefix": true
},
"sub_MinSrcIp0": IPCheckRules,
"sub_MinSrcIp1": IPCheckRules,
"sub_MinSrcIp2": IPCheckRules,
"sub_MinSrcIp3": IPCheckRules,
"sub_MaxSrcIp0": IPCheckRules,
"sub_MaxSrcIp1": IPCheckRules,
"sub_MaxSrcIp2": IPCheckRules,
"sub_MaxSrcIp3": IPCheckRules
},
"messages": {
}
};
template.setPromptCheckJSON(checkJSONTempObj, template);
});
template.bind("fillDataByApplyResult", function(event,xml, template){
ActionByApplyResult(xml, template, "Name");
});
template.bind("fillDataByCancelResult", function(event,xml, template){
var OBJID = ["OBJ_FWSC_ID"];
ActionByCancelResult(xml, template, OBJID);
template.trigger("fillDataByCustom",[0, template, xml]);
});
template.bind("fillDataByCustom", function(event, suffix, ContainerOBJ, xml){
var CustomizeParams = {
"ContainerOBJ":ContainerOBJ
};
Customize_serviceCtl(CustomizeParams);
});
template.bind("hiddenValueChangeByCustom", function(event,template){
var WanOptionJSON = {
"INCName":"INCViewName"
};
for ( var WanOptionTmp in WanOptionJSON )
{
var WanOption = $("[id^='"+WanOptionJSON[WanOptionTmp]+"']",template);
var valueTmp = $("option:selected",WanOption).text();
$("[id^='"+WanOptionTmp+"']",template).val(valueTmp);
}
SeviceValueCombineOrSplit("IPv4","Combine",template);
});
}
$(document).ready(function(){
var HeadID = "serviceCtl";
var Head = $("#"+HeadID);
var templateID = "template_"+ HeadID;
var ServerAddr = $("address span", Head).text();
initial_template_serviceCtl(templateID);
Head.succfunction = function(xml){
Head.hasError(xml,"externErrorHint");
var FWIPOBJ = $(xml).find("OBJ_FWSC_ID");
var RuleNum = $("Instance", FWIPOBJ).length;
var OBJID = ["OBJ_FWSC_ID"];
Head.createPageDataByClone(RuleNum,OBJID,xml);
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
});
})();
</script>
