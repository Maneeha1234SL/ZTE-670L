<script language="javascript">
function setPromptCheckRules()
{
var validateJSONData = {
"rules": {
"exampleInput": {
"required": true,
"ASCII": true,
"rangelength": [1, 32]
},
},
"messages": {
}
};
initFormValidator(validateJSONData);
}
function pageGetValue()
{
}
function pageload()
{
setPromptCheckRules();
pageGetValue();
}
function pageSetValue()
{
}
</script>
