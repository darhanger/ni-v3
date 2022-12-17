-------------------
-- io functions for ni
local ni = ...

ni.io = {}

-- Localization to avoid hooks
local tinsert = ni.backend.GetFunction("tinsert", "insert")

--[[--
Table keys:
- **extension** `string`
- **filename** `string`
- **stem** `string`
- **path** `string`
@table entry
]]

--[[--
Table keys:
- **path** `string`
- **is_directory** `boolean`
@table content
]]

--[[--
Gets the base path for ni, which is the location the loader resides.
 
Returns:
- **path** `string`
]]
function ni.io.get_base_path()
   return ni.backend.GetBaseFolder()
end

--[[--
@local
Gets the file extension
 
Parameters:
- **path** `string`
 
Returns:
- **extension** `string`
@param path string
]]
local function get_extension(path)
   if not path then
      return nil
   end
   return path:match("^.+(%..+)$")
end

--[[--
@local
Gets the filename from the path specified.
 
Parameters:
- **path** `string`
 
Returns:
- **filename** `string`
@param path string
]]
local function get_filename(path)
   if not path then
      return nil
   end
   local start, finish = path:find('[%w%s!-={-|]+[_%.].+')
   if not start or not finish then
      return nil
   end
   return path:sub(start, #path)
end

--[[--
@local
Returns the stem path component. This is the filename without the extension.
 
Parameters:
- **path** `string`
 
Returns:
- **stem** `string`
@param path string
]]
local function get_stem(path)
   if not path then
      return nil
   end
   local filename = get_filename(path)
   if not filename then
      return path:match("(.+)%..+$")
   end
   return filename:match("(.+)%..+$")
end

--[[--
Split the path into an entry table.
 
Parameters:
- **path** `string`
 
Returns:
- [`entry table`](#entry)
@param path string
]]
function ni.io.split_path(path)
   return {
      filename = get_filename(path),
      extension = get_extension(path),
      stem = get_stem(path),
      path = path
   }
end

--[[--
Loads a string into buffer to be executed.
 
Parameters:
- **string** `string`
- **chunk** `string`
 
Returns:
- **func** `function`
- **err** `string`
@param string string
@param[opt] chunk string
]]
function ni.io.load_string(string, chunk)
   return ni.backend.LoadString(string, chunk)
end

--[[--
Loads a file into the lua buffer to be executed.
 
Parameters:
- **file** `string`
- **chunk** `string`
 
Returns:
- **func** `function`
- **error** `string`
@param file string
@param[opt] chunk string
]]
function ni.io.load_buffer(file, chunk)
   return ni.backend.LoadFile(file, chunk)
end

--[[--
This function will load the selected file into the lua state.
 
Parameters:
- **path** `string`
- **chunk** `string`
- **parser** `function`
 
Returns:
- **success** `boolean`
- **error** `string`
@param path string
@param[opt] chunk string
@param[opt] parser func
]]
function ni.io.load_file(path, chunk, parser)
   return ni.backend.ParseFile(path, function(content)
      if not parser or parser(content) then
         chunk = chunk or get_filename(path)
         local func, err = ni.io.load_string(content, string.format("@%s", chunk))
         if func then
            func(ni)
            return true
         end
         ni.backend.Error(err)
      end
      return false
   end)
end

--[[--
@local
Checks if an entry is valid
 
Parameters:
- **entry** `entry table`
 
Returns:
- **valid** `boolean`
@param entry @{entry}
]]
local function valid_entry(entry)
   return entry and entry.path and entry.filename
end

--[[--
Loads the entry into the lua state
 
Parameters:
- **entry** `entry table`
- **parser** `function`
 
Returns:
- **success** `boolean`
- **error** `string`
@param entry @{entry}
@param[opt] parser function
]]
function ni.io.load_entry(entry, parser)
   if not valid_entry(entry) then
      return false, "Invalid entry table"
   end
   return ni.io.load_file(entry.path, entry.filename, parser)
end

--[[--
Gets contents from directory
 
Parameters:
- **directory** `string`
 
Returns:
- **content** `content table`
- **error** `string`
@param directory string
]]
function ni.io.get_contents(directory)
   return ni.backend.GetDirectoryContents(directory)
end

--[[--
Gets the folders within a directory
 
Parameters:
- **directory** `string`
 
Returns:
- **folders** `string table`
- **error** `string`
@param directory string
]]
function ni.io.get_folders(directory)
   local contents, error = ni.io.get_contents(directory)
   if error then
      return nil, error
   end
   local folders = {}
   for _, content in ni.table.pairs(contents) do
      if content.is_directory then
         tinsert(folders, content.path)
      end
   end
   if #folders == 0 then
      return nil, "No folders within directory"
   end
   return folders
end

--[[--
Gets entries from directory
 
Parameters:
- **directory** `string`
 
Returns:
- **entries** `entry table`
@param directory string
]]
function ni.io.get_entries(directory)
   local contents, error = ni.io.get_contents(directory)
   if error then
      return nil, error
   end
   local entries = {}
   for _, content in ni.table.pairs(contents) do
      if not content.is_directory then
         local entry = ni.io.split_path(content.path)
         if valid_entry(entry) then
            tinsert(entries, entry)
         end
      end
   end
   if #entries == 0 then
      return nil, "No entries obtained from directory"
   end
   return entries
end

--[[--
Gets the content of a file
 
Parameters:
- **file** `string`
- **key** `string`
 
Returns:
- **content** `string`
- **error** `string`
@param file string
@param key string
]]
function ni.io.get_content(file, key)
   return ni.backend.GetContent(file, key)
end

--[[--
Saves the content to a file
 
Parameters:
- **file** `string`
- **content** `string`
 
Returns:
- **on_fail** `nil`
- **on_success** `boolean`
@param file string
@param content string
]]
function ni.io.save_content(file, content)
   return ni.backend.SaveContent(file, content)
end