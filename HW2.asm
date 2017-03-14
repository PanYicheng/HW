	.data
	str:	.space 100						#在程序开始时要输入的串为str，最长长度为99个字符
	fail_print:	.asciiz "\r\nFail!\r\n"			#当查询失败时输出的串
	success_print:	.asciiz "\r\nSuccess!Location: "		#当查询成功时输出的串
	ln:		.asciiz "\r\n"					#用来输出一个回车换行
	.text
	.globl main
main:	la	$a0, str		#程序开始的地方
	li	$a1, 100
	li	$v0, 8			#调用系统功能输入一个字符串，其中$a1里存的是该字符串的最大长度，$a0里存的是该字符串的起始位置（即为str）
	syscall
start:	li	$v0, 12			#轮询开始的地方，调用系统功能输入一个字符（该字符在寄存器$v0里面）
	syscall
	beq	$v0, '?', stop		#如果这个字符为'?'，表示不想继续查询，跳转到结束处理模块
	add	$t1, $0, $0		#我们用寄存器$t1来记录现在已经查找到的字符的位置，初始化为0
ask:	lb	$t2, str($t1) 	#开始查找过程
	beq	$t2, '\n', fail		#如果查找到'\n'字符的话，说明这个串就找到了尽头，此时应该输出查找失败的信息
	beq	$v0, $t2, success	#如果该串的某个字符与输入字符相同，则表示查找成功
	add	$t1, $t1, 1		#更新代比较字符在串中的位置，比较下一个字符
	j	ask
fail:	la	$a0, fail_print
	li	$v0, 4			#查找失败时输出字符串“Fail!!!”（注意前后都要换行）
	syscall
	j	start			#进行下一次查询
success:la	$a0, success_print
	li	$v0, 4			#查找成功时先换行，再输出字符串“Success!!! Location: ”
	syscall
	add	$a0, $t1, $0		#再输出当前字符在串中的位置
	li	$v0, 1
	syscall
	la	$a0, ln			#最后输出一个换行
	li	$v0, 4
	syscall
	j 	start			#进行下一次查询
stop:	li $v0, 10			#程序结束
	syscall
