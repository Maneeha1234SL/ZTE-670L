<%
cgilua_lp.include("../page_mgr/wizard_page_deps/wizard_wancfg_js.lp",getfenv(1))
%>
<form class="formForValidate">
<div class="welcomeHint emFont">&?quicksetup001;</div>
<div class="row" style="padding-bottom: 10px;padding-top: 10px;">
<label>&?quicksetup002;</label>
</div>
<div class="row">
<label for="InternetUserName" class="cfgLabel w180">&?public_026;</label>
<div class="right">
<input class="inputNorm" type="text" id="InternetUserName" name="InternetUserName" value=""/>
</div>
</div>
<div class="row">
<label for="InternetPassword" class="cfgLabel w180">&?public_027;</label>
<div class="right">
<input type="password" class="inputNorm" id="InternetPassword" name="InternetPassword" autocomplete="new-password" value="						"/>
</div>
</div>
<div class="row" style="padding-bottom: 10px;padding-top: 10px;">
<label>&?quicksetup003;</label>
</div>
</form>
