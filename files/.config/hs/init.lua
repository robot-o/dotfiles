hs = hs
spoon = spoon

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("TimeMachineProgress", { start = true })

local caffeine = hs.menubar.new()
local iconOn = hs.image.imageFromPath("/users/User/.config/hs/icons/mug-white.png")
local iconOff = hs.image.imageFromPath("/users/User/.config/hs/icons/bed.png")

local function setCaffeineDisplay(state)
  if state then
    caffeine:setIcon(iconOn)
    caffeine:setTooltip("COFE >:3")
  else
    caffeine:setIcon(iconOff)
    caffeine:setTooltip("EEPY zZzZ")
  end
end

local function caffeineClicked()
  setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
  caffeine:setClickCallback(caffeineClicked)
  setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

local function getAppID(app)
  if hs.application.infoForBundlePath(app) then
    return hs.application.infoForBundlePath(app)['CFBundleIdentifier']
  end
end

local function braveProfile(profile)
  return function(url)
    url = url or ""
    hs.execute('open -n -a "Brave Browser.app" --args --profile-directory="' .. profile .. '" ' .. url)
  end
end

local browserProfiles = {
  personal = braveProfile('Default'),
  work = braveProfile('Profile 1'),
  customer = braveProfile('Profile 2'),
  p3 = braveProfile('Profile 3')
}

local function braveProfileWindow(profile)
  profile = profile or 'personal'
  local win = hs.window.find('Brave %- ' .. profile)
  if win then
    win:focus()
  else
    browserProfiles[profile]()
  end
end

local browsers = {
  brave = getAppID('/Applications/Brave Browser.app'),
  chrome = getAppID('/Applications/Google Chrome.app'),
  safari = getAppID('/Applications/Safari.app'),
  firefox = getAppID('/Applications/Firefox.app'),
  arc = getAppID('/Applications/Arc.app'),
}

local apps = {
  teams = getAppID('/Applications/Microsoft Teams.app'),
}

URLFiles = {
  work = 'urlfiles/work.txt',
  customer = 'urlfiles/customer.txt'
}

spoon.SpoonInstall:andUse('URLDispatcher',
  {
    config = {
      default_handler = browserProfiles.personal,
      url_patterns = {
        { URLFiles.work,     browserProfiles.work },
        { URLFiles.customer, browserProfiles.customer },
      },
    },
    start = true,
    loglevel = 'debug'
  }
)

local meh = { "alt", "shift", "ctrl" }
local hyper = { "alt", "shift", "ctrl", "cmd" }

hs.hotkey.showHotkeys(hyper, '-')

hs.hotkey.bind(hyper, "f", "finder", function() hs.execute('open -a Finder') end)

hs.hotkey.bind(hyper, "r", "reload config", function()
  hs.reload()
end)

local b = hs.hotkey.modal.new(hyper, 'b')

function b:entered() hs.alert('enter mode: browser') end

function b:exited() hs.alert('exit mode: browser') end

b:bind('', "q", "browser - personal",
  function() braveProfileWindow('personal') end,
  function() b:exit() end
)
b:bind('', "w", "browser - work",
  function() braveProfileWindow('work') end,
  function() b:exit() end
)
b:bind('', "e", "browser - customer",
  function() braveProfileWindow('customer') end,
  function() b:exit() end
)
b:bind('', "r", "browser - p3",
  function() braveProfileWindow('p3') end,
  function() b:exit() end
)
b:bind('shift', "q", "browser - personal", function() braveProfileWindow('personal') end)
b:bind('shift', "w", "browser - work", function() braveProfileWindow('work') end)
b:bind('shift', "e", "browser - customer", function() braveProfileWindow('customer') end)
b:bind('shift', "r", "browser - p3", function() braveProfileWindow('p3') end)
b:bind('', 'escape', function() b:exit() end)

hs.hotkey.bind(hyper, "t", "terminal", function()
  hs.execute('open -a "Ghostty"')
end)

hs.hotkey.bind(meh, "`", "lock screen", function()
  hs.shortcuts.run("Start Screen Saver")
end)

hs.hotkey.bind(hyper, "V", "type clipboard contents", function()
  hs.alert.show("Typing Clipboard..")
  local inputString = hs.pasteboard.getContents()
  for i = 1, #inputString do
    hs.eventtap.keyStrokes(inputString:sub(i, i))
    hs.timer.usleep(100000)
  end
end)
