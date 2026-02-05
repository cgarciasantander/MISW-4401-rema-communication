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

data mens "count" id count
send mens
delay 1000