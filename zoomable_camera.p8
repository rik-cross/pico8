pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
function _init()

 -- player sprite coordinates
 px = 16
 py = 16

 -- create main player camera
 c = cam(9, 9, 128-17, 128-17, 2, 14, 14, 5, true, 7)
 -- create secondary map camera
 c2 = cam(88, 88, 24, 24, 0.5, 14, 14, 5, true, 7)

end

function _update()
 
 -- arrow keys to move player
 if btn(⬆️) then py -= 1 end
 if btn(⬇️) then py += 1 end 
 if btn(⬅️) then px -= 1 end
 if btn(➡️) then px += 1 end 

 -- update the main camera to
 -- track the player center
 c.set_target(px + 4, py + 4)
 
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
 c.start_draw()
 c.draw_map(0, 0, 6, 6, 0, 0)
 c.draw_sspr(32, 0, 16, 16, 24, 24)
 c.draw_spr(1, px, py) 
 c.end_draw()
 
 -- draw the map and sprite
 -- using the secondary camera
 c2.start_draw()
 c2.draw_map(0, 0, 6, 6, 0, 0)
 c2.draw_sspr(32, 0, 16, 16, 24, 24)
 c2.draw_spr(1, px, py)
 c2.end_draw()
 
 -- print instructions
 print("zoomable camera example", 17, 2, 7)
 print("arrows to move, buttons to zoom", 2, 121, 7)

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

 -- returns the center of the camera
 c.get_center = function()
  return {x=c.x+(c.w/2), y=c.y+(c.h/2)}
 end

 -- set the camera target
 c.set_target = function(x, y)
  c.tx = x
  c.ty = y
 end
 
 -- get the camera target
 c.get_target = function()
  return {x = c.tx, y = c.ty}
 end

 -- call before using the camera to draw
 c.start_draw = function()
  clip(c.x, c.y, c.w-1, c.h-1)
  rectfill(0, 0, 128, 128, c.bg)  
 end
 
 -- call after using the camera to draw
 c.end_draw = function()
  if (c.b == true) then
   rect(c.x, c.y, c.x+c.w-2, c.y+c.h-2, c.bc) 
  end
  clip()
 end

 -- draws the map
 -- tx = lefmost map tile
 -- ty = rightmost map tile
 -- tw = map width (in tiles)
 -- th = map height (in tiles)
 -- x = x position to draw map
 -- y = y position to draw map
 c.draw_map = function(tx, ty, tw, th, x, y)
  smap(tx, ty, tw, th, c.get_center().x+x-(c.tx*c.z), c.get_center().y+y-(c.ty*c.z), tw*8*c.z, th*8*c.z)
 end

 -- draws a sprite using spr
 c.draw_spr = function(n, x, y)
  -- calculate sprite position
  sx = (n%16)*8
  sy = flr(n/16)*8
  sspr(sx, sy, 8, 8, c.get_center().x+(x*c.z)-(c.tx*c.z), c.get_center().y+(y*c.z)-(c.ty*c.z), 8*c.z, 8*c.z)
 end

 -- draws a sprite using sspr
 -- sx = spritesheet x position
 -- sy = spritesheet y position
 -- sw = spritesheet width
 -- sh = spritesheet height
 -- x = screen x position
 -- y = screen y position
 c.draw_sspr = function(sx, sy, sw, sh, x, y)
  sspr(sx, sy, sw, sh, c.get_center().x+(x*c.z)-(c.tx*c.z), c.get_center().y+(y*c.z)-(c.ty*c.z), sw*c.z, sh*c.z)
 end
 
 return c

end
-->8
-- smap

-- code from tufifdesiks
-- reddit.com/r/pico8/comments/17a00b0

function smap(mx,my,mxs,mys,x,y,xs,ys)

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
0000000000aaaa0066666666dddddddd000099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa066666666dddddddd009999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa66666666dddddddd099999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa66666666dddddddd099999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa66666666dddddddd999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa66666666dddddddd999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa066666666dddddddd999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa0066666666dddddddd999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000999999999999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000099999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000099999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000009999999999990000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111777117711771777177717771711177711111177177717771777177717771111177717171777177717771711177711111111111111111111
11111111111111111117171717171777171717171711171111111711171717771711171717171111171117171717177717171711171111111111111111111111
11111111111111111171171717171717177717711711177111111711177717171771177117771111177111711777171717771711177111111111111111111111
11111111111111111711171717171717171717171711171111111711171717171711171717171111171117171717171717111711171111111111111111111111
11111111111111111777177117711717171717771777177711111177171717171777171717171111177717171717171717111777177711111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111177777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
11111111175555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555557111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddd7111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
1111111117555555555555556666666666666666dddddddddddddddd6666aaaaaaaa6666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666aaaaaaaa6666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66aaaaaaaaaaaa66dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66aaaaaaaaaaaa66dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666ddddddddddddddddaaaaaaaaaaaaaaaadddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66aaaaaaaaaaaa66dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66aaaaaaaaaaaa66dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666aaaaaaaa6666dddddddddddddddd6666666666666666dddddddddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666aaaaaaaa6666dddddddddddddddd6666666666666666dddddddddddddd7111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666669999999999999999dddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666669999999999999999dddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666999999999999999999999999dddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666999999999999999999999999dddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd669999999999999999999999999999dd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd669999999999999999999999999999dd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd669999999999999999999999999999dd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd669999999999999999999999999999dd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd99999999999999999999999999999999666666666666667111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666999999999999999977777777777777777777777ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666999999999999999975555555555555555555557ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666999999999999999975555555555555555555557ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666999999999999999975555555555555555555557ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666999999999999999975555555555555555555557ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66666666666666669999999999999999755556666dddd6666dddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66666666666666669999999999999999755556666dddd6666dddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd66666666666666669999999999999999755556666dddd6666dddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dd99999999999999755556666dddd6666dddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dd9999999999999975555dddd6666dddd6666d7ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dd9999999999999975555dddd6666dddd6666d7ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dd9999999999999975555dddd6666dddd6666d7ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddd99999999999975555dddd6666dddd6666d7ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddd999999999999755556666ddddaaa6dddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddd99999999755556666ddddaaaadddd67ddddddd7111111111
1111111117555555555555556666666666666666dddddddddddddddd6666666666666666dddddddd99999999755556666ddddaaaadddd67ddddddd7111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666755556666dddd6aa6dddd6766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666666666666675555dddd6666dddd69999766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666666666666675555dddd6666dddd99999766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666666666666675555dddd6666dddd99999766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd666666666666666675555dddd6666dddd99999766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666755556666dddd666699999766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd66666666666666667777777777777777777777766666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
111111111755555555555555dddddddddddddddd6666666666666666dddddddddddddddd6666666666666666dddddddddddddddd666666666666667111111111
11111111177777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11777177717771177171711771111177711771111177711771717177711111111177717171777177711771771117711111777117711111777117711771777111
11717171717171717171717111111117117171111177717171717171111111111171717171171117117171717171111111171171711111117171717171777111
11777177117711717171717771111117117171111171717171717177111111111177117171171117117171717177711111171171711111171171717171717111
11717171717171717177711171111117117171111171717171777171111711111171717171171117117171717111711111171171711111711171717171717111
11717171717171771177717711111117117711111171717711171177717111111177711771171117117711717177111111171177111111777177117711717111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

__map__
0203020302030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0302030203020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203020302030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0302030203020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0203020302030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0302030203020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
