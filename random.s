/* José Javier Jo Escobar, 14343*/
/* Jonnathan Juarez, 15377
/* Main donde se recaudaran las n4 notas de estudiantes */
/* Taller de Assembler, Martha L. Naranjo 05/08/2016 */

.text
.align 2
.global avg
/*Metodo que calcula el promedio del vector en float */
avg:
	/*Movemos la direccion del arreglo a r8*/
	mov r8,r0
	/*Variables locales*/
	array .req r8
	prom .req s14
	cont .req r5
	sumatoria .req s16
	cant .req s18
	/*Inicializamos los registros en 0.0 para generar el float*/
	ldr r7,=ini
	vldr sumatoria,[r7]
	vldr prom,[r7]
	/*Inicializamos el caontador dependiendo a la cantidad de elementos del vectore*/
	ldr cont,[r1]
	/*Inicializamos el contador de elementos del vector*/
	ldr r6,=num
	vldr s20,[r6]
	vadd.F32 cant cant,s20

	ciclo3:
			/*Iniciamos el valor del vect*/
			vldr s16,[array]
			/*Sumamos elemento por elemento cada vez que se hace el ciclo*/
			vadd.F32 sumatoria,sumatoria,s16
			/*Indicamos que la siguiente direccion se direccione en +4 del vector asi lograria avanzar elemento x elem*/
			add array,#4
			/*Restamos uno al contador*/
			sub cont,#1
			/*Comparamos si ya se recorrio todos los elementow del vecrtor*/
			cmp cont,#0
			/*sumamos uno al contador de elementos */
			vadd.F32 cant,cant,s20
			/*Cuando se llegue al final del vector direccionamos al final de la subrutina*/
			beq fin3
			/*Si no repetimos el ciclo*/
			b ciclo3
	fin3:
			/*Dividimos la sumatoria con la cantidad de elementos del vector obteniendo el promediio*/
			vdiv.F32 prom,sumatoria,cant
			/*Movemos el primedio a r0*/
			vmov r0,prom
			/*Eliminamos la variables localres*/
			.unreq array
			.unreq prom
			.unreq sumatoria
			.unreq cont
			.unreq cant
			mov pc,lr

.data
.align 2
/*inicializamos los registros*/
ini: .float 0.0
num: .float 1.0

.text
.align 2
.global norm
/*Metodo qie normaliza los elementos de un vector float */
norm:
	/*Movemos a r8 las direcciones del arreglo*/
	mov r8,r0
	/*Variables locales*/
	minimo .req s18
	maximo .req s20
	array .req r8
	normalizado .req s14
	cont .req r5
	actual .req s16
	temp .req s22
	temp2 .req s24

	/*Inicializamos el contador valor maximo y minimo del vector*/
	ldr cont,[r1]
	vmov minimo,r2
	vmov maximo,r3
	ldr r9,=inic
	/*Iniciamos las Var temporales*/
	vldr temp,[r9]
	vldr temp2,[r9]

	ciclo4:
		/*Seleccionamos algun valor del array*/
		vldr actual,[array]
		/*Restamos el valor obtenido con el minimo*/
		vsub.F32 temp,actual,minimo
		/*Restamos el maximo y el minimos*/
		vsub.F32 temp2,maximo,minimo
		/*Dividimos los resultados anteriores*/
		vdiv.F32 normalizado,temp,temp2
		/*Guardamos en el vector el resultado normalizado*/
		vstr normalizado,[array]
		add array,#4
		/*Validamos si repetimos el ciclo o terminamos */
		sub cont,#1
		cmp cont,#0
		beq fin4
		b ciclo4
	fin4:
	/*Movemos el arreglo normalizado a r0*/
		mov r0,array
		/*Eliminamos variables locales*/
		.unreq array
		.unreq minimo
		.unreq maximo
		.unreq cont
		.unreq actual
		.unreq normalizado
		.unreq temp
		.unreq temp2
		mov pc,lr
.data
.align 2
/*Valor de inicializacion en 0.0*/
inic: .float 0.0

.text
.align 2
.global min
/*Metodo que realiza el calculo del valor minimo de un vector punto flotante. */

min:
	/*Almacenamos en r8 la direccion del array */
	mov r8,r0
	/*Variables locales*/
	array .req r8
	minultimo .req s14
	cont .req r5
	/*Se le suma al contador la cantidad de elementos del arreglo*/
	mov cont,r1
	/*Se suma a un registro el dato inicial que se encuentra en el arreglo como un minimo relativo */
	vldr minultimo,[array]

	ciclo:
			/*Compara su valor para ver si se llego al final del vector */
			sub cont,#1
			cmp cont,#0
			beq fin
			/*Siguiente valor del arreglo*/
			add array,#4
			vldr s16,[array]
			/*Comparamos si el siguiente valor es menor al valor presente al valor actual del arreglo */
			vcmp.F32 minultimo,s16
			vmrs APSR_nzcv,FPSCR
			/*Si no se repite el ciclo */
			blt ciclo
			/*Si se encuentra un nuevo valor menor se borra el registro con el valor menor anteriormente*/
			vmov.F32 minultimo,s16
			/*Repetimos el ciclo para cada uno de los valores */
			b ciclo
	fin:
		/*Movemos a r0 el valor mas pequeño encontrado en el vector*/
		vmov r0,minultimo
		/*Eliminamos el nombre a las variables locales */
		.unreq minultimo
		.unreq array
		.unreq cont
		mov pc,lr



.text
.align 2
.global max
/*Metodo que calcula el maximo valor que se encuentre en un vector de punto flotante*/
max:
	/*Movemos a r8 la direccion del arreglo */
	mov r8,r0
	/*Variables locales */
	array .req r8
	ultimomaximo .req s14
	cont .req r5
	/*Se le suma al contador la cantidad de datos del arreglo */
	mov cont,r1
	/*Se agrega al registro el dato inicial del arreglo tomandolo como un maximo relativo */
	vldr ultimomaximo,[array]

	ciclo2:
			/*Comparamos el registro para ver si llegamos al final del vector*/
			sub cont,#1
			cmp cont,#0
			beq fin2
			/*Tomamos el siguiuente valor del arreglo */
			add array,#4
			vldr s16,[array]
			/*Comparamos si el siguiente valor es mayor que el que esta  */
			vcmp.F32 ultimomaximo,s16
			vmrs APSR_nzcv,FPSCR
			/*Si no, repetimos el ciclo*/
			blt ciclo2
			/*Si encontramos un valor mayor al que estaba en el registro lo borramos el registro con el valor mayor anterior*/
			vmov.F32 ultimomaximo,s16
			/*Repetimos el ciclo con cada uno de los datos.*/
			b ciclo2
	fin2:
		/*Instanciamos r0 con el valor mas grande encontrado en el vector*/
		vmov r0,ultimomaximo
		/*Eliminamos las variables locales */
		.unreq ultimomaximo
		.unreq array
		.unreq cont
		mov pc,lr

