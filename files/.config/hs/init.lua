hs = hs
spoon = spoon

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("TimeMachineProgress", { start = true })

local function getAppID(app)
  if hs.application.infoForBundlePath(app) then
    return hs.application.infoForBundlePath(app)['CFBundleIdentifier']
  end
end

local function braveProfile(profile)
  return function(url)
    hs.execute('/usr/bin/open -n -a "Brave Browser.app" --args --profile-directory="' .. profile .. '" ' .. url)
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

local browserProfiles = {
  personal = braveProfile('Default'),
  work = braveProfile('Profile 1'),
  customer = braveProfile('Profile 2')
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
        { URLFiles.customer, browsers.arc },
      },
    },
    start = true,
    loglevel = 'debug'
  }
)

hs.hotkey.showHotkeys({ "cmd", "shift" }, "1")

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "V", "type clipboard contents", function()
  hs.alert.show("Typing Clipboard..")
  local inputString = hs.pasteboard.getContents()
  for i = 1, #inputString do
    hs.eventtap.keyStrokes(inputString:sub(i, i))
    hs.timer.usleep(100000)
  end
end)
