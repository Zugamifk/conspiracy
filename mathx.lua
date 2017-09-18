function math.sign(x)
   if x<0 then
     return -1
   elseif x>0 then
     return 1
   else
     return 0
   end
end

function math.clamp(x,min,max)
	return math.min(math.max(x,min), max)
end