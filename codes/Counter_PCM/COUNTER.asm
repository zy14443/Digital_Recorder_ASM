

A_DPORT EQU 9000H		;ADC0809通道地址
D_APORT EQU 0A000H		;DAC0832地址

;==========主程序==========
	ORG  0000H
	LJMP START

	ORG  000BH			;T0的中断入口
	LJMP IT0P

	ORG  0100H
START:
	MOV SP,#60H		;初始化堆栈区

	
	LCALL INIT0			;定时中断初始化
	SETB TR0


		MOV P1,#00H
	   
	   	MOV 8EH, #02H
	   		   		   

AA:

	 	
	 	
		
		MOV R6,#00H
    		CJNE R6,#01H,$             ;DA转换结束
    		SETB P1.2				;计数器时钟

		CLR P1.2	
	 	 	
	 	JZ AA
	    
	 

;=========/*定时器0初始化*/==========
INIT0:
		MOV TMOD,#01H
		MOV TL0,#83H
		MOV TH0,#0FFH
		
		SETB ET0
		SETB EA
	;	SETB TR0
		RET
IT0P:
		MOV TL0,#83H
		MOV TH0,#0FFH
		MOV R6,#01H
		RETI
		END



