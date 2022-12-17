-------------------
-- Event handler and functions
local ni = ...

ni.events = {}

local tinsert = ni.client.get_function("tinsert", "insert")
local tremove = ni.client.get_function("tremove", "remove")

-- Table to store the registered event handlers
local event_handlers = {}
-- Creating for count to prevent lookup time of the table length
local items_in_table = 0

--[[--
@local
Default event handler for all client events
 
Parameters:
- **self** `frame`
- **event** `string`
- **...**
@param self
@param event
@param[opt] ...
]]
local function event_handler(self, event, ...)
   for i = 1, items_in_table do
      if event_handlers[i].name == event then
         event_handlers[i].handler(event, ...)
      end
   end
end

--[[--
Function for registering callback handlers to be executed.
 
Parameters:
- **title** `string`
- **func** `function`
@param title string
@param func function
]]
function ni.events.register_callback(title, func)
   local contains = false
   for i = 1, #event_handlers do
      if event_handlers[i].name == title then
         contains = true
         break
      end
   end
   if not contains then
      tinsert(event_handlers, {
         name = title,
         handler = func
      })
      items_in_table = #event_handlers
   end
end

--[[--
Function for unregistering callback handlers.
 
Parameters:
- **title** `string`
@param title string
]]
function ni.events.unregister_callback(title)
   for key, handler in ni.table.pairs(event_handlers) do
      if handler.name == title then
         tremove(event_handlers, key)
         items_in_table = #event_handlers
         return
      end
   end
end

--[[--
Initializes the event handler to be used.
]]
function ni.events.initialize()
   ni.frame:SetScript("OnEvent", event_handler)
end