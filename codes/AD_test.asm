ORG 0000H
LJMP A_D
ORG 0013H					;外部中断INT1入口地址
LJMP INT_1
ORG 0100H

A_D: SETB IT1				;置IT1=1为下降沿触发方式
	 SETB EA				;总中断允许
	 SETB EX1				;外部中断INT1允许
	 MOV R7, #0FFH			;标志置初值
	 
	 MOV DPTR, #9000H	 	;选择ADC通道0
	 MOVX @DPTR, A			;启动ADC
	 CJNE R7, #00H, $		;等待转换结束
	 
	 MOV DPTR,#0F000H		;选择LED灯
	 MOV @DPTR, A			;将转换结果输出至LED
	 
	 SJMP A_D
	 
INT_1: MOVX A, @DPTR		;读取转换结果到A
	   MOV R7, #00H			;标志置为结束
	   RETI
	   
END 