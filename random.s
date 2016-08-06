/* LABORATORIO NO.1*/
/* José Javier Jo Escobar, 14343*/
/* Jonnathan A. Juarez, 15377
/* subrutina para la generacion de numeros aleatorios */
/* Taller de Assembler, Martha L. Naranjo 05/08/2016 */

.global lfsr,printVec,min,max
/*------------LFSR---------------*/
lfsr:
	@guardar punto de regreso
	push {lr}
	@copiando tamanio a r3
	mov r3, r1 
	/* forma de trabajar los registros
	lfs = r2
	lsb = r1
	tamanio = r3 
	toggle_mask = r5
	contador = r6
	*/
	ldr r5, =0x80200003
	mov r6, #0

ciclo:
	add r6, #1
	and r1, r2, #0b1 @ Obtener el bit menos significativo
	cmp r1, #0 @ comparar si el bit menos significativo es 1 o 0
	lsr r2, r2, #1 @ Correr el lfsr a la derecha 1 pos
	eorne r2, r2, r5 @ Aplicar la mascara de XOR
	vmov s0, r2
	vcvt.f32.s32 s0, s0
	vstr s0, [r0] @ Guardar el valor generado
	add r0, #4
	cmp r3, r6
	bne ciclo

	@ Regresar de la subrutina
	pop {lr}
	mov pc, lr

min:
	push {lr}
	vldr s1, [r0]
	mov r2, #0
cicloMin:
	vldr s0, [r0]
	add r0, #4
	@ Compara si es menor
	vcmp.f32 s0, s1 
	vmrs APSR_nzcv, FPSCR @ Transferir banderas
	vmovlt s1, s0 @ Si es menor realizar cambio
	add r2, #1
	cmp r2, r1
	bne cicloMin
	vmov r0, s1
	@ Salida Subrutina
	pop {lr}
	mov pc, lr


max:
	push {lr}
	vldr s1, [r0]
	mov r2, #0
cicloMax:
	vldr s0, [r0]
	add r0, #4
	vcmp.f32 s0, s1
	vmrs APSR_nzcv, FPSCR @ Transferir banderas
	vmovgt s1, s0 @ Si es mayor cambiar valor
	add r2, #1 
	cmp r2, r1
	bne cicloMax
	vmov r0, s1
	@ Salida subrutina
	pop {lr}
	mov pc, lr

printVec:
		push {lr}
		mov r4, #0
		mov r5, r0
	imprimir:	
		cmp r4, r1 @ Comparar con el tamanio
		beq salir
		vldr s0, [r5]
		add r5, #4
		@preparando para impresion
		vcvt.f64.f32 d1, s0
		vmov r2, r3, d1
		ldr r0, =frmFloat
		push {r0-r5}
		bl printf @ Imprimir valores
		pop {r0-r5}
		add r4, #1
		b imprimir
	@salida de la subrutina
	salir:
		pop {lr}
		mov pc, lr
