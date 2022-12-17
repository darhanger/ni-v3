-------------------
-- Window section for ni
local ni = ...

ni.ui = {}

--[[--
Creates a new UI element.
 
Parameters:
- **element** `string`
- **...**
 
Returns:
- **ui_element** `userdata`
@param element string
@param ...
]]
function ni.ui.new(element, ...)
   return ni.backend.ui.new(element, ...)
end

--[[--
Creates a new window.
 
Parameters:
- **title** `string`
- **shown** `boolean`
 
Returns:
- **window** `userdata`
@param title string
@param shown boolean
]]
function ni.ui.window(title, shown)
   return ni.ui.new("Window", title, shown)
end



--[[--
Creates a button.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **button** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.button(parent, same_line)
   return ni.ui.new("Button", parent, same_line)
end

--[[--
Creates a label.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **label** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.label(parent, same_line)
   return ni.ui.new("Label", parent, same_line)
end

--[[--
Creates a checkbox.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **checkbox** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.checkbox(parent, same_line)
   return ni.ui.new("Checkbox", parent, same_line)
end

--[[--
Creates a slider.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **slider** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.slider(parent, same_line)
   return ni.ui.new("Slider", parent, same_line)
end

--[[--
Creates a combo box.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **combobox** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.combobox(parent, same_line)
   return ni.ui.new("ComboBox", parent, same_line)
end

--[[--
Creates a text input.
 
Parameters:
- **parent** `userdata`
- **same_line** `boolean`
 
Returns:
- **input** `userdata`
@param parent userdata
@param[opt] same_line boolean
]]
function ni.ui.input(parent, same_line)
   return ni.ui.new("Input", parent, same_line)
end

--[[--
Creates a new tab selector/manager.
 
Parameters:
- **parent** `userdata`
 
Returns:
- **manager** `userdata`
@param parent userdata
]]
function ni.ui.tab_manager(parent)
   return ni.ui.new("TabSelector", parent)
end

--[[--
Creates a new element separator in the window.
 
Parameters:
- **parent** `userdata`
@param parent userdata
]]
function ni.ui.separator(parent)
   return ni.ui.new("Separator", parent)
end