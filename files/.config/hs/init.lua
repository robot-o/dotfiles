hs = hs

hs.hotkey.showHotkeys({ "cmd", "shift" }, "1")

hs.hotkey.bind({ "alt", "shift", "ctrl" }, "V", "type clipboard contents", function()
  hs.alert.show("Typing Clipboard..")
  local inputString = hs.pasteboard.getContents()
  for i = 1, #inputString do
    hs.eventtap.keyStrokes(inputString:sub(i, i))
    hs.timer.usleep(100000)
  end
end)
