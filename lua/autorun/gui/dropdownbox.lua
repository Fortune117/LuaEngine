

--[[
 ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▄ ▀▀▄  ▄▀▀▄ ▀▄  ▄▀▄▄▄▄  
█ ▄▀   █ ▐  ▄▀   ▐ █ █   ▐ █   ▀▄ ▄▀ █  █ █ █ █ █    ▌ 
▐ █    █   █▄▄▄▄▄     ▀▄   ▐     █   ▐  █  ▀█ ▐ █      
  █    █   █    ▌  ▀▄   █        █     █   █    █      
 ▄▀▄▄▄▄▀  ▄▀▄▄▄▄    █▀▀▀       ▄▀    ▄▀   █    ▄▀▄▄▄▄▀ 
█     ▐   █    ▐    ▐          █     █    ▐   █     ▐  
▐         ▐                    ▐     ▐        ▐   
]]


local lg = love.graphics
local lm = love.mouse
local PANEL = {}

local defaultFont = lg.newFont( 16 )

function PANEL:init()
	self.__options = {}
	self:setFont( defaultFont )
	self:setTextColor( 100, 100, 100, 255 )
end 

function PANEL:addOption( text, func, icon )
	table.insert( self.__options, {text = text, func = func, icon = icon } )
end

function PANEL:getOptionTable()
	return self.__options 
end 

function PANEL:setDefaultText( str )
	self.__defaultText = str 
	self:setText( str )
end 

function PANEL:getDefaultText()
	return self.__defaultText
end 

function PANEL:setDropMenuHeight( h )
	self.__dropMenuHeight = h 
end 

function PANEL:getDropMenuHeight()
	return self.__dropMenuHeight or (#self:getOptionTable()-1)*self:getHeight()
end 

function PANEL:doClick()
	local master = self 
	if not self.dropPanel then 

		local tbl = self:getOptionTable()
		self.dropPanel = gui.create( "panel", self )

		local w,h = self:getSize()
		local panel = self.dropPanel

		local dropHeight = self:getDropMenuHeight()
		panel:setPos( 0, h + 1 )
		panel:setSize( w, dropHeight )
		local b = 1 
		function panel:paint( w, h ) 
			lg.setColor( 0, 102, 255, 255 )
			lg.rectangle( "fill", 0, 0, w, h )

			lg.setColor( 22, 22, 22, 255 )
			lg.rectangle( "fill", b, b, w - b*2, h - b*2 )
		end
		
		for i = 1,#tbl do 
			local optionH = dropHeight/(#tbl-1) 
			local button = gui.create( "button", panel )
			button:setPos( 0, (i-1)*(optionH*.75) + i )
			button:setSize( w, h )
			button:setText( tbl[ i ].text )
			button:setTextColor( 100, 100, 100, 255 )
			button:setFont( defaultFont )
			function button:paint( w, h )
			end 
			function button:doClick()
				master:setText( tbl[ i ].text )
				tbl[ i ].func( master, self )
				master:closeDropMenu()
			end 
		end 

	else 
		self:closeDropMenu()
	end 
end 

function PANEL:closeDropMenu()
	self.dropPanel:remove()
	self.dropPanel = false 
end 


local down = "v"
local font = lg.newFont( 22 )
function PANEL:paint( w, h )

	local font = self:getFont()
	local t = self:getText()
	local tw = font:getWidth( t )

	local sz = h*0.25
	local x = w/2 + tw/2 + sz*1.5
	local y = h/2 
	lg.setColor( 88, 88, 88, 255 )
	lg.circle( "line", x, y, sz )

	lg.setFont( font )
	local tw,th = font:getWidth( down ),font:getHeight( down )
	lg.print( down, x, y, 0, 1, 1, tw/2, th/2 )

end 

gui.register( "dropDownMenu", PANEL, "button" )

