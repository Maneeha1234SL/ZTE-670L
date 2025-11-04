function wizardOperation(operation)
local tError =
{
IF_ERRORID = 0,
IF_ERRORSTR = "SUCC",
IF_ERRORPARAM = "SUCC",
IF_ERRORTYPE = "-1",
};
if operation == "SET" then
g_logger:debug("wizardOperation SET");
return tError;
else
g_logger:debug("wizardOperation GET");
return tError;
end
end
