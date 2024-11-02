
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
  19:	e8 f5 06 00 00       	call   713 <settickets>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	83 f8 ff             	cmp    $0xffffffff,%eax
  24:	0f 84 9a 00 00 00    	je     c4 <main+0xc4>

    int pid = fork();
  2a:	e8 3c 06 00 00       	call   66b <fork>
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
  8c:	68 2c 0b 00 00       	push   $0xb2c
  91:	68 16 0b 00 00       	push   $0xb16
  96:	68 20 0b 00 00       	push   $0xb20
  9b:	6a 01                	push   $0x1
  9d:	e8 3e 07 00 00       	call   7e0 <printf>
  a2:	83 c4 20             	add    $0x20,%esp
  a5:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
  ac:	6a 08                	push   $0x8
  ae:	68 dc 0b 00 00       	push   $0xbdc
  b3:	eb 32                	jmp    e7 <main+0xe7>
        run_until(rt);
  b5:	b8 e8 03 00 00       	mov    $0x3e8,%eax
  ba:	e8 c1 02 00 00       	call   380 <run_until>
        exit();
  bf:	e8 af 05 00 00       	call   673 <exit>
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  c4:	83 ec 0c             	sub    $0xc,%esp
  c7:	6a 0d                	push   $0xd
  c9:	68 2c 0b 00 00       	push   $0xb2c
  ce:	68 16 0b 00 00       	push   $0xb16
  d3:	68 20 0b 00 00       	push   $0xb20
  d8:	6a 01                	push   $0x1
  da:	e8 01 07 00 00       	call   7e0 <printf>
  df:	83 c4 18             	add    $0x18,%esp
  e2:	68 78 0b 00 00       	push   $0xb78
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  e7:	6a 01                	push   $0x1
  e9:	e8 f2 06 00 00       	call   7e0 <printf>
  ee:	5b                   	pop    %ebx
  ef:	5e                   	pop    %esi
  f0:	68 2a 0b 00 00       	push   $0xb2a
  f5:	6a 01                	push   $0x1
  f7:	e8 e4 06 00 00       	call   7e0 <printf>
  fc:	e8 72 05 00 00       	call   673 <exit>
    ASSERT(ps.tickets[my_idx] == pa_tickets, "Parent tickets should be set to %d, \
 101:	83 ec 0c             	sub    $0xc,%esp
 104:	6a 23                	push   $0x23
 106:	68 2c 0b 00 00       	push   $0xb2c
 10b:	68 16 0b 00 00       	push   $0xb16
 110:	68 20 0b 00 00       	push   $0xb20
 115:	6a 01                	push   $0x1
 117:	e8 c4 06 00 00       	call   7e0 <printf>
 11c:	83 c4 20             	add    $0x20,%esp
 11f:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 126:	6a 04                	push   $0x4
 128:	68 9c 0b 00 00       	push   $0xb9c
 12d:	eb b8                	jmp    e7 <main+0xe7>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 12f:	83 ec 0c             	sub    $0xc,%esp
 132:	6a 1f                	push   $0x1f
 134:	68 2c 0b 00 00       	push   $0xb2c
 139:	68 16 0b 00 00       	push   $0xb16
 13e:	68 20 0b 00 00       	push   $0xb20
 143:	6a 01                	push   $0x1
 145:	e8 96 06 00 00       	call   7e0 <printf>
 14a:	83 c4 18             	add    $0x18,%esp
 14d:	68 4c 0b 00 00       	push   $0xb4c
 152:	eb 93                	jmp    e7 <main+0xe7>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	6a 21                	push   $0x21
 159:	68 2c 0b 00 00       	push   $0xb2c
 15e:	68 16 0b 00 00       	push   $0xb16
 163:	68 20 0b 00 00       	push   $0xb20
 168:	6a 01                	push   $0x1
 16a:	e8 71 06 00 00       	call   7e0 <printf>
 16f:	83 c4 18             	add    $0x18,%esp
 172:	68 f4 0c 00 00       	push   $0xcf4
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
 1a7:	e8 d4 01 00 00       	call   380 <run_until>

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
 238:	68 2c 0b 00 00       	push   $0xb2c
 23d:	68 16 0b 00 00       	push   $0xb16
 242:	68 20 0b 00 00       	push   $0xb20
 247:	6a 01                	push   $0x1
 249:	e8 92 05 00 00       	call   7e0 <printf>
 24e:	83 c4 14             	add    $0x14,%esp
 251:	6a 02                	push   $0x2
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	68 8c 0c 00 00       	push   $0xc8c
 25a:	6a 01                	push   $0x1
 25c:	e8 7f 05 00 00       	call   7e0 <printf>
 261:	83 c4 18             	add    $0x18,%esp
 264:	68 2a 0b 00 00       	push   $0xb2a
 269:	6a 01                	push   $0x1
 26b:	e8 70 05 00 00       	call   7e0 <printf>
 270:	e8 fe 03 00 00       	call   673 <exit>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 275:	83 ec 0c             	sub    $0xc,%esp
 278:	6a 3c                	push   $0x3c
 27a:	68 2c 0b 00 00       	push   $0xb2c
 27f:	68 16 0b 00 00       	push   $0xb16
 284:	68 20 0b 00 00       	push   $0xb20
 289:	6a 01                	push   $0x1
 28b:	e8 50 05 00 00       	call   7e0 <printf>
 290:	83 c4 20             	add    $0x20,%esp
 293:	53                   	push   %ebx
 294:	56                   	push   %esi
 295:	68 18 0c 00 00       	push   $0xc18
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
 2be:	68 2c 0b 00 00       	push   $0xb2c
 2c3:	68 16 0b 00 00       	push   $0xb16
 2c8:	68 20 0b 00 00       	push   $0xb20
 2cd:	6a 01                	push   $0x1
 2cf:	e8 0c 05 00 00       	call   7e0 <printf>
 2d4:	8b 85 e0 f8 ff ff    	mov    -0x720(%ebp),%eax
 2da:	83 c4 20             	add    $0x20,%esp
 2dd:	50                   	push   %eax
 2de:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 2e4:	68 50 0c 00 00       	push   $0xc50
 2e9:	e9 f9 fd ff ff       	jmp    e7 <main+0xe7>
    return -1;
}

#define SUCCESS_MSG "TEST PASSED"
static void test_passed() {
    PRINTF("%s", SUCCESS_MSG);
 2ee:	50                   	push   %eax
 2ef:	68 16 0b 00 00       	push   $0xb16
 2f4:	68 35 0b 00 00       	push   $0xb35
 2f9:	6a 01                	push   $0x1
 2fb:	e8 e0 04 00 00       	call   7e0 <printf>
 300:	83 c4 0c             	add    $0xc,%esp
 303:	68 3a 0b 00 00       	push   $0xb3a
 308:	68 46 0b 00 00       	push   $0xb46
 30d:	6a 01                	push   $0x1
 30f:	e8 cc 04 00 00       	call   7e0 <printf>
 314:	5a                   	pop    %edx
 315:	59                   	pop    %ecx
 316:	68 2a 0b 00 00       	push   $0xb2a
 31b:	6a 01                	push   $0x1
 31d:	e8 be 04 00 00       	call   7e0 <printf>
%d margin of half the child ticks", diff_rtime, diff_ch_rtime, margin);


    test_passed();

    wait();
 322:	e8 54 03 00 00       	call   67b <wait>

    exit();
 327:	e8 47 03 00 00       	call   673 <exit>
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <find_my_stats_index>:
static int find_my_stats_index(struct pstat *s) {
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	89 c3                	mov    %eax,%ebx
    int mypid = getpid();
 337:	e8 b7 03 00 00       	call   6f3 <getpid>
    if (getpinfo(s) == -1)
 33c:	83 ec 0c             	sub    $0xc,%esp
 33f:	53                   	push   %ebx
    int mypid = getpid();
 340:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1)
 342:	e8 d4 03 00 00       	call   71b <getpinfo>
 347:	83 c4 10             	add    $0x10,%esp
 34a:	83 f8 ff             	cmp    $0xffffffff,%eax
 34d:	74 1a                	je     369 <find_my_stats_index+0x39>
    for (int i = 0; i < NPROC; i++)
 34f:	31 c0                	xor    %eax,%eax
 351:	eb 0d                	jmp    360 <find_my_stats_index+0x30>
 353:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 357:	90                   	nop
 358:	83 c0 01             	add    $0x1,%eax
 35b:	83 f8 40             	cmp    $0x40,%eax
 35e:	74 10                	je     370 <find_my_stats_index+0x40>
        if (s->pid[i] == mypid)
 360:	39 b4 83 00 02 00 00 	cmp    %esi,0x200(%ebx,%eax,4)
 367:	75 ef                	jne    358 <find_my_stats_index+0x28>
}
 369:	8d 65 f8             	lea    -0x8(%ebp),%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    
 370:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
 373:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 378:	5b                   	pop    %ebx
 379:	5e                   	pop    %esi
 37a:	5d                   	pop    %ebp
 37b:	c3                   	ret    
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <run_until>:

/*
 * Run at least until the specified target rtime
 * Might immediately return if the rtime is already reached
 */
static __attribute__((unused)) void run_until(int target_rtime) {
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	8d bd e8 f8 ff ff    	lea    -0x718(%ebp),%edi
 38b:	89 c6                	mov    %eax,%esi
 38d:	53                   	push   %ebx
 38e:	81 ec 0c 07 00 00    	sub    $0x70c,%esp
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int mypid = getpid();
 398:	e8 56 03 00 00       	call   6f3 <getpid>
    if (getpinfo(s) == -1)
 39d:	83 ec 0c             	sub    $0xc,%esp
 3a0:	57                   	push   %edi
    int mypid = getpid();
 3a1:	89 c3                	mov    %eax,%ebx
    if (getpinfo(s) == -1)
 3a3:	e8 73 03 00 00       	call   71b <getpinfo>
 3a8:	83 c4 10             	add    $0x10,%esp
 3ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 3ae:	74 2a                	je     3da <run_until+0x5a>
    for (int i = 0; i < NPROC; i++)
 3b0:	31 c0                	xor    %eax,%eax
 3b2:	eb 0c                	jmp    3c0 <run_until+0x40>
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b8:	83 c0 01             	add    $0x1,%eax
 3bb:	83 f8 40             	cmp    $0x40,%eax
 3be:	74 1a                	je     3da <run_until+0x5a>
        if (s->pid[i] == mypid)
 3c0:	3b 9c 87 00 02 00 00 	cmp    0x200(%edi,%eax,4),%ebx
 3c7:	75 ef                	jne    3b8 <run_until+0x38>
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");

        if (ps.rtime[my_idx] >= target_rtime)
 3c9:	39 b4 85 e8 fe ff ff 	cmp    %esi,-0x118(%ebp,%eax,4)
 3d0:	7c c6                	jl     398 <run_until+0x18>
            return;
    }
}
 3d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d5:	5b                   	pop    %ebx
 3d6:	5e                   	pop    %esi
 3d7:	5f                   	pop    %edi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 3da:	83 ec 0c             	sub    $0xc,%esp
 3dd:	6a 48                	push   $0x48
 3df:	68 08 0b 00 00       	push   $0xb08
 3e4:	68 16 0b 00 00       	push   $0xb16
 3e9:	68 20 0b 00 00       	push   $0xb20
 3ee:	6a 01                	push   $0x1
 3f0:	e8 eb 03 00 00       	call   7e0 <printf>
 3f5:	83 c4 18             	add    $0x18,%esp
 3f8:	68 4c 0b 00 00       	push   $0xb4c
 3fd:	6a 01                	push   $0x1
 3ff:	e8 dc 03 00 00       	call   7e0 <printf>
 404:	58                   	pop    %eax
 405:	5a                   	pop    %edx
 406:	68 2a 0b 00 00       	push   $0xb2a
 40b:	6a 01                	push   $0x1
 40d:	e8 ce 03 00 00       	call   7e0 <printf>
 412:	e8 5c 02 00 00       	call   673 <exit>
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 420:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 421:	31 c0                	xor    %eax,%eax
{
 423:	89 e5                	mov    %esp,%ebp
 425:	53                   	push   %ebx
 426:	8b 4d 08             	mov    0x8(%ebp),%ecx
 429:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 430:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 434:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 437:	83 c0 01             	add    $0x1,%eax
 43a:	84 d2                	test   %dl,%dl
 43c:	75 f2                	jne    430 <strcpy+0x10>
    ;
  return os;
}
 43e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 441:	89 c8                	mov    %ecx,%eax
 443:	c9                   	leave  
 444:	c3                   	ret    
 445:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000450 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 55 08             	mov    0x8(%ebp),%edx
 457:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 45a:	0f b6 02             	movzbl (%edx),%eax
 45d:	84 c0                	test   %al,%al
 45f:	75 17                	jne    478 <strcmp+0x28>
 461:	eb 3a                	jmp    49d <strcmp+0x4d>
 463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 467:	90                   	nop
 468:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 46c:	83 c2 01             	add    $0x1,%edx
 46f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 472:	84 c0                	test   %al,%al
 474:	74 1a                	je     490 <strcmp+0x40>
    p++, q++;
 476:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 478:	0f b6 19             	movzbl (%ecx),%ebx
 47b:	38 c3                	cmp    %al,%bl
 47d:	74 e9                	je     468 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 47f:	29 d8                	sub    %ebx,%eax
}
 481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 484:	c9                   	leave  
 485:	c3                   	ret    
 486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 490:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 494:	31 c0                	xor    %eax,%eax
 496:	29 d8                	sub    %ebx,%eax
}
 498:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 49b:	c9                   	leave  
 49c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 49d:	0f b6 19             	movzbl (%ecx),%ebx
 4a0:	31 c0                	xor    %eax,%eax
 4a2:	eb db                	jmp    47f <strcmp+0x2f>
 4a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop

000004b0 <strlen>:

uint
strlen(const char *s)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 4b6:	80 3a 00             	cmpb   $0x0,(%edx)
 4b9:	74 15                	je     4d0 <strlen+0x20>
 4bb:	31 c0                	xor    %eax,%eax
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	83 c0 01             	add    $0x1,%eax
 4c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 4c7:	89 c1                	mov    %eax,%ecx
 4c9:	75 f5                	jne    4c0 <strlen+0x10>
    ;
  return n;
}
 4cb:	89 c8                	mov    %ecx,%eax
 4cd:	5d                   	pop    %ebp
 4ce:	c3                   	ret    
 4cf:	90                   	nop
  for(n = 0; s[n]; n++)
 4d0:	31 c9                	xor    %ecx,%ecx
}
 4d2:	5d                   	pop    %ebp
 4d3:	89 c8                	mov    %ecx,%eax
 4d5:	c3                   	ret    
 4d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ed:	89 d7                	mov    %edx,%edi
 4ef:	fc                   	cld    
 4f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 4f5:	89 d0                	mov    %edx,%eax
 4f7:	c9                   	leave  
 4f8:	c3                   	ret    
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000500 <strchr>:

char*
strchr(const char *s, char c)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	8b 45 08             	mov    0x8(%ebp),%eax
 506:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 50a:	0f b6 10             	movzbl (%eax),%edx
 50d:	84 d2                	test   %dl,%dl
 50f:	75 12                	jne    523 <strchr+0x23>
 511:	eb 1d                	jmp    530 <strchr+0x30>
 513:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 517:	90                   	nop
 518:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 51c:	83 c0 01             	add    $0x1,%eax
 51f:	84 d2                	test   %dl,%dl
 521:	74 0d                	je     530 <strchr+0x30>
    if(*s == c)
 523:	38 d1                	cmp    %dl,%cl
 525:	75 f1                	jne    518 <strchr+0x18>
      return (char*)s;
  return 0;
}
 527:	5d                   	pop    %ebp
 528:	c3                   	ret    
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 530:	31 c0                	xor    %eax,%eax
}
 532:	5d                   	pop    %ebp
 533:	c3                   	ret    
 534:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop

00000540 <gets>:

char*
gets(char *buf, int max)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 545:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 548:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 549:	31 db                	xor    %ebx,%ebx
{
 54b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 54e:	eb 27                	jmp    577 <gets+0x37>
    cc = read(0, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	6a 00                	push   $0x0
 558:	e8 2e 01 00 00       	call   68b <read>
    if(cc < 1)
 55d:	83 c4 10             	add    $0x10,%esp
 560:	85 c0                	test   %eax,%eax
 562:	7e 1d                	jle    581 <gets+0x41>
      break;
    buf[i++] = c;
 564:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 568:	8b 55 08             	mov    0x8(%ebp),%edx
 56b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 56f:	3c 0a                	cmp    $0xa,%al
 571:	74 1d                	je     590 <gets+0x50>
 573:	3c 0d                	cmp    $0xd,%al
 575:	74 19                	je     590 <gets+0x50>
  for(i=0; i+1 < max; ){
 577:	89 de                	mov    %ebx,%esi
 579:	83 c3 01             	add    $0x1,%ebx
 57c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 57f:	7c cf                	jl     550 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 581:	8b 45 08             	mov    0x8(%ebp),%eax
 584:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 588:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58b:	5b                   	pop    %ebx
 58c:	5e                   	pop    %esi
 58d:	5f                   	pop    %edi
 58e:	5d                   	pop    %ebp
 58f:	c3                   	ret    
  buf[i] = '\0';
 590:	8b 45 08             	mov    0x8(%ebp),%eax
 593:	89 de                	mov    %ebx,%esi
 595:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 599:	8d 65 f4             	lea    -0xc(%ebp),%esp
 59c:	5b                   	pop    %ebx
 59d:	5e                   	pop    %esi
 59e:	5f                   	pop    %edi
 59f:	5d                   	pop    %ebp
 5a0:	c3                   	ret    
 5a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	56                   	push   %esi
 5b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5b5:	83 ec 08             	sub    $0x8,%esp
 5b8:	6a 00                	push   $0x0
 5ba:	ff 75 08             	push   0x8(%ebp)
 5bd:	e8 f1 00 00 00       	call   6b3 <open>
  if(fd < 0)
 5c2:	83 c4 10             	add    $0x10,%esp
 5c5:	85 c0                	test   %eax,%eax
 5c7:	78 27                	js     5f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5c9:	83 ec 08             	sub    $0x8,%esp
 5cc:	ff 75 0c             	push   0xc(%ebp)
 5cf:	89 c3                	mov    %eax,%ebx
 5d1:	50                   	push   %eax
 5d2:	e8 f4 00 00 00       	call   6cb <fstat>
  close(fd);
 5d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5da:	89 c6                	mov    %eax,%esi
  close(fd);
 5dc:	e8 ba 00 00 00       	call   69b <close>
  return r;
 5e1:	83 c4 10             	add    $0x10,%esp
}
 5e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5e7:	89 f0                	mov    %esi,%eax
 5e9:	5b                   	pop    %ebx
 5ea:	5e                   	pop    %esi
 5eb:	5d                   	pop    %ebp
 5ec:	c3                   	ret    
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 5f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5f5:	eb ed                	jmp    5e4 <stat+0x34>
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax

00000600 <atoi>:

int
atoi(const char *s)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	53                   	push   %ebx
 604:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 607:	0f be 02             	movsbl (%edx),%eax
 60a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 60d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 610:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 615:	77 1e                	ja     635 <atoi+0x35>
 617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 620:	83 c2 01             	add    $0x1,%edx
 623:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 626:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 62a:	0f be 02             	movsbl (%edx),%eax
 62d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 630:	80 fb 09             	cmp    $0x9,%bl
 633:	76 eb                	jbe    620 <atoi+0x20>
  return n;
}
 635:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 638:	89 c8                	mov    %ecx,%eax
 63a:	c9                   	leave  
 63b:	c3                   	ret    
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	8b 45 10             	mov    0x10(%ebp),%eax
 647:	8b 55 08             	mov    0x8(%ebp),%edx
 64a:	56                   	push   %esi
 64b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 64e:	85 c0                	test   %eax,%eax
 650:	7e 13                	jle    665 <memmove+0x25>
 652:	01 d0                	add    %edx,%eax
  dst = vdst;
 654:	89 d7                	mov    %edx,%edi
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 660:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 661:	39 f8                	cmp    %edi,%eax
 663:	75 fb                	jne    660 <memmove+0x20>
  return vdst;
}
 665:	5e                   	pop    %esi
 666:	89 d0                	mov    %edx,%eax
 668:	5f                   	pop    %edi
 669:	5d                   	pop    %ebp
 66a:	c3                   	ret    

0000066b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 66b:	b8 01 00 00 00       	mov    $0x1,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <exit>:
SYSCALL(exit)
 673:	b8 02 00 00 00       	mov    $0x2,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <wait>:
SYSCALL(wait)
 67b:	b8 03 00 00 00       	mov    $0x3,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <pipe>:
SYSCALL(pipe)
 683:	b8 04 00 00 00       	mov    $0x4,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <read>:
SYSCALL(read)
 68b:	b8 05 00 00 00       	mov    $0x5,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <write>:
SYSCALL(write)
 693:	b8 10 00 00 00       	mov    $0x10,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    

0000069b <close>:
SYSCALL(close)
 69b:	b8 15 00 00 00       	mov    $0x15,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret    

000006a3 <kill>:
SYSCALL(kill)
 6a3:	b8 06 00 00 00       	mov    $0x6,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret    

000006ab <exec>:
SYSCALL(exec)
 6ab:	b8 07 00 00 00       	mov    $0x7,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret    

000006b3 <open>:
SYSCALL(open)
 6b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret    

000006bb <mknod>:
SYSCALL(mknod)
 6bb:	b8 11 00 00 00       	mov    $0x11,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret    

000006c3 <unlink>:
SYSCALL(unlink)
 6c3:	b8 12 00 00 00       	mov    $0x12,%eax
 6c8:	cd 40                	int    $0x40
 6ca:	c3                   	ret    

000006cb <fstat>:
SYSCALL(fstat)
 6cb:	b8 08 00 00 00       	mov    $0x8,%eax
 6d0:	cd 40                	int    $0x40
 6d2:	c3                   	ret    

000006d3 <link>:
SYSCALL(link)
 6d3:	b8 13 00 00 00       	mov    $0x13,%eax
 6d8:	cd 40                	int    $0x40
 6da:	c3                   	ret    

000006db <mkdir>:
SYSCALL(mkdir)
 6db:	b8 14 00 00 00       	mov    $0x14,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret    

000006e3 <chdir>:
SYSCALL(chdir)
 6e3:	b8 09 00 00 00       	mov    $0x9,%eax
 6e8:	cd 40                	int    $0x40
 6ea:	c3                   	ret    

000006eb <dup>:
SYSCALL(dup)
 6eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <getpid>:
SYSCALL(getpid)
 6f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <sbrk>:
SYSCALL(sbrk)
 6fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <sleep>:
SYSCALL(sleep)
 703:	b8 0d 00 00 00       	mov    $0xd,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret    

0000070b <uptime>:
SYSCALL(uptime)
 70b:	b8 0e 00 00 00       	mov    $0xe,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <settickets>:
SYSCALL(settickets)
 713:	b8 16 00 00 00       	mov    $0x16,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <getpinfo>:
SYSCALL(getpinfo)
 71b:	b8 17 00 00 00       	mov    $0x17,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    
 723:	66 90                	xchg   %ax,%ax
 725:	66 90                	xchg   %ax,%ax
 727:	66 90                	xchg   %ax,%ax
 729:	66 90                	xchg   %ax,%ax
 72b:	66 90                	xchg   %ax,%ax
 72d:	66 90                	xchg   %ax,%ax
 72f:	90                   	nop

00000730 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 3c             	sub    $0x3c,%esp
 739:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 73c:	89 d1                	mov    %edx,%ecx
{
 73e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 741:	85 d2                	test   %edx,%edx
 743:	0f 89 7f 00 00 00    	jns    7c8 <printint+0x98>
 749:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 74d:	74 79                	je     7c8 <printint+0x98>
    neg = 1;
 74f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 756:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 758:	31 db                	xor    %ebx,%ebx
 75a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 75d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 760:	89 c8                	mov    %ecx,%eax
 762:	31 d2                	xor    %edx,%edx
 764:	89 cf                	mov    %ecx,%edi
 766:	f7 75 c4             	divl   -0x3c(%ebp)
 769:	0f b6 92 84 0d 00 00 	movzbl 0xd84(%edx),%edx
 770:	89 45 c0             	mov    %eax,-0x40(%ebp)
 773:	89 d8                	mov    %ebx,%eax
 775:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 778:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 77b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 77e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 781:	76 dd                	jbe    760 <printint+0x30>
  if(neg)
 783:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 786:	85 c9                	test   %ecx,%ecx
 788:	74 0c                	je     796 <printint+0x66>
    buf[i++] = '-';
 78a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 78f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 791:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 796:	8b 7d b8             	mov    -0x48(%ebp),%edi
 799:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 79d:	eb 07                	jmp    7a6 <printint+0x76>
 79f:	90                   	nop
    putc(fd, buf[i]);
 7a0:	0f b6 13             	movzbl (%ebx),%edx
 7a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 7a6:	83 ec 04             	sub    $0x4,%esp
 7a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 7ac:	6a 01                	push   $0x1
 7ae:	56                   	push   %esi
 7af:	57                   	push   %edi
 7b0:	e8 de fe ff ff       	call   693 <write>
  while(--i >= 0)
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	39 de                	cmp    %ebx,%esi
 7ba:	75 e4                	jne    7a0 <printint+0x70>
}
 7bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7bf:	5b                   	pop    %ebx
 7c0:	5e                   	pop    %esi
 7c1:	5f                   	pop    %edi
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret    
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 7cf:	eb 87                	jmp    758 <printint+0x28>
 7d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7df:	90                   	nop

000007e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 7ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 7ef:	0f b6 13             	movzbl (%ebx),%edx
 7f2:	84 d2                	test   %dl,%dl
 7f4:	74 6a                	je     860 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 7f6:	8d 45 10             	lea    0x10(%ebp),%eax
 7f9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 7ff:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 801:	89 45 d0             	mov    %eax,-0x30(%ebp)
 804:	eb 36                	jmp    83c <printf+0x5c>
 806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 80d:	8d 76 00             	lea    0x0(%esi),%esi
 810:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 813:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 818:	83 f8 25             	cmp    $0x25,%eax
 81b:	74 15                	je     832 <printf+0x52>
  write(fd, &c, 1);
 81d:	83 ec 04             	sub    $0x4,%esp
 820:	88 55 e7             	mov    %dl,-0x19(%ebp)
 823:	6a 01                	push   $0x1
 825:	57                   	push   %edi
 826:	56                   	push   %esi
 827:	e8 67 fe ff ff       	call   693 <write>
 82c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 82f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 832:	0f b6 13             	movzbl (%ebx),%edx
 835:	83 c3 01             	add    $0x1,%ebx
 838:	84 d2                	test   %dl,%dl
 83a:	74 24                	je     860 <printf+0x80>
    c = fmt[i] & 0xff;
 83c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 83f:	85 c9                	test   %ecx,%ecx
 841:	74 cd                	je     810 <printf+0x30>
      }
    } else if(state == '%'){
 843:	83 f9 25             	cmp    $0x25,%ecx
 846:	75 ea                	jne    832 <printf+0x52>
      if(c == 'd'){
 848:	83 f8 25             	cmp    $0x25,%eax
 84b:	0f 84 07 01 00 00    	je     958 <printf+0x178>
 851:	83 e8 63             	sub    $0x63,%eax
 854:	83 f8 15             	cmp    $0x15,%eax
 857:	77 17                	ja     870 <printf+0x90>
 859:	ff 24 85 2c 0d 00 00 	jmp    *0xd2c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 860:	8d 65 f4             	lea    -0xc(%ebp),%esp
 863:	5b                   	pop    %ebx
 864:	5e                   	pop    %esi
 865:	5f                   	pop    %edi
 866:	5d                   	pop    %ebp
 867:	c3                   	ret    
 868:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86f:	90                   	nop
  write(fd, &c, 1);
 870:	83 ec 04             	sub    $0x4,%esp
 873:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 876:	6a 01                	push   $0x1
 878:	57                   	push   %edi
 879:	56                   	push   %esi
 87a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 87e:	e8 10 fe ff ff       	call   693 <write>
        putc(fd, c);
 883:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 887:	83 c4 0c             	add    $0xc,%esp
 88a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 88d:	6a 01                	push   $0x1
 88f:	57                   	push   %edi
 890:	56                   	push   %esi
 891:	e8 fd fd ff ff       	call   693 <write>
        putc(fd, c);
 896:	83 c4 10             	add    $0x10,%esp
      state = 0;
 899:	31 c9                	xor    %ecx,%ecx
 89b:	eb 95                	jmp    832 <printf+0x52>
 89d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8a0:	83 ec 0c             	sub    $0xc,%esp
 8a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 8a8:	6a 00                	push   $0x0
 8aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8ad:	8b 10                	mov    (%eax),%edx
 8af:	89 f0                	mov    %esi,%eax
 8b1:	e8 7a fe ff ff       	call   730 <printint>
        ap++;
 8b6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 8ba:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8bd:	31 c9                	xor    %ecx,%ecx
 8bf:	e9 6e ff ff ff       	jmp    832 <printf+0x52>
 8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8cb:	8b 10                	mov    (%eax),%edx
        ap++;
 8cd:	83 c0 04             	add    $0x4,%eax
 8d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 8d3:	85 d2                	test   %edx,%edx
 8d5:	0f 84 8d 00 00 00    	je     968 <printf+0x188>
        while(*s != 0){
 8db:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 8de:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 8e0:	84 c0                	test   %al,%al
 8e2:	0f 84 4a ff ff ff    	je     832 <printf+0x52>
 8e8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 8eb:	89 d3                	mov    %edx,%ebx
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8f3:	83 c3 01             	add    $0x1,%ebx
 8f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8f9:	6a 01                	push   $0x1
 8fb:	57                   	push   %edi
 8fc:	56                   	push   %esi
 8fd:	e8 91 fd ff ff       	call   693 <write>
        while(*s != 0){
 902:	0f b6 03             	movzbl (%ebx),%eax
 905:	83 c4 10             	add    $0x10,%esp
 908:	84 c0                	test   %al,%al
 90a:	75 e4                	jne    8f0 <printf+0x110>
      state = 0;
 90c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 90f:	31 c9                	xor    %ecx,%ecx
 911:	e9 1c ff ff ff       	jmp    832 <printf+0x52>
 916:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 91d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 0a 00 00 00       	mov    $0xa,%ecx
 928:	6a 01                	push   $0x1
 92a:	e9 7b ff ff ff       	jmp    8aa <printf+0xca>
 92f:	90                   	nop
        putc(fd, *ap);
 930:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 933:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 936:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 938:	6a 01                	push   $0x1
 93a:	57                   	push   %edi
 93b:	56                   	push   %esi
        putc(fd, *ap);
 93c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 93f:	e8 4f fd ff ff       	call   693 <write>
        ap++;
 944:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 948:	83 c4 10             	add    $0x10,%esp
      state = 0;
 94b:	31 c9                	xor    %ecx,%ecx
 94d:	e9 e0 fe ff ff       	jmp    832 <printf+0x52>
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 958:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 95b:	83 ec 04             	sub    $0x4,%esp
 95e:	e9 2a ff ff ff       	jmp    88d <printf+0xad>
 963:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 967:	90                   	nop
          s = "(null)";
 968:	ba 24 0d 00 00       	mov    $0xd24,%edx
        while(*s != 0){
 96d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 970:	b8 28 00 00 00       	mov    $0x28,%eax
 975:	89 d3                	mov    %edx,%ebx
 977:	e9 74 ff ff ff       	jmp    8f0 <printf+0x110>
 97c:	66 90                	xchg   %ax,%ax
 97e:	66 90                	xchg   %ax,%ax

00000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 981:	a1 9c 10 00 00       	mov    0x109c,%eax
{
 986:	89 e5                	mov    %esp,%ebp
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	53                   	push   %ebx
 98b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 98e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 998:	89 c2                	mov    %eax,%edx
 99a:	8b 00                	mov    (%eax),%eax
 99c:	39 ca                	cmp    %ecx,%edx
 99e:	73 30                	jae    9d0 <free+0x50>
 9a0:	39 c1                	cmp    %eax,%ecx
 9a2:	72 04                	jb     9a8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a4:	39 c2                	cmp    %eax,%edx
 9a6:	72 f0                	jb     998 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9ae:	39 f8                	cmp    %edi,%eax
 9b0:	74 30                	je     9e2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 9b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9b5:	8b 42 04             	mov    0x4(%edx),%eax
 9b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9bb:	39 f1                	cmp    %esi,%ecx
 9bd:	74 3a                	je     9f9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 9bf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 9c1:	5b                   	pop    %ebx
  freep = p;
 9c2:	89 15 9c 10 00 00    	mov    %edx,0x109c
}
 9c8:	5e                   	pop    %esi
 9c9:	5f                   	pop    %edi
 9ca:	5d                   	pop    %ebp
 9cb:	c3                   	ret    
 9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d0:	39 c2                	cmp    %eax,%edx
 9d2:	72 c4                	jb     998 <free+0x18>
 9d4:	39 c1                	cmp    %eax,%ecx
 9d6:	73 c0                	jae    998 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 9d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9de:	39 f8                	cmp    %edi,%eax
 9e0:	75 d0                	jne    9b2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 9e2:	03 70 04             	add    0x4(%eax),%esi
 9e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e8:	8b 02                	mov    (%edx),%eax
 9ea:	8b 00                	mov    (%eax),%eax
 9ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 9ef:	8b 42 04             	mov    0x4(%edx),%eax
 9f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 9f5:	39 f1                	cmp    %esi,%ecx
 9f7:	75 c6                	jne    9bf <free+0x3f>
    p->s.size += bp->s.size;
 9f9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 9fc:	89 15 9c 10 00 00    	mov    %edx,0x109c
    p->s.size += bp->s.size;
 a02:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a05:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a08:	89 0a                	mov    %ecx,(%edx)
}
 a0a:	5b                   	pop    %ebx
 a0b:	5e                   	pop    %esi
 a0c:	5f                   	pop    %edi
 a0d:	5d                   	pop    %ebp
 a0e:	c3                   	ret    
 a0f:	90                   	nop

00000a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a1c:	8b 3d 9c 10 00 00    	mov    0x109c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	8d 70 07             	lea    0x7(%eax),%esi
 a25:	c1 ee 03             	shr    $0x3,%esi
 a28:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 a2b:	85 ff                	test   %edi,%edi
 a2d:	0f 84 9d 00 00 00    	je     ad0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a33:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 a35:	8b 4a 04             	mov    0x4(%edx),%ecx
 a38:	39 f1                	cmp    %esi,%ecx
 a3a:	73 6a                	jae    aa6 <malloc+0x96>
 a3c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a41:	39 de                	cmp    %ebx,%esi
 a43:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 a46:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 a4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 a50:	eb 17                	jmp    a69 <malloc+0x59>
 a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a5a:	8b 48 04             	mov    0x4(%eax),%ecx
 a5d:	39 f1                	cmp    %esi,%ecx
 a5f:	73 4f                	jae    ab0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a61:	8b 3d 9c 10 00 00    	mov    0x109c,%edi
 a67:	89 c2                	mov    %eax,%edx
 a69:	39 d7                	cmp    %edx,%edi
 a6b:	75 eb                	jne    a58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a6d:	83 ec 0c             	sub    $0xc,%esp
 a70:	ff 75 e4             	push   -0x1c(%ebp)
 a73:	e8 83 fc ff ff       	call   6fb <sbrk>
  if(p == (char*)-1)
 a78:	83 c4 10             	add    $0x10,%esp
 a7b:	83 f8 ff             	cmp    $0xffffffff,%eax
 a7e:	74 1c                	je     a9c <malloc+0x8c>
  hp->s.size = nu;
 a80:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a83:	83 ec 0c             	sub    $0xc,%esp
 a86:	83 c0 08             	add    $0x8,%eax
 a89:	50                   	push   %eax
 a8a:	e8 f1 fe ff ff       	call   980 <free>
  return freep;
 a8f:	8b 15 9c 10 00 00    	mov    0x109c,%edx
      if((p = morecore(nunits)) == 0)
 a95:	83 c4 10             	add    $0x10,%esp
 a98:	85 d2                	test   %edx,%edx
 a9a:	75 bc                	jne    a58 <malloc+0x48>
        return 0;
  }
}
 a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a9f:	31 c0                	xor    %eax,%eax
}
 aa1:	5b                   	pop    %ebx
 aa2:	5e                   	pop    %esi
 aa3:	5f                   	pop    %edi
 aa4:	5d                   	pop    %ebp
 aa5:	c3                   	ret    
    if(p->s.size >= nunits){
 aa6:	89 d0                	mov    %edx,%eax
 aa8:	89 fa                	mov    %edi,%edx
 aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ab0:	39 ce                	cmp    %ecx,%esi
 ab2:	74 4c                	je     b00 <malloc+0xf0>
        p->s.size -= nunits;
 ab4:	29 f1                	sub    %esi,%ecx
 ab6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ab9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 abc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 abf:	89 15 9c 10 00 00    	mov    %edx,0x109c
}
 ac5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ac8:	83 c0 08             	add    $0x8,%eax
}
 acb:	5b                   	pop    %ebx
 acc:	5e                   	pop    %esi
 acd:	5f                   	pop    %edi
 ace:	5d                   	pop    %ebp
 acf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 ad0:	c7 05 9c 10 00 00 a0 	movl   $0x10a0,0x109c
 ad7:	10 00 00 
    base.s.size = 0;
 ada:	bf a0 10 00 00       	mov    $0x10a0,%edi
    base.s.ptr = freep = prevp = &base;
 adf:	c7 05 a0 10 00 00 a0 	movl   $0x10a0,0x10a0
 ae6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 aeb:	c7 05 a4 10 00 00 00 	movl   $0x0,0x10a4
 af2:	00 00 00 
    if(p->s.size >= nunits){
 af5:	e9 42 ff ff ff       	jmp    a3c <malloc+0x2c>
 afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 b00:	8b 08                	mov    (%eax),%ecx
 b02:	89 0a                	mov    %ecx,(%edx)
 b04:	eb b9                	jmp    abf <malloc+0xaf>
