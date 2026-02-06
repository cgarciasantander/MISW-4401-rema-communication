set ant 999
set count 0
set maxCount 1000

battery set 100

atget id id
getpos2 lonSen latSen

loop
wait 100
read mens
rdata mens tipo valor

if((tipo=="hola") && (ant == 999))
   set ant valor
   data mens tipo id
   send mens * valor
end

if(tipo=="alerta")
   send mens ant
end

if (tipo=="stop")
	data mens "stop"
	send mens * valor
	cprint "Para sensor: " id
	wait 1000
	stop
end

battery bat
if(bat<5)
	data mens "critico" lonSen latSen
	send mens ant
end

inc count
if (count >= maxCount)
	stop
end

randb menuIdx 1 10
if(menuIdx == 1)
	set orderItem "pizza"
end
if(menuIdx == 2)
	set orderItem "burger"
end
if(menuIdx == 3)
	set orderItem "taco"
end
if(menuIdx == 4)
	set orderItem "sushi"
end
if(menuIdx == 5)
	set orderItem "donut"
end
if(menuIdx == 6)
	set orderItem "watermelon"
end
if(menuIdx == 7)
	set orderItem "fries"
end
if(menuIdx == 8)
	set orderItem "cupcake"
end
if(menuIdx == 9)
	set orderItem "ramen"
end
if(menuIdx == 10)
	set orderItem "burrito"
end

int orderId count
data mens "orden" id orderId orderItem
send mens

randb randdelay 100 1000
delay randdelay