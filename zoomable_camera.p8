pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
function _init()

 -- create main player camera
 c = cam(9, 9, 128-17, 128-17, 1.5, 14, 14, 13, true, 7)
 -- create secondary map camera
 c2 = cam(88, 88, 24, 24, 0.5, 14, 14, 5, true, 7)
 -- create player sprite
 s = sprite(1*8, 0, 8, 8, 10, 10)

end

function _update()
 
 -- arrow keys to move player
 if btn(⬆️) then s.y -= 1 end
 if btn(⬇️) then s.y += 1 end 
 if btn(⬅️) then s.x -= 1 end
 if btn(➡️) then s.x += 1 end 

 -- update the main camera to
 -- track the player center
 c.settarget(
  s.getcenter().x,
  s.getcenter().y
 )
 
 -- buttons to change main
 -- camera zoom level
 if btn(4) then c.z -= 0.1 end
 if btn(5) then c.z += 0.1 end

end

function _draw()
 
 -- clear the screen
 cls(1)
 
 -- draw the map and sprite
 -- using the main camera
 c.startdraw()
 c.drawmap()
 c.drawsprite(s)
 c.enddraw()
 
 -- draw the map and sprite
 -- using the secondary camera
 c2.startdraw()
 c2.drawmap()
 c2.drawsprite(s)
 c2.enddraw()
 
 -- print instructions
 print("zoomable camera example", 17, 2, 7)
 print("arrows to move, buttons to zoom", 2, 121, 7)
 
end
-->8
-- sprite

function sprite(sx, sy, sw, sh, x, y)

 -- stores data needed for
 -- sspr() draw call

 -- sx = sprite x position on spritesheet
 -- sy = sprite y position on spritesheet
 -- sx = sprite width on spritesheet
 -- sx = sprite height on spritesheet
 -- x = x position to draw sprite
 -- y = y position to draw sprite

 local s = {}

 s.sx = sx
 s.sy = sy
 s.sw = sw
 s.sh = sh
 s.x = x
 s.y = y
 
 -- returns a table containing
 -- sprite center x/y position
 s.getcenter = function()
  return {
   x = s.x + (s.sw/2),
   y = s.y + (s.sh/2)
  }
 end
 
 return s

end
-->8
-- camera

function cam(x, y, w, h, z, tx, ty, bg, b, bc)

 -- x = camera x position
 -- y = camera y position
 -- w = camera width
 -- h = camera height
 -- z = camera zoom factor
 -- tx = camera target x position
 -- ty = camera target y position
 -- bg = map background colour (default = 0)
 -- b = border required (default = no)
 -- bc = border colour (default = 7)

 local c = {}
 c.x = x
 c.y = y
 c.w = w
 c.h = h
 c.z = z
 c.tx = tx
 c.ty = ty
 c.bg = bg or 0
 c.b = b or false
 c.bc = bc or 7

 -- set the camera target
 c.settarget = function(x, y)
  c.tx = x
  c.ty = y
 end

 -- returns the center of the camera
 c.getcenter = function()
  return {x=c.x+c.w/2, y=c.y+c.w/2}
 end

 -- call before using the camera to draw
 c.startdraw = function()
  clip(c.x, c.y, c.w-1, c.h-1)
  rectfill(0, 0, 128, 128, c.bg)  
 end
 
 -- call after using the camera to draw
 c.enddraw = function()
  if (c.b == true) then
   rect(c.x, c.y, c.x+c.w-2, c.y+c.h-2, c.bc) 
  end
  clip()
 end

 -- draws the map
 c.drawmap = function()
  smap(0, 0, 12, 8, c.getcenter().x+0-(c.tx*c.z), c.getcenter().y+0-(c.ty*c.z), 8*8*c.z, 8*8*c.z)
 end

 -- draws a sprite object
 c.drawsprite = function(s)
  sspr(s.sx, s.sy, s.sw, s.sh, c.getcenter().x+(s.x*c.z)-(c.tx*c.z), c.getcenter().y+(s.y*c.z)-(c.ty*c.z), s.sw*c.z, s.sh*c.z)
 end

 return c

end
-->8
-- smap

-- code from tufifdesiks
-- reddit.com/r/pico8/comments/17a00b0

function smap(mx,my,mxs,mys,x,y,xs,ys)

 -- draws a scaled portion of the map

	-- mx = section of map to draw top left corner x in tiles
	-- my = section of map to draw top left corner y in tiles
	-- mxs = width of map section to draw in tiles
	-- mys = height of map section to draw in tiles
	-- x = screen position top left corner x in pixels
	-- y = screen position top left corner y in pixels
	-- xs = how wide to draw section in pixels
	-- ys = how tall to draw section in pixels
	
	local yo=((mys*8-1)/ys)/8

	for i=1,ys+1 do
		tline(x,y-1+i,x+xs,y-1+i,mx,my-yo+i*yo,((mxs*8-1)/xs)/8)
	end

end
__gfx__
0000000000aaaa005355333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa05333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa3333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa3333553300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa3335333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa3333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa03333333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa003335533500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
