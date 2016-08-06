/* LABORATORIO NO.1*/
/* José Javier Jo Escobar, 14343*/
/* Jonnathan A. Juarez, 15377
/* Main, encargado de la entrada y salida de datos con el usuario */
/* Taller de Assembler, Martha L. Naranjo 05/08/2016 */


.global main,frmFloat
.func main

main:

	@ingreso de datos
	ldr r0, =strBienvenida
	bl printf
	ldr r0, =strSemilla
	bl printf
	ldr r0, =frmDec
	ldr r1, =semilla
	bl scanf
	ldr r0, =strSizeVector
	bl printf
	ldr r0, =frmDec
	ldr r1, =tamano
	bl scanf

	@@llamado a LFSR
	ldr r0,=vector
	ldr r1,=tamano
	ldr r1,[r1]
	ldr r2,=semilla
	ldr r2,[r2]
	bl lfsr

	@ Calcular el maximo 
	ldr r0, =vector
	ldr r1, =tamano
	ldr r1, [r1]
	bl max
	mov r2, r0

	@ Imprimir el maximo
	ldr r0, =strMax
	vmov s0, r2
	vcvt.f64.f32 d1, s0
	vmov r2, r3, d1
	bl printf 

	@ Calcular el minimo
	ldr r0, =vector
	ldr r1, =tamano
	ldr r1, [r1]
	push {r2}
	bl min
	pop {r2}
	mov r3, r0

	@Imprimir el minimo
	ldr r0, =strMin
	vmov s0, r3
	vcvt.f64.f32 d1, s0
	vmov r2, r3, d1
	bl printf



	@impresion de vector
	
	ldr r0, =vector
	ldr r1, =tamano
	ldr r1, [r1]
	bl printVec
	


	@salida
	MOV R7, #1				
	SWI 0


.data
	vector:	 .space 1048576 * 4
	tamano:	 .word 0
	semilla:	.word 0
	strSizeVector:	.asciz "Ingrese la cantidad de elmentos que desea que tenga su vector\n"
	strSemilla:	.asciz "\n\nPorfavor ingrese la semilla: \n"
	strMax:	.asciz "El valor maximo  es: %f\n"
	strMin:	.asciz "El valor minimo  es: %f\n"
	frmDec:	.asciz "%d"
	frmFloat:	.asciz "%f\n"
	strBienvenida:	.asciz "88^^Yb 88 888888 88b 88 Yb    dP 888888 88b 88 88 8888b.   dP^Yb  \n88__dP 88 88__   88Yb88  Yb  dP  88__   88Yb88 88  8I  Yb dP   Yb \n88^^Yb 88 88^^   88 Y88   YbdP   88^^   88 Y88 88  8I  dY Yb   dP \n88oodP 88 888888 88  Y8    YP    888888 88  Y8 88 8888Y^   YbodP  \n"

