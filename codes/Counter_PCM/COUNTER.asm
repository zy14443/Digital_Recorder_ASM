

A_DPORT EQU 9000H		;ADC0809ͨ����ַ
D_APORT EQU 0A000H		;DAC0832��ַ

;==========������==========
	ORG  0000H
	LJMP START

	ORG  000BH			;T0���ж����
	LJMP IT0P

	ORG  0100H
START:
	MOV SP,#60H		;��ʼ����ջ��

	
	LCALL INIT0			;��ʱ�жϳ�ʼ��
	SETB TR0


		MOV P1,#00H
	   
	   	MOV 8EH, #02H
	   		   		   

AA:

	 	
	 	
		
		MOV R6,#00H
    		CJNE R6,#01H,$             ;DAת������
    		SETB P1.2				;������ʱ��

		CLR P1.2	
	 	 	
	 	JZ AA
	    
	 

;=========/*��ʱ��0��ʼ��*/==========
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



