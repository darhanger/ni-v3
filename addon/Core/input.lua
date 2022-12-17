-------------------
-- Input hook functions for ni
local ni = ...

ni.input = {}

-- Localization to avoid hooks
local contains_key = ni.table.contains_key
local tinsert = ni.client.get_function("tinsert", "insert")
local tremove = ni.client.get_function("tremove", "remove")

--- virtual key to string table
local keys = {
   [0x01] = "LBUTTON", -- Left mouse button
   [0x02] = "RBUTTON", -- Right mouse button
   [0x03] = "CANCEL", -- Control-break processing
   [0x04] = "MBUTTON", -- Middle mouse button (three-button mouse)
   [0x05] = "XBUTTON1", -- X1 mouse button
   [0x06] = "XBUTTON2", -- X2 mouse button
   [0x08] = "BACK", -- BACKSPACE key
   [0x09] = "TAB", -- TAB key
   [0x0C] = "CLEAR", -- CLEAR key
   [0x0D] = "RETURN", -- ENTER key
   [0x10] = "SHIFT", -- SHIFT key
   [0x11] = "CONTROL", -- CTRL key
   [0x12] = "MENU", -- ALT key
   [0x13] = "PAUSE", -- PAUSE key
   [0x1B] = "ESCAPE", -- ESC key
   [0x20] = "SPACE", -- SPACEBAR
   [0x21] = "PRIOR", -- PAGE UP key
   [0x22] = "NEXT", -- PAGE DOWN key
   [0x23] = "END", -- END key
   [0x24] = "HOME", -- HOME key
   [0x2C] = "SNAPSHOT", -- PRINT SCREEN key
   [0x2D] = "INSERT", -- INS key
   [0x2E] = "DELETE", -- DEL key
   [0x30] = "0", -- 0 key
   [0x31] = "1", -- 1 key
   [0x32] = "2", -- 2 key
   [0x33] = "3", -- 3 key
   [0x34] = "4", -- 4 key
   [0x35] = "5", -- 5 key
   [0x36] = "6", -- 6 key
   [0x37] = "7", -- 7 key
   [0x38] = "8", -- 8 key
   [0x39] = "9", -- 9 key
   [0x41] = "A", -- A key
   [0x42] = "B", -- B key
   [0x43] = "C", -- C key
   [0x44] = "D", -- D key
   [0x45] = "E", -- E key
   [0x46] = "F", -- F key
   [0x47] = "G", -- G key
   [0x48] = "H", -- H key
   [0x49] = "I", -- I key
   [0x4A] = "J", -- J key
   [0x4B] = "K", -- K key
   [0x4C] = "L", -- L key
   [0x4D] = "M", -- M key
   [0x4E] = "N", -- N key
   [0x4F] = "O", -- O key
   [0x50] = "P", -- P key
   [0x51] = "Q", -- Q key
   [0x52] = "R", -- R key
   [0x53] = "S", -- S key
   [0x54] = "T", -- T key
   [0x55] = "U", -- U key
   [0x56] = "V", -- V key
   [0x57] = "W", -- W key
   [0x58] = "X", -- X key
   [0x59] = "Y", -- Y key
   [0x5A] = "Z", -- Z key
   [0x5B] = "LWIN", -- Left Windows key
   [0x5C] = "RWIN", -- Right windows key
   [0x60] = "NUMPAD0", -- Numeric keypad 0 key
   [0x61] = "NUMPAD1", -- Numeric keypad 1 key
   [0x62] = "NUMPAD2", -- Numeric keypad 2 key
   [0x63] = "NUMPAD3", -- Numeric keypad 3 key
   [0x64] = "NUMPAD4", -- Numeric keypad 4 key
   [0x65] = "NUMPAD5", -- Numeric keypad 5 key
   [0x66] = "NUMPAD6", -- Numeric keypad 6 key
   [0x67] = "NUMPAD7", -- Numeric keypad 7 key
   [0x68] = "NUMPAD8", -- Numeric keypad 8 key
   [0x69] = "NUMPAD9", -- Numeric keypad 9 key
   [0x6A] = "MULTIPLY", -- Multiply key
   [0x6B] = "ADD", -- Add key
   [0x6C] = "SEPARATOR", -- Separator key
   [0x6D] = "SUBTRACT", -- Subtract key
   [0x6E] = "DECIMAL", -- Decimal key
   [0x6F] = "DIVIDE", -- Divide key
   [0x70] = "F1", -- F1 key
   [0x71] = "F2", -- F2 key
   [0x72] = "F3", -- F3 key
   [0x73] = "F4", -- F4 key
   [0x74] = "F5", -- F5 key
   [0x75] = "F6", -- F6 key
   [0x76] = "F7", -- F7 key
   [0x77] = "F8", -- F8 key
   [0x78] = "F9", -- F9 key
   [0x79] = "F10", -- F10 key
   [0x7A] = "F11", -- F11 key
   [0x7B] = "F12", -- F12 key
   [0x7C] = "F13", -- F13 key
   [0x7D] = "F14", -- F14 key
   [0x7E] = "F15", -- F15 key
   [0x7F] = "F16", -- F16 key
   [0x80] = "F17", -- F17 key
   [0x81] = "F18", -- F18 key
   [0x82] = "F19", -- F19 key
   [0x83] = "F20", -- F20 key
   [0x84] = "F21", -- F21 key
   [0x85] = "F22", -- F22 key
   [0x86] = "F23", -- F23 key
   [0x87] = "F24", -- F24 key
   [0xA0] = "LSHIFT", -- Left SHIFT key
   [0xA1] = "RSHIFT", -- Right SHIFT key
   [0xA2] = "LCONTROL", -- Left CONTROL key
   [0xA3] = "RCONTROL", -- Right CONTROL key
}

-- Input table to track down/up states
local input_down = {}
do
   -- Initialize this table with each key as false
   for _, key in ni.table.pairs(keys) do
      input_down[key] = false
   end
end

--[[--
@local
Gets the key string from key code
 
Parameters:
- **key** `number`
 
Returns:
- **key** `string`
@param key number
]]
local function key_to_string(key)
   return keys[key]
end

--[[--
@local
Sets the input state to true for down, or false for up
 
Parameters:
- **key** `number`
- **down** `boolean`
@param key
@param down
]]
local function update_input_state(key, down)
   -- We only care about tracking the keys listed above for now
   local key_string = key_to_string(key)
   if key_string then
      input_down[key_string] = down
   end
end

--- registered input handlers
local input_handlers = {}
-- Creating for count to prevent lookup time of the table length
local items_in_table = 0

--[[--
@local
Main callback registered to the backend for input processing
 
Parameters:
- **state** `number`
- **key** `number`
 
Returns:
- **block_input** `boolean`
@param state number
@param key number
]]
local function input_handler(state, key)
   -- State of 0x100 and 0x104 is for down on keys or system keys
   if state == 0x100 or state == 0x104 then
      update_input_state(key, true)
   -- State of 0x101 and 0x105 is for up on keys or system keys
   elseif state == 0x101 or state == 0x105 then
      update_input_state(key, false)
   end
   local block_input = false
   -- Run each of the registered callbacks to see if we should block input
   for i = 1, items_in_table do
      local result = input_handlers[i].handler(state, key)
      if result and not block_input then
         block_input = result
      end
   end
   return block_input
end

--[[--
Gets if a virtual key is down or up
 
Parameters:
- **key** `string`
 
Returns:
- **down** `boolean`
@param key string
]]
function ni.input.key_down(key)
   if not contains_key(input_down, key) then
      return false
   end
   return input_down[key]
end

--[[--
Registers a callback to the input main callback
 
Parameters:
- **title** `string`
- **func** `function`
@param title string
@param func function
]]
function ni.input.register_callback(title, func)
   local contains = false
   for i = 1, #input_handlers do
      if input_handlers[i].name == title then
         contains = true
         break
      end
   end
   if not contains then
      tinsert(input_handlers, {
         name = title,
         handler = func
      })
      items_in_table = #input_handlers
   end
end

--[[--
Unregister a callback to from the input main calllback
 
Parameters:
- **title** `string`
@param title string
]]
function ni.input.unregister_callback(title)
   for i = 1, #input_handlers do
      if input_handlers[i].name == title then
         tremove(input_handlers, i)
         items_in_table = #input_handlers
         return
      end
   end
end

-- Finish up with registering our callback
ni.backend.RegisterCallback(input_handler)