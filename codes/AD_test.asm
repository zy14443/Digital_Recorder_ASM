ORG 0000H
LJMP A_D
ORG 0013H					;�ⲿ�ж�INT1��ڵ�ַ
LJMP INT_1
ORG 0100H

A_D: SETB IT1				;��IT1=1Ϊ�½��ش�����ʽ
	 SETB EA				;���ж�����
	 SETB EX1				;�ⲿ�ж�INT1����
	 MOV R7, #0FFH			;��־�ó�ֵ
	 
	 MOV DPTR, #9000H	 	;ѡ��ADCͨ��0
	 MOVX @DPTR, A			;����ADC
	 CJNE R7, #00H, $		;�ȴ�ת������
	 
	 MOV DPTR,#0F000H		;ѡ��LED��
	 MOV @DPTR, A			;��ת����������LED
	 
	 SJMP A_D
	 
INT_1: MOVX A, @DPTR		;��ȡת�������A
	   MOV R7, #00H			;��־��Ϊ����
	   RETI
	   
END 