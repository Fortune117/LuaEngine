
--[[--
 ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▄ ▀▀▄  ▄▀▀▄ ▀▄  ▄▀▄▄▄▄  
█ ▄▀   █ ▐  ▄▀   ▐ █ █   ▐ █   ▀▄ ▄▀ █  █ █ █ █ █    ▌ 
▐ █    █   █▄▄▄▄▄     ▀▄   ▐     █   ▐  █  ▀█ ▐ █      
  █    █   █    ▌  ▀▄   █        █     █   █    █      
 ▄▀▄▄▄▄▀  ▄▀▄▄▄▄    █▀▀▀       ▄▀    ▄▀   █    ▄▀▄▄▄▄▀ 
█     ▐   █    ▐    ▐          █     █    ▐   █     ▐  
▐         ▐                    ▐     ▐        ▐   
--]]--

local lg = love.graphics
local lm = love.mouse
local PANEL = {}

local buttonD =
{
	{ "Resume", function( self )
		game.unpause()
		self:getParent():remove()
	end },
	{ "Save", function( self )
		
	end },
	{ "Save and Exit", function( button )
		local p = button:getParent()
		p:remove()
		game.changeState( "menu" )
	end }
}

local padding = 40 
function PANEL:initialize() 

	self.buttons = {}
	local w, h = love.graphics.getDimensions()
	self:setSize( w, h )
	self:center()
	self:blurBackground( true, 0.1 )

	local bWidth = w/5
	local bHeight = h/10
	local UISpace = h-padding*2
	local gap = UISpace/#buttonD
	for i = 1,#buttonD do

		local tbl = buttonD[ i ]
		local b = gui.create( "button", self )
		local bY = gap*(i-1) + bHeight/2 -- fuk dis gey erth
		b.doClick = tbl[ 2 ]
		b:setSize( bWidth, bHeight )
		b:setPos( w/2 - bWidth/2, bY + padding ) 
		b:setText( tbl[ 1 ] )
		b.clr = 120
		b.alpha = 150
		b.tAlpha = 150

		function b:paint( w, h )

		end 

		function b:onCursorEntered()
			self.tAlpha = 255
		end 

		function b:onCursorExited()
			self.tAlpha = 150
		end 

		function b:think()
			if self.alpha ~= self.tAlpha then
				self.alpha = math.approach( self.alpha, self.tAlpha, 8 )
				b:setTextColor( { self.clr, self.clr, self.clr, self.alpha } )
			end 
		end 

		b:setTextColor( { b.clr, b.clr, b.clr, b.alpha } )
	end 

end 

function PANEL:paint()

	lg.setColor( 11, 11, 11, 120 )
	lg.rectangle( "fill", 0, 0, self:getWidth(), self:getHeight() )

end
gui.register( "pMenu", PANEL, "panel" )