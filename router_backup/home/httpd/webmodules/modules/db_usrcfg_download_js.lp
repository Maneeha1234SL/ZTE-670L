<script type="text/javascript">
(function(){
function g_downLoadAllowHandle(xml)
{
var HeadID = "UserConfDownload";
var Head = $("#"+HeadID);
if (Head.hasError(xml) == 0)
{
var fileURL = "/?_type=menuData&_tag=do_download_usercfg.lua";
document.getElementById("fDownload").action = fileURL;
document.fDownload.submit();
}
else
{
showWaitTip(false);
}
}
$(document).ready(function(){
showWaitTip(false);
var HeadID = "UserConfDownload";
var Head = $("#"+HeadID);
var template = $("#template_"+ HeadID);
$("#Btn_Download").bind("click", function(){
var loadAllowAddr = "/?_type=menuData&_tag=updownload_prevent_ctl.lua"
+"&sessToken=" +document.getElementById("TOKEN_DOWNLOAD").value;
Head.dataTransfer(loadAllowAddr, "GET", g_downLoadAllowHandle);
});
$(".collapsibleBar", $("#UserConfDownload")).click();
});
})();
</script>
