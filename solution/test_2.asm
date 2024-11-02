
_test_2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "pstat.h"
#include "test_helper.h"

int
main(int argc, char* argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
    struct pstat ps;
    int my_idx = find_my_stats_index(&ps);
   f:	8d 85 e8 f1 ff ff    	lea    -0xe18(%ebp),%eax
{
  15:	53                   	push   %ebx
  16:	51                   	push   %ecx
  17:	81 ec 18 0e 00 00    	sub    $0xe18,%esp
    int my_idx = find_my_stats_index(&ps);
  1d:	e8 0e 02 00 00       	call   230 <find_my_stats_index>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  22:	83 f8 ff             	cmp    $0xffffffff,%eax
  25:	0f 84 60 01 00 00    	je     18b <main+0x18b>

    int old_rtime = ps.rtime[my_idx];
  2b:	8b 8c 85 e8 f7 ff ff 	mov    -0x818(%ebp,%eax,4),%ecx
    int old_pass = ps.pass[my_idx];
  32:	8b 94 85 e8 f4 ff ff 	mov    -0xb18(%ebp,%eax,4),%edx
  39:	8d b5 e8 f8 ff ff    	lea    -0x718(%ebp),%esi
    int old_stride = ps.stride[my_idx];
  3f:	8b 84 85 e8 f6 ff ff 	mov    -0x918(%ebp,%eax,4),%eax
    int old_rtime = ps.rtime[my_idx];
  46:	89 8d dc f1 ff ff    	mov    %ecx,-0xe24(%ebp)
    
    int extra = 4;

    run_until(old_rtime + extra);
  4c:	8d 59 04             	lea    0x4(%ecx),%ebx
    int old_pass = ps.pass[my_idx];
  4f:	89 95 e4 f1 ff ff    	mov    %edx,-0xe1c(%ebp)
    int old_stride = ps.stride[my_idx];
  55:	89 85 e0 f1 ff ff    	mov    %eax,-0xe20(%ebp)

/*
 * Run at least until the specified target rtime
 * Might immediately return if the rtime is already reached
 */
static __attribute__((unused)) void run_until(int target_rtime) {
  5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  5f:	90                   	nop
    int mypid = getpid();
  60:	e8 ee 04 00 00       	call   553 <getpid>
    if (getpinfo(s) == -1)
  65:	83 ec 0c             	sub    $0xc,%esp
  68:	56                   	push   %esi
    int mypid = getpid();
  69:	89 c7                	mov    %eax,%edi
    if (getpinfo(s) == -1)
  6b:	e8 0b 05 00 00       	call   57b <getpinfo>
  70:	83 c4 10             	add    $0x10,%esp
  73:	83 f8 ff             	cmp    $0xffffffff,%eax
  76:	74 13                	je     8b <main+0x8b>
    for (int i = 0; i < NPROC; i++)
  78:	31 c0                	xor    %eax,%eax
        if (s->pid[i] == mypid)
  7a:	3b bc 86 00 02 00 00 	cmp    0x200(%esi,%eax,4),%edi
  81:	74 4d                	je     d0 <main+0xd0>
    for (int i = 0; i < NPROC; i++)
  83:	83 c0 01             	add    $0x1,%eax
  86:	83 f8 40             	cmp    $0x40,%eax
  89:	75 ef                	jne    7a <main+0x7a>
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  8b:	83 ec 0c             	sub    $0xc,%esp
  8e:	6a 48                	push   $0x48
  90:	68 87 09 00 00       	push   $0x987
  95:	68 71 09 00 00       	push   $0x971
  9a:	68 7b 09 00 00       	push   $0x97b
  9f:	6a 01                	push   $0x1
  a1:	e8 9a 05 00 00       	call   640 <printf>
  a6:	83 c4 18             	add    $0x18,%esp
  a9:	68 ac 09 00 00       	push   $0x9ac
  ae:	6a 01                	push   $0x1
  b0:	e8 8b 05 00 00       	call   640 <printf>
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 85 09 00 00       	push   $0x985
  bc:	6a 01                	push   $0x1
  be:	e8 7d 05 00 00       	call   640 <printf>
  c3:	e8 0b 04 00 00       	call   4d3 <exit>
  c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cf:	90                   	nop

        if (ps.rtime[my_idx] >= target_rtime)
  d0:	3b 9c 85 e8 fe ff ff 	cmp    -0x118(%ebp,%eax,4),%ebx
  d7:	7f 87                	jg     60 <main+0x60>

    my_idx = find_my_stats_index(&ps);
  d9:	8d 85 e8 f1 ff ff    	lea    -0xe18(%ebp),%eax
  df:	e8 4c 01 00 00       	call   230 <find_my_stats_index>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  e4:	83 f8 ff             	cmp    $0xffffffff,%eax
  e7:	0f 84 0c 01 00 00    	je     1f9 <main+0x1f9>

    int now_rtime = ps.rtime[my_idx];
  ed:	8b 94 85 e8 f7 ff ff 	mov    -0x818(%ebp,%eax,4),%edx
    int now_pass = ps.pass[my_idx];
  f4:	8b 9c 85 e8 f4 ff ff 	mov    -0xb18(%ebp,%eax,4),%ebx
    int now_stride = ps.stride[my_idx];
  fb:	8b 84 85 e8 f6 ff ff 	mov    -0x918(%ebp,%eax,4),%eax

    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 102:	39 9d e4 f1 ff ff    	cmp    %ebx,-0xe1c(%ebp)
 108:	0f 8d bc 00 00 00    	jge    1ca <main+0x1ca>
new_pass is %d", old_pass, now_pass);
    
    ASSERT(old_stride == now_stride, "Stride changed from %d to %d without \
 10e:	8b b5 e0 f1 ff ff    	mov    -0xe20(%ebp),%esi
 114:	89 85 d8 f1 ff ff    	mov    %eax,-0xe28(%ebp)
 11a:	39 c6                	cmp    %eax,%esi
 11c:	75 7c                	jne    19a <main+0x19a>
calling settickets", old_stride, now_stride);

    int diff_rtime = now_rtime - old_rtime;
    int diff_pass = now_pass - old_pass;
    int exp_pass = diff_rtime * now_stride;
 11e:	8b bd e0 f1 ff ff    	mov    -0xe20(%ebp),%edi
    int diff_rtime = now_rtime - old_rtime;
 124:	2b 95 dc f1 ff ff    	sub    -0xe24(%ebp),%edx
    int diff_pass = now_pass - old_pass;
 12a:	2b 9d e4 f1 ff ff    	sub    -0xe1c(%ebp),%ebx
    int exp_pass = diff_rtime * now_stride;
 130:	89 95 e4 f1 ff ff    	mov    %edx,-0xe1c(%ebp)
 136:	89 fe                	mov    %edi,%esi
 138:	0f af f2             	imul   %edx,%esi

    ASSERT(diff_pass == exp_pass, "Pass is not incremented correctly by stride. \
 13b:	39 f3                	cmp    %esi,%ebx
 13d:	0f 84 c5 00 00 00    	je     208 <main+0x208>
 143:	83 ec 0c             	sub    $0xc,%esp
 146:	6a 27                	push   $0x27
 148:	68 68 09 00 00       	push   $0x968
 14d:	68 71 09 00 00       	push   $0x971
 152:	68 7b 09 00 00       	push   $0x97b
 157:	6a 01                	push   $0x1
 159:	e8 e2 04 00 00       	call   640 <printf>
 15e:	8b 95 e4 f1 ff ff    	mov    -0xe1c(%ebp),%edx
 164:	83 c4 18             	add    $0x18,%esp
 167:	53                   	push   %ebx
 168:	56                   	push   %esi
 169:	57                   	push   %edi
 16a:	52                   	push   %edx
 16b:	68 48 0a 00 00       	push   $0xa48
 170:	6a 01                	push   $0x1
 172:	e8 c9 04 00 00       	call   640 <printf>
 177:	83 c4 18             	add    $0x18,%esp
 17a:	68 85 09 00 00       	push   $0x985
 17f:	6a 01                	push   $0x1
 181:	e8 ba 04 00 00       	call   640 <printf>
 186:	e8 48 03 00 00       	call   4d3 <exit>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 18b:	83 ec 0c             	sub    $0xc,%esp
 18e:	6a 0c                	push   $0xc
 190:	68 68 09 00 00       	push   $0x968
 195:	e9 fb fe ff ff       	jmp    95 <main+0x95>
    ASSERT(old_stride == now_stride, "Stride changed from %d to %d without \
 19a:	83 ec 0c             	sub    $0xc,%esp
 19d:	6a 20                	push   $0x20
 19f:	68 68 09 00 00       	push   $0x968
 1a4:	68 71 09 00 00       	push   $0x971
 1a9:	68 7b 09 00 00       	push   $0x97b
 1ae:	6a 01                	push   $0x1
 1b0:	e8 8b 04 00 00       	call   640 <printf>
 1b5:	8b 85 d8 f1 ff ff    	mov    -0xe28(%ebp),%eax
 1bb:	83 c4 20             	add    $0x20,%esp
 1be:	50                   	push   %eax
 1bf:	56                   	push   %esi
 1c0:	68 10 0a 00 00       	push   $0xa10
 1c5:	e9 e4 fe ff ff       	jmp    ae <main+0xae>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 1ca:	83 ec 0c             	sub    $0xc,%esp
 1cd:	6a 1d                	push   $0x1d
 1cf:	68 68 09 00 00       	push   $0x968
 1d4:	68 71 09 00 00       	push   $0x971
 1d9:	68 7b 09 00 00       	push   $0x97b
 1de:	6a 01                	push   $0x1
 1e0:	e8 5b 04 00 00       	call   640 <printf>
 1e5:	83 c4 20             	add    $0x20,%esp
 1e8:	53                   	push   %ebx
 1e9:	ff b5 e4 f1 ff ff    	push   -0xe1c(%ebp)
 1ef:	68 d8 09 00 00       	push   $0x9d8
 1f4:	e9 b5 fe ff ff       	jmp    ae <main+0xae>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 1f9:	83 ec 0c             	sub    $0xc,%esp
 1fc:	6a 17                	push   $0x17
 1fe:	68 68 09 00 00       	push   $0x968
 203:	e9 8d fe ff ff       	jmp    95 <main+0x95>
    PRINTF("%s", SUCCESS_MSG);
 208:	50                   	push   %eax
 209:	68 71 09 00 00       	push   $0x971
 20e:	68 95 09 00 00       	push   $0x995
 213:	6a 01                	push   $0x1
 215:	e8 26 04 00 00       	call   640 <printf>
 21a:	83 c4 0c             	add    $0xc,%esp
 21d:	68 9a 09 00 00       	push   $0x99a
 222:	68 a6 09 00 00       	push   $0x9a6
 227:	e9 82 fe ff ff       	jmp    ae <main+0xae>
 22c:	66 90                	xchg   %ax,%ax
 22e:	66 90                	xchg   %ax,%ax

00000230 <find_my_stats_index>:
static int find_my_stats_index(struct pstat *s) {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	89 c3                	mov    %eax,%ebx
    int mypid = getpid();
 237:	e8 17 03 00 00       	call   553 <getpid>
    if (getpinfo(s) == -1)
 23c:	83 ec 0c             	sub    $0xc,%esp
 23f:	53                   	push   %ebx
    int mypid = getpid();
 240:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1)
 242:	e8 34 03 00 00       	call   57b <getpinfo>
 247:	83 c4 10             	add    $0x10,%esp
 24a:	83 f8 ff             	cmp    $0xffffffff,%eax
 24d:	74 1a                	je     269 <find_my_stats_index+0x39>
    for (int i = 0; i < NPROC; i++)
 24f:	31 c0                	xor    %eax,%eax
 251:	eb 0d                	jmp    260 <find_my_stats_index+0x30>
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
 258:	83 c0 01             	add    $0x1,%eax
 25b:	83 f8 40             	cmp    $0x40,%eax
 25e:	74 10                	je     270 <find_my_stats_index+0x40>
        if (s->pid[i] == mypid)
 260:	39 b4 83 00 02 00 00 	cmp    %esi,0x200(%ebx,%eax,4)
 267:	75 ef                	jne    258 <find_my_stats_index+0x28>
}
 269:	8d 65 f8             	lea    -0x8(%ebp),%esp
 26c:	5b                   	pop    %ebx
 26d:	5e                   	pop    %esi
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    
 270:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
 273:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    
 27c:	66 90                	xchg   %ax,%ax
 27e:	66 90                	xchg   %ax,%ax

00000280 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 280:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 281:	31 c0                	xor    %eax,%eax
{
 283:	89 e5                	mov    %esp,%ebp
 285:	53                   	push   %ebx
 286:	8b 4d 08             	mov    0x8(%ebp),%ecx
 289:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 290:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 294:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 297:	83 c0 01             	add    $0x1,%eax
 29a:	84 d2                	test   %dl,%dl
 29c:	75 f2                	jne    290 <strcpy+0x10>
    ;
  return os;
}
 29e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a1:	89 c8                	mov    %ecx,%eax
 2a3:	c9                   	leave  
 2a4:	c3                   	ret    
 2a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2ba:	0f b6 02             	movzbl (%edx),%eax
 2bd:	84 c0                	test   %al,%al
 2bf:	75 17                	jne    2d8 <strcmp+0x28>
 2c1:	eb 3a                	jmp    2fd <strcmp+0x4d>
 2c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c7:	90                   	nop
 2c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 2cc:	83 c2 01             	add    $0x1,%edx
 2cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 2d2:	84 c0                	test   %al,%al
 2d4:	74 1a                	je     2f0 <strcmp+0x40>
    p++, q++;
 2d6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 2d8:	0f b6 19             	movzbl (%ecx),%ebx
 2db:	38 c3                	cmp    %al,%bl
 2dd:	74 e9                	je     2c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 2df:	29 d8                	sub    %ebx,%eax
}
 2e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e4:	c9                   	leave  
 2e5:	c3                   	ret    
 2e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 2f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2f4:	31 c0                	xor    %eax,%eax
 2f6:	29 d8                	sub    %ebx,%eax
}
 2f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2fb:	c9                   	leave  
 2fc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 2fd:	0f b6 19             	movzbl (%ecx),%ebx
 300:	31 c0                	xor    %eax,%eax
 302:	eb db                	jmp    2df <strcmp+0x2f>
 304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 30f:	90                   	nop

00000310 <strlen>:

uint
strlen(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 316:	80 3a 00             	cmpb   $0x0,(%edx)
 319:	74 15                	je     330 <strlen+0x20>
 31b:	31 c0                	xor    %eax,%eax
 31d:	8d 76 00             	lea    0x0(%esi),%esi
 320:	83 c0 01             	add    $0x1,%eax
 323:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 327:	89 c1                	mov    %eax,%ecx
 329:	75 f5                	jne    320 <strlen+0x10>
    ;
  return n;
}
 32b:	89 c8                	mov    %ecx,%eax
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
 32f:	90                   	nop
  for(n = 0; s[n]; n++)
 330:	31 c9                	xor    %ecx,%ecx
}
 332:	5d                   	pop    %ebp
 333:	89 c8                	mov    %ecx,%eax
 335:	c3                   	ret    
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi

00000340 <memset>:

void*
memset(void *dst, int c, uint n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 347:	8b 4d 10             	mov    0x10(%ebp),%ecx
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	89 d7                	mov    %edx,%edi
 34f:	fc                   	cld    
 350:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 352:	8b 7d fc             	mov    -0x4(%ebp),%edi
 355:	89 d0                	mov    %edx,%eax
 357:	c9                   	leave  
 358:	c3                   	ret    
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 36a:	0f b6 10             	movzbl (%eax),%edx
 36d:	84 d2                	test   %dl,%dl
 36f:	75 12                	jne    383 <strchr+0x23>
 371:	eb 1d                	jmp    390 <strchr+0x30>
 373:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 377:	90                   	nop
 378:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 37c:	83 c0 01             	add    $0x1,%eax
 37f:	84 d2                	test   %dl,%dl
 381:	74 0d                	je     390 <strchr+0x30>
    if(*s == c)
 383:	38 d1                	cmp    %dl,%cl
 385:	75 f1                	jne    378 <strchr+0x18>
      return (char*)s;
  return 0;
}
 387:	5d                   	pop    %ebp
 388:	c3                   	ret    
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 390:	31 c0                	xor    %eax,%eax
}
 392:	5d                   	pop    %ebp
 393:	c3                   	ret    
 394:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop

000003a0 <gets>:

char*
gets(char *buf, int max)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 3a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 3a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 3a9:	31 db                	xor    %ebx,%ebx
{
 3ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 3ae:	eb 27                	jmp    3d7 <gets+0x37>
    cc = read(0, &c, 1);
 3b0:	83 ec 04             	sub    $0x4,%esp
 3b3:	6a 01                	push   $0x1
 3b5:	57                   	push   %edi
 3b6:	6a 00                	push   $0x0
 3b8:	e8 2e 01 00 00       	call   4eb <read>
    if(cc < 1)
 3bd:	83 c4 10             	add    $0x10,%esp
 3c0:	85 c0                	test   %eax,%eax
 3c2:	7e 1d                	jle    3e1 <gets+0x41>
      break;
    buf[i++] = c;
 3c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3c8:	8b 55 08             	mov    0x8(%ebp),%edx
 3cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3cf:	3c 0a                	cmp    $0xa,%al
 3d1:	74 1d                	je     3f0 <gets+0x50>
 3d3:	3c 0d                	cmp    $0xd,%al
 3d5:	74 19                	je     3f0 <gets+0x50>
  for(i=0; i+1 < max; ){
 3d7:	89 de                	mov    %ebx,%esi
 3d9:	83 c3 01             	add    $0x1,%ebx
 3dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3df:	7c cf                	jl     3b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 3e1:	8b 45 08             	mov    0x8(%ebp),%eax
 3e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3eb:	5b                   	pop    %ebx
 3ec:	5e                   	pop    %esi
 3ed:	5f                   	pop    %edi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    
  buf[i] = '\0';
 3f0:	8b 45 08             	mov    0x8(%ebp),%eax
 3f3:	89 de                	mov    %ebx,%esi
 3f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 3f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fc:	5b                   	pop    %ebx
 3fd:	5e                   	pop    %esi
 3fe:	5f                   	pop    %edi
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret    
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40f:	90                   	nop

00000410 <stat>:

int
stat(const char *n, struct stat *st)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	push   0x8(%ebp)
 41d:	e8 f1 00 00 00       	call   513 <open>
  if(fd < 0)
 422:	83 c4 10             	add    $0x10,%esp
 425:	85 c0                	test   %eax,%eax
 427:	78 27                	js     450 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	ff 75 0c             	push   0xc(%ebp)
 42f:	89 c3                	mov    %eax,%ebx
 431:	50                   	push   %eax
 432:	e8 f4 00 00 00       	call   52b <fstat>
  close(fd);
 437:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 43a:	89 c6                	mov    %eax,%esi
  close(fd);
 43c:	e8 ba 00 00 00       	call   4fb <close>
  return r;
 441:	83 c4 10             	add    $0x10,%esp
}
 444:	8d 65 f8             	lea    -0x8(%ebp),%esp
 447:	89 f0                	mov    %esi,%eax
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 450:	be ff ff ff ff       	mov    $0xffffffff,%esi
 455:	eb ed                	jmp    444 <stat+0x34>
 457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45e:	66 90                	xchg   %ax,%ax

00000460 <atoi>:

int
atoi(const char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 467:	0f be 02             	movsbl (%edx),%eax
 46a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 46d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 470:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 475:	77 1e                	ja     495 <atoi+0x35>
 477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 480:	83 c2 01             	add    $0x1,%edx
 483:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 486:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 48a:	0f be 02             	movsbl (%edx),%eax
 48d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 490:	80 fb 09             	cmp    $0x9,%bl
 493:	76 eb                	jbe    480 <atoi+0x20>
  return n;
}
 495:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 498:	89 c8                	mov    %ecx,%eax
 49a:	c9                   	leave  
 49b:	c3                   	ret    
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	8b 45 10             	mov    0x10(%ebp),%eax
 4a7:	8b 55 08             	mov    0x8(%ebp),%edx
 4aa:	56                   	push   %esi
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ae:	85 c0                	test   %eax,%eax
 4b0:	7e 13                	jle    4c5 <memmove+0x25>
 4b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 4b4:	89 d7                	mov    %edx,%edi
 4b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 4c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 4c1:	39 f8                	cmp    %edi,%eax
 4c3:	75 fb                	jne    4c0 <memmove+0x20>
  return vdst;
}
 4c5:	5e                   	pop    %esi
 4c6:	89 d0                	mov    %edx,%eax
 4c8:	5f                   	pop    %edi
 4c9:	5d                   	pop    %ebp
 4ca:	c3                   	ret    

000004cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4cb:	b8 01 00 00 00       	mov    $0x1,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <exit>:
SYSCALL(exit)
 4d3:	b8 02 00 00 00       	mov    $0x2,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <wait>:
SYSCALL(wait)
 4db:	b8 03 00 00 00       	mov    $0x3,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <pipe>:
SYSCALL(pipe)
 4e3:	b8 04 00 00 00       	mov    $0x4,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <read>:
SYSCALL(read)
 4eb:	b8 05 00 00 00       	mov    $0x5,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <write>:
SYSCALL(write)
 4f3:	b8 10 00 00 00       	mov    $0x10,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <close>:
SYSCALL(close)
 4fb:	b8 15 00 00 00       	mov    $0x15,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <kill>:
SYSCALL(kill)
 503:	b8 06 00 00 00       	mov    $0x6,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <exec>:
SYSCALL(exec)
 50b:	b8 07 00 00 00       	mov    $0x7,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <open>:
SYSCALL(open)
 513:	b8 0f 00 00 00       	mov    $0xf,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <mknod>:
SYSCALL(mknod)
 51b:	b8 11 00 00 00       	mov    $0x11,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <unlink>:
SYSCALL(unlink)
 523:	b8 12 00 00 00       	mov    $0x12,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <fstat>:
SYSCALL(fstat)
 52b:	b8 08 00 00 00       	mov    $0x8,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <link>:
SYSCALL(link)
 533:	b8 13 00 00 00       	mov    $0x13,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <mkdir>:
SYSCALL(mkdir)
 53b:	b8 14 00 00 00       	mov    $0x14,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <chdir>:
SYSCALL(chdir)
 543:	b8 09 00 00 00       	mov    $0x9,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <dup>:
SYSCALL(dup)
 54b:	b8 0a 00 00 00       	mov    $0xa,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <getpid>:
SYSCALL(getpid)
 553:	b8 0b 00 00 00       	mov    $0xb,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <sbrk>:
SYSCALL(sbrk)
 55b:	b8 0c 00 00 00       	mov    $0xc,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <sleep>:
SYSCALL(sleep)
 563:	b8 0d 00 00 00       	mov    $0xd,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <uptime>:
SYSCALL(uptime)
 56b:	b8 0e 00 00 00       	mov    $0xe,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <settickets>:
SYSCALL(settickets)
 573:	b8 16 00 00 00       	mov    $0x16,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <getpinfo>:
SYSCALL(getpinfo)
 57b:	b8 17 00 00 00       	mov    $0x17,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    
 583:	66 90                	xchg   %ax,%ax
 585:	66 90                	xchg   %ax,%ax
 587:	66 90                	xchg   %ax,%ax
 589:	66 90                	xchg   %ax,%ax
 58b:	66 90                	xchg   %ax,%ax
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 3c             	sub    $0x3c,%esp
 599:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 59c:	89 d1                	mov    %edx,%ecx
{
 59e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 5a1:	85 d2                	test   %edx,%edx
 5a3:	0f 89 7f 00 00 00    	jns    628 <printint+0x98>
 5a9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5ad:	74 79                	je     628 <printint+0x98>
    neg = 1;
 5af:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 5b6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 5b8:	31 db                	xor    %ebx,%ebx
 5ba:	8d 75 d7             	lea    -0x29(%ebp),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5c0:	89 c8                	mov    %ecx,%eax
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	89 cf                	mov    %ecx,%edi
 5c6:	f7 75 c4             	divl   -0x3c(%ebp)
 5c9:	0f b6 92 6c 0b 00 00 	movzbl 0xb6c(%edx),%edx
 5d0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 5d3:	89 d8                	mov    %ebx,%eax
 5d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 5d8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 5db:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 5de:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 5e1:	76 dd                	jbe    5c0 <printint+0x30>
  if(neg)
 5e3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 5e6:	85 c9                	test   %ecx,%ecx
 5e8:	74 0c                	je     5f6 <printint+0x66>
    buf[i++] = '-';
 5ea:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 5ef:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 5f1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 5f6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 5f9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 5fd:	eb 07                	jmp    606 <printint+0x76>
 5ff:	90                   	nop
    putc(fd, buf[i]);
 600:	0f b6 13             	movzbl (%ebx),%edx
 603:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 606:	83 ec 04             	sub    $0x4,%esp
 609:	88 55 d7             	mov    %dl,-0x29(%ebp)
 60c:	6a 01                	push   $0x1
 60e:	56                   	push   %esi
 60f:	57                   	push   %edi
 610:	e8 de fe ff ff       	call   4f3 <write>
  while(--i >= 0)
 615:	83 c4 10             	add    $0x10,%esp
 618:	39 de                	cmp    %ebx,%esi
 61a:	75 e4                	jne    600 <printint+0x70>
}
 61c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61f:	5b                   	pop    %ebx
 620:	5e                   	pop    %esi
 621:	5f                   	pop    %edi
 622:	5d                   	pop    %ebp
 623:	c3                   	ret    
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 628:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 62f:	eb 87                	jmp    5b8 <printint+0x28>
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop

00000640 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 649:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 64c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 64f:	0f b6 13             	movzbl (%ebx),%edx
 652:	84 d2                	test   %dl,%dl
 654:	74 6a                	je     6c0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 656:	8d 45 10             	lea    0x10(%ebp),%eax
 659:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 65c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 65f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 661:	89 45 d0             	mov    %eax,-0x30(%ebp)
 664:	eb 36                	jmp    69c <printf+0x5c>
 666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
 670:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 673:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 678:	83 f8 25             	cmp    $0x25,%eax
 67b:	74 15                	je     692 <printf+0x52>
  write(fd, &c, 1);
 67d:	83 ec 04             	sub    $0x4,%esp
 680:	88 55 e7             	mov    %dl,-0x19(%ebp)
 683:	6a 01                	push   $0x1
 685:	57                   	push   %edi
 686:	56                   	push   %esi
 687:	e8 67 fe ff ff       	call   4f3 <write>
 68c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 68f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 692:	0f b6 13             	movzbl (%ebx),%edx
 695:	83 c3 01             	add    $0x1,%ebx
 698:	84 d2                	test   %dl,%dl
 69a:	74 24                	je     6c0 <printf+0x80>
    c = fmt[i] & 0xff;
 69c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 69f:	85 c9                	test   %ecx,%ecx
 6a1:	74 cd                	je     670 <printf+0x30>
      }
    } else if(state == '%'){
 6a3:	83 f9 25             	cmp    $0x25,%ecx
 6a6:	75 ea                	jne    692 <printf+0x52>
      if(c == 'd'){
 6a8:	83 f8 25             	cmp    $0x25,%eax
 6ab:	0f 84 07 01 00 00    	je     7b8 <printf+0x178>
 6b1:	83 e8 63             	sub    $0x63,%eax
 6b4:	83 f8 15             	cmp    $0x15,%eax
 6b7:	77 17                	ja     6d0 <printf+0x90>
 6b9:	ff 24 85 14 0b 00 00 	jmp    *0xb14(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c3:	5b                   	pop    %ebx
 6c4:	5e                   	pop    %esi
 6c5:	5f                   	pop    %edi
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
 6c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
  write(fd, &c, 1);
 6d0:	83 ec 04             	sub    $0x4,%esp
 6d3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 6d6:	6a 01                	push   $0x1
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6de:	e8 10 fe ff ff       	call   4f3 <write>
        putc(fd, c);
 6e3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 6e7:	83 c4 0c             	add    $0xc,%esp
 6ea:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6ed:	6a 01                	push   $0x1
 6ef:	57                   	push   %edi
 6f0:	56                   	push   %esi
 6f1:	e8 fd fd ff ff       	call   4f3 <write>
        putc(fd, c);
 6f6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6f9:	31 c9                	xor    %ecx,%ecx
 6fb:	eb 95                	jmp    692 <printf+0x52>
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 700:	83 ec 0c             	sub    $0xc,%esp
 703:	b9 10 00 00 00       	mov    $0x10,%ecx
 708:	6a 00                	push   $0x0
 70a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 70d:	8b 10                	mov    (%eax),%edx
 70f:	89 f0                	mov    %esi,%eax
 711:	e8 7a fe ff ff       	call   590 <printint>
        ap++;
 716:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 71a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 71d:	31 c9                	xor    %ecx,%ecx
 71f:	e9 6e ff ff ff       	jmp    692 <printf+0x52>
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 728:	8b 45 d0             	mov    -0x30(%ebp),%eax
 72b:	8b 10                	mov    (%eax),%edx
        ap++;
 72d:	83 c0 04             	add    $0x4,%eax
 730:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 733:	85 d2                	test   %edx,%edx
 735:	0f 84 8d 00 00 00    	je     7c8 <printf+0x188>
        while(*s != 0){
 73b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 73e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 740:	84 c0                	test   %al,%al
 742:	0f 84 4a ff ff ff    	je     692 <printf+0x52>
 748:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 74b:	89 d3                	mov    %edx,%ebx
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
          s++;
 753:	83 c3 01             	add    $0x1,%ebx
 756:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 759:	6a 01                	push   $0x1
 75b:	57                   	push   %edi
 75c:	56                   	push   %esi
 75d:	e8 91 fd ff ff       	call   4f3 <write>
        while(*s != 0){
 762:	0f b6 03             	movzbl (%ebx),%eax
 765:	83 c4 10             	add    $0x10,%esp
 768:	84 c0                	test   %al,%al
 76a:	75 e4                	jne    750 <printf+0x110>
      state = 0;
 76c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 76f:	31 c9                	xor    %ecx,%ecx
 771:	e9 1c ff ff ff       	jmp    692 <printf+0x52>
 776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	b9 0a 00 00 00       	mov    $0xa,%ecx
 788:	6a 01                	push   $0x1
 78a:	e9 7b ff ff ff       	jmp    70a <printf+0xca>
 78f:	90                   	nop
        putc(fd, *ap);
 790:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 793:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 796:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 798:	6a 01                	push   $0x1
 79a:	57                   	push   %edi
 79b:	56                   	push   %esi
        putc(fd, *ap);
 79c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 79f:	e8 4f fd ff ff       	call   4f3 <write>
        ap++;
 7a4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 7a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7ab:	31 c9                	xor    %ecx,%ecx
 7ad:	e9 e0 fe ff ff       	jmp    692 <printf+0x52>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 7b8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 7bb:	83 ec 04             	sub    $0x4,%esp
 7be:	e9 2a ff ff ff       	jmp    6ed <printf+0xad>
 7c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7c7:	90                   	nop
          s = "(null)";
 7c8:	ba 0d 0b 00 00       	mov    $0xb0d,%edx
        while(*s != 0){
 7cd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7d0:	b8 28 00 00 00       	mov    $0x28,%eax
 7d5:	89 d3                	mov    %edx,%ebx
 7d7:	e9 74 ff ff ff       	jmp    750 <printf+0x110>
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e1:	a1 54 0e 00 00       	mov    0xe54,%eax
{
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	57                   	push   %edi
 7e9:	56                   	push   %esi
 7ea:	53                   	push   %ebx
 7eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7f8:	89 c2                	mov    %eax,%edx
 7fa:	8b 00                	mov    (%eax),%eax
 7fc:	39 ca                	cmp    %ecx,%edx
 7fe:	73 30                	jae    830 <free+0x50>
 800:	39 c1                	cmp    %eax,%ecx
 802:	72 04                	jb     808 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	39 c2                	cmp    %eax,%edx
 806:	72 f0                	jb     7f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 808:	8b 73 fc             	mov    -0x4(%ebx),%esi
 80b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 80e:	39 f8                	cmp    %edi,%eax
 810:	74 30                	je     842 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 812:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 815:	8b 42 04             	mov    0x4(%edx),%eax
 818:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 81b:	39 f1                	cmp    %esi,%ecx
 81d:	74 3a                	je     859 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 81f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 821:	5b                   	pop    %ebx
  freep = p;
 822:	89 15 54 0e 00 00    	mov    %edx,0xe54
}
 828:	5e                   	pop    %esi
 829:	5f                   	pop    %edi
 82a:	5d                   	pop    %ebp
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 830:	39 c2                	cmp    %eax,%edx
 832:	72 c4                	jb     7f8 <free+0x18>
 834:	39 c1                	cmp    %eax,%ecx
 836:	73 c0                	jae    7f8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 838:	8b 73 fc             	mov    -0x4(%ebx),%esi
 83b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 83e:	39 f8                	cmp    %edi,%eax
 840:	75 d0                	jne    812 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 842:	03 70 04             	add    0x4(%eax),%esi
 845:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 848:	8b 02                	mov    (%edx),%eax
 84a:	8b 00                	mov    (%eax),%eax
 84c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 84f:	8b 42 04             	mov    0x4(%edx),%eax
 852:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 855:	39 f1                	cmp    %esi,%ecx
 857:	75 c6                	jne    81f <free+0x3f>
    p->s.size += bp->s.size;
 859:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 85c:	89 15 54 0e 00 00    	mov    %edx,0xe54
    p->s.size += bp->s.size;
 862:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 865:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 868:	89 0a                	mov    %ecx,(%edx)
}
 86a:	5b                   	pop    %ebx
 86b:	5e                   	pop    %esi
 86c:	5f                   	pop    %edi
 86d:	5d                   	pop    %ebp
 86e:	c3                   	ret    
 86f:	90                   	nop

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 87c:	8b 3d 54 0e 00 00    	mov    0xe54,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 882:	8d 70 07             	lea    0x7(%eax),%esi
 885:	c1 ee 03             	shr    $0x3,%esi
 888:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 88b:	85 ff                	test   %edi,%edi
 88d:	0f 84 9d 00 00 00    	je     930 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 893:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 895:	8b 4a 04             	mov    0x4(%edx),%ecx
 898:	39 f1                	cmp    %esi,%ecx
 89a:	73 6a                	jae    906 <malloc+0x96>
 89c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8a1:	39 de                	cmp    %ebx,%esi
 8a3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 8a6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 8ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8b0:	eb 17                	jmp    8c9 <malloc+0x59>
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ba:	8b 48 04             	mov    0x4(%eax),%ecx
 8bd:	39 f1                	cmp    %esi,%ecx
 8bf:	73 4f                	jae    910 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c1:	8b 3d 54 0e 00 00    	mov    0xe54,%edi
 8c7:	89 c2                	mov    %eax,%edx
 8c9:	39 d7                	cmp    %edx,%edi
 8cb:	75 eb                	jne    8b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 8cd:	83 ec 0c             	sub    $0xc,%esp
 8d0:	ff 75 e4             	push   -0x1c(%ebp)
 8d3:	e8 83 fc ff ff       	call   55b <sbrk>
  if(p == (char*)-1)
 8d8:	83 c4 10             	add    $0x10,%esp
 8db:	83 f8 ff             	cmp    $0xffffffff,%eax
 8de:	74 1c                	je     8fc <malloc+0x8c>
  hp->s.size = nu;
 8e0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8e3:	83 ec 0c             	sub    $0xc,%esp
 8e6:	83 c0 08             	add    $0x8,%eax
 8e9:	50                   	push   %eax
 8ea:	e8 f1 fe ff ff       	call   7e0 <free>
  return freep;
 8ef:	8b 15 54 0e 00 00    	mov    0xe54,%edx
      if((p = morecore(nunits)) == 0)
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	85 d2                	test   %edx,%edx
 8fa:	75 bc                	jne    8b8 <malloc+0x48>
        return 0;
  }
}
 8fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8ff:	31 c0                	xor    %eax,%eax
}
 901:	5b                   	pop    %ebx
 902:	5e                   	pop    %esi
 903:	5f                   	pop    %edi
 904:	5d                   	pop    %ebp
 905:	c3                   	ret    
    if(p->s.size >= nunits){
 906:	89 d0                	mov    %edx,%eax
 908:	89 fa                	mov    %edi,%edx
 90a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 910:	39 ce                	cmp    %ecx,%esi
 912:	74 4c                	je     960 <malloc+0xf0>
        p->s.size -= nunits;
 914:	29 f1                	sub    %esi,%ecx
 916:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 919:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 91c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 91f:	89 15 54 0e 00 00    	mov    %edx,0xe54
}
 925:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 928:	83 c0 08             	add    $0x8,%eax
}
 92b:	5b                   	pop    %ebx
 92c:	5e                   	pop    %esi
 92d:	5f                   	pop    %edi
 92e:	5d                   	pop    %ebp
 92f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 930:	c7 05 54 0e 00 00 58 	movl   $0xe58,0xe54
 937:	0e 00 00 
    base.s.size = 0;
 93a:	bf 58 0e 00 00       	mov    $0xe58,%edi
    base.s.ptr = freep = prevp = &base;
 93f:	c7 05 58 0e 00 00 58 	movl   $0xe58,0xe58
 946:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 949:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 94b:	c7 05 5c 0e 00 00 00 	movl   $0x0,0xe5c
 952:	00 00 00 
    if(p->s.size >= nunits){
 955:	e9 42 ff ff ff       	jmp    89c <malloc+0x2c>
 95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 960:	8b 08                	mov    (%eax),%ecx
 962:	89 0a                	mov    %ecx,(%edx)
 964:	eb b9                	jmp    91f <malloc+0xaf>
