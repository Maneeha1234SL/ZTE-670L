<%
cgilua_lp.include("../../webmodules/modules/upnp_portmap_js.lp", getfenv(1))
%>
<div id="PortMap" class="HeadDIV">
<address style="display:none">
<span class="form-action">/?_type=menuData&_tag=upnp_portmap_lua.lua</span>
</address>
<div class="externErrorHint" style="display:none;">
<span class="caption1"></span>
</div>
<h1 class="collapBarWithDataTrans" id="PortMapBar">&?upnpPortMap_001;</h1>
<div id="PortMap_container">
<input type="hidden" id="DataHasBeenGot" value="0">
<div class="errorHint" style="display:none;">
<span class="caption1"></span>
</div>
<div class="succHint" style="display:none;">
<span class="caption1">&?public_021;</span>
</div>
<div class="noDataHint" style="display:none;">
<span>&?public_023;</span>
</div>
<div class="colorTbl">
<div id="colorTblHead" class="colorTblRow emFont titleRow">
<span class="w130" title="&?public_053;">&?public_053;</span>
<span class="w130" title="&?upnpPortMap_002;">&?upnpPortMap_002;</span>
<span class="w130" title="&?upnpPortMap_003;">&?upnpPortMap_003;</span>
<span class="w130" title="&?public_183;">&?public_183;</span>
<span class="w130" title="&?public_182;">&?public_182;</span>
</div>
<div id="template_PortMap" class="colorTblRow" style="display:none;">
<input type="hidden" id="_InstID" value="">
<span class="w130" id="Protocol" title=""></span>
<span class="w130" id="InternalPort" title=""></span>
<span class="w130" id="ExternalPort" title=""></span>
<span class="w130" id="ServerIPAddress" title=""></span>
<span class="w130" id="InternalClient" title=""></span>
</div>
</div>
<div class="buttongroup">
<input type="button" class="Button Btn_refresh" id="PortMap_Btn_refresh" name="PortMap_Btn_refresh" value="&?public_003;" />
</div>
</div>
</div>
