.data
	stra: .asciiz "lpha\n" #以下是字母对应的字符串
	strb: .asciiz "ravo\n"
	strc: .asciiz "hina\n"
	strd: .asciiz "elta\n"
	stre: .asciiz "cho\n"
	strf: .asciiz "oxtrot\n"
	strg: .asciiz "olf\n"
	strh: .asciiz "otel\n"
	stri: .asciiz "ndia\n"
	strj: .asciiz "uliet\n"
	strk: .asciiz "ilo\n"
	strl: .asciiz "ima\n"
	strm: .asciiz "ary\n"
	strn: .asciiz "ovember\n"
	stro: .asciiz "scar\n"
	strp: .asciiz "aper\n"
	strq: .asciiz "uebec\n"
	strr: .asciiz "esearch\n"
	strs: .asciiz "ierra\n"
	strt: .asciiz "ango\n"
	stru: .asciiz "niform\n"
	strv: .asciiz "ictor\n"
	strw: .asciiz "hisky\n"
	strx: .asciiz "-ray\n"
	stry: .asciiz "ankee\n"
	strz: .asciiz "ulu\n"
	zero: .asciiz "zero\n"    #以下是数字对应的单词
	one:  .asciiz "First\n"
	two:  .asciiz "Second\n"
	three:.asciiz "Third\n"
	four: .asciiz "Fourth\n"
	five: .asciiz "Fifth\n"
	six:  .asciiz "Sixth\n"
	seven:.asciiz "Seventh\n"
	eight:.asciiz "Eighth\n"
	nine: .asciiz "Ninth\n"
	star: .asciiz "*\n"
	newline:.ascii "\n"
	alphabet:.word stra,strb,strc,strd,stre,strf,strg,strh,stri,strj,strk,strl,strm,strn,stro,strp,strq,strr,strs,strt,stru,strv,strw,strx,stry,strz
	numbers:.word zero,one,two,three,four,five,six,seven,eight,nine
.text
 main:
 	li $s0,'a' #一些比较的边界
 	li $s1,'A'
 	li $s2,'0'
 	li $s3,26
 	li $s4,9
 	li $s5,'z'
 	li $s6,'Z'
 	li $s7,'9'
 getKey:
 	li $v0,12 #the key ascii num 获取键值
 	syscall
 Compare:
 	li $t0,'?'  #比较并进入相应的分支
 	beq $v0,$t0,stopprogram
 	slt $t1,$s5,$v0 #xiao xie小写字母的比较
 	bne $t1,$0,printstar
 	slt $t1,$v0,$s0
 	beq $t1,$0,printalpha
 	slt $t1,$s6,$v0 #da xie大写字母的比较
 	bne $t1,$0,printstar
 	slt $t1,$v0,$s1
 	beq $t1,$0,printalpha
 	slt $t1,$s7,$v0 #numbers数字的比较
 	bne $t1,$0,printstar
 	slt $t1,$v0,$s2
 	beq $t1,$0,printnum
 	j printstar
 printalpha:
 	add $t3,$v0,$0 #打印字符相关的
 	la $a0,newline #print newline
 	li $v0,4
 	syscall
 	add $a0,$t3,$0
 	li $v0,11 #print the input char
 	syscall
 	slt $t1,$t3,$s0
 	bne $t1,$0,skip #为小写字母转换偏移
 	li $t2,32
 	sub $t3,$t3,$t2
 skip:
 	sub $t0,$t3,$s1 #计算偏移
 	sll $t0,$t0,2
 	la $t1,alphabet
 	add $t1,$t1,$t0
 	lw $a0,($t1) #加载字符串地址
 	li $v0,4
 	syscall
 	j getKey
 printnum:
 	add $t3,$v0,$0 #打印数字
 	la $a0,newline #print newline
 	li $v0,4
 	syscall
 	sub $t0,$t3,$s2
 	sll $t0,$t0,2
 	la $t1,numbers 
 	add $t1,$t1,$t0
 	lw $a0,($t1) #加载数字地址
 	li $v0,4
 	syscall
 	j getKey
 printstar:
 	la $a0,newline #print newline打印星号
 	li $v0,4
 	syscall
 	la $a0,star
 	li $v0,4
 	syscall
 	j getKey
 stopprogram: #终止程序
 	li $v0,10
 	syscall
