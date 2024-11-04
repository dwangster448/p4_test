
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
  19:	e8 75 07 00 00       	call   793 <settickets>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	83 f8 ff             	cmp    $0xffffffff,%eax
  24:	0f 84 9a 00 00 00    	je     c4 <main+0xc4>

    int pid = fork();
  2a:	e8 bc 06 00 00       	call   6eb <fork>
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
  8c:	68 c0 0b 00 00       	push   $0xbc0
  91:	68 88 0b 00 00       	push   $0xb88
  96:	68 b6 0b 00 00       	push   $0xbb6
  9b:	6a 01                	push   $0x1
  9d:	e8 be 07 00 00       	call   860 <printf>
  a2:	83 c4 20             	add    $0x20,%esp
  a5:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
  ac:	6a 08                	push   $0x8
  ae:	68 68 0c 00 00       	push   $0xc68
  b3:	eb 32                	jmp    e7 <main+0xe7>
        run_until(rt);
  b5:	b8 e8 03 00 00       	mov    $0x3e8,%eax
  ba:	e8 11 03 00 00       	call   3d0 <run_until>
        exit();
  bf:	e8 2f 06 00 00       	call   6f3 <exit>
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  c4:	83 ec 0c             	sub    $0xc,%esp
  c7:	6a 0d                	push   $0xd
  c9:	68 c0 0b 00 00       	push   $0xbc0
  ce:	68 88 0b 00 00       	push   $0xb88
  d3:	68 b6 0b 00 00       	push   $0xbb6
  d8:	6a 01                	push   $0x1
  da:	e8 81 07 00 00       	call   860 <printf>
  df:	83 c4 18             	add    $0x18,%esp
  e2:	68 04 0c 00 00       	push   $0xc04
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  e7:	6a 01                	push   $0x1
  e9:	e8 72 07 00 00       	call   860 <printf>
  ee:	5b                   	pop    %ebx
  ef:	5e                   	pop    %esi
  f0:	68 a6 0b 00 00       	push   $0xba6
  f5:	6a 01                	push   $0x1
  f7:	e8 64 07 00 00       	call   860 <printf>
  fc:	e8 f2 05 00 00       	call   6f3 <exit>
    ASSERT(ps.tickets[my_idx] == pa_tickets, "Parent tickets should be set to %d, \
 101:	83 ec 0c             	sub    $0xc,%esp
 104:	6a 23                	push   $0x23
 106:	68 c0 0b 00 00       	push   $0xbc0
 10b:	68 88 0b 00 00       	push   $0xb88
 110:	68 b6 0b 00 00       	push   $0xbb6
 115:	6a 01                	push   $0x1
 117:	e8 44 07 00 00       	call   860 <printf>
 11c:	83 c4 20             	add    $0x20,%esp
 11f:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 126:	6a 04                	push   $0x4
 128:	68 28 0c 00 00       	push   $0xc28
 12d:	eb b8                	jmp    e7 <main+0xe7>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 12f:	83 ec 0c             	sub    $0xc,%esp
 132:	6a 1f                	push   $0x1f
 134:	68 c0 0b 00 00       	push   $0xbc0
 139:	68 88 0b 00 00       	push   $0xb88
 13e:	68 b6 0b 00 00       	push   $0xbb6
 143:	6a 01                	push   $0x1
 145:	e8 16 07 00 00       	call   860 <printf>
 14a:	83 c4 18             	add    $0x18,%esp
 14d:	68 d8 0b 00 00       	push   $0xbd8
 152:	eb 93                	jmp    e7 <main+0xe7>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	6a 21                	push   $0x21
 159:	68 c0 0b 00 00       	push   $0xbc0
 15e:	68 88 0b 00 00       	push   $0xb88
 163:	68 b6 0b 00 00       	push   $0xbb6
 168:	6a 01                	push   $0x1
 16a:	e8 f1 06 00 00       	call   860 <printf>
 16f:	83 c4 18             	add    $0x18,%esp
 172:	68 80 0d 00 00       	push   $0xd80
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
 238:	68 c0 0b 00 00       	push   $0xbc0
 23d:	68 88 0b 00 00       	push   $0xb88
 242:	68 b6 0b 00 00       	push   $0xbb6
 247:	6a 01                	push   $0x1
 249:	e8 12 06 00 00       	call   860 <printf>
 24e:	83 c4 14             	add    $0x14,%esp
 251:	6a 02                	push   $0x2
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	68 18 0d 00 00       	push   $0xd18
 25a:	6a 01                	push   $0x1
 25c:	e8 ff 05 00 00       	call   860 <printf>
 261:	83 c4 18             	add    $0x18,%esp
 264:	68 a6 0b 00 00       	push   $0xba6
 269:	6a 01                	push   $0x1
 26b:	e8 f0 05 00 00       	call   860 <printf>
 270:	e8 7e 04 00 00       	call   6f3 <exit>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 275:	83 ec 0c             	sub    $0xc,%esp
 278:	6a 3c                	push   $0x3c
 27a:	68 c0 0b 00 00       	push   $0xbc0
 27f:	68 88 0b 00 00       	push   $0xb88
 284:	68 b6 0b 00 00       	push   $0xbb6
 289:	6a 01                	push   $0x1
 28b:	e8 d0 05 00 00       	call   860 <printf>
 290:	83 c4 20             	add    $0x20,%esp
 293:	53                   	push   %ebx
 294:	56                   	push   %esi
 295:	68 a4 0c 00 00       	push   $0xca4
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
 2be:	68 c0 0b 00 00       	push   $0xbc0
 2c3:	68 88 0b 00 00       	push   $0xb88
 2c8:	68 b6 0b 00 00       	push   $0xbb6
 2cd:	6a 01                	push   $0x1
 2cf:	e8 8c 05 00 00       	call   860 <printf>
 2d4:	8b 85 e0 f8 ff ff    	mov    -0x720(%ebp),%eax
 2da:	83 c4 20             	add    $0x20,%esp
 2dd:	50                   	push   %eax
 2de:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 2e4:	68 dc 0c 00 00       	push   $0xcdc
 2e9:	e9 f9 fd ff ff       	jmp    e7 <main+0xe7>
    return -1;
}

#define SUCCESS_MSG "TEST PASSED"
static void test_passed() {
    PRINTF("%s", SUCCESS_MSG);
 2ee:	50                   	push   %eax
 2ef:	68 88 0b 00 00       	push   $0xb88
 2f4:	68 92 0b 00 00       	push   $0xb92
 2f9:	6a 01                	push   $0x1
 2fb:	e8 60 05 00 00       	call   860 <printf>
 300:	83 c4 0c             	add    $0xc,%esp
 303:	68 c9 0b 00 00       	push   $0xbc9
 308:	68 d5 0b 00 00       	push   $0xbd5
 30d:	6a 01                	push   $0x1
 30f:	e8 4c 05 00 00       	call   860 <printf>
 314:	5a                   	pop    %edx
 315:	59                   	pop    %ecx
 316:	68 a6 0b 00 00       	push   $0xba6
 31b:	6a 01                	push   $0x1
 31d:	e8 3e 05 00 00       	call   860 <printf>
%d margin of half the child ticks", diff_rtime, diff_ch_rtime, margin);


    test_passed();

    wait();
 322:	e8 d4 03 00 00       	call   6fb <wait>

    exit();
 327:	e8 c7 03 00 00       	call   6f3 <exit>
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
 33a:	e8 34 04 00 00       	call   773 <getpid>
    if (getpinfo(s) == -1) {
 33f:	83 ec 0c             	sub    $0xc,%esp
 342:	53                   	push   %ebx
    int mypid = getpid();
 343:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 345:	e8 51 04 00 00       	call   79b <getpinfo>
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
 392:	68 88 0b 00 00       	push   $0xb88
 397:	68 92 0b 00 00       	push   $0xb92
 39c:	6a 01                	push   $0x1
 39e:	e8 bd 04 00 00       	call   860 <printf>
 3a3:	58                   	pop    %eax
 3a4:	5a                   	pop    %edx
 3a5:	68 97 0b 00 00       	push   $0xb97
 3aa:	6a 01                	push   $0x1
 3ac:	e8 af 04 00 00       	call   860 <printf>
 3b1:	59                   	pop    %ecx
 3b2:	5b                   	pop    %ebx
 3b3:	68 a6 0b 00 00       	push   $0xba6
 3b8:	6a 01                	push   $0x1
 3ba:	e8 a1 04 00 00       	call   860 <printf>
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
 3db:	89 c6                	mov    %eax,%esi
 3dd:	53                   	push   %ebx
 3de:	81 ec 0c 07 00 00    	sub    $0x70c,%esp
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int mypid = getpid();
 3e8:	e8 86 03 00 00       	call   773 <getpid>
    if (getpinfo(s) == -1) {
 3ed:	83 ec 0c             	sub    $0xc,%esp
 3f0:	57                   	push   %edi
    int mypid = getpid();
 3f1:	89 c3                	mov    %eax,%ebx
    if (getpinfo(s) == -1) {
 3f3:	e8 a3 03 00 00       	call   79b <getpinfo>
 3f8:	83 c4 10             	add    $0x10,%esp
 3fb:	83 f8 ff             	cmp    $0xffffffff,%eax
 3fe:	74 2a                	je     42a <run_until+0x5a>
    for (int i = 0; i < NPROC; i++)
 400:	31 c0                	xor    %eax,%eax
 402:	eb 0c                	jmp    410 <run_until+0x40>
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 408:	83 c0 01             	add    $0x1,%eax
 40b:	83 f8 40             	cmp    $0x40,%eax
 40e:	74 4b                	je     45b <run_until+0x8b>
        if (s->pid[i] == mypid)
 410:	3b 9c 87 00 02 00 00 	cmp    0x200(%edi,%eax,4),%ebx
 417:	75 ef                	jne    408 <run_until+0x38>
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");

        if (ps.rtime[my_idx] >= target_rtime)
 419:	39 b4 85 e8 fe ff ff 	cmp    %esi,-0x118(%ebp,%eax,4)
 420:	7c c6                	jl     3e8 <run_until+0x18>
            return;
    }
}
 422:	8d 65 f4             	lea    -0xc(%ebp),%esp
 425:	5b                   	pop    %ebx
 426:	5e                   	pop    %esi
 427:	5f                   	pop    %edi
 428:	5d                   	pop    %ebp
 429:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 42a:	51                   	push   %ecx
 42b:	68 88 0b 00 00       	push   $0xb88
 430:	68 92 0b 00 00       	push   $0xb92
 435:	6a 01                	push   $0x1
 437:	e8 24 04 00 00       	call   860 <printf>
 43c:	5b                   	pop    %ebx
 43d:	5e                   	pop    %esi
 43e:	68 97 0b 00 00       	push   $0xb97
 443:	6a 01                	push   $0x1
 445:	e8 16 04 00 00       	call   860 <printf>
 44a:	5f                   	pop    %edi
 44b:	58                   	pop    %eax
 44c:	68 a6 0b 00 00       	push   $0xba6
 451:	6a 01                	push   $0x1
 453:	e8 08 04 00 00       	call   860 <printf>
 458:	83 c4 10             	add    $0x10,%esp
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 45b:	83 ec 0c             	sub    $0xc,%esp
 45e:	6a 4b                	push   $0x4b
 460:	68 a8 0b 00 00       	push   $0xba8
 465:	68 88 0b 00 00       	push   $0xb88
 46a:	68 b6 0b 00 00       	push   $0xbb6
 46f:	6a 01                	push   $0x1
 471:	e8 ea 03 00 00       	call   860 <printf>
 476:	83 c4 18             	add    $0x18,%esp
 479:	68 d8 0b 00 00       	push   $0xbd8
 47e:	6a 01                	push   $0x1
 480:	e8 db 03 00 00       	call   860 <printf>
 485:	58                   	pop    %eax
 486:	5a                   	pop    %edx
 487:	68 a6 0b 00 00       	push   $0xba6
 48c:	6a 01                	push   $0x1
 48e:	e8 cd 03 00 00       	call   860 <printf>
 493:	e8 5b 02 00 00       	call   6f3 <exit>
 498:	66 90                	xchg   %ax,%ax
 49a:	66 90                	xchg   %ax,%ax
 49c:	66 90                	xchg   %ax,%ax
 49e:	66 90                	xchg   %ax,%ax

000004a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4a1:	31 c0                	xor    %eax,%eax
{
 4a3:	89 e5                	mov    %esp,%ebp
 4a5:	53                   	push   %ebx
 4a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 4b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 4b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 4b7:	83 c0 01             	add    $0x1,%eax
 4ba:	84 d2                	test   %dl,%dl
 4bc:	75 f2                	jne    4b0 <strcpy+0x10>
    ;
  return os;
}
 4be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c1:	89 c8                	mov    %ecx,%eax
 4c3:	c9                   	leave  
 4c4:	c3                   	ret    
 4c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 55 08             	mov    0x8(%ebp),%edx
 4d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4da:	0f b6 02             	movzbl (%edx),%eax
 4dd:	84 c0                	test   %al,%al
 4df:	75 17                	jne    4f8 <strcmp+0x28>
 4e1:	eb 3a                	jmp    51d <strcmp+0x4d>
 4e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e7:	90                   	nop
 4e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 4ec:	83 c2 01             	add    $0x1,%edx
 4ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 4f2:	84 c0                	test   %al,%al
 4f4:	74 1a                	je     510 <strcmp+0x40>
    p++, q++;
 4f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 4f8:	0f b6 19             	movzbl (%ecx),%ebx
 4fb:	38 c3                	cmp    %al,%bl
 4fd:	74 e9                	je     4e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 4ff:	29 d8                	sub    %ebx,%eax
}
 501:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 504:	c9                   	leave  
 505:	c3                   	ret    
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 510:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 514:	31 c0                	xor    %eax,%eax
 516:	29 d8                	sub    %ebx,%eax
}
 518:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 51b:	c9                   	leave  
 51c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 51d:	0f b6 19             	movzbl (%ecx),%ebx
 520:	31 c0                	xor    %eax,%eax
 522:	eb db                	jmp    4ff <strcmp+0x2f>
 524:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop

00000530 <strlen>:

uint
strlen(const char *s)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 536:	80 3a 00             	cmpb   $0x0,(%edx)
 539:	74 15                	je     550 <strlen+0x20>
 53b:	31 c0                	xor    %eax,%eax
 53d:	8d 76 00             	lea    0x0(%esi),%esi
 540:	83 c0 01             	add    $0x1,%eax
 543:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 547:	89 c1                	mov    %eax,%ecx
 549:	75 f5                	jne    540 <strlen+0x10>
    ;
  return n;
}
 54b:	89 c8                	mov    %ecx,%eax
 54d:	5d                   	pop    %ebp
 54e:	c3                   	ret    
 54f:	90                   	nop
  for(n = 0; s[n]; n++)
 550:	31 c9                	xor    %ecx,%ecx
}
 552:	5d                   	pop    %ebp
 553:	89 c8                	mov    %ecx,%eax
 555:	c3                   	ret    
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <memset>:

void*
memset(void *dst, int c, uint n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 567:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56a:	8b 45 0c             	mov    0xc(%ebp),%eax
 56d:	89 d7                	mov    %edx,%edi
 56f:	fc                   	cld    
 570:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 572:	8b 7d fc             	mov    -0x4(%ebp),%edi
 575:	89 d0                	mov    %edx,%eax
 577:	c9                   	leave  
 578:	c3                   	ret    
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000580 <strchr>:

char*
strchr(const char *s, char c)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 58a:	0f b6 10             	movzbl (%eax),%edx
 58d:	84 d2                	test   %dl,%dl
 58f:	75 12                	jne    5a3 <strchr+0x23>
 591:	eb 1d                	jmp    5b0 <strchr+0x30>
 593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 597:	90                   	nop
 598:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 59c:	83 c0 01             	add    $0x1,%eax
 59f:	84 d2                	test   %dl,%dl
 5a1:	74 0d                	je     5b0 <strchr+0x30>
    if(*s == c)
 5a3:	38 d1                	cmp    %dl,%cl
 5a5:	75 f1                	jne    598 <strchr+0x18>
      return (char*)s;
  return 0;
}
 5a7:	5d                   	pop    %ebp
 5a8:	c3                   	ret    
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 5b0:	31 c0                	xor    %eax,%eax
}
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop

000005c0 <gets>:

char*
gets(char *buf, int max)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 5c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 5c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 5c9:	31 db                	xor    %ebx,%ebx
{
 5cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 5ce:	eb 27                	jmp    5f7 <gets+0x37>
    cc = read(0, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	6a 01                	push   $0x1
 5d5:	57                   	push   %edi
 5d6:	6a 00                	push   $0x0
 5d8:	e8 2e 01 00 00       	call   70b <read>
    if(cc < 1)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	85 c0                	test   %eax,%eax
 5e2:	7e 1d                	jle    601 <gets+0x41>
      break;
    buf[i++] = c;
 5e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5e8:	8b 55 08             	mov    0x8(%ebp),%edx
 5eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 5ef:	3c 0a                	cmp    $0xa,%al
 5f1:	74 1d                	je     610 <gets+0x50>
 5f3:	3c 0d                	cmp    $0xd,%al
 5f5:	74 19                	je     610 <gets+0x50>
  for(i=0; i+1 < max; ){
 5f7:	89 de                	mov    %ebx,%esi
 5f9:	83 c3 01             	add    $0x1,%ebx
 5fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5ff:	7c cf                	jl     5d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 601:	8b 45 08             	mov    0x8(%ebp),%eax
 604:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 608:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60b:	5b                   	pop    %ebx
 60c:	5e                   	pop    %esi
 60d:	5f                   	pop    %edi
 60e:	5d                   	pop    %ebp
 60f:	c3                   	ret    
  buf[i] = '\0';
 610:	8b 45 08             	mov    0x8(%ebp),%eax
 613:	89 de                	mov    %ebx,%esi
 615:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 619:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61c:	5b                   	pop    %ebx
 61d:	5e                   	pop    %esi
 61e:	5f                   	pop    %edi
 61f:	5d                   	pop    %ebp
 620:	c3                   	ret    
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop

00000630 <stat>:

int
stat(const char *n, struct stat *st)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 635:	83 ec 08             	sub    $0x8,%esp
 638:	6a 00                	push   $0x0
 63a:	ff 75 08             	push   0x8(%ebp)
 63d:	e8 f1 00 00 00       	call   733 <open>
  if(fd < 0)
 642:	83 c4 10             	add    $0x10,%esp
 645:	85 c0                	test   %eax,%eax
 647:	78 27                	js     670 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	ff 75 0c             	push   0xc(%ebp)
 64f:	89 c3                	mov    %eax,%ebx
 651:	50                   	push   %eax
 652:	e8 f4 00 00 00       	call   74b <fstat>
  close(fd);
 657:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 65a:	89 c6                	mov    %eax,%esi
  close(fd);
 65c:	e8 ba 00 00 00       	call   71b <close>
  return r;
 661:	83 c4 10             	add    $0x10,%esp
}
 664:	8d 65 f8             	lea    -0x8(%ebp),%esp
 667:	89 f0                	mov    %esi,%eax
 669:	5b                   	pop    %ebx
 66a:	5e                   	pop    %esi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 670:	be ff ff ff ff       	mov    $0xffffffff,%esi
 675:	eb ed                	jmp    664 <stat+0x34>
 677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67e:	66 90                	xchg   %ax,%ax

00000680 <atoi>:

int
atoi(const char *s)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	53                   	push   %ebx
 684:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 687:	0f be 02             	movsbl (%edx),%eax
 68a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 68d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 690:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 695:	77 1e                	ja     6b5 <atoi+0x35>
 697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 6a0:	83 c2 01             	add    $0x1,%edx
 6a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 6a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 6aa:	0f be 02             	movsbl (%edx),%eax
 6ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 6b0:	80 fb 09             	cmp    $0x9,%bl
 6b3:	76 eb                	jbe    6a0 <atoi+0x20>
  return n;
}
 6b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b8:	89 c8                	mov    %ecx,%eax
 6ba:	c9                   	leave  
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	8b 45 10             	mov    0x10(%ebp),%eax
 6c7:	8b 55 08             	mov    0x8(%ebp),%edx
 6ca:	56                   	push   %esi
 6cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ce:	85 c0                	test   %eax,%eax
 6d0:	7e 13                	jle    6e5 <memmove+0x25>
 6d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 6d4:	89 d7                	mov    %edx,%edi
 6d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 6e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 6e1:	39 f8                	cmp    %edi,%eax
 6e3:	75 fb                	jne    6e0 <memmove+0x20>
  return vdst;
}
 6e5:	5e                   	pop    %esi
 6e6:	89 d0                	mov    %edx,%eax
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    

000006eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6eb:	b8 01 00 00 00       	mov    $0x1,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <exit>:
SYSCALL(exit)
 6f3:	b8 02 00 00 00       	mov    $0x2,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <wait>:
SYSCALL(wait)
 6fb:	b8 03 00 00 00       	mov    $0x3,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <pipe>:
SYSCALL(pipe)
 703:	b8 04 00 00 00       	mov    $0x4,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret    

0000070b <read>:
SYSCALL(read)
 70b:	b8 05 00 00 00       	mov    $0x5,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <write>:
SYSCALL(write)
 713:	b8 10 00 00 00       	mov    $0x10,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <close>:
SYSCALL(close)
 71b:	b8 15 00 00 00       	mov    $0x15,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    

00000723 <kill>:
SYSCALL(kill)
 723:	b8 06 00 00 00       	mov    $0x6,%eax
 728:	cd 40                	int    $0x40
 72a:	c3                   	ret    

0000072b <exec>:
SYSCALL(exec)
 72b:	b8 07 00 00 00       	mov    $0x7,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <open>:
SYSCALL(open)
 733:	b8 0f 00 00 00       	mov    $0xf,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <mknod>:
SYSCALL(mknod)
 73b:	b8 11 00 00 00       	mov    $0x11,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <unlink>:
SYSCALL(unlink)
 743:	b8 12 00 00 00       	mov    $0x12,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    

0000074b <fstat>:
SYSCALL(fstat)
 74b:	b8 08 00 00 00       	mov    $0x8,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <link>:
SYSCALL(link)
 753:	b8 13 00 00 00       	mov    $0x13,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <mkdir>:
SYSCALL(mkdir)
 75b:	b8 14 00 00 00       	mov    $0x14,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <chdir>:
SYSCALL(chdir)
 763:	b8 09 00 00 00       	mov    $0x9,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <dup>:
SYSCALL(dup)
 76b:	b8 0a 00 00 00       	mov    $0xa,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <getpid>:
SYSCALL(getpid)
 773:	b8 0b 00 00 00       	mov    $0xb,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <sbrk>:
SYSCALL(sbrk)
 77b:	b8 0c 00 00 00       	mov    $0xc,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <sleep>:
SYSCALL(sleep)
 783:	b8 0d 00 00 00       	mov    $0xd,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <uptime>:
SYSCALL(uptime)
 78b:	b8 0e 00 00 00       	mov    $0xe,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <settickets>:
SYSCALL(settickets)
 793:	b8 16 00 00 00       	mov    $0x16,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <getpinfo>:
SYSCALL(getpinfo)
 79b:	b8 17 00 00 00       	mov    $0x17,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    
 7a3:	66 90                	xchg   %ax,%ax
 7a5:	66 90                	xchg   %ax,%ax
 7a7:	66 90                	xchg   %ax,%ax
 7a9:	66 90                	xchg   %ax,%ax
 7ab:	66 90                	xchg   %ax,%ax
 7ad:	66 90                	xchg   %ax,%ax
 7af:	90                   	nop

000007b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 3c             	sub    $0x3c,%esp
 7b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 7bc:	89 d1                	mov    %edx,%ecx
{
 7be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 7c1:	85 d2                	test   %edx,%edx
 7c3:	0f 89 7f 00 00 00    	jns    848 <printint+0x98>
 7c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7cd:	74 79                	je     848 <printint+0x98>
    neg = 1;
 7cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 7d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 7d8:	31 db                	xor    %ebx,%ebx
 7da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 7e0:	89 c8                	mov    %ecx,%eax
 7e2:	31 d2                	xor    %edx,%edx
 7e4:	89 cf                	mov    %ecx,%edi
 7e6:	f7 75 c4             	divl   -0x3c(%ebp)
 7e9:	0f b6 92 10 0e 00 00 	movzbl 0xe10(%edx),%edx
 7f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 7f3:	89 d8                	mov    %ebx,%eax
 7f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 7f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 7fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 7fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 801:	76 dd                	jbe    7e0 <printint+0x30>
  if(neg)
 803:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 806:	85 c9                	test   %ecx,%ecx
 808:	74 0c                	je     816 <printint+0x66>
    buf[i++] = '-';
 80a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 80f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 811:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 816:	8b 7d b8             	mov    -0x48(%ebp),%edi
 819:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 81d:	eb 07                	jmp    826 <printint+0x76>
 81f:	90                   	nop
    putc(fd, buf[i]);
 820:	0f b6 13             	movzbl (%ebx),%edx
 823:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 826:	83 ec 04             	sub    $0x4,%esp
 829:	88 55 d7             	mov    %dl,-0x29(%ebp)
 82c:	6a 01                	push   $0x1
 82e:	56                   	push   %esi
 82f:	57                   	push   %edi
 830:	e8 de fe ff ff       	call   713 <write>
  while(--i >= 0)
 835:	83 c4 10             	add    $0x10,%esp
 838:	39 de                	cmp    %ebx,%esi
 83a:	75 e4                	jne    820 <printint+0x70>
}
 83c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 83f:	5b                   	pop    %ebx
 840:	5e                   	pop    %esi
 841:	5f                   	pop    %edi
 842:	5d                   	pop    %ebp
 843:	c3                   	ret    
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 848:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 84f:	eb 87                	jmp    7d8 <printint+0x28>
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85f:	90                   	nop

00000860 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 869:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 86c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 86f:	0f b6 13             	movzbl (%ebx),%edx
 872:	84 d2                	test   %dl,%dl
 874:	74 6a                	je     8e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 876:	8d 45 10             	lea    0x10(%ebp),%eax
 879:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 87c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 87f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 881:	89 45 d0             	mov    %eax,-0x30(%ebp)
 884:	eb 36                	jmp    8bc <printf+0x5c>
 886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 893:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 898:	83 f8 25             	cmp    $0x25,%eax
 89b:	74 15                	je     8b2 <printf+0x52>
  write(fd, &c, 1);
 89d:	83 ec 04             	sub    $0x4,%esp
 8a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8a3:	6a 01                	push   $0x1
 8a5:	57                   	push   %edi
 8a6:	56                   	push   %esi
 8a7:	e8 67 fe ff ff       	call   713 <write>
 8ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 8af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8b2:	0f b6 13             	movzbl (%ebx),%edx
 8b5:	83 c3 01             	add    $0x1,%ebx
 8b8:	84 d2                	test   %dl,%dl
 8ba:	74 24                	je     8e0 <printf+0x80>
    c = fmt[i] & 0xff;
 8bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 8bf:	85 c9                	test   %ecx,%ecx
 8c1:	74 cd                	je     890 <printf+0x30>
      }
    } else if(state == '%'){
 8c3:	83 f9 25             	cmp    $0x25,%ecx
 8c6:	75 ea                	jne    8b2 <printf+0x52>
      if(c == 'd'){
 8c8:	83 f8 25             	cmp    $0x25,%eax
 8cb:	0f 84 07 01 00 00    	je     9d8 <printf+0x178>
 8d1:	83 e8 63             	sub    $0x63,%eax
 8d4:	83 f8 15             	cmp    $0x15,%eax
 8d7:	77 17                	ja     8f0 <printf+0x90>
 8d9:	ff 24 85 b8 0d 00 00 	jmp    *0xdb8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop
  write(fd, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 8f6:	6a 01                	push   $0x1
 8f8:	57                   	push   %edi
 8f9:	56                   	push   %esi
 8fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8fe:	e8 10 fe ff ff       	call   713 <write>
        putc(fd, c);
 903:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 907:	83 c4 0c             	add    $0xc,%esp
 90a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 90d:	6a 01                	push   $0x1
 90f:	57                   	push   %edi
 910:	56                   	push   %esi
 911:	e8 fd fd ff ff       	call   713 <write>
        putc(fd, c);
 916:	83 c4 10             	add    $0x10,%esp
      state = 0;
 919:	31 c9                	xor    %ecx,%ecx
 91b:	eb 95                	jmp    8b2 <printf+0x52>
 91d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 10 00 00 00       	mov    $0x10,%ecx
 928:	6a 00                	push   $0x0
 92a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 92d:	8b 10                	mov    (%eax),%edx
 92f:	89 f0                	mov    %esi,%eax
 931:	e8 7a fe ff ff       	call   7b0 <printint>
        ap++;
 936:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 93a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 93d:	31 c9                	xor    %ecx,%ecx
 93f:	e9 6e ff ff ff       	jmp    8b2 <printf+0x52>
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 948:	8b 45 d0             	mov    -0x30(%ebp),%eax
 94b:	8b 10                	mov    (%eax),%edx
        ap++;
 94d:	83 c0 04             	add    $0x4,%eax
 950:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 953:	85 d2                	test   %edx,%edx
 955:	0f 84 8d 00 00 00    	je     9e8 <printf+0x188>
        while(*s != 0){
 95b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 95e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 960:	84 c0                	test   %al,%al
 962:	0f 84 4a ff ff ff    	je     8b2 <printf+0x52>
 968:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 96b:	89 d3                	mov    %edx,%ebx
 96d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 970:	83 ec 04             	sub    $0x4,%esp
          s++;
 973:	83 c3 01             	add    $0x1,%ebx
 976:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 979:	6a 01                	push   $0x1
 97b:	57                   	push   %edi
 97c:	56                   	push   %esi
 97d:	e8 91 fd ff ff       	call   713 <write>
        while(*s != 0){
 982:	0f b6 03             	movzbl (%ebx),%eax
 985:	83 c4 10             	add    $0x10,%esp
 988:	84 c0                	test   %al,%al
 98a:	75 e4                	jne    970 <printf+0x110>
      state = 0;
 98c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 98f:	31 c9                	xor    %ecx,%ecx
 991:	e9 1c ff ff ff       	jmp    8b2 <printf+0x52>
 996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9a8:	6a 01                	push   $0x1
 9aa:	e9 7b ff ff ff       	jmp    92a <printf+0xca>
 9af:	90                   	nop
        putc(fd, *ap);
 9b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 9b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 9b8:	6a 01                	push   $0x1
 9ba:	57                   	push   %edi
 9bb:	56                   	push   %esi
        putc(fd, *ap);
 9bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9bf:	e8 4f fd ff ff       	call   713 <write>
        ap++;
 9c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9cb:	31 c9                	xor    %ecx,%ecx
 9cd:	e9 e0 fe ff ff       	jmp    8b2 <printf+0x52>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 9d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 9db:	83 ec 04             	sub    $0x4,%esp
 9de:	e9 2a ff ff ff       	jmp    90d <printf+0xad>
 9e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9e7:	90                   	nop
          s = "(null)";
 9e8:	ba b0 0d 00 00       	mov    $0xdb0,%edx
        while(*s != 0){
 9ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9f0:	b8 28 00 00 00       	mov    $0x28,%eax
 9f5:	89 d3                	mov    %edx,%ebx
 9f7:	e9 74 ff ff ff       	jmp    970 <printf+0x110>
 9fc:	66 90                	xchg   %ax,%ax
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a01:	a1 2c 11 00 00       	mov    0x112c,%eax
{
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a18:	89 c2                	mov    %eax,%edx
 a1a:	8b 00                	mov    (%eax),%eax
 a1c:	39 ca                	cmp    %ecx,%edx
 a1e:	73 30                	jae    a50 <free+0x50>
 a20:	39 c1                	cmp    %eax,%ecx
 a22:	72 04                	jb     a28 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a24:	39 c2                	cmp    %eax,%edx
 a26:	72 f0                	jb     a18 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a28:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a2b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a2e:	39 f8                	cmp    %edi,%eax
 a30:	74 30                	je     a62 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a32:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a35:	8b 42 04             	mov    0x4(%edx),%eax
 a38:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a3b:	39 f1                	cmp    %esi,%ecx
 a3d:	74 3a                	je     a79 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a3f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a41:	5b                   	pop    %ebx
  freep = p;
 a42:	89 15 2c 11 00 00    	mov    %edx,0x112c
}
 a48:	5e                   	pop    %esi
 a49:	5f                   	pop    %edi
 a4a:	5d                   	pop    %ebp
 a4b:	c3                   	ret    
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a50:	39 c2                	cmp    %eax,%edx
 a52:	72 c4                	jb     a18 <free+0x18>
 a54:	39 c1                	cmp    %eax,%ecx
 a56:	73 c0                	jae    a18 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 a58:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a5b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a5e:	39 f8                	cmp    %edi,%eax
 a60:	75 d0                	jne    a32 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 a62:	03 70 04             	add    0x4(%eax),%esi
 a65:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a68:	8b 02                	mov    (%edx),%eax
 a6a:	8b 00                	mov    (%eax),%eax
 a6c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a6f:	8b 42 04             	mov    0x4(%edx),%eax
 a72:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a75:	39 f1                	cmp    %esi,%ecx
 a77:	75 c6                	jne    a3f <free+0x3f>
    p->s.size += bp->s.size;
 a79:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 a7c:	89 15 2c 11 00 00    	mov    %edx,0x112c
    p->s.size += bp->s.size;
 a82:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a85:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a88:	89 0a                	mov    %ecx,(%edx)
}
 a8a:	5b                   	pop    %ebx
 a8b:	5e                   	pop    %esi
 a8c:	5f                   	pop    %edi
 a8d:	5d                   	pop    %ebp
 a8e:	c3                   	ret    
 a8f:	90                   	nop

00000a90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a9c:	8b 3d 2c 11 00 00    	mov    0x112c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa2:	8d 70 07             	lea    0x7(%eax),%esi
 aa5:	c1 ee 03             	shr    $0x3,%esi
 aa8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 aab:	85 ff                	test   %edi,%edi
 aad:	0f 84 9d 00 00 00    	je     b50 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 ab5:	8b 4a 04             	mov    0x4(%edx),%ecx
 ab8:	39 f1                	cmp    %esi,%ecx
 aba:	73 6a                	jae    b26 <malloc+0x96>
 abc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac1:	39 de                	cmp    %ebx,%esi
 ac3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 ac6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 acd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ad0:	eb 17                	jmp    ae9 <malloc+0x59>
 ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f1                	cmp    %esi,%ecx
 adf:	73 4f                	jae    b30 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae1:	8b 3d 2c 11 00 00    	mov    0x112c,%edi
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	39 d7                	cmp    %edx,%edi
 aeb:	75 eb                	jne    ad8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 aed:	83 ec 0c             	sub    $0xc,%esp
 af0:	ff 75 e4             	push   -0x1c(%ebp)
 af3:	e8 83 fc ff ff       	call   77b <sbrk>
  if(p == (char*)-1)
 af8:	83 c4 10             	add    $0x10,%esp
 afb:	83 f8 ff             	cmp    $0xffffffff,%eax
 afe:	74 1c                	je     b1c <malloc+0x8c>
  hp->s.size = nu;
 b00:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b03:	83 ec 0c             	sub    $0xc,%esp
 b06:	83 c0 08             	add    $0x8,%eax
 b09:	50                   	push   %eax
 b0a:	e8 f1 fe ff ff       	call   a00 <free>
  return freep;
 b0f:	8b 15 2c 11 00 00    	mov    0x112c,%edx
      if((p = morecore(nunits)) == 0)
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	85 d2                	test   %edx,%edx
 b1a:	75 bc                	jne    ad8 <malloc+0x48>
        return 0;
  }
}
 b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b1f:	31 c0                	xor    %eax,%eax
}
 b21:	5b                   	pop    %ebx
 b22:	5e                   	pop    %esi
 b23:	5f                   	pop    %edi
 b24:	5d                   	pop    %ebp
 b25:	c3                   	ret    
    if(p->s.size >= nunits){
 b26:	89 d0                	mov    %edx,%eax
 b28:	89 fa                	mov    %edi,%edx
 b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b30:	39 ce                	cmp    %ecx,%esi
 b32:	74 4c                	je     b80 <malloc+0xf0>
        p->s.size -= nunits;
 b34:	29 f1                	sub    %esi,%ecx
 b36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b3c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 b3f:	89 15 2c 11 00 00    	mov    %edx,0x112c
}
 b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b48:	83 c0 08             	add    $0x8,%eax
}
 b4b:	5b                   	pop    %ebx
 b4c:	5e                   	pop    %esi
 b4d:	5f                   	pop    %edi
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 b50:	c7 05 2c 11 00 00 30 	movl   $0x1130,0x112c
 b57:	11 00 00 
    base.s.size = 0;
 b5a:	bf 30 11 00 00       	mov    $0x1130,%edi
    base.s.ptr = freep = prevp = &base;
 b5f:	c7 05 30 11 00 00 30 	movl   $0x1130,0x1130
 b66:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b69:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 b6b:	c7 05 34 11 00 00 00 	movl   $0x0,0x1134
 b72:	00 00 00 
    if(p->s.size >= nunits){
 b75:	e9 42 ff ff ff       	jmp    abc <malloc+0x2c>
 b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b9                	jmp    b3f <malloc+0xaf>
