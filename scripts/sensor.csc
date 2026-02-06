set ant 999
set count 0
set maxCount 1000

battery set 100

atget id id
getpos2 lonSen latSen

loop
wait 100
read incoming
rdata incoming tipo valor1 valor2 valor3

if((tipo=="hola") && (ant == 999))
	set ant valor1
	cprint "Registered in the network:" ant
	data mens tipo id
	cprint "Forwarding ant:" tipo id
	send mens * valor1
end

if(tipo=="stop")
	cprint "Stop signal received"
	wait 1000
	stop
end

if((tipo=="orden") && (ant<999))
	cprint "Order forwarded from:" valor1 "to:" ant
	data mens tipo valor1 valor2 valor3
	send mens ant
	wait 100
end

inc count
if(count >= maxCount)
	stop
end

battery bat
int batLevel bat
if(batLevel<15)
	data mens "critico" id lonSen latSen
	send mens ant
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
