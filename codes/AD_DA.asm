A_DPORT EQU 9000H			;ADC0809ͨ����ַ
D_APORT EQU 0A000H			;DAC0832��ַ

ORG 0000H
LJMP START
ORG 0013H					;�ж�INT1��ڵ�ַ
LJMP INT_1
ORG 0040H

START: MOV SP, #60H			;���ö�ջջ��
	   MOV R7, #0FFH		;��־�������ó�ֵ
	   SETB IT1				;��IT1=1Ϊ�½��ش�����ʽ
	   SETB EA				;���ж�����
	   SETB EX1				;�ⲿ�ж�INT1����
	   
	   MOV R2, #00H			;R2,R3Ϊ�ⲿ���ݴ洢��16λ��ַ
	   MOV R3, #00H
	   CLR A

A_D: MOV DPTR, #A_DPORT
	 MOVX @DPTR, A			;����ADת��
	 
	 CJNE R7, #00H, $		;�ȴ�ADת������
	 
	 MOV DPH, R3
	 MOV DPL, R2
	 MOVX @DPTR, A			;AD���������͵��ⲿ���ݴ洢��
	 
	 MOV DPTR, #D_APORT
	 MOVX @DPTR,A			;AD���������͵�DAת��
	 
	 INC R2
	 CJNE R2,#00H,CLEAR
	 INC R3
	 CJNE R3, #80H,CLEAR	;�ⲿ���ݴ洢����ַ�ۼ�
	 MOV R3,#00H

CLEAR: MOV R7, #0FFH		;�������־
	   SJMP A_D

INT_1: MOVX A, @DPTR		;��AD����
	   MOV R7, #00H			;�ö�����־
	   RETI
	   END

