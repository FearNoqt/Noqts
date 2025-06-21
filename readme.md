-- setting window
local window = UILibrary:CreateWindow("Titlebar")
-- setting tabs
local tab1 = UILibrary:AddTab(window, "Main")
-- setting lable
UILibrary:AddLabel(tab1, "Welcome")
-- setting button
UILibrary:AddButton(tab1, "Click Me", function()
    print("Clicked on Main tab")
end)

local tab2 = UILibrary:AddTab(window, "Settings")
UILibrary:AddLabel(tab2, "Adjust here")
UILibrary:AddButton(tab2, "Apply", function()
    print("Applied settings")
end)
