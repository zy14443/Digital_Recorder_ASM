A_DPORT EQU 9000H			;ADC0809通道地址
D_APORT EQU 0A000H			;DAC0832地址

ORG 0000H
LJMP START
ORG 0013H					;中断INT1入口地址
LJMP INT_1
ORG 0040H

START: MOV SP, #60H			;设置堆栈栈底
	   MOV R7, #0FFH		;标志积存器置初值
	   SETB IT1				;置IT1=1为下降沿触发方式
	   SETB EA				;总中断允许
	   SETB EX1				;外部中断INT1允许
	   
	   MOV R2, #00H			;R2,R3为外部数据存储器16位地址
	   MOV R3, #00H
	   CLR A

A_D: MOV DPTR, #A_DPORT
	 MOVX @DPTR, A			;启动AD转换
	 
	 CJNE R7, #00H, $		;等待AD转换结束
	 
	 MOV DPH, R3
	 MOV DPL, R2
	 MOVX @DPTR, A			;AD采样数据送到外部数据存储器
	 
	 MOV DPTR, #D_APORT
	 MOVX @DPTR,A			;AD采样数据送到DA转换
	 
	 INC R2
	 CJNE R2,#00H,CLEAR
	 INC R3
	 CJNE R3, #80H,CLEAR	;外部数据存储器地址累加
	 MOV R3,#00H

CLEAR: MOV R7, #0FFH		;清读数标志
	   SJMP A_D

INT_1: MOVX A, @DPTR		;读AD数据
	   MOV R7, #00H			;置读数标志
	   RETI
	   END

