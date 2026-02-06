atget id id

data p "hola" id
send p

loop
read mens
rdata mens tipo valor1 valor2 valor3

if(tipo == "orden")
	printfile tipo valor1 valor2 valor3
end

if(tipo == "critico")
	cprint "Nodo descargado en device:" valor1 ", longitud:" valor2 ", latitud: " valor3
	data p "stop"
	send p valor1
end

wait 100