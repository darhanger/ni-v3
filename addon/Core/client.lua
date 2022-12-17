-------------------
-- Client functions for ni
local ni = ...

ni.client = {}

--[[--
Gets the client C function for the specified string.
 
Parameters:
- **name** `string`
- **binary_name** `string`
 
Returns:
- **function** `function`
 
Notes:
Not all binary functions are registered with the function string passed.
Some may require the binary name to be specified. I.E. tinsert in the binary
is just 'insert'. This function can return nil if a funciton isn't found.
@param name string
@param[opt] binary_name string
]]
function ni.client.get_function(name, binary_name)
   return ni.backend.GetFunction(name, binary_name)
end

-- localize functions here for below use
local GetTime = ni.client.get_function("GetTime")
local GetBuildInfo = ni.client.get_function("GetBuildInfo")
local GetNetStats = ni.client.get_function("GetNetStats")
local select = ni.client.get_function("select")
local tonumber = ni.client.get_function("tonumber")

--[[--
Gets the current client build information
 
Returns:
- **version** `string`
- **build** `string`
- **date** `string`
]]
function ni.client.build_info()
   -- The first GetBuildInfo that is found is for the GlueXML which has 2
   -- returns prior
   return select(3, GetBuildInfo())
end

--[[--
Gets the current client version
 
Returns:
- **version** `string`
]]
function ni.client.version()
   local version = ni.client.build_info()
   return version
end

--[[--
Gets the current client build number
 
Returns:
- **build** `string`
 
Notes:
3.3.5 is 12340,
4.3.4 is 15595,
5.4.8 is 18414
]]
function ni.client.build()
   local _, build = ni.client.build_info()
   return tonumber(build)
end

-- localize the build here for use below
local build = ni.client.build()

--[[--
Raise a lua error with the specified message.
 
Parameters:
- **message** `string`
@param message string
]]
function ni.client.error(message)
   return ni.backend.Error(message)
end

--[[--
Registers a frame to be protected from enumeration with the games Lua.
 
Parameters:
- **frame** `frame`
 
Returns:
- **success** `boolean`
@param frame
]]
function ni.client.protect_frame(frame)
   return ni.backend.ProtectFrame(frame)
end

--[[--
Calls a function with the game taint triggering.
 
Parameters:
- **name** `string`
- **...** `functions args`
 
Returns:
- **...** `functions returns`
@param name string
@param[opt] ...
]]
function ni.client.call_protected(name, ...)
   return ni.backend.CallProtected(name, ...)
end

--[[--
Sets the last hardware action as if a key was pressed.
]]
function ni.client.reset_last_hardware_action()
   return ni.backend.ResetLastHardwareAction()
end

--[[--
Gets the computer uptime in seconds
 
Returns:
- **uptime** `number`
]]
function ni.client.get_time()
   return GetTime()
end

--[[--
Runs macro text securely
 
Parameters:
- **text** `string`
@param text string
]]
function ni.client.run_text(text)
   return ni.client.call_protected("RunMacroText", text)
end

--[[--
Gets the current client network statistics

Returns:
- **down** `number`
- **up** `number`
- **latency** `number`
 
Or:
- **down** `number`
- **up** `number`
- **latency_home** `number`
- **latency_world** `number`
 
Notes:
3.3.5 network statistics didn't differentiate between latency home and world.
Latency home is the connection between computer to server in milliseconds and
latency world is the connection between computer and server including TCP
overhead.
]]
function ni.client.get_net_stats()
   return GetNetStats()
end

--[[--
Gets the average home latence in milliseconds
 
Returns:
- **latency** `number`
]]
function ni.client.latency()
   local _, _, home_latency, world_latency = ni.client.get_net_stats()
   if build == 12340 then
      return home_latency
   else
      return world_latency
   end
end