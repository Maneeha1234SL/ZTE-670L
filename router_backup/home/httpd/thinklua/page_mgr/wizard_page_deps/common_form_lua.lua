local cgilua = require("cgilua.cgilua")
function create_form_start(ID, URL)
local formHead = "<form name='" .. ID
.."'id='".. ID
.."' method='POST' action='".. URL .."'>\n";
cgilua.put(formHead)
end
function create_form_end()
local formTail = "</form>\n";
cgilua.put(formTail)
end
function create_hidden_input(ID, value, encode)
local eStr = ""
if encode == 1 then
eStr = "encode='1'"
end
local inprinttr ="<input type='hidden' name='".. ID
.."'id='".. ID
.."'value='".. encodeHTML(value) .."' " .. eStr .." >\n";
cgilua.put(inprinttr)
end
function set_hidden_input(ID, value)
local inprinttr = "<script language=javascript>"
.."document.getElementById('"
..ID
.."').value = '"
.. encodeJS(value)
.."';"
.."</script>\n";
cgilua.put(inprinttr);
end
function create_ctrl_fields()
create_hidden_input("IF_ACTION", "");
create_hidden_input("IF_ERRORSTR", "SUCC");
create_hidden_input("IF_ERRORPARAM", "SUCC");
create_hidden_input("IF_ERRORTYPE", "-1");
end
function output_form_error(tError)
if type(tError) ~= "table" then
return ""
end
if tError.IF_ERRORID == 0 then
return;
end
if tError.IF_ERRORID ~= 0 then
if tError.IF_ERRORSTR ~= "FAIL" then
tError.IF_ERRORSTR = lang["cmret_"..tError.IF_ERRORSTR] or lang.cmret_001
end
end
tError.IF_ERRORTYPE = tError.IF_ERRORTYPE or "SUCC"
tError.IF_ERRORSTR = tError.IF_ERRORSTR or "SUCC"
tError.IF_ERRORPARAM = tError.IF_ERRORPARAM or "SUCC"
set_hidden_input("IF_ERRORSTR", tostring(tError.IF_ERRORSTR));
set_hidden_input("IF_ERRORTYPE", tostring(tError.IF_ERRORTYPE));
set_hidden_input("IF_ERRORPARAM", tostring(tError.IF_ERRORPARAM));
end
function transToPostTab_Module(MPrefix, MPara, IIndex)
if type(MPara) ~= "table" then
return
end
local tem_MPara = {}
if MPara.encrypt ~= nil then
tem_MPara = MPara.para
else
tem_MPara = MPara
end
local retTab = {}
for i,v in ipairs(tem_MPara) do
local POST_NAME = MPrefix..v..IIndex;
retTab[v] = cgilua.POST[POST_NAME]
end
if MPara.encrypt==nil or cgilua.POST.encode==nil then
return retTab
end
local decodeKV = cmapi.nocsrf.rsa_decrypt(cgilua.POST.encode)
local strpass = string.format("%c%c%c%c%c%c", 9,9,9,9,9,9)
local key,iv = string.match(decodeKV,"(%d+)%+(%d+)")
for i,v in ipairs(MPara.encrypt) do
if retTab[v] ~= nil and string.len(retTab[v]) > 0 then
retTab[v] = cmapi.nocsrf.aes_decrypt(retTab[v], key, iv)
if retTab[v] == strpass then
g_logger:info("para "..v.." value is 6 tab")
retTab[v] = nil
end
end
end
return retTab
end
function ModuleAction_MuteInst(MPrefix, MPara)
local IACTION = "";
local IMNAME = "";
local IID = "";
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local IACTION_NAME = MPrefix .. "IACTION";
local IMNAME_NAME = MPrefix .. "IMNAME";
local IID_NAME = MPrefix .. "IDENTITY";
IACTION = cgilua.POST[IACTION_NAME];
IMNAME = cgilua.POST[IMNAME_NAME];
IID = cgilua.POST[IID_NAME];
if IID == "" or IID == nil then
IID = "IGD"
end
if IACTION == nil then
return tError
end
if "apply" == IACTION then
local tData = transToPostTab_Module(MPrefix, MPara, "");
tError = cmapi.setinst(IMNAME, IID, tData);
elseif "delete" == IACTION then
tError = cmapi.delinst(IMNAME, IID);
end
return tError;
end
function ModuleAction_RealInst(MPrefix, MPara)
local IACTION = "";
local IMNAME = "";
local IID = "";
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local IACTION_NAME = MPrefix .. "IACTION";
local IMNAME_NAME = MPrefix .. "IMNAME";
local IID_NAME = MPrefix .. "IDENTITY";
local INSTNUM = cgilua.POST[MPrefix.."INSTNUM"];
INSTNUM = tonumber(INSTNUM);
if INSTNUM <= 1 then
return tError
end
local IIndex=1;
for IIndex=1,INSTNUM do
local IACTION_NAME_I = IACTION_NAME .. IIndex;
local IMNAME_I = IMNAME_NAME .. IIndex;
local IID_NAME_I = IID_NAME .. IIndex;
IACTION = cgilua.POST[IACTION_NAME_I];
IMNAME = cgilua.POST[IMNAME_I];
IID = cgilua.POST[IID_NAME_I];
if IACTION == nil then
return tError
end
if "apply" == IACTION then
local tData = transToPostTab_Module(MPrefix, MPara, IIndex);
tError = cmapi.setinst(IMNAME, IID, tData);
elseif "delete" == IACTION then
tError = cmapi.delinst(IMNAME, IID);
end
if tError.IF_ERRORID ~= 0 then
return tError;
end
end
return tError;
end
function ModuleAction(MPrefixs, MParas)
local MPrefix = "";
local MPara = {};
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local MIndex=1;
for key,val in ipairs(MPrefixs) do
MIndex = key;
MPrefix = MPrefixs[MIndex];
MPara = MParas[MIndex];
tError = ModuleAction_RealInst(MPrefix, MPara);
if tError.IF_ERRORID ~= 0 then
return tError;
end
end
for key,val in ipairs(MPrefixs) do
MIndex = key;
MPrefix = MPrefixs[MIndex];
MPara = MParas[MIndex];
tError = ModuleAction_MuteInst(MPrefix, MPara);
if tError.IF_ERRORID ~= 0 then
return tError;
end
end
return tError;
end
function ModuleOutput_MuteInst(MName, MPrefix, MPara)
local key;
local val;
local paraID;
local tem_MPara = {}
create_hidden_input(MPrefix.."IACTION", "");
create_hidden_input(MPrefix.."IMNAME", MName);
create_hidden_input(MPrefix.."IDENTITY", "");
if MPara.encrypt == nil then
tem_MPara = MPara
else
tem_MPara = MPara.para
end
for key, val in ipairs(tem_MPara) do
local encodeF = 0
paraID = MPrefix .. tem_MPara[key];
if MPara.encrypt ~= nil then
for i,v in ipairs(MPara.encrypt) do
if val == v then
encodeF = 1
break
end
end
end
if encodeF == 1 then
create_hidden_input(paraID, "", 1);
else
create_hidden_input(paraID, "");
end
end
end
function ModuleOutput_RealInst(MName, MPrefix, MPara)
local tem_MPara = {}
if MPara.encrypt == nil then
tem_MPara = MPara
else
tem_MPara = MPara.para
end
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local reTable = cmapi.querylist(MName, "IGD");
if reTable.IF_ERRORID ~= 0 then
if tError.IF_ERRORID == 0 then
tError = reTable
end
return tError;
end
local count = reTable.Count
create_hidden_input(MPrefix.."INSTNUM", count);
if count == 0 then
return tError
end
if count ~= 1 then
for i=1, count do
local ID = reTable[i];
if "table" == type(ID) then
ID = ID.InstName
end
create_hidden_input(MPrefix.."IACTION"..i, "");
create_hidden_input(MPrefix.."IMNAME"..i, MName);
create_hidden_input(MPrefix.."IDENTITY"..i, ID);
local tData = cmapi.getinst(MName, ID)
if tData.IF_ERRORID ~= 0 then
g_logger:warn("getinst error")
if tError.IF_ERRORID == 0 then
tError = tData
end
return tError;
end
local k, v;
for k,v in pairs(tem_MPara) do
local para = tem_MPara[k];
local val = tData[para];
local encodeF = 0
g_logger:debug("tem_MPara[k]="..tem_MPara[k]);
if MPara.encrypt ~= nil then
for i,val in ipairs(MPara.encrypt) do
if v == val then
encodeF = 1
break
end
end
end
if encodeF == 1 then
create_hidden_input(MPrefix..para..i, val, 1);
else
create_hidden_input(MPrefix..para..i, val);
end
end
end
else
local ID = reTable[1];
if "table" == type(ID) then
ID = ID.InstName
end
set_hidden_input(MPrefix.."IACTION", "");
set_hidden_input(MPrefix.."IMNAME", MName);
set_hidden_input(MPrefix.."IDENTITY", ID);
local tData = cmapi.getinst(MName, ID);
if tData.IF_ERRORID ~= 0 then
g_logger:warn("getinst error")
if tError.IF_ERRORID == 0 then
tError = tData
end
return tError;
end
local k, v;
for k,v in pairs(tem_MPara) do
local para = tem_MPara[k];
local val = tData[para]
set_hidden_input(MPrefix..para, val);
end
end
return tError;
end
function ModuleOutput(MNames, MPrefixs, MParas)
local MName = "";
local MPrefix = "";
local MPara = {};
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
local MIndex=1;
for key, val in ipairs(MNames) do
MIndex = key;
MName = MNames[MIndex]
MPrefix = MPrefixs[MIndex];
MPara = MParas[MIndex];
ModuleOutput_MuteInst(MName, MPrefix, MPara);
tError = ModuleOutput_RealInst(MName, MPrefix, MPara);
if tError.IF_ERRORID ~= 0 then
return tError;
end
end
return tError;
end
