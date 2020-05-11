local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local json = require("utils.json")
local module = {}

module.last_notify_id = 0
module.last_result = {}

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

function show_message(error)
    local message_notify =
        naughty.notify(
        {
            title = "Awesome",
            text = error,
            margin = 20,
            replaces_id = module.last_notify_id
        }
    )
    module.last_notify_id = message_notify.id
end
-- 通过通知显示单词信息
function show_notify(data)
    if module.enable_anki then
        module.last_notify_id =
            naughty.notify(
            {
                title = data.word,
                text = "\nus:[" ..
                    data.us_pronunciations .. "] uk:[" .. data.uk_pronunciations .. "]\n" .. data.definition,
                margin = 20,
                replaces_id = module.last_notify_id,
                actions = {
                    save = function()
                        saveAnki(data)
                    end
                }
            }
        ).id
    else
        module.last_notify_id =
            naughty.notify(
            {
                title = data.word,
                text = "\nus:[" ..
                    data.us_pronunciations .. "] uk:[" .. data.uk_pronunciations .. "]\n" .. data.definition,
                margin = 20,
                replaces_id = module.last_notify_id
            }
        ).id
    end
end
-- 通过rofi显示单词信息
function show_rofi(data)
    local command =
        string.format(
        "echo '%s'|rofi -dmenu  -p 'Query>' -selected-row 0 -a 0",
        string_safe(data.word) ..
            "\nus:[" ..
                string_safe(data.us_pronunciations) ..
                    "] uk:[" .. string_safe(data.uk_pronunciations) .. "]\n" .. string_safe(data.definition)
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
    local json_data = {
        action = "addNote",
        version = 6,
        params = {
            note = {
                deckName = module.anki_desk,
                modelName = module.anki_model,
                fields = {
                    Word = data.word,
                    Definition = data.definition
                },
                options = {
                    allowDuplicate = module.allow_duplicate,
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
                            module.us_audio_field
                        }
                    },
                    {
                        url = data.uk_audio,
                        filename = data.word .. "uk.mp3",
                        skipHash = "7e2c2f954ef6051373ba916f000168dc",
                        fields = {
                            module.uk_audio_field
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
        module.anki_connect_port,
        string_trim(string_safe(request_data))
    )
    gears.debug.dump(command, "", 1)
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            if exit_code ~= 0 then
                show_message("保存失败：连接Anki出错")
                gears.debug.dump(reason .. "|" .. stderr, "request failed", 2)
                return
            end

            local response = json.decode(stdout)
            gears.debug.dump(response, "", 2)
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
    data.word = response.data.content
    data.us_audio = response.data.us_audio
    data.uk_audio = response.data.uk_audio

    data.definition = table.concat(split_definition(response.data.definition), "\n")
    data.us_pronunciations = response.data.pronunciations.us
    data.uk_pronunciations = response.data.pronunciations.uk
    return data
end

-- 单词查询
function dict(word, copy)
    word = word or ""
    local url = string.format("https://api.shanbay.com/bdc/search/?word=%s", string_trim(string_safe(word)))
    local command = string.format("curl -s -H 'Accept: application/json' --request GET '%s'", url)
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            if exit_code ~= 0 then
                show_message("查询失败：命令执行失败")
                return
            end
            local response = json.decode(stdout)

            if response.status_code ~= 0 then
                show_message(response.msg)
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
    gears.debug.dump(command)
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            if exit_code ~= 0 then
                show_message("翻译失败：命令执行失败")
                return
            end
            local response = json.decode(stdout)
            if response.errorCode ~= 0 then
                show_message(response.msg)
            end
            -- gears.debug.dump(response, "translate", 4)

            local sentences = {}
            for _, paragraph in ipairs(response.translateResult) do
                gears.debug.dump(paragraph, "paragraph", 4)
                for _, item in ipairs(paragraph) do
                    table.insert(sentences, item.tgt)
                end
            end

            module.last_notify_id =
                naughty.notify(
                {
                    title = "翻译 [" .. response.type .. "]",
                    text = "\n" .. table.concat(sentences, "\n"),
                    margin = 20,
                    replaces_id = module.last_notify_id,
                    timeout = 0
                }
            ).id
            module.last_result = table.concat(sentences, "\n")
            if copy then
                set_clipboard(module.last_result)
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

function module.init(args)
    module.enable_rofi = args.enable_rofi or false
    module.enable_anki = args.enable_anki or false
    module.anki_desk = args.anki_desk or "Default"
    module.anki_model = args.anki_model or "Basic"
    module.anki_connect_port = args.anki_connect_port or 8080
    module.allow_duplicate = args.allow_duplicate or false
    module.us_audio_field = args.us_audio_field or "audio"
    module.uk_audio_field = args.uk_audio_field or "audio"
end

function module.query(data, copy)
    if is_word(data) then
        dict(data, copy)
    else
        translate(data, copy)
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
