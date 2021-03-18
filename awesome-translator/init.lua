local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local json = require("awesome-translator.json")
local module = {}

module.last_notify_id = 0
module.last_result = {}

module.enable_rofi = false

module.enable_anki = false
module.anki = {}
module.anki.desk = "Default"
module.anki.model = "Basic"
module.anki.connect_port = 8080
module.anki.word_field = "word"
module.anki.definition_field = "definition"
module.anki.us_pronunciation_field = "us_pronunciation"
module.anki.uk_pronunciation_field = "uk_pronunciation"
module.anki.us_audio_field = "audio"
module.anki.uk_audio_field = "audio"

function string_trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end
-- 将单引号转义
function string_safe(s)
    s = s or ""
    return string.gsub(s, "'", "'\\''")
end

function is_word(s)
    local result = string.find(string_trim(s), "[^a-zA-Z']") == nil
    return result
end

function show_error(e)
   show_message(e.message)
end
function show_message(message)
    local message_notify =
        naughty.notify(
        {
            title = "Awesome translator",
            text = message,
            replaces_id = module.last_notify_id
        }
    )
    module.last_notify_id = message_notify.id
end
-- 通过通知显示单词信息
function show_notify(data)
   local message = {
      title = data.word,
      text = "us: [" .. data.us_pronunciation .. "]   uk: [" .. data.uk_pronunciation .. "]\n\n" .. data.definition,
      replaces_id = module.last_notify_id,
      timeout = 10
   }
   if module.enable_anki then
      message.actions = {
         save = function()
            saveAnki(data)
         end
      }
   end
   module.last_notify_id =
      naughty.notify(
         message
      ).id
end
-- 通过rofi显示单词信息
function show_rofi(data)
    local command =
        string.format(
        "echo '%s'|rofi -dmenu  -p 'Query>' -selected-row 0 -a 0",
        string_safe(data.word) ..
            "\nus:[" ..
                string_safe(data.us_pronunciation) ..
                    "] uk:[" .. string_safe(data.uk_pronunciation) .. "]\n" .. string_safe(data.definition)
    )
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            stdout = string_trim(stdout)
            if string_safe(stdout) == string_safe(data.word) and module.enable_anki then
                saveAnki(data)
            end
        end
    )
end
-- 构建anki请求数据结构
function buildAnkiData(data)
    local definition = split_definition(data.definition)

    local fields = {}
    fields[module.anki.word_field] = data.word
    fields[module.anki.definition_field] = table.concat(definition, "<br>")
    fields[module.anki.us_pronunciation_field] = data.us_pronunciation
    fields[module.anki.uk_pronunciation_field] = data.uk_pronunciation

    local json_data = {
        action = "addNote",
        version = 6,
        params = {
            note = {
                deckName = module.anki.desk,
                modelName = module.anki.model,
                fields = fields,
                options = {
                    allowDuplicate = false,
                    duplicateScope = "deck"
                },
                tags = {
                    "Awesome Word Plugin"
                },
                audio = {
                    {
                        url = data.us_audio,
                        filename = data.word .. "us.mp3",
                        skipHash = "7e2c2f954ef6051373ba916f000168dc",
                        fields = {
                            module.anki.us_audio_field
                        }
                    },
                    {
                        url = data.uk_audio,
                        filename = data.word .. "uk.mp3",
                        skipHash = "7e2c2f954ef6051373ba916f000168dc",
                        fields = {
                            module.anki.uk_audio_field
                        }
                    }
                }
            }
        }
    }

    return json.encode(json_data)
end
-- 保存到anki
function saveAnki(data)
    local request_data = buildAnkiData(data)
    local command =
        string.format(
        "curl --location --request GET 'localhost:%s'  --header 'Content-Type: application/json' --data-raw '%s'",
        module.anki.connect_port,
        string_trim(string_safe(request_data))
    )
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            if exit_code ~= 0 then
                show_message("保存失败：连接Anki出错")
                return
            end

            local response = json.decode(stdout)
            if response.error ~= nil then
                show_message("保存失败：" .. response.error)
            else
                show_message("保存成功")
            end
        end
    )
end
function split_definition(inputstr)
    local delimiter = "\n"

    local t = {}
    for str in string.gmatch(inputstr, "([^" .. delimiter .. "]+)") do
        table.insert(t, string_trim(str))
    end
    return t
end
function convert_response(response)

    local data = {}
    data.word = response.query
    data.us_audio = ""
    data.uk_audio = ""
    if response.basic==nil then
        error({message="未找到单词"})
    end
    data.definition =  table.concat(response.basic.explains, "\n")
    data.us_pronunciation = response.basic["us-phonetic"] or ""
    data.uk_pronunciation = response.basic["uk-phonetic"] or ""
    return data
end

-- 单词查询
function query(word, copy)
    word = word or ""
    local url = string.format("http://fanyi.youdao.com/openapi.do?keyfrom=YouDaoCV&key=659600698&type=data&doctype=json&version=1.1&q=%s", string_trim(string_safe(word)))
    local command = string.format("curl -s -H 'Accept: application/json' --request GET '%s'", url)
    awful.spawn.easy_async_with_shell(
       command,
       function(stdout, stderr, reason, exit_code)
          local inner=function(stdout,stderr,reason,exit_code)
             if exit_code ~= 0 then
                error({message="查询失败：命令执行失败"})
             end

             local response = json.decode(stdout)
             if response.errorCode ~= 0 then
                error({message=response.msg})
             end
             local data = convert_response(response)
             if module.enable_rofi then
                show_rofi(data)
             else
                show_notify(data)
             end
             -- 保存结果
             module.last_result = data.definition
             if copy then
                set_clipboard(module.last_result)
             end
          end
          local state,result = pcall(inner,stdout,stderr,reason,exit_code)
          if not state then
             show_error(result)
          end
       end
    )
end

-- 翻译
function translate(input, copy)
    input = input or ""
    local command =
        string.format(
        "curl --location --request POST 'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'i=%s' --data-urlencode 'from=AUTO' --data-urlencode 'to=AUTO' --data-urlencode 'doctype=json'",
        string_trim(string_safe(input))
    )
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
           local inner = function(stdout, stderr, reason, exit_code)
              if exit_code ~= 0 then
                 show_message({message="翻译失败：命令执行失败"})
                 return
              end
              local response = json.decode(stdout)
              if response.errorCode ~= 0 then
                 show_message({message=response.msg})
              end
              -- gears.debug.dump(response, "translate", 4)

              local sentences = {}
              for _, paragraph in ipairs(response.translateResult) do
                 for _, item in ipairs(paragraph) do
                    table.insert(sentences, item.tgt)
                 end
              end

              module.last_notify_id =
                 naughty.notify(
                    {
                       title = "翻译",
                       text = "\n" .. table.concat(sentences, "\n"),
                       replaces_id = module.last_notify_id,
                       timeout = 10
                    }
                 ).id
              module.last_result = table.concat(sentences, "\n")
              if copy then
                 set_clipboard(module.last_result)
              end
           end
          local state,result = pcall(inner,stdout,stderr,reason,exit_code)
          if not state then
             show_error(result)
          end
        end
    )
end
-- 设置剪切版
function set_clipboard(text, callback)
    if text ~= nil then
        local command = string.format("echo -n '%s'|xclip -selection clipboard", string_safe(text))
        awful.spawn.easy_async_with_shell(
            command,
            function(stdout, stderr, reason, exit_code)
                if callback ~= nil then
                    if exit_code == 0 then
                        callback(true)
                    else
                        callback(false)
                    end
                end
            end
        )
    end
end
function module.query(data, copy)
   if is_word(data) then
      query(data,copy)
   else
      translate(data,copy)
   end

end

function module.copy(text)
    text = text or module.last_result
    set_clipboard(
        text,
        function(result)
            if result then
                show_message("复制成功")
            else
                show_message("复制失败")
            end
        end
    )
end
return module
