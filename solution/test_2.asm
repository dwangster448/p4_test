
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
  1d:	e8 6e 02 00 00       	call   290 <find_my_stats_index>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  22:	83 f8 ff             	cmp    $0xffffffff,%eax
  25:	0f 84 86 01 00 00    	je     1b1 <main+0x1b1>

    int old_rtime = ps.rtime[my_idx];
  2b:	8b b4 85 e8 f7 ff ff 	mov    -0x818(%ebp,%eax,4),%esi
    int old_pass = ps.pass[my_idx];
  32:	8b 9c 85 e8 f4 ff ff 	mov    -0xb18(%ebp,%eax,4),%ebx
    int old_stride = ps.stride[my_idx];
  39:	8b bc 85 e8 f6 ff ff 	mov    -0x918(%ebp,%eax,4),%edi
    
    printf(1, "old_rtime: %d\n", old_rtime);
  40:	50                   	push   %eax
  41:	56                   	push   %esi
  42:	68 4b 0a 00 00       	push   $0xa4b
  47:	6a 01                	push   $0x1
    int old_rtime = ps.rtime[my_idx];
  49:	89 b5 dc f1 ff ff    	mov    %esi,-0xe24(%ebp)
    printf(1, "old_stride: %d\n", old_stride);

    int extra = 4;

    printf(1, "Target rttime: %d\n", old_stride + extra);
    run_until(old_rtime + extra);  //This is imporant: test_helper function will continue until (old_rtime + extra) is reached
  4f:	83 c6 04             	add    $0x4,%esi
    int old_pass = ps.pass[my_idx];
  52:	89 9d e4 f1 ff ff    	mov    %ebx,-0xe1c(%ebp)
    int old_stride = ps.stride[my_idx];
  58:	89 bd e0 f1 ff ff    	mov    %edi,-0xe20(%ebp)
    printf(1, "old_rtime: %d\n", old_rtime);
  5e:	e8 8d 06 00 00       	call   6f0 <printf>
    printf(1, "old_pass: %d\n", old_pass);
  63:	83 c4 0c             	add    $0xc,%esp
  66:	53                   	push   %ebx
  67:	68 5a 0a 00 00       	push   $0xa5a
  6c:	6a 01                	push   $0x1
  6e:	e8 7d 06 00 00       	call   6f0 <printf>
    printf(1, "old_stride: %d\n", old_stride);
  73:	83 c4 0c             	add    $0xc,%esp
  76:	57                   	push   %edi
  77:	68 68 0a 00 00       	push   $0xa68
  7c:	6a 01                	push   $0x1
  7e:	e8 6d 06 00 00       	call   6f0 <printf>
    printf(1, "Target rttime: %d\n", old_stride + extra);
  83:	83 c4 0c             	add    $0xc,%esp
  86:	8d 47 04             	lea    0x4(%edi),%eax
  89:	50                   	push   %eax
  8a:	68 78 0a 00 00       	push   $0xa78
  8f:	6a 01                	push   $0x1
  91:	e8 5a 06 00 00       	call   6f0 <printf>
    run_until(old_rtime + extra);  //This is imporant: test_helper function will continue until (old_rtime + extra) is reached
  96:	83 c4 10             	add    $0x10,%esp
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 * Might immediately return if the rtime is already reached
 */
static __attribute__((unused)) void run_until(int target_rtime) {
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);
  a0:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
  a6:	e8 e5 01 00 00       	call   290 <find_my_stats_index>

        PRINTF("ps[%d] rttime: %d\n",my_idx, ps.rtime[my_idx]); 
  ab:	83 ec 04             	sub    $0x4,%esp
  ae:	68 18 0a 00 00       	push   $0xa18
        int my_idx = find_my_stats_index(&ps);
  b3:	89 c3                	mov    %eax,%ebx
        PRINTF("ps[%d] rttime: %d\n",my_idx, ps.rtime[my_idx]); 
  b5:	68 22 0a 00 00       	push   $0xa22
  ba:	8d bb 80 01 00 00    	lea    0x180(%ebx),%edi
  c0:	6a 01                	push   $0x1
  c2:	e8 29 06 00 00       	call   6f0 <printf>
  c7:	ff b4 bd e8 f8 ff ff 	push   -0x718(%ebp,%edi,4)
  ce:	53                   	push   %ebx
  cf:	68 8b 0a 00 00       	push   $0xa8b
  d4:	6a 01                	push   $0x1
  d6:	e8 15 06 00 00       	call   6f0 <printf>
  db:	83 c4 18             	add    $0x18,%esp
  de:	68 76 0a 00 00       	push   $0xa76
  e3:	6a 01                	push   $0x1
  e5:	e8 06 06 00 00       	call   6f0 <printf>

        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  ea:	83 c4 10             	add    $0x10,%esp
  ed:	83 fb ff             	cmp    $0xffffffff,%ebx
  f0:	0f 84 7e 01 00 00    	je     274 <main+0x274>

        if (ps.rtime[my_idx] >= target_rtime)
  f6:	3b b4 bd e8 f8 ff ff 	cmp    -0x718(%ebp,%edi,4),%esi
  fd:	7f a1                	jg     a0 <main+0xa0>

    my_idx = find_my_stats_index(&ps);
  ff:	8d 85 e8 f1 ff ff    	lea    -0xe18(%ebp),%eax
 105:	e8 86 01 00 00       	call   290 <find_my_stats_index>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 10a:	83 f8 ff             	cmp    $0xffffffff,%eax
 10d:	0f 84 2e 01 00 00    	je     241 <main+0x241>

    int now_rtime = ps.rtime[my_idx];
 113:	8b 94 85 e8 f7 ff ff 	mov    -0x818(%ebp,%eax,4),%edx
    int now_pass = ps.pass[my_idx];
 11a:	8b 9c 85 e8 f4 ff ff 	mov    -0xb18(%ebp,%eax,4),%ebx
    int now_stride = ps.stride[my_idx];
 121:	8b b4 85 e8 f6 ff ff 	mov    -0x918(%ebp,%eax,4),%esi

    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 128:	39 9d e4 f1 ff ff    	cmp    %ebx,-0xe1c(%ebp)
 12e:	0f 8d ba 00 00 00    	jge    1ee <main+0x1ee>
new_pass is %d", old_pass, now_pass);
    
    ASSERT(old_stride == now_stride, "Stride changed from %d to %d without \
 134:	8b bd e0 f1 ff ff    	mov    -0xe20(%ebp),%edi
 13a:	39 f7                	cmp    %esi,%edi
 13c:	0f 85 d8 00 00 00    	jne    21a <main+0x21a>
calling settickets", old_stride, now_stride);

    int diff_rtime = now_rtime - old_rtime;
    int diff_pass = now_pass - old_pass;
    int exp_pass = diff_rtime * now_stride;
 142:	8b bd e0 f1 ff ff    	mov    -0xe20(%ebp),%edi
    int diff_rtime = now_rtime - old_rtime;
 148:	2b 95 dc f1 ff ff    	sub    -0xe24(%ebp),%edx
    int diff_pass = now_pass - old_pass;
 14e:	2b 9d e4 f1 ff ff    	sub    -0xe1c(%ebp),%ebx
    int diff_rtime = now_rtime - old_rtime;
 154:	89 d6                	mov    %edx,%esi
    int exp_pass = diff_rtime * now_stride;
 156:	89 f8                	mov    %edi,%eax
 158:	0f af c2             	imul   %edx,%eax

    ASSERT(diff_pass == exp_pass, "Pass is not incremented correctly by stride. \
 15b:	39 c3                	cmp    %eax,%ebx
 15d:	89 85 e4 f1 ff ff    	mov    %eax,-0xe1c(%ebp)
 163:	0f 84 e7 00 00 00    	je     250 <main+0x250>
 169:	83 ec 0c             	sub    $0xc,%esp
 16c:	6a 2c                	push   $0x2c
 16e:	68 38 0a 00 00       	push   $0xa38
 173:	68 18 0a 00 00       	push   $0xa18
 178:	68 41 0a 00 00       	push   $0xa41
 17d:	6a 01                	push   $0x1
 17f:	e8 6c 05 00 00       	call   6f0 <printf>
 184:	8b 85 e4 f1 ff ff    	mov    -0xe1c(%ebp),%eax
 18a:	83 c4 18             	add    $0x18,%esp
 18d:	53                   	push   %ebx
 18e:	50                   	push   %eax
 18f:	57                   	push   %edi
 190:	56                   	push   %esi
 191:	68 58 0b 00 00       	push   $0xb58
 196:	6a 01                	push   $0x1
 198:	e8 53 05 00 00       	call   6f0 <printf>
 19d:	83 c4 18             	add    $0x18,%esp
 1a0:	68 76 0a 00 00       	push   $0xa76
 1a5:	6a 01                	push   $0x1
 1a7:	e8 44 05 00 00       	call   6f0 <printf>
 1ac:	e8 d2 03 00 00       	call   583 <exit>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 1b1:	83 ec 0c             	sub    $0xc,%esp
 1b4:	6a 0c                	push   $0xc
 1b6:	68 38 0a 00 00       	push   $0xa38
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 1bb:	68 18 0a 00 00       	push   $0xa18
 1c0:	68 41 0a 00 00       	push   $0xa41
 1c5:	6a 01                	push   $0x1
 1c7:	e8 24 05 00 00       	call   6f0 <printf>
 1cc:	83 c4 18             	add    $0x18,%esp
 1cf:	68 bc 0a 00 00       	push   $0xabc
 1d4:	6a 01                	push   $0x1
 1d6:	e8 15 05 00 00       	call   6f0 <printf>
 1db:	5a                   	pop    %edx
 1dc:	59                   	pop    %ecx
 1dd:	68 76 0a 00 00       	push   $0xa76
 1e2:	6a 01                	push   $0x1
 1e4:	e8 07 05 00 00       	call   6f0 <printf>
 1e9:	e8 95 03 00 00       	call   583 <exit>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 1ee:	83 ec 0c             	sub    $0xc,%esp
 1f1:	6a 22                	push   $0x22
 1f3:	68 38 0a 00 00       	push   $0xa38
 1f8:	68 18 0a 00 00       	push   $0xa18
 1fd:	68 41 0a 00 00       	push   $0xa41
 202:	6a 01                	push   $0x1
 204:	e8 e7 04 00 00       	call   6f0 <printf>
 209:	83 c4 20             	add    $0x20,%esp
 20c:	53                   	push   %ebx
 20d:	ff b5 e4 f1 ff ff    	push   -0xe1c(%ebp)
 213:	68 e8 0a 00 00       	push   $0xae8
 218:	eb ba                	jmp    1d4 <main+0x1d4>
    ASSERT(old_stride == now_stride, "Stride changed from %d to %d without \
 21a:	83 ec 0c             	sub    $0xc,%esp
 21d:	6a 25                	push   $0x25
 21f:	68 38 0a 00 00       	push   $0xa38
 224:	68 18 0a 00 00       	push   $0xa18
 229:	68 41 0a 00 00       	push   $0xa41
 22e:	6a 01                	push   $0x1
 230:	e8 bb 04 00 00       	call   6f0 <printf>
 235:	83 c4 20             	add    $0x20,%esp
 238:	56                   	push   %esi
 239:	57                   	push   %edi
 23a:	68 20 0b 00 00       	push   $0xb20
 23f:	eb 93                	jmp    1d4 <main+0x1d4>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 241:	83 ec 0c             	sub    $0xc,%esp
 244:	6a 1c                	push   $0x1c
 246:	68 38 0a 00 00       	push   $0xa38
 24b:	e9 6b ff ff ff       	jmp    1bb <main+0x1bb>
    PRINTF("%s", SUCCESS_MSG);
 250:	50                   	push   %eax
 251:	68 18 0a 00 00       	push   $0xa18
 256:	68 22 0a 00 00       	push   $0xa22
 25b:	6a 01                	push   $0x1
 25d:	e8 8e 04 00 00       	call   6f0 <printf>
 262:	83 c4 0c             	add    $0xc,%esp
 265:	68 ac 0a 00 00       	push   $0xaac
 26a:	68 b8 0a 00 00       	push   $0xab8
 26f:	e9 60 ff ff ff       	jmp    1d4 <main+0x1d4>
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 274:	83 ec 0c             	sub    $0xc,%esp
 277:	6a 4e                	push   $0x4e
 279:	68 9e 0a 00 00       	push   $0xa9e
 27e:	e9 38 ff ff ff       	jmp    1bb <main+0x1bb>
 283:	66 90                	xchg   %ax,%ax
 285:	66 90                	xchg   %ax,%ax
 287:	66 90                	xchg   %ax,%ax
 289:	66 90                	xchg   %ax,%ax
 28b:	66 90                	xchg   %ax,%ax
 28d:	66 90                	xchg   %ax,%ax
 28f:	90                   	nop

00000290 <find_my_stats_index>:
static int find_my_stats_index(struct pstat *s) {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	89 c3                	mov    %eax,%ebx
 297:	83 ec 10             	sub    $0x10,%esp
    int mypid = getpid();
 29a:	e8 64 03 00 00       	call   603 <getpid>
    if (getpinfo(s) == -1) {
 29f:	83 ec 0c             	sub    $0xc,%esp
 2a2:	53                   	push   %ebx
    int mypid = getpid();
 2a3:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 2a5:	e8 81 03 00 00       	call   62b <getpinfo>
 2aa:	83 c4 10             	add    $0x10,%esp
 2ad:	83 f8 ff             	cmp    $0xffffffff,%eax
 2b0:	74 3a                	je     2ec <find_my_stats_index+0x5c>
    for (int i = 0; i < NPROC; i++)
 2b2:	31 c0                	xor    %eax,%eax
 2b4:	eb 12                	jmp    2c8 <find_my_stats_index+0x38>
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
 2c0:	83 c0 01             	add    $0x1,%eax
 2c3:	83 f8 40             	cmp    $0x40,%eax
 2c6:	74 18                	je     2e0 <find_my_stats_index+0x50>
        if (s->pid[i] == mypid)
 2c8:	39 b4 83 00 02 00 00 	cmp    %esi,0x200(%ebx,%eax,4)
 2cf:	75 ef                	jne    2c0 <find_my_stats_index+0x30>
}
 2d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d4:	5b                   	pop    %ebx
 2d5:	5e                   	pop    %esi
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2df:	90                   	nop
 2e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
 2e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 2e8:	5b                   	pop    %ebx
 2e9:	5e                   	pop    %esi
 2ea:	5d                   	pop    %ebp
 2eb:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 2ec:	83 ec 04             	sub    $0x4,%esp
 2ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
 2f2:	68 18 0a 00 00       	push   $0xa18
 2f7:	68 22 0a 00 00       	push   $0xa22
 2fc:	6a 01                	push   $0x1
 2fe:	e8 ed 03 00 00       	call   6f0 <printf>
 303:	58                   	pop    %eax
 304:	5a                   	pop    %edx
 305:	68 27 0a 00 00       	push   $0xa27
 30a:	6a 01                	push   $0x1
 30c:	e8 df 03 00 00       	call   6f0 <printf>
 311:	59                   	pop    %ecx
 312:	5b                   	pop    %ebx
 313:	68 76 0a 00 00       	push   $0xa76
 318:	6a 01                	push   $0x1
 31a:	e8 d1 03 00 00       	call   6f0 <printf>
        return -1;
 31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
        PRINTF("getpinfo failed\n"); 
 322:	83 c4 10             	add    $0x10,%esp
 325:	eb aa                	jmp    2d1 <find_my_stats_index+0x41>
 327:	66 90                	xchg   %ax,%ax
 329:	66 90                	xchg   %ax,%ax
 32b:	66 90                	xchg   %ax,%ax
 32d:	66 90                	xchg   %ax,%ax
 32f:	90                   	nop

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 331:	31 c0                	xor    %eax,%eax
{
 333:	89 e5                	mov    %esp,%ebp
 335:	53                   	push   %ebx
 336:	8b 4d 08             	mov    0x8(%ebp),%ecx
 339:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 340:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 344:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 347:	83 c0 01             	add    $0x1,%eax
 34a:	84 d2                	test   %dl,%dl
 34c:	75 f2                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 351:	89 c8                	mov    %ecx,%eax
 353:	c9                   	leave  
 354:	c3                   	ret    
 355:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	84 c0                	test   %al,%al
 36f:	75 17                	jne    388 <strcmp+0x28>
 371:	eb 3a                	jmp    3ad <strcmp+0x4d>
 373:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 377:	90                   	nop
 378:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 37c:	83 c2 01             	add    $0x1,%edx
 37f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 382:	84 c0                	test   %al,%al
 384:	74 1a                	je     3a0 <strcmp+0x40>
    p++, q++;
 386:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 388:	0f b6 19             	movzbl (%ecx),%ebx
 38b:	38 c3                	cmp    %al,%bl
 38d:	74 e9                	je     378 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 38f:	29 d8                	sub    %ebx,%eax
}
 391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 394:	c9                   	leave  
 395:	c3                   	ret    
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 3a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3a4:	31 c0                	xor    %eax,%eax
 3a6:	29 d8                	sub    %ebx,%eax
}
 3a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ab:	c9                   	leave  
 3ac:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 3ad:	0f b6 19             	movzbl (%ecx),%ebx
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	eb db                	jmp    38f <strcmp+0x2f>
 3b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3bf:	90                   	nop

000003c0 <strlen>:

uint
strlen(const char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3c6:	80 3a 00             	cmpb   $0x0,(%edx)
 3c9:	74 15                	je     3e0 <strlen+0x20>
 3cb:	31 c0                	xor    %eax,%eax
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	83 c0 01             	add    $0x1,%eax
 3d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3d7:	89 c1                	mov    %eax,%ecx
 3d9:	75 f5                	jne    3d0 <strlen+0x10>
    ;
  return n;
}
 3db:	89 c8                	mov    %ecx,%eax
 3dd:	5d                   	pop    %ebp
 3de:	c3                   	ret    
 3df:	90                   	nop
  for(n = 0; s[n]; n++)
 3e0:	31 c9                	xor    %ecx,%ecx
}
 3e2:	5d                   	pop    %ebp
 3e3:	89 c8                	mov    %ecx,%eax
 3e5:	c3                   	ret    
 3e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 d7                	mov    %edx,%edi
 3ff:	fc                   	cld    
 400:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 402:	8b 7d fc             	mov    -0x4(%ebp),%edi
 405:	89 d0                	mov    %edx,%eax
 407:	c9                   	leave  
 408:	c3                   	ret    
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <strchr>:

char*
strchr(const char *s, char c)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 41a:	0f b6 10             	movzbl (%eax),%edx
 41d:	84 d2                	test   %dl,%dl
 41f:	75 12                	jne    433 <strchr+0x23>
 421:	eb 1d                	jmp    440 <strchr+0x30>
 423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 427:	90                   	nop
 428:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 42c:	83 c0 01             	add    $0x1,%eax
 42f:	84 d2                	test   %dl,%dl
 431:	74 0d                	je     440 <strchr+0x30>
    if(*s == c)
 433:	38 d1                	cmp    %dl,%cl
 435:	75 f1                	jne    428 <strchr+0x18>
      return (char*)s;
  return 0;
}
 437:	5d                   	pop    %ebp
 438:	c3                   	ret    
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 440:	31 c0                	xor    %eax,%eax
}
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <gets>:

char*
gets(char *buf, int max)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 455:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 458:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 459:	31 db                	xor    %ebx,%ebx
{
 45b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 45e:	eb 27                	jmp    487 <gets+0x37>
    cc = read(0, &c, 1);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	6a 01                	push   $0x1
 465:	57                   	push   %edi
 466:	6a 00                	push   $0x0
 468:	e8 2e 01 00 00       	call   59b <read>
    if(cc < 1)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	85 c0                	test   %eax,%eax
 472:	7e 1d                	jle    491 <gets+0x41>
      break;
    buf[i++] = c;
 474:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 478:	8b 55 08             	mov    0x8(%ebp),%edx
 47b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 47f:	3c 0a                	cmp    $0xa,%al
 481:	74 1d                	je     4a0 <gets+0x50>
 483:	3c 0d                	cmp    $0xd,%al
 485:	74 19                	je     4a0 <gets+0x50>
  for(i=0; i+1 < max; ){
 487:	89 de                	mov    %ebx,%esi
 489:	83 c3 01             	add    $0x1,%ebx
 48c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 48f:	7c cf                	jl     460 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 498:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49b:	5b                   	pop    %ebx
 49c:	5e                   	pop    %esi
 49d:	5f                   	pop    %edi
 49e:	5d                   	pop    %ebp
 49f:	c3                   	ret    
  buf[i] = '\0';
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	89 de                	mov    %ebx,%esi
 4a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 4a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ac:	5b                   	pop    %ebx
 4ad:	5e                   	pop    %esi
 4ae:	5f                   	pop    %edi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret    
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop

000004c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	push   0x8(%ebp)
 4cd:	e8 f1 00 00 00       	call   5c3 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	push   0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f4 00 00 00       	call   5db <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 ba 00 00 00       	call   5ab <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50e:	66 90                	xchg   %ax,%ax

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 02             	movsbl (%edx),%eax
 51a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 51d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 520:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 525:	77 1e                	ja     545 <atoi+0x35>
 527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 530:	83 c2 01             	add    $0x1,%edx
 533:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 536:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 53a:	0f be 02             	movsbl (%edx),%eax
 53d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 548:	89 c8                	mov    %ecx,%eax
 54a:	c9                   	leave  
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	8b 45 10             	mov    0x10(%ebp),%eax
 557:	8b 55 08             	mov    0x8(%ebp),%edx
 55a:	56                   	push   %esi
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 c0                	test   %eax,%eax
 560:	7e 13                	jle    575 <memmove+0x25>
 562:	01 d0                	add    %edx,%eax
  dst = vdst;
 564:	89 d7                	mov    %edx,%edi
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 570:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 571:	39 f8                	cmp    %edi,%eax
 573:	75 fb                	jne    570 <memmove+0x20>
  return vdst;
}
 575:	5e                   	pop    %esi
 576:	89 d0                	mov    %edx,%eax
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    

0000057b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57b:	b8 01 00 00 00       	mov    $0x1,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <exit>:
SYSCALL(exit)
 583:	b8 02 00 00 00       	mov    $0x2,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <wait>:
SYSCALL(wait)
 58b:	b8 03 00 00 00       	mov    $0x3,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <pipe>:
SYSCALL(pipe)
 593:	b8 04 00 00 00       	mov    $0x4,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <read>:
SYSCALL(read)
 59b:	b8 05 00 00 00       	mov    $0x5,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <write>:
SYSCALL(write)
 5a3:	b8 10 00 00 00       	mov    $0x10,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <close>:
SYSCALL(close)
 5ab:	b8 15 00 00 00       	mov    $0x15,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <kill>:
SYSCALL(kill)
 5b3:	b8 06 00 00 00       	mov    $0x6,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <exec>:
SYSCALL(exec)
 5bb:	b8 07 00 00 00       	mov    $0x7,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <open>:
SYSCALL(open)
 5c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <mknod>:
SYSCALL(mknod)
 5cb:	b8 11 00 00 00       	mov    $0x11,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <unlink>:
SYSCALL(unlink)
 5d3:	b8 12 00 00 00       	mov    $0x12,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <fstat>:
SYSCALL(fstat)
 5db:	b8 08 00 00 00       	mov    $0x8,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <link>:
SYSCALL(link)
 5e3:	b8 13 00 00 00       	mov    $0x13,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <mkdir>:
SYSCALL(mkdir)
 5eb:	b8 14 00 00 00       	mov    $0x14,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <chdir>:
SYSCALL(chdir)
 5f3:	b8 09 00 00 00       	mov    $0x9,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <dup>:
SYSCALL(dup)
 5fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <getpid>:
SYSCALL(getpid)
 603:	b8 0b 00 00 00       	mov    $0xb,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <sbrk>:
SYSCALL(sbrk)
 60b:	b8 0c 00 00 00       	mov    $0xc,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <sleep>:
SYSCALL(sleep)
 613:	b8 0d 00 00 00       	mov    $0xd,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <uptime>:
SYSCALL(uptime)
 61b:	b8 0e 00 00 00       	mov    $0xe,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <settickets>:
SYSCALL(settickets)
 623:	b8 16 00 00 00       	mov    $0x16,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <getpinfo>:
SYSCALL(getpinfo)
 62b:	b8 17 00 00 00       	mov    $0x17,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    
 633:	66 90                	xchg   %ax,%ax
 635:	66 90                	xchg   %ax,%ax
 637:	66 90                	xchg   %ax,%ax
 639:	66 90                	xchg   %ax,%ax
 63b:	66 90                	xchg   %ax,%ax
 63d:	66 90                	xchg   %ax,%ax
 63f:	90                   	nop

00000640 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
 646:	83 ec 3c             	sub    $0x3c,%esp
 649:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 64c:	89 d1                	mov    %edx,%ecx
{
 64e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 651:	85 d2                	test   %edx,%edx
 653:	0f 89 7f 00 00 00    	jns    6d8 <printint+0x98>
 659:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 65d:	74 79                	je     6d8 <printint+0x98>
    neg = 1;
 65f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 666:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 668:	31 db                	xor    %ebx,%ebx
 66a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 66d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 670:	89 c8                	mov    %ecx,%eax
 672:	31 d2                	xor    %edx,%edx
 674:	89 cf                	mov    %ecx,%edi
 676:	f7 75 c4             	divl   -0x3c(%ebp)
 679:	0f b6 92 7c 0c 00 00 	movzbl 0xc7c(%edx),%edx
 680:	89 45 c0             	mov    %eax,-0x40(%ebp)
 683:	89 d8                	mov    %ebx,%eax
 685:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 688:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 68b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 68e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 691:	76 dd                	jbe    670 <printint+0x30>
  if(neg)
 693:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 696:	85 c9                	test   %ecx,%ecx
 698:	74 0c                	je     6a6 <printint+0x66>
    buf[i++] = '-';
 69a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 69f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 6a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 6a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 6a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 6ad:	eb 07                	jmp    6b6 <printint+0x76>
 6af:	90                   	nop
    putc(fd, buf[i]);
 6b0:	0f b6 13             	movzbl (%ebx),%edx
 6b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 6b6:	83 ec 04             	sub    $0x4,%esp
 6b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 6bc:	6a 01                	push   $0x1
 6be:	56                   	push   %esi
 6bf:	57                   	push   %edi
 6c0:	e8 de fe ff ff       	call   5a3 <write>
  while(--i >= 0)
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	39 de                	cmp    %ebx,%esi
 6ca:	75 e4                	jne    6b0 <printint+0x70>
}
 6cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6cf:	5b                   	pop    %ebx
 6d0:	5e                   	pop    %esi
 6d1:	5f                   	pop    %edi
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret    
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 6df:	eb 87                	jmp    668 <printint+0x28>
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop

000006f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 6fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6ff:	0f b6 13             	movzbl (%ebx),%edx
 702:	84 d2                	test   %dl,%dl
 704:	74 6a                	je     770 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 706:	8d 45 10             	lea    0x10(%ebp),%eax
 709:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 70c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 70f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 711:	89 45 d0             	mov    %eax,-0x30(%ebp)
 714:	eb 36                	jmp    74c <printf+0x5c>
 716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71d:	8d 76 00             	lea    0x0(%esi),%esi
 720:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 723:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 728:	83 f8 25             	cmp    $0x25,%eax
 72b:	74 15                	je     742 <printf+0x52>
  write(fd, &c, 1);
 72d:	83 ec 04             	sub    $0x4,%esp
 730:	88 55 e7             	mov    %dl,-0x19(%ebp)
 733:	6a 01                	push   $0x1
 735:	57                   	push   %edi
 736:	56                   	push   %esi
 737:	e8 67 fe ff ff       	call   5a3 <write>
 73c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 73f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 742:	0f b6 13             	movzbl (%ebx),%edx
 745:	83 c3 01             	add    $0x1,%ebx
 748:	84 d2                	test   %dl,%dl
 74a:	74 24                	je     770 <printf+0x80>
    c = fmt[i] & 0xff;
 74c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 74f:	85 c9                	test   %ecx,%ecx
 751:	74 cd                	je     720 <printf+0x30>
      }
    } else if(state == '%'){
 753:	83 f9 25             	cmp    $0x25,%ecx
 756:	75 ea                	jne    742 <printf+0x52>
      if(c == 'd'){
 758:	83 f8 25             	cmp    $0x25,%eax
 75b:	0f 84 07 01 00 00    	je     868 <printf+0x178>
 761:	83 e8 63             	sub    $0x63,%eax
 764:	83 f8 15             	cmp    $0x15,%eax
 767:	77 17                	ja     780 <printf+0x90>
 769:	ff 24 85 24 0c 00 00 	jmp    *0xc24(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 770:	8d 65 f4             	lea    -0xc(%ebp),%esp
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
 778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop
  write(fd, &c, 1);
 780:	83 ec 04             	sub    $0x4,%esp
 783:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 786:	6a 01                	push   $0x1
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 78e:	e8 10 fe ff ff       	call   5a3 <write>
        putc(fd, c);
 793:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 797:	83 c4 0c             	add    $0xc,%esp
 79a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 79d:	6a 01                	push   $0x1
 79f:	57                   	push   %edi
 7a0:	56                   	push   %esi
 7a1:	e8 fd fd ff ff       	call   5a3 <write>
        putc(fd, c);
 7a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7a9:	31 c9                	xor    %ecx,%ecx
 7ab:	eb 95                	jmp    742 <printf+0x52>
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7b0:	83 ec 0c             	sub    $0xc,%esp
 7b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7b8:	6a 00                	push   $0x0
 7ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7bd:	8b 10                	mov    (%eax),%edx
 7bf:	89 f0                	mov    %esi,%eax
 7c1:	e8 7a fe ff ff       	call   640 <printint>
        ap++;
 7c6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 7ca:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7cd:	31 c9                	xor    %ecx,%ecx
 7cf:	e9 6e ff ff ff       	jmp    742 <printf+0x52>
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7db:	8b 10                	mov    (%eax),%edx
        ap++;
 7dd:	83 c0 04             	add    $0x4,%eax
 7e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7e3:	85 d2                	test   %edx,%edx
 7e5:	0f 84 8d 00 00 00    	je     878 <printf+0x188>
        while(*s != 0){
 7eb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 7ee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 7f0:	84 c0                	test   %al,%al
 7f2:	0f 84 4a ff ff ff    	je     742 <printf+0x52>
 7f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7fb:	89 d3                	mov    %edx,%ebx
 7fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
          s++;
 803:	83 c3 01             	add    $0x1,%ebx
 806:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 809:	6a 01                	push   $0x1
 80b:	57                   	push   %edi
 80c:	56                   	push   %esi
 80d:	e8 91 fd ff ff       	call   5a3 <write>
        while(*s != 0){
 812:	0f b6 03             	movzbl (%ebx),%eax
 815:	83 c4 10             	add    $0x10,%esp
 818:	84 c0                	test   %al,%al
 81a:	75 e4                	jne    800 <printf+0x110>
      state = 0;
 81c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 81f:	31 c9                	xor    %ecx,%ecx
 821:	e9 1c ff ff ff       	jmp    742 <printf+0x52>
 826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 830:	83 ec 0c             	sub    $0xc,%esp
 833:	b9 0a 00 00 00       	mov    $0xa,%ecx
 838:	6a 01                	push   $0x1
 83a:	e9 7b ff ff ff       	jmp    7ba <printf+0xca>
 83f:	90                   	nop
        putc(fd, *ap);
 840:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 843:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 846:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 848:	6a 01                	push   $0x1
 84a:	57                   	push   %edi
 84b:	56                   	push   %esi
        putc(fd, *ap);
 84c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 84f:	e8 4f fd ff ff       	call   5a3 <write>
        ap++;
 854:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 858:	83 c4 10             	add    $0x10,%esp
      state = 0;
 85b:	31 c9                	xor    %ecx,%ecx
 85d:	e9 e0 fe ff ff       	jmp    742 <printf+0x52>
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 868:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 86b:	83 ec 04             	sub    $0x4,%esp
 86e:	e9 2a ff ff ff       	jmp    79d <printf+0xad>
 873:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 877:	90                   	nop
          s = "(null)";
 878:	ba 1d 0c 00 00       	mov    $0xc1d,%edx
        while(*s != 0){
 87d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 880:	b8 28 00 00 00       	mov    $0x28,%eax
 885:	89 d3                	mov    %edx,%ebx
 887:	e9 74 ff ff ff       	jmp    800 <printf+0x110>
 88c:	66 90                	xchg   %ax,%ax
 88e:	66 90                	xchg   %ax,%ax

00000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	a1 68 0f 00 00       	mov    0xf68,%eax
{
 896:	89 e5                	mov    %esp,%ebp
 898:	57                   	push   %edi
 899:	56                   	push   %esi
 89a:	53                   	push   %ebx
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 89e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8a8:	89 c2                	mov    %eax,%edx
 8aa:	8b 00                	mov    (%eax),%eax
 8ac:	39 ca                	cmp    %ecx,%edx
 8ae:	73 30                	jae    8e0 <free+0x50>
 8b0:	39 c1                	cmp    %eax,%ecx
 8b2:	72 04                	jb     8b8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b4:	39 c2                	cmp    %eax,%edx
 8b6:	72 f0                	jb     8a8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8be:	39 f8                	cmp    %edi,%eax
 8c0:	74 30                	je     8f2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8c2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8c5:	8b 42 04             	mov    0x4(%edx),%eax
 8c8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8cb:	39 f1                	cmp    %esi,%ecx
 8cd:	74 3a                	je     909 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8cf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8d1:	5b                   	pop    %ebx
  freep = p;
 8d2:	89 15 68 0f 00 00    	mov    %edx,0xf68
}
 8d8:	5e                   	pop    %esi
 8d9:	5f                   	pop    %edi
 8da:	5d                   	pop    %ebp
 8db:	c3                   	ret    
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	39 c2                	cmp    %eax,%edx
 8e2:	72 c4                	jb     8a8 <free+0x18>
 8e4:	39 c1                	cmp    %eax,%ecx
 8e6:	73 c0                	jae    8a8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 8e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ee:	39 f8                	cmp    %edi,%eax
 8f0:	75 d0                	jne    8c2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 8f2:	03 70 04             	add    0x4(%eax),%esi
 8f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f8:	8b 02                	mov    (%edx),%eax
 8fa:	8b 00                	mov    (%eax),%eax
 8fc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ff:	8b 42 04             	mov    0x4(%edx),%eax
 902:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 905:	39 f1                	cmp    %esi,%ecx
 907:	75 c6                	jne    8cf <free+0x3f>
    p->s.size += bp->s.size;
 909:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 90c:	89 15 68 0f 00 00    	mov    %edx,0xf68
    p->s.size += bp->s.size;
 912:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 915:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 918:	89 0a                	mov    %ecx,(%edx)
}
 91a:	5b                   	pop    %ebx
 91b:	5e                   	pop    %esi
 91c:	5f                   	pop    %edi
 91d:	5d                   	pop    %ebp
 91e:	c3                   	ret    
 91f:	90                   	nop

00000920 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 929:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 92c:	8b 3d 68 0f 00 00    	mov    0xf68,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 932:	8d 70 07             	lea    0x7(%eax),%esi
 935:	c1 ee 03             	shr    $0x3,%esi
 938:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 93b:	85 ff                	test   %edi,%edi
 93d:	0f 84 9d 00 00 00    	je     9e0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 943:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 945:	8b 4a 04             	mov    0x4(%edx),%ecx
 948:	39 f1                	cmp    %esi,%ecx
 94a:	73 6a                	jae    9b6 <malloc+0x96>
 94c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 951:	39 de                	cmp    %ebx,%esi
 953:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 956:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 95d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 960:	eb 17                	jmp    979 <malloc+0x59>
 962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 96a:	8b 48 04             	mov    0x4(%eax),%ecx
 96d:	39 f1                	cmp    %esi,%ecx
 96f:	73 4f                	jae    9c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 971:	8b 3d 68 0f 00 00    	mov    0xf68,%edi
 977:	89 c2                	mov    %eax,%edx
 979:	39 d7                	cmp    %edx,%edi
 97b:	75 eb                	jne    968 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 97d:	83 ec 0c             	sub    $0xc,%esp
 980:	ff 75 e4             	push   -0x1c(%ebp)
 983:	e8 83 fc ff ff       	call   60b <sbrk>
  if(p == (char*)-1)
 988:	83 c4 10             	add    $0x10,%esp
 98b:	83 f8 ff             	cmp    $0xffffffff,%eax
 98e:	74 1c                	je     9ac <malloc+0x8c>
  hp->s.size = nu;
 990:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 993:	83 ec 0c             	sub    $0xc,%esp
 996:	83 c0 08             	add    $0x8,%eax
 999:	50                   	push   %eax
 99a:	e8 f1 fe ff ff       	call   890 <free>
  return freep;
 99f:	8b 15 68 0f 00 00    	mov    0xf68,%edx
      if((p = morecore(nunits)) == 0)
 9a5:	83 c4 10             	add    $0x10,%esp
 9a8:	85 d2                	test   %edx,%edx
 9aa:	75 bc                	jne    968 <malloc+0x48>
        return 0;
  }
}
 9ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9af:	31 c0                	xor    %eax,%eax
}
 9b1:	5b                   	pop    %ebx
 9b2:	5e                   	pop    %esi
 9b3:	5f                   	pop    %edi
 9b4:	5d                   	pop    %ebp
 9b5:	c3                   	ret    
    if(p->s.size >= nunits){
 9b6:	89 d0                	mov    %edx,%eax
 9b8:	89 fa                	mov    %edi,%edx
 9ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9c0:	39 ce                	cmp    %ecx,%esi
 9c2:	74 4c                	je     a10 <malloc+0xf0>
        p->s.size -= nunits;
 9c4:	29 f1                	sub    %esi,%ecx
 9c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9cc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 9cf:	89 15 68 0f 00 00    	mov    %edx,0xf68
}
 9d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9d8:	83 c0 08             	add    $0x8,%eax
}
 9db:	5b                   	pop    %ebx
 9dc:	5e                   	pop    %esi
 9dd:	5f                   	pop    %edi
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 9e0:	c7 05 68 0f 00 00 6c 	movl   $0xf6c,0xf68
 9e7:	0f 00 00 
    base.s.size = 0;
 9ea:	bf 6c 0f 00 00       	mov    $0xf6c,%edi
    base.s.ptr = freep = prevp = &base;
 9ef:	c7 05 6c 0f 00 00 6c 	movl   $0xf6c,0xf6c
 9f6:	0f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 9fb:	c7 05 70 0f 00 00 00 	movl   $0x0,0xf70
 a02:	00 00 00 
    if(p->s.size >= nunits){
 a05:	e9 42 ff ff ff       	jmp    94c <malloc+0x2c>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a10:	8b 08                	mov    (%eax),%ecx
 a12:	89 0a                	mov    %ecx,(%edx)
 a14:	eb b9                	jmp    9cf <malloc+0xaf>
