local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local json = require("utils.json")
local module = {}

module.last_notify_id = 0

function string_trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function split_definition(inputstr)
    local delimiter = "\n"

    local t = {}
    for str in string.gmatch(inputstr, "([^" .. delimiter .. "]+)") do
        table.insert(t, string_trim(str))
    end
    return t
end

function show_message(error)
    local message_notify =
        naughty.notify(
        {
            title = "Awesome Word",
            text = error,
            margin = 20,
            replaces_id = module.last_notify_id
        }
    )
    module.last_notify_id = message_notify.id
end

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

function show_rofi(data)
    local command =
        string.format(
        'echo "%s"|rofi -dmenu  -p "Query>" -selected-row 0 -a 0',
        data.word ..
            "\nus:[" .. data.us_pronunciations .. "] uk:[" .. data.uk_pronunciations .. "]\n" .. data.definition
    )
    awful.spawn.easy_async_with_shell(
        command,
        function(stdout, stderr, reason, exit_code)
            stdout = string_trim(stdout)
            if stdout == data.word and module.enable_anki then
                saveAnki(data)
            end
        end
    )
end

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
function saveAnki(data)
    local request_data = buildAnkiData(data)

    local command =
        string.format(
        "curl --location --request GET 'localhost:%s'  --header 'Content-Type: application/json' --data-raw '%s'",
        module.anki_connect_port,
        request_data
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

function convertResponse(response)
    local data = {}
    data.word = response.data.content
    data.us_audio = response.data.us_audio
    data.uk_audio = response.data.uk_audio
    data.definition = table.concat(split_definition(response.data.definition), "\n")
    data.us_pronunciations = response.data.pronunciations.us
    data.uk_pronunciations = response.data.pronunciations.uk
    return data
end

function query(word)
    assert(word ~= nil, "请输入正确的单词")
    local url = string.format("https://api.shanbay.com/bdc/search/?word=%s", word)
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
            local data = convertResponse(response)
            show_notify(data)
        end
    )
end

function module.init(args)
    module.enable_anki = args.enable_anki or false
    module.anki_desk = args.anki_desk or "Default"
    module.anki_model = args.anki_model or "Basic"
    module.anki_connect_port = args.anki_connect_port or 8080
    module.allow_duplicate = args.allow_duplicate or false
    module.us_audio_field = args.us_audio_field or "audio"
    module.uk_audio_field = args.uk_audio_field or "audio"
end

--
function module.query(word)
    query(word)
end
return module
