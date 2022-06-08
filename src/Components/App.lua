local Hoarcekat = script:FindFirstAncestor("Hoarcekat")

local Roact = require(Hoarcekat.Vendor.Roact)

local Preview = require(script.Parent.Preview)
local Sidebar = require(script.Parent.Sidebar)
local StudioThemeAccessor = require(script.Parent.StudioThemeAccessor)

local e = Roact.createElement

local App = Roact.PureComponent:extend("App")

function App:init()
	self.modalFrameRef = Roact.createRef()
end

function App:didMount()
	self:setState({
		modalFrame = self.modalFrameRef:getValue(),
	})
end

function App:render()
	return e(StudioThemeAccessor, {}, {
		function(theme)
			return e("Frame", {
				BackgroundColor3 = theme:GetColor("MainBackground", "Default"),
				Size = UDim2.fromScale(1, 1),
			}, {
				ModalFrame = e("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0, 0),
					Size = UDim2.fromScale(1, 1),
					ZIndex = 2,
					[Roact.Ref] = self.modalFrameRef,
				}),

				Sidebar = e("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.2, 1),
					ZIndex = 3,
				}, {
					Sidebar = e(Sidebar),
				}),

				Preview = self.state.modalFrame and e("Frame", {
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.fromScale(0.8, 1),
					ZIndex = 1,
				}, {
					Preview = e(Preview, {
						modalFrame = self.state.modalFrame,
					}),
				}),
			})
		end,
	})
end

return App
