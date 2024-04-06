pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
function _init()

 message = "hello world!  "
 frame = 0
 speed = 0.01
 size = 15

end

function _update()
 
 frame += speed
 c = cos(frame)
 s = sin(frame)
 dx = c * size
 dy = s * size
 
 -- left / right arrows to change speed
 if btn(⬅️) then speed -= 0.001 end
 if btn(➡️) then speed += 0.001 end
 -- up / down arrows to change size
 if btn(⬆️) then size += 0.2 end
 if btn(⬇️) then size -= 0.2 end
 
end

function _draw()

 -- print main variables
 cls()
 print("frame: " .. frame, 0, 0, 7)
 print("cos(frame) (x): " .. c, 0, 6, 7)
 print("sin(frame) (y): " .. s, 0, 12, 7)
 print("speed: " .. speed .. " size: " .. size, 0, 18, 7) 

 -- horizontal motion
 spr(1, 32 + dx, 42)
 line(
  32+4,
  42+4,
  32+4+dx,
  42+4,
  3
 )
 
 -- vertical motion
 spr(1, 64, 42 + dy)
 line(
  64+4,
  42+4,
  64+4,
  42+4+dy
 )

 -- circular motion
 spr(1, 96 + dx, 42 - dy)
 line(
  96+4,
  42+4,
  96+4+dx,
  42+4-dy
 )
 circ(96+4, 42+4, size, 3)
 
 -- circular progress bar
 for z=flr(frame), frame, 0.001 do
  line(
   96+4,
   42+4,
   96+4+cos(z)*size,
   42+4+sin(-z)*size,
   3
  )
 end
 
 -- wavy text
 for i=1, #message do
 
  offset=i*1.05
  ci = cos(frame+offset)
  si = sin(frame+offset)
  dxi = ci * size
  dyi = si * size
  col = abs(flr(si * 15))
  
  print(message[i], i*5, 90 + dyi, col)
 
 end
 
 -- circular text
 for i=1, #message do
  
  offset= -i * (1 / #message)
  ci = cos(frame+offset)
  si = sin(frame+offset)
  dxi = ci * size
  dyi = si * size / 3
  
  if (ci > -0.2 and ci < 0.2 and si < -0.9) then
   col = 7
  else
   col = 5
  end
  
  print(message[i], 100+dxi, 90-dyi, col)
 
 end
 
end
__gfx__
0000000000aaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
