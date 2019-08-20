# ELF文件

[TOC]

```
Executable and Linking Format
```



## 1、简介

在计算机科学中，是一种用于可执行文件(executable files)、目标文件(object code)、共享库(shared libraries)和核心转储(core dumps)的标准文件格式。

1999年，被[86open](https://zh.wikipedia.org/w/index.php?title=86open&action=edit&redlink=1)项目选为x86架构上的[类Unix](https://zh.wikipedia.org/wiki/类Unix)操作系统的[二进制文件](https://zh.wikipedia.org/wiki/二进制文件)格式标准，用来取代[COFF](https://zh.wikipedia.org/wiki/COFF)。因其可扩展性与灵活性，也可应用在其它[处理器](https://zh.wikipedia.org/wiki/处理器)、[计算机系统](https://zh.wikipedia.org/wiki/计算机系统)架构的操作系统上。



## 2、文件布局

ELF文件格式提供了两种视图，分别是链接视图和执行视图。

```
               +------------------------------------+          
               |                                    |          
               |             ELF Header             |          
               |                                    |          
               +------------------------------------+          
               +------------------------------------+          
+--------------+        Program Header Table        |          
|      +-------|                                    |          
|      |       +------------------------------------+          
|      |       +------------------------------------+          
|      |       |                                    |          
|      |       |               .text                |<--------+
|      |    +->|                                    |         |
|      |    |  |                                    |         |
|      +----|  +------------------------------------+         |
|           |  +------------------------------------+         |
|           |  |              .rodata               |<----+   |
|           +->|                                    |     |   |
|              +------------------------------------+     |   |
|     +--->                     ...                       |   |
|     |                                                   |   |
+-----+        +------------------------------------+     |   |
      |        |                                    |     |   |
      |        |               .data                |<-+  |   |
      +--->    |                                    |  |  |   |
               +------------------------------------+  |  |   |
                                                       |  |   |
               +------------------------------------+--+  |   |
               |         Section Header Table       +-----+   |
               |                                    +---------+
               +------------------------------------+          
```

链接视图是以节（section）为单位，执行视图是以段（segment）为单位。链接视图就是在链接时用到的视图，而执行视图则是在执行时用到的视图。右侧的视角是从链接来看的，左侧是执行来看的。可以分为四个部分：

- ELF文件的组成：ELF Header
- Program Header：描述段信息
- Section Header：链接与重定位需要的数据
- Program Header与Section Header 需要的数据 .text .data

**程序头部表**（Program Header Table），如果存在的话，告诉系统如何创建进程映像。 
**节区头部表**（Section Header Table）包含了描述文件节区的信息，比如大小、偏移等。



### ELF Header

```
#define ELF_MAGIC 0x464C457FU	/* "\x7FELF" in little endian */

struct Elf {
	uint32_t e_magic;			// must equal ELF_MAGIC  魔数
	uint8_t e_elf[12];
	uint16_t e_type;    	// 类型
	uint16_t e_machine;   // 系统架构
	uint32_t e_version;   // 版本
	uint32_t e_entry;     // 入口地址
	uint32_t e_phoff;     // Program Header程序头偏移
	uint32_t e_shoff;     // Section Header段头偏移
	uint32_t e_flags;     // 标志
	uint16_t e_ehsize;    // ELF文件头大小
	uint16_t e_phentsize; // Program Header程序头大小
	uint16_t e_phnum;     // Program 个数
	uint16_t e_shentsize; // Section Header段头大小
	uint16_t e_shnum;     // Section 个数
	uint16_t e_shstrndx;  // 字符串表段索引
};
```

```shell
$ lab git:(lab1) i386-elf-readelf -h obj/kern/kernel
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x10000c
  Start of program headers:          52 (bytes into file)
  Start of section headers:          98140 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         2
  Size of section headers:           40 (bytes)
  Number of section headers:         18
  Section header string table index: 17
```



### Program Header

```
struct Proghdr {
	uint32_t p_type;    // 标识段的类型
	uint32_t p_offset;  // 该段在文件中的偏移
	uint32_t p_va;      // 该段在内存中的虚拟地址，即执行地址
	uint32_t p_pa;      // 该段的物理地址，为物理地址相关的系统保留
	uint32_t p_filesz;  // 段在文件映像中所占的字节数，可以为0
	uint32_t p_memsz;   // 段在内存中所占的字节数，可以为0
	uint32_t p_flags;   // 段相关标志（32位结构的位置）
	uint32_t p_align;   // 0和1指定无对齐。否则应该是2的正整数幂，其中p_vaddr等于p_offset模数p_align
};
```

```shell
$ lab git:(lab1) i386-elf-readelf -l obj/kern/kernel

Elf file type is EXEC (Executable file)
Entry point 0x10000c
There are 2 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x001000 0xf0100000 0x00100000 0x07934 0x07934 R E 0x1000
  LOAD           0x009000 0xf0108000 0x00108000 0x0a948 0x0a948 RW  0x1000

 Section to Segment mapping:
  Segment Sections...
   00     .text .rodata .stab .stabstr
   01     .data .bss
```



### Section Header

```
struct Secthdr {
	uint32_t sh_name;   // 段名
	uint32_t sh_type;   // 段类型
	uint32_t sh_flags;  // 段标记
	uint32_t sh_addr;
	uint32_t sh_offset;
	uint32_t sh_size;
	uint32_t sh_link;
	uint32_t sh_info;
	uint32_t sh_addralign;
	uint32_t sh_entsize;
};
```

```shell
$ lab git:(lab1)  i386-elf-readelf -S obj/kern/kernel
There are 18 section headers, starting at offset 0x17f5c:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        f0100000 001000 001736 00  AX  0   0  4
  [ 2] .rodata           PROGBITS        f0101740 002740 000714 00   A  0   0 32
  [ 3] .stab             PROGBITS        f0101e54 002e54 004195 0c   A  4   0  4
  [ 4] .stabstr          STRTAB          f0105fe9 006fe9 00194b 00   A  0   0  1
  [ 5] .data             PROGBITS        f0108000 009000 00a300 00  WA  0   0 4096
  [ 6] .bss              PROGBITS        f0112300 013300 000648 00  WA  0   0 32
  [ 7] .comment          PROGBITS        00000000 013948 000011 01  MS  0   0  1
  [ 8] .debug_info       PROGBITS        00000000 013959 001811 00      0   0  1
  [ 9] .debug_abbrev     PROGBITS        00000000 01516a 000486 00      0   0  1
  [10] .debug_loc        PROGBITS        00000000 0155f0 000eef 00      0   0  1
  [11] .debug_aranges    PROGBITS        00000000 0164df 000040 00      0   0  1
  [12] .debug_ranges     PROGBITS        00000000 01651f 000070 00      0   0  1
  [13] .debug_line       PROGBITS        00000000 01658f 00044a 00      0   0  1
  [14] .debug_str        PROGBITS        00000000 0169d9 000ae8 01  MS  0   0  1
  [15] .symtab           SYMTAB          00000000 0174c4 0006b0 10     16  52  4
  [16] .strtab           STRTAB          00000000 017b74 000343 00      0   0  1
  [17] .shstrtab         STRTAB          00000000 017eb7 0000a5 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  p (processor specific)
```



### 符号表

```shell
$ lab git:(lab1)  i386-elf-readelf -s obj/kern/kernel

Symbol table '.symtab' contains 107 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: f0100000     0 SECTION LOCAL  DEFAULT    1
     2: f0101740     0 SECTION LOCAL  DEFAULT    2
     3: f0101e54     0 SECTION LOCAL  DEFAULT    3
     4: f0105fe9     0 SECTION LOCAL  DEFAULT    4
     5: f0108000     0 SECTION LOCAL  DEFAULT    5
     6: f0112300     0 SECTION LOCAL  DEFAULT    6
     7: 00000000     0 SECTION LOCAL  DEFAULT    7
     8: 00000000     0 SECTION LOCAL  DEFAULT    8
     9: 00000000     0 SECTION LOCAL  DEFAULT    9
    10: 00000000     0 SECTION LOCAL  DEFAULT   10
    11: 00000000     0 SECTION LOCAL  DEFAULT   11
    12: 00000000     0 SECTION LOCAL  DEFAULT   12
    13: 00000000     0 SECTION LOCAL  DEFAULT   13
    14: 00000000     0 SECTION LOCAL  DEFAULT   14
    15: 00000000     0 FILE    LOCAL  DEFAULT  ABS obj/kern/entry.o
    16: f010002f     0 NOTYPE  LOCAL  DEFAULT    1 relocated
    17: f010003e     0 NOTYPE  LOCAL  DEFAULT    1 spin
    18: 00000000     0 FILE    LOCAL  DEFAULT  ABS entrypgdir.c
    19: 00000000     0 FILE    LOCAL  DEFAULT  ABS init.c
    20: 00000000     0 FILE    LOCAL  DEFAULT  ABS console.c
    21: f0100179    26 FUNC    LOCAL  DEFAULT    1 serial_proc_data
    22: f0100193    67 FUNC    LOCAL  DEFAULT    1 cons_intr
    23: f0112320   520 OBJECT  LOCAL  DEFAULT    6 cons
    24: f01001d6   268 FUNC    LOCAL  DEFAULT    1 kbd_proc_data
    25: f0112300     4 OBJECT  LOCAL  DEFAULT    6 shift.1377
    26: f0101920   256 OBJECT  LOCAL  DEFAULT    2 shiftcode
    27: f0101820   256 OBJECT  LOCAL  DEFAULT    2 togglecode
    28: f0101800    16 OBJECT  LOCAL  DEFAULT    2 charcode
    29: f01002e2   465 FUNC    LOCAL  DEFAULT    1 cons_putc
    30: f0112528     2 OBJECT  LOCAL  DEFAULT    6 crt_pos
    31: f0112530     4 OBJECT  LOCAL  DEFAULT    6 addr_6845
    32: f011252c     4 OBJECT  LOCAL  DEFAULT    6 crt_buf
    33: f0112534     1 OBJECT  LOCAL  DEFAULT    6 serial_exists
    34: f0112200   256 OBJECT  LOCAL  DEFAULT    5 normalmap
    35: f0112100   256 OBJECT  LOCAL  DEFAULT    5 shiftmap
    36: f0112000   256 OBJECT  LOCAL  DEFAULT    5 ctlmap
    37: 00000000     0 FILE    LOCAL  DEFAULT  ABS monitor.c
    38: f0101c04    24 OBJECT  LOCAL  DEFAULT    2 commands
    39: 00000000     0 FILE    LOCAL  DEFAULT  ABS printf.c
    40: f010086a    19 FUNC    LOCAL  DEFAULT    1 putch
    41: 00000000     0 FILE    LOCAL  DEFAULT  ABS kdebug.c
    42: f01008b7   237 FUNC    LOCAL  DEFAULT    1 stab_binsearch
    43: 00000000     0 FILE    LOCAL  DEFAULT  ABS printfmt.c
    44: f0100b8c   165 FUNC    LOCAL  DEFAULT    1 printnum
    45: f0100c31    28 FUNC    LOCAL  DEFAULT    1 sprintputch
    46: f0101e28    28 OBJECT  LOCAL  DEFAULT    2 error_string
    47: 00000000     0 FILE    LOCAL  DEFAULT  ABS readline.c
    48: f0112540  1024 OBJECT  LOCAL  DEFAULT    6 buf
    49: 00000000     0 FILE    LOCAL  DEFAULT  ABS string.c
    50: 00000000     0 FILE    LOCAL  DEFAULT  ABS libgcc2.c
    51: 00000000     0 FILE    LOCAL  DEFAULT  ABS libgcc2.c
    52: f010000c     0 NOTYPE  GLOBAL DEFAULT    1 entry
    53: f0101206    31 FUNC    GLOBAL DEFAULT    1 strcpy
    54: f01004cf    18 FUNC    GLOBAL DEFAULT    1 kbd_intr
    55: f0100720     6 FUNC    GLOBAL DEFAULT    1 mon_backtrace
    56: f01000e6    89 FUNC    GLOBAL DEFAULT    1 _panic
    57: f0100094    82 FUNC    GLOBAL DEFAULT    1 i386_init
    58: f010137e    96 FUNC    GLOBAL DEFAULT    1 memmove
    59: f01010d8    26 FUNC    GLOBAL DEFAULT    1 snprintf
    60: f0100c6a  1049 FUNC    GLOBAL DEFAULT    1 vprintfmt
    61: f01004e1    72 FUNC    GLOBAL DEFAULT    1 cons_getc
    62: f01008a3    20 FUNC    GLOBAL DEFAULT    1 cprintf
    63: f01013de    22 FUNC    GLOBAL DEFAULT    1 memcpy
    64: f01010f2   221 FUNC    GLOBAL DEFAULT    1 readline
    65: f0111000  4096 OBJECT  GLOBAL DEFAULT    5 entry_pgtable
    66: f0100040    84 FUNC    GLOBAL DEFAULT    1 test_backtrace
    67: f0101083    85 FUNC    GLOBAL DEFAULT    1 vsnprintf
    68: f0112300     0 NOTYPE  GLOBAL DEFAULT    6 edata
    69: f0100529   248 FUNC    GLOBAL DEFAULT    1 cons_init
    70: f0105fe8     0 NOTYPE  GLOBAL DEFAULT    3 __STAB_END__
    71: f0105fe9     0 NOTYPE  GLOBAL DEFAULT    4 __STABSTR_BEGIN__
    72: f0101610   294 FUNC    GLOBAL HIDDEN     1 __umoddi3
    73: f01004b3    28 FUNC    GLOBAL DEFAULT    1 serial_intr
    74: f0101510   255 FUNC    GLOBAL HIDDEN     1 __udivdi3
    75: f0100642     6 FUNC    GLOBAL DEFAULT    1 iscons
    76: f0101442   204 FUNC    GLOBAL DEFAULT    1 strtol
    77: f01011e5    33 FUNC    GLOBAL DEFAULT    1 strnlen
    78: f0101225    37 FUNC    GLOBAL DEFAULT    1 strcat
    79: f0112944     4 OBJECT  GLOBAL DEFAULT    6 panicstr
    80: f0112940     0 NOTYPE  GLOBAL DEFAULT    6 end
    81: f010013f    58 FUNC    GLOBAL DEFAULT    1 _warn
    82: f010131b    24 FUNC    GLOBAL DEFAULT    1 strfind
    83: f0101736     0 NOTYPE  GLOBAL DEFAULT    1 etext
    84: 0010000c     0 NOTYPE  GLOBAL DEFAULT    1 _start
    85: f0101272    56 FUNC    GLOBAL DEFAULT    1 strlcpy
    86: f01012cb    51 FUNC    GLOBAL DEFAULT    1 strncmp
    87: f010124a    40 FUNC    GLOBAL DEFAULT    1 strncpy
    88: f01013f4    51 FUNC    GLOBAL DEFAULT    1 memcmp
    89: f0100621    16 FUNC    GLOBAL DEFAULT    1 cputchar
    90: f0101333    75 FUNC    GLOBAL DEFAULT    1 memset
    91: f0100631    17 FUNC    GLOBAL DEFAULT    1 getchar
    92: f0100c4d    29 FUNC    GLOBAL DEFAULT    1 printfmt
    93: f0107933     0 NOTYPE  GLOBAL DEFAULT    4 __STABSTR_END__
    94: f01012aa    33 FUNC    GLOBAL DEFAULT    1 strcmp
    95: f01009a4   488 FUNC    GLOBAL DEFAULT    1 debuginfo_eip
    96: f010087d    38 FUNC    GLOBAL DEFAULT    1 vcprintf
    97: f0110000     0 NOTYPE  GLOBAL DEFAULT    5 bootstacktop
    98: f0110000  4096 OBJECT  GLOBAL DEFAULT    5 entry_pgdir
    99: f0108000     0 NOTYPE  GLOBAL DEFAULT    5 bootstack
   100: f0101e54     0 NOTYPE  GLOBAL DEFAULT    3 __STAB_BEGIN__
   101: f01011cf    22 FUNC    GLOBAL DEFAULT    1 strlen
   102: f01012fe    29 FUNC    GLOBAL DEFAULT    1 strchr
   103: f0100680   160 FUNC    GLOBAL DEFAULT    1 mon_kerninfo
   104: f0100726   324 FUNC    GLOBAL DEFAULT    1 monitor
   105: f0101427    27 FUNC    GLOBAL DEFAULT    1 memfind
   106: f0100648    56 FUNC    GLOBAL DEFAULT    1 mon_help
```



## 3、工具

- `readelf`   

  Unix二进制工具，显示一个或多个ELF文件信息；[GNU Binutils](https://en.wikipedia.org/wiki/GNU_Binutils)提供.

- `elfutils` 

  仅用于Linux的替代工具

- `elfdump` 

  查看ELF信息的命令行工具，在Solaris 与FreeBSD下可用

- `objdump` 

  通用的文件信息查看工具，可以查看ELF与其他相关格式文件；参见 [Binary File Descriptor library](https://en.wikipedia.org/wiki/Binary_File_Descriptor_library) 

> **GNU Binutils**

**GNU Binary Utilities** 或 **binutils** 是一整套的[编程语言](https://zh.wikipedia.org/wiki/程式語言)工具程序，用来处理许多格式的[目标文件](https://zh.wikipedia.org/wiki/目的檔)。

binutils包含底下这些指令：

| 工具        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| `as`        | [汇编器](https://zh.wikipedia.org/wiki/組譯器)               |
| `ld`        | [链接器](https://zh.wikipedia.org/wiki/連結器)               |
| `gprof`     | [性能分析](https://zh.wikipedia.org/wiki/性能分析)工具程序   |
| `addr2line` | 从目标文件的虚拟地址获取文件的行号或符号                     |
| `ar`        | 可以对[静态库](https://zh.wikipedia.org/w/index.php?title=Archive_file&action=edit&redlink=1)做创建、修改和取出的操作。 |
| `c++filt`   | [解码](https://zh.wikipedia.org/wiki/Name_mangling#Name_mangling_in_C++) [C++](https://zh.wikipedia.org/wiki/C%2B%2B) 的符号 |
| `dlltool`   | 创建Windows [动态库](https://zh.wikipedia.org/wiki/動態函式庫) |
| `gold`      | 另一种链接器                                                 |
| `nlmconv`   | 可以转换成[NetWare Loadable Module](https://zh.wikipedia.org/w/index.php?title=NetWare_Loadable_Module&action=edit&redlink=1)目标文件格式 |
| `nm`        | 显示目标文件内的符号                                         |
| `objcopy`   | 复制目标文件，过程中可以修改                                 |
| `objdump`   | 显示目标文件的相关信息，亦可反汇编                           |
| `ranlib`    | 产生静态库的索引                                             |
| `readelf`   | 显示[ELF](https://zh.wikipedia.org/wiki/可執行與可鏈接格式)文件的内容 |
| `size`      | 列出总体和section的大小                                      |
| `strings`   | 列出任何二进制档内的可显示字符串                             |
| `strip`     | 从目标文件中移除符号                                         |
| `windmc`    | 产生Windows消息资源                                          |
| `windres`   | Windows [资源](https://zh.wikipedia.org/wiki/资源_(Windows))档编译器 |



## 4、参考链接

**WIKI**: https://en.wikipedia.org/wiki/Executable_and_Linkable_Format

**ELF Specification:** https://pdos.csail.mit.edu/6.828/2018/readings/elf.pdf

**进程地址空间再学习:** http://www.choudan.net/2013/11/16/Linux进程地址空间再学习.html





