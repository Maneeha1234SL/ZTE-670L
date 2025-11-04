<script language="javascript">
function setValue(dst, src)
{
var data = $("#"+src).val();
$("#"+dst).val(data);
}
function setPromptCheckRules()
{
var validateJSONData = {
"rules": {
"ESSID": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
},
"KeyPassphrase": {
"required": true,
"ASCII": true,
"rangelength": [8, 63]
},
},
"messages": {
}
};
initFormValidator(validateJSONData);
}
function getEncryptionType()
{
$("#EncryptionType").val("WPA/WPA2-PSK-AES");
setValue("hidden_EncryptionType","EncryptionType");
}
function setEncryptionType()
{
var EncryptionPara = {
"No Security": {
"AP_BeaconType1": "none"
},
"WPA2-PSK-AES": {
"AP_BeaconType1":"11i",
"AP_11iAuthMode1":"PSKAuthentication",
"AP_11iEncryptType1":"AESEncryption"
},
"WPA/WPA2-PSK-AES": {
"AP_BeaconType1":"WPAand11i",
"AP_WPAAuthMode1":"PSKAuthentication",
"AP_11iAuthMode1":"PSKAuthentication",
"AP_WPAEncryptType1":"AESEncryption",
"AP_11iEncryptType1":"AESEncryption"
},
"WPA/WPA2-PSK-TKIP/AES": {
"AP_BeaconType1":"WPAand11i",
"AP_WPAAuthMode1":"PSKAuthentication",
"AP_11iAuthMode1":"PSKAuthentication",
"AP_WPAEncryptType1":"TKIPandAESEncryption",
"AP_11iEncryptType1":"TKIPandAESEncryption"
}
};
var EncryptionType = $("#EncryptionType").val();
if ( EncryptionPara[EncryptionType] )
{
var EncryptionDataByType = EncryptionPara[EncryptionType];
for ( var Tmp in EncryptionDataByType )
{
$("#"+Tmp).val(EncryptionDataByType[Tmp]);
}
}
}
function pageGetValue()
{
setValue("ESSID","AP_ESSID1");
setValue("KeyPassphrase","PSK_KeyPassphrase1");
getEncryptionType();
if ($("#SET_RadioStatus1").val() == 1)
{
$("#RadioStatus").prop("checked", true);
$("#ShowKeyPassphrase").bind("click",function(){showPass($(this), "KeyPassphrase");});
}
else
{
$("#ESSID").prop("disabled",true);
$("#KeyPassphrase").prop("disabled",true);
$("#RadioStatus").prop("checked", false);
$("#ShowKeyPassphrase").unbind("click");
}
}
function pageload()
{
setPromptCheckRules();
pageGetValue();
}
$("#RadioStatus").bind("click",function(){
if($("#RadioStatus").is(':checked'))
{
$("#ESSID").prop("disabled",false);
$("#KeyPassphrase").prop("disabled",false);
$("#ShowKeyPassphrase").bind("click",function(){showPass($(this), "KeyPassphrase");});
}
else
{
$("#ESSID").prop("disabled",true);
$("#KeyPassphrase").prop("disabled",true);
if($("#ShowKeyPassphrase").attr("src") == "../img/awaking.png")
{
showPass($("#ShowKeyPassphrase"), "KeyPassphrase");
}
$("#ShowKeyPassphrase").unbind("click");
}
});
function showPass(srcObj, tObjId){
var TypeOBJ = (srcObj);
var KeyPassphrasePassObj = $("[id="+tObjId+"][type='password']");
var KeyPassphraseTextObj = $("[id="+tObjId+"][type='text']");
if(TypeOBJ.attr("src") == "../img/sleeping.png")
{
TypeOBJ.attr("src", "../img/awaking.png");
$("[id="+tObjId+"][type='password']").hide();
$("[id="+tObjId+"][type='password']").attr("class","PostIgnore");
$("[id="+tObjId+"][type='text']").attr("class","w150");
$("[id="+tObjId+"][type='text']").show();
KeyPassphraseTextObj.val(KeyPassphrasePassObj.val());
}
else
{
TypeOBJ.attr("src", "../img/sleeping.png");
$("[id="+tObjId+"][type='password']").attr("style","width: 150px");
$("[id="+tObjId+"][type='password']").attr("class","valid");
$("[id="+tObjId+"][type='text']").hide();
$("[id="+tObjId+"][type='text']").attr("class","PostIgnore");
KeyPassphrasePassObj.val(KeyPassphraseTextObj.val());
}
}
function pageSetValue()
{
if($("#RadioStatus").is(':checked'))
{
$("#SET_RadioStatus1").val("1");
}
else
{
$("#SET_RadioStatus1").val("0");
}
setValue("AP_ESSID1","ESSID");
$("#AP_Enable1").val("1");
setEncryptionType()
if($("#ShowKeyPassphrase").attr("src") == "../img/sleeping.png")
{
$("#PSK_KeyPassphrase1").val($("[id='KeyPassphrase'][type='password']").val());
}
else
{
$("#PSK_KeyPassphrase1").val($("[id='KeyPassphrase'][type='text']").val());
}
$("#AP_IACTION1").val("apply");
$("#SET_IACTION1").val("apply");
$("#PSK_IACTION1").val("apply");
}
</script>
