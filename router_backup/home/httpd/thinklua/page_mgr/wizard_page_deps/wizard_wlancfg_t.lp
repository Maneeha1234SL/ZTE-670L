<%
cgilua_lp.include("../page_mgr/wizard_page_deps/wizard_wlancfg_js.lp",getfenv(1))
%>
<form class="formForValidate">
<div class="welcomeHint emFont">&?quicksetup001;</div>
<div class="row" style="padding-bottom: 10px;padding-top: 10px;">
<label>&?quicksetup004;</label>
</div>
<div class="row" id="div_ServerEnable">
<label for="RadioStatus" class="cfgLabel w180">&?quicksetup016;</label>
<div class="right">
<input type="checkbox" id="RadioStatus" name="RadioStatus" value="" />
</div>
</div>
<div class="row">
<label for="ESSID" class="left w180">&?public_117;</label>
<div class="right">
<input type="text" id="ESSID" name="ESSID" class="inputNorm" />
<span style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row" style="display:none">
<label for="EncryptionType" class="left w180">&?WlanBasic_012;</label>
<div class="right">
<select id="EncryptionType" name="EncryptionType" class="selectNorm">
<option value="No Security" title='&?public_059;'>&?public_059;</option>
<option value="WPA2-PSK-AES" title='&?WlanBasicAd_062;'>&?WlanBasicAd_062;</option>
<option value="WPA/WPA2-PSK-TKIP/AES" title='&?WlanBasicAd_063;'>&?WlanBasicAd_063;</option>
<option value="WPA/WPA2-PSK-AES" title='&?WlanBasicAd_086;'>&?WlanBasicAd_086;</option>
</select>
</div>
</div>
<div class="row" style="padding-bottom: 10px;padding-top: 10px;">
<label>&?quicksetup005;</label>
</div>
<div class="row" id="div_KeyPassphrase">
<label for="KeyPassphrase" class="left w180">&?quicksetup006;</label>
<div class="right">
<input type="password" id="KeyPassphrase" name="KeyPassphrase" class="inputNorm"/>
<input type="text" id="KeyPassphrase" name="KeyPassphrase" class="PostIgnore" style="display:none"/>
<img id="ShowKeyPassphrase" src="../img/sleeping.png" style="width:16px; height:16px;"/>
<span style="display:none;">&?public_073;8 ~ 63</span>
</div>
</div>
</form>
