<script language="javascript">
<%
local sess_id = cgilua.getCurrentSessID()
local token = cmapi.nocsrf.tokenRandom()
session_set(sess_id, "sess_token", token)
local wizardModuleMgr = require "page_mgr.wizard_module_mgr"
local jsArray = wizardModuleMgr:convertConf2JSArray()
cgilua.put(jsArray)
%>
function randomNum(n){
var t='';
for(var i=0;i<n;i++)
{
t+=Math.floor(Math.random()*10);
}
return t;
}
function asyEncode(srcStr)
{
var pubKey = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAodPTerkUVCYmv28SOfRV\n7UKHVujx/HjCUTAWy9l0L5H0JV0LfDudTdMNPEKloZsNam3YrtEnq6jqMLJV4ASb\n1d6axmIgJ636wyTUS99gj4BKs6bQSTUSE8h/QkUYv4gEIt3saMS0pZpd90y6+B/9\nhZxZE/RKU8e+zgRqp1/762TB7vcjtjOwXRDEL0w71Jk9i8VUQ59MR1Uj5E8X3WIc\nfYSK5RWBkMhfaTRM6ozS9Bqhi40xlSOb3GBxCmliCifOJNLoO9kFoWgAIw5hkSIb\nGH+4Csop9Uy8VvmmB+B3ubFLN35qIa5OG5+SDXn4L7FeAA5lRiGxRi8tsWrtew8w\nnwIDAQAB\n-----END PUBLIC KEY-----";
var encrypt = new JSEncrypt();
encrypt.setPublicKey(pubKey);
var encrypted = encrypt.encrypt(srcStr);
var dstStr = encrypted.toString();
if(dstStr.length == 0 || dstStr == "false")
{
console.log("encrypt key fail!");
dstStr = "";
}
return dstStr;
}
function encodeKey(key,iv)
{
var kv = key + "+" + iv;
return asyEncode(kv);
}
function encodeParaValue(src,key,iv)
{
if(src.length > 0)
{
var bKey = CryptoJS.SHA256(key);
var bIv = CryptoJS.SHA256(iv);
var encrypted =CryptoJS.AES.encrypt(src,bKey,
{
iv:bIv,
mode:CryptoJS.mode.CBC,
padding:CryptoJS.pad.ZeroPadding
});
var dst = encrypted.toString();
if(dst != "" && dst != "failed")
{
return dst;
}
}
return src;
}
function decodeParaValue(src,key,iv)
{
if(src.length > 0)
{
var bKey = CryptoJS.SHA256(key);
var bIv = CryptoJS.SHA256(iv);
var decrypted =CryptoJS.AES.decrypt(src,bKey,
{
iv:bIv,
mode:CryptoJS.mode.CBC,
padding:CryptoJS.pad.ZeroPadding
});
var dst = decrypted.toString(CryptoJS.enc.Utf8);
if(dst != "" && dst != "failed")
{
return dst;
}
}
return src;
}
function GetEntryPage()
{
for( var pDesc in wizardGraphConf )
{
var pStyleFile = wizardGraphConf[pDesc]["info"]["styleFile"];
var isBeginning = wizardGraphConf[pDesc]["isBeginning"];
if ( true == isBeginning )
{
return pStyleFile;
}
}
return "";
}
function IsEntryPage(pageName)
{
for( var pDesc in wizardGraphConf )
{
var pStyleFile = wizardGraphConf[pDesc]["info"]["styleFile"];
if ( pageName == pStyleFile )
{
var isBeginning = wizardGraphConf[pDesc]["isBeginning"];
if ( true == isBeginning )
{
return true;
}
}
}
return false;
}
function IsLastPage(pageName)
{
for( var pDesc in wizardGraphConf )
{
var pStyleFile = wizardGraphConf[pDesc]["info"]["styleFile"];
if ( pageName == pStyleFile )
{
var successors = wizardGraphConf[pDesc]["successor"];
if ( 0 == successors.length )
{
return true;
}
}
}
return false;
}
function GetPageDescName(styleFile)
{
for( var pDesc in wizardGraphConf )
{
var pStyleFile = wizardGraphConf[pDesc]["info"]["styleFile"];
if ( styleFile == pStyleFile )
{
return pDesc;
}
}
return "";
}
function IsSuccessor(pName, pNameSucc)
{
var page = wizardGraphConf[pName];
var successors = page["successor"];
var styleFile = wizardGraphConf[pNameSucc]["info"]["styleFile"];
for ( var index in successors )
{
var successor = successors[index];
if ( successor == styleFile )
{
return true;
}
}
return false;
}
var wizardCurrpage = GetEntryPage();
var wizardVisitedPageStack = [];
var g_userAssignNextPage = "";
function SetNextPage(styleFile)
{
g_userAssignNextPage = styleFile;
}
function IsPageBeConfigured(styleFile)
{
for ( var pIndex in wizardVisitedPageStack )
{
var page = wizardVisitedPageStack[pIndex];
if ( styleFile == page )
{
return true;
}
}
return false;
}
function GetSuccessorPage(successors)
{
var succPage = "";
if ( "" != g_userAssignNextPage )
{
succPage = g_userAssignNextPage;
g_userAssignNextPage = "";
}
if ( "" == succPage )
{
succPage = successors[0];
}
return succPage;
}
function GetNextPage()
{
for( var pIndex in wizardGraphConf )
{
var pStyleFile = wizardGraphConf[pIndex]["info"]["styleFile"];
if ( wizardCurrpage == pStyleFile )
{
wizardVisitedPageStack.push(wizardCurrpage);
var successors = wizardGraphConf[pIndex]["successor"];
var postPage = GetSuccessorPage(successors)
wizardCurrpage = postPage;
return postPage;
}
}
return "";
}
function GetBackPage()
{
var prePage = wizardVisitedPageStack.pop();
wizardCurrpage = prePage;
return prePage;
}
function GetExitPage()
{
var Sys = {};
var ua = navigator.userAgent.toLowerCase();
var s;
(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
if (Sys.firefox || Sys.chrome)
{
window.location.href = 'about:blank';
}
else if (Sys.safari)
{
window.open('','_self');
window.close();
}
else
{
window.opener = "whocares";
window.close();
}
}
function AjaxWizardPageGet(PageName,IsEntry,IsLast)
{
var pageContainer = $(".wizardChildPage");
pageContainer.succfunction = function(html){
pageContainer.html(html);
showWaitTip(false);
DisplayWizardBtn();
DisplayStepBar();
initWizardDynamicTip();
pageload();
};
pageContainer.errorfunction = function(html){
consoleLog("page get fail!");
showWaitTip(false);
pageContainer.html("page get is fail,please try again!!");
};
showWaitTip(true);
pageContainer.dataTransfer( PageName, "GET", pageContainer.succfunction,
pageContainer.errorfunction, false,
undefined, 'html'
);
}
function AjaxQuery_ClassWizardClick(NextPage,IsEntry,IsLast)
{
var pageFile = "/?_type=wizardView&_tag="+NextPage;
AjaxWizardPageGet(pageFile,IsEntry,IsLast);
}
function LoadPageLocally(FileName)
{
var IsLast = IsLastPage(FileName);
var IsEntry = IsEntryPage(FileName);
AjaxQuery_ClassWizardClick(FileName,IsEntry,IsLast);
}
var g_edgeWeight = [];
InitEdgeWeightMatrix();
var knownSet = [];
var unKnownSet = [];
var distanceSP = [];
function InitEdgeWeightMatrix()
{
if (2 == 1)
{
delete wizardGraphConf['CSPWLAN1'];
wizardGraphConf['CSPWLAN']['successor'][0] = "wizard_over_t.lp";
}
for ( var pName in wizardGraphConf )
{
g_edgeWeight[pName] = [];
for ( var pNameSucc in wizardGraphConf )
{
var isSucc = IsSuccessor(pName, pNameSucc);
if ( true == isSucc )
{
g_edgeWeight[pName][pNameSucc] = 1;
}
else
{
g_edgeWeight[pName][pNameSucc] = Number.POSITIVE_INFINITY;
}
}
}
}
function InitDijkstraSet(pNameStart)
{
knownSet = [];
unKnownSet = [];
for ( var pName in wizardGraphConf )
{
if ( pName == pNameStart )
{
knownSet.push(pName);
}
else
{
unKnownSet.push(pName);
}
}
}
function InitDijstraDistanceSP()
{
distanceSP = [];
var pNameStart = knownSet[0];
for ( var index in unKnownSet )
{
var pName = unKnownSet[index];
distanceSP[pName] = g_edgeWeight[pNameStart][pName];
}
}
function DoDijkstraAlgorithm()
{
var loopNum = unKnownSet.length;
for ( var i=0; i<loopNum; i++ )
{
var minDistPName = unKnownSet[0];
var minDistIndex = 0;
var minDist = distanceSP[minDistPName]
for ( var index in unKnownSet )
{
var pName = unKnownSet[index];
var dist = distanceSP[pName];
if ( dist < minDist )
{
minDist = dist;
minDistPName = pName;
minDistIndex = index;
}
}
unKnownSet.splice(minDistIndex, 1);
knownSet.push(minDistPName);
for ( var index in unKnownSet )
{
var pName = unKnownSet[index];
var oldDist = distanceSP[pName];
var weight = g_edgeWeight[minDistPName][pName];
var newDist = minDist + weight;
if ( newDist < oldDist )
{
distanceSP[pName] = newDist;
}
}
}
for ( var index in knownSet )
{
var pName = knownSet[index];
}
}
function GetLeftStepNum()
{
if ( true == IsLastPage(wizardCurrpage) )
{
return 0;
}
pNameStart = GetPageDescName(wizardCurrpage);
InitDijkstraSet(pNameStart);
InitDijstraDistanceSP();
DoDijkstraAlgorithm();
var overVertex = [];
for( var pName in wizardGraphConf )
{
var page = wizardGraphConf[pName];
var successors = page["successor"];
if ( 0 == successors.length )
{
overVertex.push(pName);
}
}
var shortestPath = Number.POSITIVE_INFINITY;
for ( var index in overVertex )
{
var pName = overVertex[index];
if ( shortestPath > distanceSP[pName] )
{
shortestPath = distanceSP[pName] ;
}
}
return shortestPath;
}
jQuery.fn.formPost = function(IfShowWaitTip, PostSuccHandler, IsWaitTipOff)
{
var IfShowWaitTipTmp = IfShowWaitTip;
if ( IfShowWaitTipTmp == undefined )
{
IfShowWaitTipTmp = true;
}
if ( undefined == IsWaitTipOff )
{
IsWaitTipOff = true;
}
if ( IfShowWaitTipTmp == true )
{
showWaitTip(true);
}
var formObj = $(this);
var postURL = formObj.attr("action");
var postData = "";
var cryptoKey = randomNum(16);
var cryptoIv = randomNum(16);
var needEncode = false;
var formInputContent = formObj.find("input");
formInputContent.each(function(key){
var Elems = $(this);
var ElemsID = Elems.attr("id");
var ElemsValue = "";
switch (Elems.attr("type"))
{
case "hidden":
{
ElemsValue = Elems.val();
if( Elems.attr("encode") == "1" )
{
ElemsValue = encodeParaValue(ElemsValue,cryptoKey,cryptoIv);
needEncode = true;
}
break;
}
default:
{
break;
}
}
var RealElemsValue = encodeURIComponent(ElemsValue);
postData += ElemsID + "=" + RealElemsValue + "&";
});
if(needEncode)
{
postData += "encode=" + encodeURIComponent(encodeKey(cryptoKey,cryptoIv)) + "&";
}
var pageContainer = $("#page_content");
$.ajax({
url:postURL,
type: 'POST',
data: postData,
dataType: 'xml',
async: true,
timeout: 30000,
error: function(){
consoleLog("page get fail");
showWaitTip(false);
pageContainer.html("page get is fail,please try again!!");
},
success: function(xml){
PostSuccHandler(xml);
if ( IfShowWaitTipTmp == true && IsWaitTipOff == true )
{
showWaitTip(false);
}
}
});
}
function pageBack()
{
var validateForm = $(".formForValidate");
if ( true == validateForm.valid() )
{
showWaitTip(true);
pageSetValue();
var pageName = GetBackPage();
LoadPageLocally(pageName);
}
}
function pageExit()
{
showWaitTip(true);
$.post( "/?_type=loginData&_tag=logout_entry", {IF_LogOff:1}, undefined, "json" )
.done(function( data ) {
if ( data.need_refresh )
{
var pageName = GetExitPage();
}
});
}
function pageNext()
{
var ContentContainer = $("#template_wizardFrame");
var cmapiErrorContainer = $(".errorHint",ContentContainer);
cmapiErrorContainer.showIt(false);
var validateForm = $(".formForValidate");
if ( true == validateForm.valid() )
{
showWaitTip(true);
pageSetValue();
var pageName = GetNextPage();
LoadPageLocally(pageName);
}
}
var g_error_page = "";
function delayLoadErrpage()
{
LoadPageLocally(g_error_page);
}
var g_finishRedirectPage = "";
function setFinishRedirectPage(page)
{
g_finishRedirectPage = page;
}
function SavehasError(xml){
var ContentContainer = $("#template_wizardFrame");
var cmapiErrorContainer = $(".errorHint",ContentContainer);
var errStr = $("IF_ERRORSTR", $(xml));
var errParam = $("IF_ERRORPARAM", $(xml));
if (errStr.length <= 0 || errParam.length <= 0)
{
consoleLog("[hasError:]cannot find IF_ERRORSTR or IF_ERRORPARAM");
return;
}
var ErrorString = $("IF_ERRORSTR", $(xml)).text();
var ErrorParam = $("IF_ERRORPARAM", $(xml)).text();
if ( ErrorString == "SUCC" )
{
cmapiErrorContainer.showIt(false);
return 0;
}
else if ( ErrorString == "SessionTimeout" )
{
top.location.href = top.location.href;
return 1;
}
else
{
return 1;
}
}
function handleFinishAjaxResponse(xml)
{
var ContentContainer = $("#template_wizardFrame");
var isError = SavehasError(xml);
if ( 0 == isError )
{
var pageName = GetNextPage();
LoadPageLocally(pageName);
}
else
{
var pageName = GetBackPage();
LoadPageLocally(pageName);
var cmapiErrorContainer = $(".errorHint",ContentContainer);
$("span",cmapiErrorContainer).text("&?quicksetup015;");
cmapiErrorContainer.showIt(true);
}
}
function pageSave()
{
<%
local sess_id = cgilua.getCurrentSessID()
local sess_temp = session_get(sess_id, "sess_token")
%>
var sess_temp = "<%=_G.encodeJS(sess_temp)%>";
var validateForm = $(".formForValidate");
if ( false == validateForm.valid() )
{
return ;
}
showWaitTip(true);
pageSetValue();
var path = wizardVisitedPageStack.join(",");
path += "," + wizardCurrpage;
var pathHTML = "<input id='_sessionTOKEN' name='_sessionTOKEN' "
+"type='hidden' value='"+sess_temp+"'>"
$("#fSubmit").append(pathHTML);
var pathHTML = "<input id='IF_WIZARDPATH' name='IF_WIZARDPATH' "
+"type='hidden' value='"+path+"'>"
$("#fSubmit").append(pathHTML);
var pageHTML = "<input id='IF_FINISH_REDIRECTPAGE' "
+ "name='IF_FINISH_REDIRECTPAGE' "
+ "type='hidden' value='"+g_finishRedirectPage+"'>"
$("#fSubmit").append(pageHTML);
var postURL = "/?_type=wizardData&_tag=finishaction";
$("#fSubmit").attr("action", postURL);
$("#fSubmit").formPost(true, handleFinishAjaxResponse, false);
}
var g_closeRedirectPage = "";
function setCloseRedirectPage(page)
{
g_closeRedirectPage = page;
}
function handleCloseAjaxResponse(xml)
{
var isError = $("#template_wizardFrame").hasError(xml);
if ( 0 == isError )
{
top.location.href = top.location.href;
}
}
function pageTohome()
{
<%
local sess_id = cgilua.getCurrentSessID()
local sess_temp = session_get(sess_id, "sess_token")
%>
var sess_temp = "<%=_G.encodeJS(sess_temp)%>";
showWaitTip(true);
$("#fSubmit").empty();
var pathHTML = "<input id='_sessionTOKEN' name='_sessionTOKEN' "
+"type='hidden' value='"+sess_temp+"'>"
$("#fSubmit").append(pathHTML);
var pageHTML = "<input id='IF_CLOSE_REDIRECTPAGE' "
+ "name='IF_CLOSE_REDIRECTPAGE' "
+ "type='hidden' value='"+g_closeRedirectPage+"'>"
$("#fSubmit").append(pageHTML);
var postURL = "/?_type=wizardData&_tag=closeaction";
$("#fSubmit").attr("action", postURL);
$("#fSubmit").formPost(true, handleCloseAjaxResponse, false);
}
function createWizardButton(Btn_id, Btn_method, Btn_value)
{
return ("<input type=\"button\" id=\"" + Btn_id
+"\" class =\"button wizardBtn\" onclick=\"" + Btn_method
+ "\" value=\"" + Btn_value+ "\"\>");
}
function wizardCreateBtnInSubArea()
{
var btnObjs = {
Next : {
btnID : "Btn_Next",
btnMethod : "pageNext()",
btnName : "&?quicksetup008;"
},
Back : {
btnID : "Btn_Back",
btnMethod : "pageBack()",
btnName : "&?quicksetup007;"
},
Exit : {
btnID : "Btn_Exit",
btnMethod : "pageExit()",
btnName : "&?quicksetup010;"
},
OK : {
btnID : "Btn_Exit",
btnMethod : "pageExit()",
btnName : "&?quicksetup013;"
},
Save : {
btnID : "Btn_Finish",
btnMethod : "pageSave()",
btnName : "&?quicksetup009;"
}
};
var typeNum = arguments.length;
var i;
for(i=typeNum-1; i>=0; i--)
{
var type = arguments[i];
var btnObj = btnObjs[type];
var btnID = btnObj.btnID;
var btnMethod = btnObj.btnMethod;
var btnName = btnObj.btnName;
var btnHTML = createWizardButton(btnID, btnMethod, btnName);
$("#wizardSubmitArea").append(btnHTML);
}
}
function DisplayWizardBtn()
{
$("#wizardSubmitArea").empty();
var DetailSetupHTML = "<input id='Btn_Close' class='button wizardCloseBtn'"+
"type='button'"+
"value='&?quicksetup011;' onclick='pageTohome()'>";
var CancelHTML = "<input id='Btn_Close' class='button wizardCloseBtn'"+
"type='button'"+
"value='&?quicksetup014;' onclick='pageTohome()'>";
if( true == IsEntryPage(wizardCurrpage) )
{
$("#wizardSubmitArea").append(DetailSetupHTML);
wizardCreateBtnInSubArea("Next", "Exit");
}
else if( true == IsLastPage(wizardCurrpage) )
{
$("#wizardSubmitArea").append(CancelHTML);
wizardCreateBtnInSubArea("OK");
}
else if( (2 != 1) && ("wizard_wlancfg_t.lp" == wizardCurrpage ))
{
$("#wizardSubmitArea").append(DetailSetupHTML);
wizardCreateBtnInSubArea("Back", "Next", "Exit");
}
else
{
$("#wizardSubmitArea").append(DetailSetupHTML);
wizardCreateBtnInSubArea("Back", "Save", "Exit");
}
}
function DisplayStepBar()
{
var visitedPageNum = wizardVisitedPageStack.length;
var doningSetpIndex = visitedPageNum + 1;
var unDoneStepNum = GetLeftStepNum();
var totalStep = visitedPageNum + 1 + unDoneStepNum;
var stepBarHTML = "";
for ( var i=1; i<=totalStep; i++ )
{
if ( i == doningSetpIndex )
{
stepBarHTML += "<span class='stepDone'></span>";
}
else
{
stepBarHTML += "<span class='stepUndone'></span>";
}
}
$("#span_stepBar").html(stepBarHTML);
}
function initFormValidator(validateJSONData)
{
var validateForm = $(".formForValidate");
validateForm.validate(validateJSONData);
}
function initWizardDynamicTip()
{
$("input[type='text'],input[type='password']").focus(function(){
var thisObj = $(this);
var msg = thisObj.next("span").text();
if (msg != "")
{
var pos = thisObj.offset();
var objWidth = thisObj.width();
var dhtml = "<div id='dynamicTip'><div id='dTip_l'></div>"
+ "<div id='dTip_m'>"
+ msg
+ "</div><div id='dTip_r'></div></div>";
var dtObj = $(dhtml).css({top:(pos.top-33)+'px',left:(pos.left+objWidth+8)+'px'});
dtObj.appendTo('body').fadeIn(400);
thisObj.blur(function(){
dtObj.fadeOut(100, function(){$(this).remove()});
});
}
});
$("input[class='ip'],input[class='mac']").each(function(){
var InputOBJ = $(this);
InputOBJ.unbind("keydown");
InputOBJ.unbind("keyup");
InputOBJ.keydown(function(event){
autoJumpBack(this,this.value,event);
});
InputOBJ.keyup(function(event){
FocusAutoJump(this,this.value,event);
});
});
}
function errorTrapDisplay()
{
var ErrorString = $("#IF_ERRORSTR").val();
var ErrorParam = $("#IF_ERRORPARAM").val();
var ContentContainer = $("#template_wizardFrame");
var cmapiErrorContainer = $(".errorHint",ContentContainer);
if ( ErrorString == "SUCC" )
{
cmapiErrorContainer.showIt(false);
return 0;
}
else if ( ErrorString == "SessionTimeout" )
{
top.location.href = top.location.href;
return 1;
}
else
{
var cmapiErrorContainerHtml = "";
var paraString = "";
if ( ErrorParam != "SUCC")
{
ErrorString = "&?cmret_101;"
var paraLabel = ContentContainer.find("label[for^='"+ErrorParam+"\\:']");
if ( paraLabel.length <= 0 )
{
paraLabel = ContentContainer.find("label[for='"+ErrorParam+"']");
}
if ( paraLabel.length > 0 )
{
paraString = paraLabel.text();
}
else
{
ErrorString = "&?cmret_001;";
}
cmapiErrorContainerHtml = ErrorString.format(paraString);
}
else
{
if ( "FAIL" == ErrorString
||"&?cmret_101;" == ErrorString )
{
ErrorString = "&?cmret_001;";
}
cmapiErrorContainerHtml = ErrorString;
}
$("span",cmapiErrorContainer).text(cmapiErrorContainerHtml);
cmapiErrorContainer.showIt(true);
return 1;
}
}
$(document).ready(function(){
showWaitTip(false);
FakeClass1MenuShow();
DisplayStepBar();
DisplayWizardBtn();
errorTrapDisplay();
initWizardDynamicTip();
pageload();
});
</script>
