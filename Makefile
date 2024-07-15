# GCC编译参数
CFLAGS = -g -c -O0 -m32 -fno-pie -fno-stack-protector -nostdlib -nostdinc

# 目标创建:涉及编译、链接、二进制转换、反汇编、写磁盘映像
all: source/os.c source/os.h source/start.S
	gcc $(CFLAGS) source/start.S
	gcc $(CFLAGS) source/os.c
	ld -m elf_i386 -Ttext=0x7c00 start.o os.o -o os.elf
	objcopy -O binary os.elf os.bin
	objdump -x -d -S  os.elf > os_dis.txt
	readelf -a  os.elf > os_elf.txt
	dd if=os.bin of=image/disk.img conv=notrunc

# 清理
clean:
	rm -f *.elf *.o
