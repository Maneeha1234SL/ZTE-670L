<%
cgilua_lp.include("wizard_page/wizard_CSPExample_js.lp", getfenv(1))
%>
<form class="formForValidate">
<p class="wizardIntroP">
(1)&?wizardCSPExample_001;
<br/>
(2)&?wizardCSPExample_002;
</p>
<div class="row">
<label for="exampleRadio" class="left w150">&?wizardCSPExample_003;</label>
<div id="exampleRadio" class="right">
<input type="radio" id="exampleRadio_ON" name="exampleRadio" value="1" checked="checked"/>
<label for="exampleRadio_ON">&?public_033;</label>
&nbsp;&nbsp;
<input type="radio" id="exampleRadio_OFF" name="exampleRadio" value="0"/>
<label for="exampleRadio_OFF">&?public_034;</label>
</div>
</div>
<div class="row">
<label for="exampleInput" class="left w150">&?wizardCSPExample_004;</label>
<div class="right">
<input type="text" id="exampleInput" name="exampleInput" class="w180" />
<span style="display:none;">&?public_073;1 ~ 32</span>
</div>
</div>
<div class="row">
<label for="exampleSelect" class="left w150">&?wizardCSPExample_005;</label>
<div class="right">
<select id="exampleSelect" name="exampleSelect" class="w180">
<option value="1" title="1">1</option>
</select>
</div>
</div>
<div class="row">
<label for="exampleIP" class="cfgLabel w150">&?wizardCSPExample_006;</label>
<div class="right">
<input class="ip" name="sub_exampleIP0" type="text" maxlength="3" id="sub_exampleIP0" value="" />.
<input class="ip" name="sub_exampleIP1" type="text" maxlength="3" id="sub_exampleIP1" value="" />.
<input class="ip" name="sub_exampleIP2" type="text" maxlength="3" id="sub_exampleIP2" value="" />.
<input class="ip" name="sub_exampleIP3" type="text" maxlength="3" id="sub_exampleIP3" value="" />
</div>
</div>
</form>
