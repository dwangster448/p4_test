
_test_3:     file format elf32-i386


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
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 24 07 00 00    	sub    $0x724,%esp
    struct pstat ps;

    int pa_tickets = 4;
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  17:	6a 04                	push   $0x4
  19:	e8 05 08 00 00       	call   823 <settickets>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	83 f8 ff             	cmp    $0xffffffff,%eax
  24:	0f 84 9a 00 00 00    	je     c4 <main+0xc4>

    int pid = fork();
  2a:	e8 4c 07 00 00       	call   77b <fork>
  2f:	89 c3                	mov    %eax,%ebx

    // Child has double the tickets of the parent (default = 8)
    int ch_tickets = 8;

    if (pid == 0) {
  31:	85 c0                	test   %eax,%eax
  33:	0f 84 7c 00 00 00    	je     b5 <main+0xb5>
        int rt = 1000;
        run_until(rt);
        exit();
    }

    int my_idx = find_my_stats_index(&ps);
  39:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
  3f:	e8 ec 02 00 00       	call   330 <find_my_stats_index>
static __attribute__((unused)) int find_stats_index_for_pid(const struct pstat *s, int pid) {
    if (!s)
        return -1;

    // Find an entry matching my pid
    for (int i = 0; i < NPROC; i++)
  44:	31 d2                	xor    %edx,%edx
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  46:	83 f8 ff             	cmp    $0xffffffff,%eax
  49:	75 11                	jne    5c <main+0x5c>
  4b:	e9 df 00 00 00       	jmp    12f <main+0x12f>
  50:	83 c2 01             	add    $0x1,%edx
  53:	83 fa 40             	cmp    $0x40,%edx
  56:	0f 84 f8 00 00 00    	je     154 <main+0x154>
        if (s->pid[i] == pid)
  5c:	3b 9c 95 e8 fa ff ff 	cmp    -0x518(%ebp,%edx,4),%ebx
  63:	75 eb                	jne    50 <main+0x50>
    int ch_idx = find_stats_index_for_pid(&ps, pid);
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");

    ASSERT(ps.tickets[my_idx] == pa_tickets, "Parent tickets should be set to %d, \
  65:	83 bc 85 e8 f9 ff ff 	cmpl   $0x4,-0x618(%ebp,%eax,4)
  6c:	04 
  6d:	8d 70 40             	lea    0x40(%eax),%esi
  70:	0f 85 8b 00 00 00    	jne    101 <main+0x101>
but got %d from pgetinfo", pa_tickets, ps.tickets[my_idx]);
    ASSERT(ps.tickets[ch_idx] == ch_tickets, "Child tickets should be set to %d, \
  76:	83 bc 95 e8 f9 ff ff 	cmpl   $0x8,-0x618(%ebp,%edx,4)
  7d:	08 
  7e:	8d 72 40             	lea    0x40(%edx),%esi
  81:	0f 84 f5 00 00 00    	je     17c <main+0x17c>
  87:	83 ec 0c             	sub    $0xc,%esp
  8a:	6a 25                	push   $0x25
  8c:	68 63 0c 00 00       	push   $0xc63
  91:	68 18 0c 00 00       	push   $0xc18
  96:	68 59 0c 00 00       	push   $0xc59
  9b:	6a 01                	push   $0x1
  9d:	e8 4e 08 00 00       	call   8f0 <printf>
  a2:	83 c4 20             	add    $0x20,%esp
  a5:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
  ac:	6a 08                	push   $0x8
  ae:	68 0c 0d 00 00       	push   $0xd0c
  b3:	eb 32                	jmp    e7 <main+0xe7>
        run_until(rt);
  b5:	b8 e8 03 00 00       	mov    $0x3e8,%eax
  ba:	e8 11 03 00 00       	call   3d0 <run_until>
        exit();
  bf:	e8 bf 06 00 00       	call   783 <exit>
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  c4:	83 ec 0c             	sub    $0xc,%esp
  c7:	6a 0d                	push   $0xd
  c9:	68 63 0c 00 00       	push   $0xc63
  ce:	68 18 0c 00 00       	push   $0xc18
  d3:	68 59 0c 00 00       	push   $0xc59
  d8:	6a 01                	push   $0x1
  da:	e8 11 08 00 00       	call   8f0 <printf>
  df:	83 c4 18             	add    $0x18,%esp
  e2:	68 a8 0c 00 00       	push   $0xca8
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  e7:	6a 01                	push   $0x1
  e9:	e8 02 08 00 00       	call   8f0 <printf>
  ee:	5b                   	pop    %ebx
  ef:	5e                   	pop    %esi
  f0:	68 49 0c 00 00       	push   $0xc49
  f5:	6a 01                	push   $0x1
  f7:	e8 f4 07 00 00       	call   8f0 <printf>
  fc:	e8 82 06 00 00       	call   783 <exit>
    ASSERT(ps.tickets[my_idx] == pa_tickets, "Parent tickets should be set to %d, \
 101:	83 ec 0c             	sub    $0xc,%esp
 104:	6a 23                	push   $0x23
 106:	68 63 0c 00 00       	push   $0xc63
 10b:	68 18 0c 00 00       	push   $0xc18
 110:	68 59 0c 00 00       	push   $0xc59
 115:	6a 01                	push   $0x1
 117:	e8 d4 07 00 00       	call   8f0 <printf>
 11c:	83 c4 20             	add    $0x20,%esp
 11f:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 126:	6a 04                	push   $0x4
 128:	68 cc 0c 00 00       	push   $0xccc
 12d:	eb b8                	jmp    e7 <main+0xe7>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 12f:	83 ec 0c             	sub    $0xc,%esp
 132:	6a 1f                	push   $0x1f
 134:	68 63 0c 00 00       	push   $0xc63
 139:	68 18 0c 00 00       	push   $0xc18
 13e:	68 59 0c 00 00       	push   $0xc59
 143:	6a 01                	push   $0x1
 145:	e8 a6 07 00 00       	call   8f0 <printf>
 14a:	83 c4 18             	add    $0x18,%esp
 14d:	68 7c 0c 00 00       	push   $0xc7c
 152:	eb 93                	jmp    e7 <main+0xe7>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	6a 21                	push   $0x21
 159:	68 63 0c 00 00       	push   $0xc63
 15e:	68 18 0c 00 00       	push   $0xc18
 163:	68 59 0c 00 00       	push   $0xc59
 168:	6a 01                	push   $0x1
 16a:	e8 81 07 00 00       	call   8f0 <printf>
 16f:	83 c4 18             	add    $0x18,%esp
 172:	68 24 0e 00 00       	push   $0xe24
 177:	e9 6b ff ff ff       	jmp    e7 <main+0xe7>
but got %d from pgetinfo", ch_tickets, ps.tickets[ch_idx]);

    int old_rtime = ps.rtime[my_idx];
 17c:	8b bc 85 e8 fe ff ff 	mov    -0x118(%ebp,%eax,4),%edi
    int old_pass = ps.pass[my_idx];
 183:	8b b4 85 e8 fb ff ff 	mov    -0x418(%ebp,%eax,4),%esi

    int old_ch_rtime = ps.rtime[ch_idx];
 18a:	8b 84 95 e8 fe ff ff 	mov    -0x118(%ebp,%edx,4),%eax
 191:	89 85 e0 f8 ff ff    	mov    %eax,-0x720(%ebp)
    int old_ch_pass = ps.pass[ch_idx];
 197:	8b 84 95 e8 fb ff ff 	mov    -0x418(%ebp,%edx,4),%eax
 19e:	89 85 e4 f8 ff ff    	mov    %eax,-0x71c(%ebp)
    
    int extra = 40;
    run_until(old_rtime + extra);
 1a4:	8d 47 28             	lea    0x28(%edi),%eax
 1a7:	e8 24 02 00 00       	call   3d0 <run_until>

    my_idx = find_my_stats_index(&ps);
 1ac:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
 1b2:	e8 79 01 00 00       	call   330 <find_my_stats_index>
 1b7:	89 c2                	mov    %eax,%edx
    for (int i = 0; i < NPROC; i++)
 1b9:	31 c0                	xor    %eax,%eax
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 1bb:	83 fa ff             	cmp    $0xffffffff,%edx
 1be:	75 11                	jne    1d1 <main+0x1d1>
 1c0:	e9 da 00 00 00       	jmp    29f <main+0x29f>
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	83 f8 40             	cmp    $0x40,%eax
 1cb:	0f 84 d8 00 00 00    	je     2a9 <main+0x2a9>
        if (s->pid[i] == pid)
 1d1:	3b 9c 85 e8 fa ff ff 	cmp    -0x518(%ebp,%eax,4),%ebx
 1d8:	75 eb                	jne    1c5 <main+0x1c5>
    ch_idx = find_stats_index_for_pid(&ps, pid);
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");

    int now_rtime = ps.rtime[my_idx];
    int now_pass = ps.pass[my_idx];
 1da:	8b 9c 95 e8 fb ff ff 	mov    -0x418(%ebp,%edx,4),%ebx
    int now_rtime = ps.rtime[my_idx];
 1e1:	8b 8c 95 e8 fe ff ff 	mov    -0x118(%ebp,%edx,4),%ecx

    int now_ch_rtime = ps.rtime[ch_idx];
 1e8:	8b 94 85 e8 fe ff ff 	mov    -0x118(%ebp,%eax,4),%edx
    int now_ch_pass = ps.pass[ch_idx];
 1ef:	8b 84 85 e8 fb ff ff 	mov    -0x418(%ebp,%eax,4),%eax

    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 1f6:	39 de                	cmp    %ebx,%esi
 1f8:	7d 7b                	jge    275 <main+0x275>
new_pass is %d", old_pass, now_pass);

    ASSERT(now_ch_pass > old_ch_pass, "Child pass didn't increase: old_pass was %d, \
 1fa:	39 85 e4 f8 ff ff    	cmp    %eax,-0x71c(%ebp)
 200:	0f 8d ad 00 00 00    	jge    2b3 <main+0x2b3>
new_pass is %d", old_ch_pass, now_ch_pass);
    

    int diff_rtime = now_rtime - old_rtime;
    int __attribute__((unused)) diff_pass = now_pass - old_pass;
    int diff_ch_rtime = now_ch_rtime - old_ch_rtime;
 206:	89 d6                	mov    %edx,%esi
 208:	2b b5 e0 f8 ff ff    	sub    -0x720(%ebp),%esi
    int diff_rtime = now_rtime - old_rtime;
 20e:	29 f9                	sub    %edi,%ecx
    int __attribute__((unused)) diff_ch_pass = now_ch_pass - old_ch_pass;

    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 210:	8d 04 b5 00 00 00 00 	lea    0x0(,%esi,4),%eax
    int diff_rtime = now_rtime - old_rtime;
 217:	89 cb                	mov    %ecx,%ebx
    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 219:	b9 08 00 00 00       	mov    $0x8,%ecx
 21e:	99                   	cltd   
 21f:	f7 f9                	idiv   %ecx

    int margin = 2;
    ASSERT(diff_rtime <= exp_rtime + margin && diff_rtime >= exp_rtime - margin,
 221:	8d 50 02             	lea    0x2(%eax),%edx
 224:	39 da                	cmp    %ebx,%edx
 226:	7c 0b                	jl     233 <main+0x233>
 228:	83 e8 02             	sub    $0x2,%eax
 22b:	39 d8                	cmp    %ebx,%eax
 22d:	0f 8e bb 00 00 00    	jle    2ee <main+0x2ee>
 233:	83 ec 0c             	sub    $0xc,%esp
 236:	6a 4b                	push   $0x4b
 238:	68 63 0c 00 00       	push   $0xc63
 23d:	68 18 0c 00 00       	push   $0xc18
 242:	68 59 0c 00 00       	push   $0xc59
 247:	6a 01                	push   $0x1
 249:	e8 a2 06 00 00       	call   8f0 <printf>
 24e:	83 c4 14             	add    $0x14,%esp
 251:	6a 02                	push   $0x2
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	68 bc 0d 00 00       	push   $0xdbc
 25a:	6a 01                	push   $0x1
 25c:	e8 8f 06 00 00       	call   8f0 <printf>
 261:	83 c4 18             	add    $0x18,%esp
 264:	68 49 0c 00 00       	push   $0xc49
 269:	6a 01                	push   $0x1
 26b:	e8 80 06 00 00       	call   8f0 <printf>
 270:	e8 0e 05 00 00       	call   783 <exit>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 275:	83 ec 0c             	sub    $0xc,%esp
 278:	6a 3c                	push   $0x3c
 27a:	68 63 0c 00 00       	push   $0xc63
 27f:	68 18 0c 00 00       	push   $0xc18
 284:	68 59 0c 00 00       	push   $0xc59
 289:	6a 01                	push   $0x1
 28b:	e8 60 06 00 00       	call   8f0 <printf>
 290:	83 c4 20             	add    $0x20,%esp
 293:	53                   	push   %ebx
 294:	56                   	push   %esi
 295:	68 48 0d 00 00       	push   $0xd48
 29a:	e9 48 fe ff ff       	jmp    e7 <main+0xe7>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 29f:	83 ec 0c             	sub    $0xc,%esp
 2a2:	6a 32                	push   $0x32
 2a4:	e9 8b fe ff ff       	jmp    134 <main+0x134>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 2a9:	83 ec 0c             	sub    $0xc,%esp
 2ac:	6a 34                	push   $0x34
 2ae:	e9 a6 fe ff ff       	jmp    159 <main+0x159>
    ASSERT(now_ch_pass > old_ch_pass, "Child pass didn't increase: old_pass was %d, \
 2b3:	83 ec 0c             	sub    $0xc,%esp
 2b6:	89 85 e0 f8 ff ff    	mov    %eax,-0x720(%ebp)
 2bc:	6a 3f                	push   $0x3f
 2be:	68 63 0c 00 00       	push   $0xc63
 2c3:	68 18 0c 00 00       	push   $0xc18
 2c8:	68 59 0c 00 00       	push   $0xc59
 2cd:	6a 01                	push   $0x1
 2cf:	e8 1c 06 00 00       	call   8f0 <printf>
 2d4:	8b 85 e0 f8 ff ff    	mov    -0x720(%ebp),%eax
 2da:	83 c4 20             	add    $0x20,%esp
 2dd:	50                   	push   %eax
 2de:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 2e4:	68 80 0d 00 00       	push   $0xd80
 2e9:	e9 f9 fd ff ff       	jmp    e7 <main+0xe7>
    return -1;
}

#define SUCCESS_MSG "TEST PASSED"
static void test_passed() {
    PRINTF("%s", SUCCESS_MSG);
 2ee:	50                   	push   %eax
 2ef:	68 18 0c 00 00       	push   $0xc18
 2f4:	68 22 0c 00 00       	push   $0xc22
 2f9:	6a 01                	push   $0x1
 2fb:	e8 f0 05 00 00       	call   8f0 <printf>
 300:	83 c4 0c             	add    $0xc,%esp
 303:	68 6c 0c 00 00       	push   $0xc6c
 308:	68 78 0c 00 00       	push   $0xc78
 30d:	6a 01                	push   $0x1
 30f:	e8 dc 05 00 00       	call   8f0 <printf>
 314:	5a                   	pop    %edx
 315:	59                   	pop    %ecx
 316:	68 49 0c 00 00       	push   $0xc49
 31b:	6a 01                	push   $0x1
 31d:	e8 ce 05 00 00       	call   8f0 <printf>
%d margin of half the child ticks", diff_rtime, diff_ch_rtime, margin);


    test_passed();

    wait();
 322:	e8 64 04 00 00       	call   78b <wait>

    exit();
 327:	e8 57 04 00 00       	call   783 <exit>
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <find_my_stats_index>:
static int find_my_stats_index(struct pstat *s) {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	89 c3                	mov    %eax,%ebx
 337:	83 ec 10             	sub    $0x10,%esp
    int mypid = getpid();
 33a:	e8 c4 04 00 00       	call   803 <getpid>
    if (getpinfo(s) == -1) {
 33f:	83 ec 0c             	sub    $0xc,%esp
 342:	53                   	push   %ebx
    int mypid = getpid();
 343:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 345:	e8 e1 04 00 00       	call   82b <getpinfo>
 34a:	83 c4 10             	add    $0x10,%esp
 34d:	83 f8 ff             	cmp    $0xffffffff,%eax
 350:	74 3a                	je     38c <find_my_stats_index+0x5c>
    for (int i = 0; i < NPROC; i++)
 352:	31 c0                	xor    %eax,%eax
 354:	eb 12                	jmp    368 <find_my_stats_index+0x38>
 356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35d:	8d 76 00             	lea    0x0(%esi),%esi
 360:	83 c0 01             	add    $0x1,%eax
 363:	83 f8 40             	cmp    $0x40,%eax
 366:	74 18                	je     380 <find_my_stats_index+0x50>
        if (s->pid[i] == mypid)
 368:	39 b4 83 00 02 00 00 	cmp    %esi,0x200(%ebx,%eax,4)
 36f:	75 ef                	jne    360 <find_my_stats_index+0x30>
}
 371:	8d 65 f8             	lea    -0x8(%ebp),%esp
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
 378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37f:	90                   	nop
 380:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
 383:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 388:	5b                   	pop    %ebx
 389:	5e                   	pop    %esi
 38a:	5d                   	pop    %ebp
 38b:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 38c:	83 ec 04             	sub    $0x4,%esp
 38f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 392:	68 18 0c 00 00       	push   $0xc18
 397:	68 22 0c 00 00       	push   $0xc22
 39c:	6a 01                	push   $0x1
 39e:	e8 4d 05 00 00       	call   8f0 <printf>
 3a3:	58                   	pop    %eax
 3a4:	5a                   	pop    %edx
 3a5:	68 27 0c 00 00       	push   $0xc27
 3aa:	6a 01                	push   $0x1
 3ac:	e8 3f 05 00 00       	call   8f0 <printf>
 3b1:	59                   	pop    %ecx
 3b2:	5b                   	pop    %ebx
 3b3:	68 49 0c 00 00       	push   $0xc49
 3b8:	6a 01                	push   $0x1
 3ba:	e8 31 05 00 00       	call   8f0 <printf>
        return -1;
 3bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
        PRINTF("getpinfo failed\n"); 
 3c2:	83 c4 10             	add    $0x10,%esp
 3c5:	eb aa                	jmp    371 <find_my_stats_index+0x41>
 3c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <run_until>:

/*
 * Run at least until the specified target rtime
 * Might immediately return if the rtime is already reached
 */
static __attribute__((unused)) void run_until(int target_rtime) {
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	8d bd e8 f8 ff ff    	lea    -0x718(%ebp),%edi
 3db:	53                   	push   %ebx
 3dc:	81 ec 1c 07 00 00    	sub    $0x71c,%esp
 3e2:	89 85 e4 f8 ff ff    	mov    %eax,-0x71c(%ebp)
 3e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop
    int mypid = getpid();
 3f0:	e8 0e 04 00 00       	call   803 <getpid>
    if (getpinfo(s) == -1) {
 3f5:	83 ec 0c             	sub    $0xc,%esp
 3f8:	57                   	push   %edi
    int mypid = getpid();
 3f9:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 3fb:	e8 2b 04 00 00       	call   82b <getpinfo>
 400:	83 c4 10             	add    $0x10,%esp
 403:	83 f8 ff             	cmp    $0xffffffff,%eax
 406:	74 78                	je     480 <run_until+0xb0>
    for (int i = 0; i < NPROC; i++)
 408:	31 db                	xor    %ebx,%ebx
 40a:	eb 10                	jmp    41c <run_until+0x4c>
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 410:	83 c3 01             	add    $0x1,%ebx
 413:	83 fb 40             	cmp    $0x40,%ebx
 416:	0f 84 95 00 00 00    	je     4b1 <run_until+0xe1>
        if (s->pid[i] == mypid)
 41c:	3b b4 9f 00 02 00 00 	cmp    0x200(%edi,%ebx,4),%esi
 423:	75 eb                	jne    410 <run_until+0x40>
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);

        PRINTF("ps[%d] rttime: %d\n",my_idx, ps.rtime[my_idx]); 
 425:	83 ec 04             	sub    $0x4,%esp
 428:	8d b3 80 01 00 00    	lea    0x180(%ebx),%esi
 42e:	68 18 0c 00 00       	push   $0xc18
 433:	68 22 0c 00 00       	push   $0xc22
 438:	6a 01                	push   $0x1
 43a:	e8 b1 04 00 00       	call   8f0 <printf>
 43f:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 446:	53                   	push   %ebx
 447:	68 38 0c 00 00       	push   $0xc38
 44c:	6a 01                	push   $0x1
 44e:	e8 9d 04 00 00       	call   8f0 <printf>
 453:	83 c4 18             	add    $0x18,%esp
 456:	68 49 0c 00 00       	push   $0xc49
 45b:	6a 01                	push   $0x1
 45d:	e8 8e 04 00 00       	call   8f0 <printf>

        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");

        if (ps.rtime[my_idx] >= target_rtime)
 462:	8b 85 e4 f8 ff ff    	mov    -0x71c(%ebp),%eax
 468:	83 c4 10             	add    $0x10,%esp
 46b:	39 84 b5 e8 f8 ff ff 	cmp    %eax,-0x718(%ebp,%esi,4)
 472:	0f 8c 78 ff ff ff    	jl     3f0 <run_until+0x20>
            return;
    }
}
 478:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47b:	5b                   	pop    %ebx
 47c:	5e                   	pop    %esi
 47d:	5f                   	pop    %edi
 47e:	5d                   	pop    %ebp
 47f:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 480:	53                   	push   %ebx
 481:	68 18 0c 00 00       	push   $0xc18
 486:	68 22 0c 00 00       	push   $0xc22
 48b:	6a 01                	push   $0x1
 48d:	e8 5e 04 00 00       	call   8f0 <printf>
 492:	5e                   	pop    %esi
 493:	5f                   	pop    %edi
 494:	68 27 0c 00 00       	push   $0xc27
 499:	6a 01                	push   $0x1
 49b:	e8 50 04 00 00       	call   8f0 <printf>
 4a0:	58                   	pop    %eax
 4a1:	5a                   	pop    %edx
 4a2:	68 49 0c 00 00       	push   $0xc49
 4a7:	6a 01                	push   $0x1
 4a9:	e8 42 04 00 00       	call   8f0 <printf>
 4ae:	83 c4 10             	add    $0x10,%esp
        PRINTF("ps[%d] rttime: %d\n",my_idx, ps.rtime[my_idx]); 
 4b1:	50                   	push   %eax
 4b2:	68 18 0c 00 00       	push   $0xc18
 4b7:	68 22 0c 00 00       	push   $0xc22
 4bc:	6a 01                	push   $0x1
 4be:	e8 2d 04 00 00       	call   8f0 <printf>
 4c3:	ff b5 e4 fe ff ff    	push   -0x11c(%ebp)
 4c9:	6a ff                	push   $0xffffffff
 4cb:	68 38 0c 00 00       	push   $0xc38
 4d0:	6a 01                	push   $0x1
 4d2:	e8 19 04 00 00       	call   8f0 <printf>
 4d7:	83 c4 18             	add    $0x18,%esp
 4da:	68 49 0c 00 00       	push   $0xc49
 4df:	6a 01                	push   $0x1
 4e1:	e8 0a 04 00 00       	call   8f0 <printf>
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 4e6:	c7 04 24 4e 00 00 00 	movl   $0x4e,(%esp)
 4ed:	68 4b 0c 00 00       	push   $0xc4b
 4f2:	68 18 0c 00 00       	push   $0xc18
 4f7:	68 59 0c 00 00       	push   $0xc59
 4fc:	6a 01                	push   $0x1
 4fe:	e8 ed 03 00 00       	call   8f0 <printf>
 503:	83 c4 18             	add    $0x18,%esp
 506:	68 7c 0c 00 00       	push   $0xc7c
 50b:	6a 01                	push   $0x1
 50d:	e8 de 03 00 00       	call   8f0 <printf>
 512:	5a                   	pop    %edx
 513:	59                   	pop    %ecx
 514:	68 49 0c 00 00       	push   $0xc49
 519:	6a 01                	push   $0x1
 51b:	e8 d0 03 00 00       	call   8f0 <printf>
 520:	e8 5e 02 00 00       	call   783 <exit>
 525:	66 90                	xchg   %ax,%ax
 527:	66 90                	xchg   %ax,%ax
 529:	66 90                	xchg   %ax,%ax
 52b:	66 90                	xchg   %ax,%ax
 52d:	66 90                	xchg   %ax,%ax
 52f:	90                   	nop

00000530 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 530:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 531:	31 c0                	xor    %eax,%eax
{
 533:	89 e5                	mov    %esp,%ebp
 535:	53                   	push   %ebx
 536:	8b 4d 08             	mov    0x8(%ebp),%ecx
 539:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 540:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 544:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 547:	83 c0 01             	add    $0x1,%eax
 54a:	84 d2                	test   %dl,%dl
 54c:	75 f2                	jne    540 <strcpy+0x10>
    ;
  return os;
}
 54e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 551:	89 c8                	mov    %ecx,%eax
 553:	c9                   	leave  
 554:	c3                   	ret    
 555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000560 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	8b 55 08             	mov    0x8(%ebp),%edx
 567:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 56a:	0f b6 02             	movzbl (%edx),%eax
 56d:	84 c0                	test   %al,%al
 56f:	75 17                	jne    588 <strcmp+0x28>
 571:	eb 3a                	jmp    5ad <strcmp+0x4d>
 573:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 577:	90                   	nop
 578:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 57c:	83 c2 01             	add    $0x1,%edx
 57f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 582:	84 c0                	test   %al,%al
 584:	74 1a                	je     5a0 <strcmp+0x40>
    p++, q++;
 586:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 588:	0f b6 19             	movzbl (%ecx),%ebx
 58b:	38 c3                	cmp    %al,%bl
 58d:	74 e9                	je     578 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 58f:	29 d8                	sub    %ebx,%eax
}
 591:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 594:	c9                   	leave  
 595:	c3                   	ret    
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 5a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 5a4:	31 c0                	xor    %eax,%eax
 5a6:	29 d8                	sub    %ebx,%eax
}
 5a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5ab:	c9                   	leave  
 5ac:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 5ad:	0f b6 19             	movzbl (%ecx),%ebx
 5b0:	31 c0                	xor    %eax,%eax
 5b2:	eb db                	jmp    58f <strcmp+0x2f>
 5b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop

000005c0 <strlen>:

uint
strlen(const char *s)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 5c6:	80 3a 00             	cmpb   $0x0,(%edx)
 5c9:	74 15                	je     5e0 <strlen+0x20>
 5cb:	31 c0                	xor    %eax,%eax
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
 5d0:	83 c0 01             	add    $0x1,%eax
 5d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5d7:	89 c1                	mov    %eax,%ecx
 5d9:	75 f5                	jne    5d0 <strlen+0x10>
    ;
  return n;
}
 5db:	89 c8                	mov    %ecx,%eax
 5dd:	5d                   	pop    %ebp
 5de:	c3                   	ret    
 5df:	90                   	nop
  for(n = 0; s[n]; n++)
 5e0:	31 c9                	xor    %ecx,%ecx
}
 5e2:	5d                   	pop    %ebp
 5e3:	89 c8                	mov    %ecx,%eax
 5e5:	c3                   	ret    
 5e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ed:	8d 76 00             	lea    0x0(%esi),%esi

000005f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 5fd:	89 d7                	mov    %edx,%edi
 5ff:	fc                   	cld    
 600:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 602:	8b 7d fc             	mov    -0x4(%ebp),%edi
 605:	89 d0                	mov    %edx,%eax
 607:	c9                   	leave  
 608:	c3                   	ret    
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000610 <strchr>:

char*
strchr(const char *s, char c)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	8b 45 08             	mov    0x8(%ebp),%eax
 616:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 61a:	0f b6 10             	movzbl (%eax),%edx
 61d:	84 d2                	test   %dl,%dl
 61f:	75 12                	jne    633 <strchr+0x23>
 621:	eb 1d                	jmp    640 <strchr+0x30>
 623:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 627:	90                   	nop
 628:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 62c:	83 c0 01             	add    $0x1,%eax
 62f:	84 d2                	test   %dl,%dl
 631:	74 0d                	je     640 <strchr+0x30>
    if(*s == c)
 633:	38 d1                	cmp    %dl,%cl
 635:	75 f1                	jne    628 <strchr+0x18>
      return (char*)s;
  return 0;
}
 637:	5d                   	pop    %ebp
 638:	c3                   	ret    
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 640:	31 c0                	xor    %eax,%eax
}
 642:	5d                   	pop    %ebp
 643:	c3                   	ret    
 644:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop

00000650 <gets>:

char*
gets(char *buf, int max)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 655:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 658:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 659:	31 db                	xor    %ebx,%ebx
{
 65b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 65e:	eb 27                	jmp    687 <gets+0x37>
    cc = read(0, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	6a 01                	push   $0x1
 665:	57                   	push   %edi
 666:	6a 00                	push   $0x0
 668:	e8 2e 01 00 00       	call   79b <read>
    if(cc < 1)
 66d:	83 c4 10             	add    $0x10,%esp
 670:	85 c0                	test   %eax,%eax
 672:	7e 1d                	jle    691 <gets+0x41>
      break;
    buf[i++] = c;
 674:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 678:	8b 55 08             	mov    0x8(%ebp),%edx
 67b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 67f:	3c 0a                	cmp    $0xa,%al
 681:	74 1d                	je     6a0 <gets+0x50>
 683:	3c 0d                	cmp    $0xd,%al
 685:	74 19                	je     6a0 <gets+0x50>
  for(i=0; i+1 < max; ){
 687:	89 de                	mov    %ebx,%esi
 689:	83 c3 01             	add    $0x1,%ebx
 68c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 68f:	7c cf                	jl     660 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 691:	8b 45 08             	mov    0x8(%ebp),%eax
 694:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 698:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret    
  buf[i] = '\0';
 6a0:	8b 45 08             	mov    0x8(%ebp),%eax
 6a3:	89 de                	mov    %ebx,%esi
 6a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 6a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ac:	5b                   	pop    %ebx
 6ad:	5e                   	pop    %esi
 6ae:	5f                   	pop    %edi
 6af:	5d                   	pop    %ebp
 6b0:	c3                   	ret    
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop

000006c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	56                   	push   %esi
 6c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6c5:	83 ec 08             	sub    $0x8,%esp
 6c8:	6a 00                	push   $0x0
 6ca:	ff 75 08             	push   0x8(%ebp)
 6cd:	e8 f1 00 00 00       	call   7c3 <open>
  if(fd < 0)
 6d2:	83 c4 10             	add    $0x10,%esp
 6d5:	85 c0                	test   %eax,%eax
 6d7:	78 27                	js     700 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6d9:	83 ec 08             	sub    $0x8,%esp
 6dc:	ff 75 0c             	push   0xc(%ebp)
 6df:	89 c3                	mov    %eax,%ebx
 6e1:	50                   	push   %eax
 6e2:	e8 f4 00 00 00       	call   7db <fstat>
  close(fd);
 6e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ea:	89 c6                	mov    %eax,%esi
  close(fd);
 6ec:	e8 ba 00 00 00       	call   7ab <close>
  return r;
 6f1:	83 c4 10             	add    $0x10,%esp
}
 6f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6f7:	89 f0                	mov    %esi,%eax
 6f9:	5b                   	pop    %ebx
 6fa:	5e                   	pop    %esi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret    
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 700:	be ff ff ff ff       	mov    $0xffffffff,%esi
 705:	eb ed                	jmp    6f4 <stat+0x34>
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax

00000710 <atoi>:

int
atoi(const char *s)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	53                   	push   %ebx
 714:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 717:	0f be 02             	movsbl (%edx),%eax
 71a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 71d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 720:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 725:	77 1e                	ja     745 <atoi+0x35>
 727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 730:	83 c2 01             	add    $0x1,%edx
 733:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 736:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 73a:	0f be 02             	movsbl (%edx),%eax
 73d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 740:	80 fb 09             	cmp    $0x9,%bl
 743:	76 eb                	jbe    730 <atoi+0x20>
  return n;
}
 745:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 748:	89 c8                	mov    %ecx,%eax
 74a:	c9                   	leave  
 74b:	c3                   	ret    
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	8b 45 10             	mov    0x10(%ebp),%eax
 757:	8b 55 08             	mov    0x8(%ebp),%edx
 75a:	56                   	push   %esi
 75b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 75e:	85 c0                	test   %eax,%eax
 760:	7e 13                	jle    775 <memmove+0x25>
 762:	01 d0                	add    %edx,%eax
  dst = vdst;
 764:	89 d7                	mov    %edx,%edi
 766:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 770:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 771:	39 f8                	cmp    %edi,%eax
 773:	75 fb                	jne    770 <memmove+0x20>
  return vdst;
}
 775:	5e                   	pop    %esi
 776:	89 d0                	mov    %edx,%eax
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    

0000077b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 77b:	b8 01 00 00 00       	mov    $0x1,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <exit>:
SYSCALL(exit)
 783:	b8 02 00 00 00       	mov    $0x2,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <wait>:
SYSCALL(wait)
 78b:	b8 03 00 00 00       	mov    $0x3,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <pipe>:
SYSCALL(pipe)
 793:	b8 04 00 00 00       	mov    $0x4,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <read>:
SYSCALL(read)
 79b:	b8 05 00 00 00       	mov    $0x5,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <write>:
SYSCALL(write)
 7a3:	b8 10 00 00 00       	mov    $0x10,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <close>:
SYSCALL(close)
 7ab:	b8 15 00 00 00       	mov    $0x15,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <kill>:
SYSCALL(kill)
 7b3:	b8 06 00 00 00       	mov    $0x6,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <exec>:
SYSCALL(exec)
 7bb:	b8 07 00 00 00       	mov    $0x7,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <open>:
SYSCALL(open)
 7c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <mknod>:
SYSCALL(mknod)
 7cb:	b8 11 00 00 00       	mov    $0x11,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <unlink>:
SYSCALL(unlink)
 7d3:	b8 12 00 00 00       	mov    $0x12,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <fstat>:
SYSCALL(fstat)
 7db:	b8 08 00 00 00       	mov    $0x8,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <link>:
SYSCALL(link)
 7e3:	b8 13 00 00 00       	mov    $0x13,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <mkdir>:
SYSCALL(mkdir)
 7eb:	b8 14 00 00 00       	mov    $0x14,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <chdir>:
SYSCALL(chdir)
 7f3:	b8 09 00 00 00       	mov    $0x9,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <dup>:
SYSCALL(dup)
 7fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    

00000803 <getpid>:
SYSCALL(getpid)
 803:	b8 0b 00 00 00       	mov    $0xb,%eax
 808:	cd 40                	int    $0x40
 80a:	c3                   	ret    

0000080b <sbrk>:
SYSCALL(sbrk)
 80b:	b8 0c 00 00 00       	mov    $0xc,%eax
 810:	cd 40                	int    $0x40
 812:	c3                   	ret    

00000813 <sleep>:
SYSCALL(sleep)
 813:	b8 0d 00 00 00       	mov    $0xd,%eax
 818:	cd 40                	int    $0x40
 81a:	c3                   	ret    

0000081b <uptime>:
SYSCALL(uptime)
 81b:	b8 0e 00 00 00       	mov    $0xe,%eax
 820:	cd 40                	int    $0x40
 822:	c3                   	ret    

00000823 <settickets>:
SYSCALL(settickets)
 823:	b8 16 00 00 00       	mov    $0x16,%eax
 828:	cd 40                	int    $0x40
 82a:	c3                   	ret    

0000082b <getpinfo>:
SYSCALL(getpinfo)
 82b:	b8 17 00 00 00       	mov    $0x17,%eax
 830:	cd 40                	int    $0x40
 832:	c3                   	ret    
 833:	66 90                	xchg   %ax,%ax
 835:	66 90                	xchg   %ax,%ax
 837:	66 90                	xchg   %ax,%ax
 839:	66 90                	xchg   %ax,%ax
 83b:	66 90                	xchg   %ax,%ax
 83d:	66 90                	xchg   %ax,%ax
 83f:	90                   	nop

00000840 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 3c             	sub    $0x3c,%esp
 849:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 84c:	89 d1                	mov    %edx,%ecx
{
 84e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 851:	85 d2                	test   %edx,%edx
 853:	0f 89 7f 00 00 00    	jns    8d8 <printint+0x98>
 859:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 85d:	74 79                	je     8d8 <printint+0x98>
    neg = 1;
 85f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 866:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 868:	31 db                	xor    %ebx,%ebx
 86a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 870:	89 c8                	mov    %ecx,%eax
 872:	31 d2                	xor    %edx,%edx
 874:	89 cf                	mov    %ecx,%edi
 876:	f7 75 c4             	divl   -0x3c(%ebp)
 879:	0f b6 92 b4 0e 00 00 	movzbl 0xeb4(%edx),%edx
 880:	89 45 c0             	mov    %eax,-0x40(%ebp)
 883:	89 d8                	mov    %ebx,%eax
 885:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 888:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 88b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 88e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 891:	76 dd                	jbe    870 <printint+0x30>
  if(neg)
 893:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 896:	85 c9                	test   %ecx,%ecx
 898:	74 0c                	je     8a6 <printint+0x66>
    buf[i++] = '-';
 89a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 89f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 8a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 8a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 8a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 8ad:	eb 07                	jmp    8b6 <printint+0x76>
 8af:	90                   	nop
    putc(fd, buf[i]);
 8b0:	0f b6 13             	movzbl (%ebx),%edx
 8b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 8b6:	83 ec 04             	sub    $0x4,%esp
 8b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 8bc:	6a 01                	push   $0x1
 8be:	56                   	push   %esi
 8bf:	57                   	push   %edi
 8c0:	e8 de fe ff ff       	call   7a3 <write>
  while(--i >= 0)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	39 de                	cmp    %ebx,%esi
 8ca:	75 e4                	jne    8b0 <printint+0x70>
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8df:	eb 87                	jmp    868 <printint+0x28>
 8e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop

000008f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8ff:	0f b6 13             	movzbl (%ebx),%edx
 902:	84 d2                	test   %dl,%dl
 904:	74 6a                	je     970 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 906:	8d 45 10             	lea    0x10(%ebp),%eax
 909:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 90c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 90f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 911:	89 45 d0             	mov    %eax,-0x30(%ebp)
 914:	eb 36                	jmp    94c <printf+0x5c>
 916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 91d:	8d 76 00             	lea    0x0(%esi),%esi
 920:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 923:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 928:	83 f8 25             	cmp    $0x25,%eax
 92b:	74 15                	je     942 <printf+0x52>
  write(fd, &c, 1);
 92d:	83 ec 04             	sub    $0x4,%esp
 930:	88 55 e7             	mov    %dl,-0x19(%ebp)
 933:	6a 01                	push   $0x1
 935:	57                   	push   %edi
 936:	56                   	push   %esi
 937:	e8 67 fe ff ff       	call   7a3 <write>
 93c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 93f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 942:	0f b6 13             	movzbl (%ebx),%edx
 945:	83 c3 01             	add    $0x1,%ebx
 948:	84 d2                	test   %dl,%dl
 94a:	74 24                	je     970 <printf+0x80>
    c = fmt[i] & 0xff;
 94c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 94f:	85 c9                	test   %ecx,%ecx
 951:	74 cd                	je     920 <printf+0x30>
      }
    } else if(state == '%'){
 953:	83 f9 25             	cmp    $0x25,%ecx
 956:	75 ea                	jne    942 <printf+0x52>
      if(c == 'd'){
 958:	83 f8 25             	cmp    $0x25,%eax
 95b:	0f 84 07 01 00 00    	je     a68 <printf+0x178>
 961:	83 e8 63             	sub    $0x63,%eax
 964:	83 f8 15             	cmp    $0x15,%eax
 967:	77 17                	ja     980 <printf+0x90>
 969:	ff 24 85 5c 0e 00 00 	jmp    *0xe5c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 970:	8d 65 f4             	lea    -0xc(%ebp),%esp
 973:	5b                   	pop    %ebx
 974:	5e                   	pop    %esi
 975:	5f                   	pop    %edi
 976:	5d                   	pop    %ebp
 977:	c3                   	ret    
 978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 97f:	90                   	nop
  write(fd, &c, 1);
 980:	83 ec 04             	sub    $0x4,%esp
 983:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 986:	6a 01                	push   $0x1
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 98e:	e8 10 fe ff ff       	call   7a3 <write>
        putc(fd, c);
 993:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 997:	83 c4 0c             	add    $0xc,%esp
 99a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 99d:	6a 01                	push   $0x1
 99f:	57                   	push   %edi
 9a0:	56                   	push   %esi
 9a1:	e8 fd fd ff ff       	call   7a3 <write>
        putc(fd, c);
 9a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9a9:	31 c9                	xor    %ecx,%ecx
 9ab:	eb 95                	jmp    942 <printf+0x52>
 9ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9b0:	83 ec 0c             	sub    $0xc,%esp
 9b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 9b8:	6a 00                	push   $0x0
 9ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9bd:	8b 10                	mov    (%eax),%edx
 9bf:	89 f0                	mov    %esi,%eax
 9c1:	e8 7a fe ff ff       	call   840 <printint>
        ap++;
 9c6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9ca:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9cd:	31 c9                	xor    %ecx,%ecx
 9cf:	e9 6e ff ff ff       	jmp    942 <printf+0x52>
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9db:	8b 10                	mov    (%eax),%edx
        ap++;
 9dd:	83 c0 04             	add    $0x4,%eax
 9e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 9e3:	85 d2                	test   %edx,%edx
 9e5:	0f 84 8d 00 00 00    	je     a78 <printf+0x188>
        while(*s != 0){
 9eb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 9ee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9f0:	84 c0                	test   %al,%al
 9f2:	0f 84 4a ff ff ff    	je     942 <printf+0x52>
 9f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9fb:	89 d3                	mov    %edx,%ebx
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a00:	83 ec 04             	sub    $0x4,%esp
          s++;
 a03:	83 c3 01             	add    $0x1,%ebx
 a06:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a09:	6a 01                	push   $0x1
 a0b:	57                   	push   %edi
 a0c:	56                   	push   %esi
 a0d:	e8 91 fd ff ff       	call   7a3 <write>
        while(*s != 0){
 a12:	0f b6 03             	movzbl (%ebx),%eax
 a15:	83 c4 10             	add    $0x10,%esp
 a18:	84 c0                	test   %al,%al
 a1a:	75 e4                	jne    a00 <printf+0x110>
      state = 0;
 a1c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 a1f:	31 c9                	xor    %ecx,%ecx
 a21:	e9 1c ff ff ff       	jmp    942 <printf+0x52>
 a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a2d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a30:	83 ec 0c             	sub    $0xc,%esp
 a33:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a38:	6a 01                	push   $0x1
 a3a:	e9 7b ff ff ff       	jmp    9ba <printf+0xca>
 a3f:	90                   	nop
        putc(fd, *ap);
 a40:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 a43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a46:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a48:	6a 01                	push   $0x1
 a4a:	57                   	push   %edi
 a4b:	56                   	push   %esi
        putc(fd, *ap);
 a4c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a4f:	e8 4f fd ff ff       	call   7a3 <write>
        ap++;
 a54:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a58:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a5b:	31 c9                	xor    %ecx,%ecx
 a5d:	e9 e0 fe ff ff       	jmp    942 <printf+0x52>
 a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a68:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a6b:	83 ec 04             	sub    $0x4,%esp
 a6e:	e9 2a ff ff ff       	jmp    99d <printf+0xad>
 a73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a77:	90                   	nop
          s = "(null)";
 a78:	ba 54 0e 00 00       	mov    $0xe54,%edx
        while(*s != 0){
 a7d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a80:	b8 28 00 00 00       	mov    $0x28,%eax
 a85:	89 d3                	mov    %edx,%ebx
 a87:	e9 74 ff ff ff       	jmp    a00 <printf+0x110>
 a8c:	66 90                	xchg   %ax,%ax
 a8e:	66 90                	xchg   %ax,%ax

00000a90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a90:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a91:	a1 d0 11 00 00       	mov    0x11d0,%eax
{
 a96:	89 e5                	mov    %esp,%ebp
 a98:	57                   	push   %edi
 a99:	56                   	push   %esi
 a9a:	53                   	push   %ebx
 a9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a9e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 aa8:	89 c2                	mov    %eax,%edx
 aaa:	8b 00                	mov    (%eax),%eax
 aac:	39 ca                	cmp    %ecx,%edx
 aae:	73 30                	jae    ae0 <free+0x50>
 ab0:	39 c1                	cmp    %eax,%ecx
 ab2:	72 04                	jb     ab8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab4:	39 c2                	cmp    %eax,%edx
 ab6:	72 f0                	jb     aa8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ab8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 abb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 abe:	39 f8                	cmp    %edi,%eax
 ac0:	74 30                	je     af2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 ac2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ac5:	8b 42 04             	mov    0x4(%edx),%eax
 ac8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 acb:	39 f1                	cmp    %esi,%ecx
 acd:	74 3a                	je     b09 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 acf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 ad1:	5b                   	pop    %ebx
  freep = p;
 ad2:	89 15 d0 11 00 00    	mov    %edx,0x11d0
}
 ad8:	5e                   	pop    %esi
 ad9:	5f                   	pop    %edi
 ada:	5d                   	pop    %ebp
 adb:	c3                   	ret    
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae0:	39 c2                	cmp    %eax,%edx
 ae2:	72 c4                	jb     aa8 <free+0x18>
 ae4:	39 c1                	cmp    %eax,%ecx
 ae6:	73 c0                	jae    aa8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 ae8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aeb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aee:	39 f8                	cmp    %edi,%eax
 af0:	75 d0                	jne    ac2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 af2:	03 70 04             	add    0x4(%eax),%esi
 af5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 af8:	8b 02                	mov    (%edx),%eax
 afa:	8b 00                	mov    (%eax),%eax
 afc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 aff:	8b 42 04             	mov    0x4(%edx),%eax
 b02:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b05:	39 f1                	cmp    %esi,%ecx
 b07:	75 c6                	jne    acf <free+0x3f>
    p->s.size += bp->s.size;
 b09:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 b0c:	89 15 d0 11 00 00    	mov    %edx,0x11d0
    p->s.size += bp->s.size;
 b12:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 b15:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 b18:	89 0a                	mov    %ecx,(%edx)
}
 b1a:	5b                   	pop    %ebx
 b1b:	5e                   	pop    %esi
 b1c:	5f                   	pop    %edi
 b1d:	5d                   	pop    %ebp
 b1e:	c3                   	ret    
 b1f:	90                   	nop

00000b20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b20:	55                   	push   %ebp
 b21:	89 e5                	mov    %esp,%ebp
 b23:	57                   	push   %edi
 b24:	56                   	push   %esi
 b25:	53                   	push   %ebx
 b26:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b2c:	8b 3d d0 11 00 00    	mov    0x11d0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b32:	8d 70 07             	lea    0x7(%eax),%esi
 b35:	c1 ee 03             	shr    $0x3,%esi
 b38:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b3b:	85 ff                	test   %edi,%edi
 b3d:	0f 84 9d 00 00 00    	je     be0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b43:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 b45:	8b 4a 04             	mov    0x4(%edx),%ecx
 b48:	39 f1                	cmp    %esi,%ecx
 b4a:	73 6a                	jae    bb6 <malloc+0x96>
 b4c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b51:	39 de                	cmp    %ebx,%esi
 b53:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b56:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b60:	eb 17                	jmp    b79 <malloc+0x59>
 b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b6a:	8b 48 04             	mov    0x4(%eax),%ecx
 b6d:	39 f1                	cmp    %esi,%ecx
 b6f:	73 4f                	jae    bc0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b71:	8b 3d d0 11 00 00    	mov    0x11d0,%edi
 b77:	89 c2                	mov    %eax,%edx
 b79:	39 d7                	cmp    %edx,%edi
 b7b:	75 eb                	jne    b68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b7d:	83 ec 0c             	sub    $0xc,%esp
 b80:	ff 75 e4             	push   -0x1c(%ebp)
 b83:	e8 83 fc ff ff       	call   80b <sbrk>
  if(p == (char*)-1)
 b88:	83 c4 10             	add    $0x10,%esp
 b8b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b8e:	74 1c                	je     bac <malloc+0x8c>
  hp->s.size = nu;
 b90:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b93:	83 ec 0c             	sub    $0xc,%esp
 b96:	83 c0 08             	add    $0x8,%eax
 b99:	50                   	push   %eax
 b9a:	e8 f1 fe ff ff       	call   a90 <free>
  return freep;
 b9f:	8b 15 d0 11 00 00    	mov    0x11d0,%edx
      if((p = morecore(nunits)) == 0)
 ba5:	83 c4 10             	add    $0x10,%esp
 ba8:	85 d2                	test   %edx,%edx
 baa:	75 bc                	jne    b68 <malloc+0x48>
        return 0;
  }
}
 bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 baf:	31 c0                	xor    %eax,%eax
}
 bb1:	5b                   	pop    %ebx
 bb2:	5e                   	pop    %esi
 bb3:	5f                   	pop    %edi
 bb4:	5d                   	pop    %ebp
 bb5:	c3                   	ret    
    if(p->s.size >= nunits){
 bb6:	89 d0                	mov    %edx,%eax
 bb8:	89 fa                	mov    %edi,%edx
 bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 bc0:	39 ce                	cmp    %ecx,%esi
 bc2:	74 4c                	je     c10 <malloc+0xf0>
        p->s.size -= nunits;
 bc4:	29 f1                	sub    %esi,%ecx
 bc6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bc9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bcc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 bcf:	89 15 d0 11 00 00    	mov    %edx,0x11d0
}
 bd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bd8:	83 c0 08             	add    $0x8,%eax
}
 bdb:	5b                   	pop    %ebx
 bdc:	5e                   	pop    %esi
 bdd:	5f                   	pop    %edi
 bde:	5d                   	pop    %ebp
 bdf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 be0:	c7 05 d0 11 00 00 d4 	movl   $0x11d4,0x11d0
 be7:	11 00 00 
    base.s.size = 0;
 bea:	bf d4 11 00 00       	mov    $0x11d4,%edi
    base.s.ptr = freep = prevp = &base;
 bef:	c7 05 d4 11 00 00 d4 	movl   $0x11d4,0x11d4
 bf6:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bf9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 bfb:	c7 05 d8 11 00 00 00 	movl   $0x0,0x11d8
 c02:	00 00 00 
    if(p->s.size >= nunits){
 c05:	e9 42 ff ff ff       	jmp    b4c <malloc+0x2c>
 c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 c10:	8b 08                	mov    (%eax),%ecx
 c12:	89 0a                	mov    %ecx,(%edx)
 c14:	eb b9                	jmp    bcf <malloc+0xaf>
