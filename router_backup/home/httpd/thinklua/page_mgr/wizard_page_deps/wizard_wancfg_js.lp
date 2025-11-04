<script language="javascript">
function setValue(dst, src)
{
var data = $("#"+src).val();
if( data == "::" || data == "NULL")
data="";
$("#"+dst).val(data);
}
function setPromptCheckRules()
{
var validateJSONData = {
"rules": {
"InternetUserName": {
"ASCII": true,
"rangelength": [0, 64]
},
"InternetPassword": {
"PasswordASCII": true,
"rangelength": [0, 64]
}
},
"messages": {
}
};
initFormValidator(validateJSONData);
}
function pageGetValue()
{
setValue("InternetUserName","hidden_InternetUserName");
setValue("InternetPassword","hidden_InternetPassword");
}
function pageSetValue()
{
setValue("hidden_InternetUserName","InternetUserName");
setValue("hidden_InternetPassword","InternetPassword");
}
function pageload()
{
setPromptCheckRules();
pageGetValue();
}
</script>
