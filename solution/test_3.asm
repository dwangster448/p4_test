
_test_3:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "pstat.h"
#include "test_helper.h"

int main(int argc, char *argv[])
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
  11:	81 ec 34 07 00 00    	sub    $0x734,%esp
    struct pstat ps;

    int pa_tickets = 4;
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  17:	6a 04                	push   $0x4
  19:	e8 75 09 00 00       	call   993 <settickets>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	83 f8 ff             	cmp    $0xffffffff,%eax
  24:	0f 84 9a 00 00 00    	je     c4 <main+0xc4>

    int pid = fork();
  2a:	e8 bc 08 00 00       	call   8eb <fork>
  2f:	89 c3                	mov    %eax,%ebx

    // Child has double the tickets of the parent (default = 8)
    int ch_tickets = 8;

    if (pid == 0)
  31:	85 c0                	test   %eax,%eax
  33:	0f 84 7c 00 00 00    	je     b5 <main+0xb5>
        int rt = 1000;
        run_until(rt);
        exit();
    }

    int my_idx = find_my_stats_index(&ps);
  39:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
  3f:	e8 7c 03 00 00       	call   3c0 <find_my_stats_index>
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
but got %d from pgetinfo",
           pa_tickets, ps.tickets[my_idx]);
    ASSERT(ps.tickets[ch_idx] == ch_tickets, "Child tickets should be set to %d, \
  76:	83 bc 95 e8 f9 ff ff 	cmpl   $0x8,-0x618(%ebp,%edx,4)
  7d:	08 
  7e:	8d 72 40             	lea    0x40(%edx),%esi
  81:	0f 84 f5 00 00 00    	je     17c <main+0x17c>
  87:	83 ec 0c             	sub    $0xc,%esp
  8a:	6a 26                	push   $0x26
  8c:	68 f5 0d 00 00       	push   $0xdf5
  91:	68 88 0d 00 00       	push   $0xd88
  96:	68 eb 0d 00 00       	push   $0xdeb
  9b:	6a 01                	push   $0x1
  9d:	e8 be 09 00 00       	call   a60 <printf>
  a2:	83 c4 20             	add    $0x20,%esp
  a5:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
  ac:	6a 08                	push   $0x8
  ae:	68 f0 0e 00 00       	push   $0xef0
  b3:	eb 32                	jmp    e7 <main+0xe7>
        run_until(rt);
  b5:	b8 e8 03 00 00       	mov    $0x3e8,%eax
  ba:	e8 a1 03 00 00       	call   460 <run_until>
        exit();
  bf:	e8 2f 08 00 00       	call   8f3 <exit>
    ASSERT(settickets(pa_tickets) != -1, "settickets syscall failed in parent");
  c4:	83 ec 0c             	sub    $0xc,%esp
  c7:	6a 0c                	push   $0xc
  c9:	68 f5 0d 00 00       	push   $0xdf5
  ce:	68 88 0d 00 00       	push   $0xd88
  d3:	68 eb 0d 00 00       	push   $0xdeb
  d8:	6a 01                	push   $0x1
  da:	e8 81 09 00 00       	call   a60 <printf>
  df:	83 c4 18             	add    $0x18,%esp
  e2:	68 8c 0e 00 00       	push   $0xe8c
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
  e7:	6a 01                	push   $0x1
  e9:	e8 72 09 00 00       	call   a60 <printf>
  ee:	58                   	pop    %eax
  ef:	5a                   	pop    %edx
  f0:	68 0c 0e 00 00       	push   $0xe0c
  f5:	6a 01                	push   $0x1
  f7:	e8 64 09 00 00       	call   a60 <printf>
  fc:	e8 f2 07 00 00       	call   8f3 <exit>
    ASSERT(ps.tickets[my_idx] == pa_tickets, "Parent tickets should be set to %d, \
 101:	83 ec 0c             	sub    $0xc,%esp
 104:	6a 23                	push   $0x23
 106:	68 f5 0d 00 00       	push   $0xdf5
 10b:	68 88 0d 00 00       	push   $0xd88
 110:	68 eb 0d 00 00       	push   $0xdeb
 115:	6a 01                	push   $0x1
 117:	e8 44 09 00 00       	call   a60 <printf>
 11c:	83 c4 20             	add    $0x20,%esp
 11f:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 126:	6a 04                	push   $0x4
 128:	68 b0 0e 00 00       	push   $0xeb0
 12d:	eb b8                	jmp    e7 <main+0xe7>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 12f:	83 ec 0c             	sub    $0xc,%esp
 132:	6a 1f                	push   $0x1f
 134:	68 f5 0d 00 00       	push   $0xdf5
 139:	68 88 0d 00 00       	push   $0xd88
 13e:	68 eb 0d 00 00       	push   $0xdeb
 143:	6a 01                	push   $0x1
 145:	e8 16 09 00 00       	call   a60 <printf>
 14a:	83 c4 18             	add    $0x18,%esp
 14d:	68 60 0e 00 00       	push   $0xe60
 152:	eb 93                	jmp    e7 <main+0xe7>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	6a 21                	push   $0x21
 159:	68 f5 0d 00 00       	push   $0xdf5
 15e:	68 88 0d 00 00       	push   $0xd88
 163:	68 eb 0d 00 00       	push   $0xdeb
 168:	6a 01                	push   $0x1
 16a:	e8 f1 08 00 00       	call   a60 <printf>
 16f:	83 c4 18             	add    $0x18,%esp
 172:	68 08 10 00 00       	push   $0x1008
 177:	e9 6b ff ff ff       	jmp    e7 <main+0xe7>
but got %d from pgetinfo",
           ch_tickets, ps.tickets[ch_idx]);

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
 1a7:	e8 b4 02 00 00       	call   460 <run_until>

    my_idx = find_my_stats_index(&ps);
 1ac:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
 1b2:	e8 09 02 00 00       	call   3c0 <find_my_stats_index>
 1b7:	89 c2                	mov    %eax,%edx
    for (int i = 0; i < NPROC; i++)
 1b9:	31 c0                	xor    %eax,%eax
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 1bb:	83 fa ff             	cmp    $0xffffffff,%edx
 1be:	75 11                	jne    1d1 <main+0x1d1>
 1c0:	e9 72 01 00 00       	jmp    337 <main+0x337>
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	83 f8 40             	cmp    $0x40,%eax
 1cb:	0f 84 9a 01 00 00    	je     36b <main+0x36b>
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
 1f8:	0f 8d 43 01 00 00    	jge    341 <main+0x341>
new_pass is %d",
           old_pass, now_pass);

    ASSERT(now_ch_pass > old_ch_pass, "Child pass didn't increase: old_pass was %d, \
 1fe:	39 85 e4 f8 ff ff    	cmp    %eax,-0x71c(%ebp)
 204:	7c 3b                	jl     241 <main+0x241>
 206:	83 ec 0c             	sub    $0xc,%esp
 209:	89 85 e0 f8 ff ff    	mov    %eax,-0x720(%ebp)
 20f:	6a 42                	push   $0x42
 211:	68 f5 0d 00 00       	push   $0xdf5
 216:	68 88 0d 00 00       	push   $0xd88
 21b:	68 eb 0d 00 00       	push   $0xdeb
 220:	6a 01                	push   $0x1
 222:	e8 39 08 00 00       	call   a60 <printf>
 227:	8b 85 e0 f8 ff ff    	mov    -0x720(%ebp),%eax
 22d:	83 c4 20             	add    $0x20,%esp
 230:	50                   	push   %eax
 231:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 237:	68 64 0f 00 00       	push   $0xf64
 23c:	e9 a6 fe ff ff       	jmp    e7 <main+0xe7>
new_pass is %d",
           old_ch_pass, now_ch_pass);

    int diff_rtime = now_rtime - old_rtime;
 241:	29 f9                	sub    %edi,%ecx
    printf(1, "diff_rtime: %d\n", diff_rtime);
 243:	57                   	push   %edi
    int __attribute__((unused)) diff_pass = now_pass - old_pass;
 244:	29 f3                	sub    %esi,%ebx
    int diff_ch_rtime = now_ch_rtime - old_ch_rtime;
    printf(1, "diff_ch_rtime: %d\n", diff_ch_rtime);
    int __attribute__((unused)) diff_ch_pass = now_ch_pass - old_ch_pass;
    printf(1, "diff_ch_pass: %d\n", diff_ch_pass);

    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 246:	be 08 00 00 00       	mov    $0x8,%esi
    printf(1, "diff_rtime: %d\n", diff_rtime);
 24b:	51                   	push   %ecx
 24c:	68 fe 0d 00 00       	push   $0xdfe
 251:	6a 01                	push   $0x1
 253:	89 8d dc f8 ff ff    	mov    %ecx,-0x724(%ebp)
 259:	89 95 d8 f8 ff ff    	mov    %edx,-0x728(%ebp)
 25f:	89 85 d4 f8 ff ff    	mov    %eax,-0x72c(%ebp)
 265:	e8 f6 07 00 00       	call   a60 <printf>
    printf(1, "diff_pass: %d\n", diff_pass);
 26a:	83 c4 0c             	add    $0xc,%esp
 26d:	53                   	push   %ebx
 26e:	68 0e 0e 00 00       	push   $0xe0e
 273:	6a 01                	push   $0x1
 275:	e8 e6 07 00 00       	call   a60 <printf>
    printf(1, "diff_ch_rtime: %d\n", diff_ch_rtime);
 27a:	83 c4 0c             	add    $0xc,%esp
    int diff_ch_rtime = now_ch_rtime - old_ch_rtime;
 27d:	8b 9d d8 f8 ff ff    	mov    -0x728(%ebp),%ebx
 283:	2b 9d e0 f8 ff ff    	sub    -0x720(%ebp),%ebx
    printf(1, "diff_ch_rtime: %d\n", diff_ch_rtime);
 289:	53                   	push   %ebx
 28a:	68 1d 0e 00 00       	push   $0xe1d
 28f:	6a 01                	push   $0x1
 291:	e8 ca 07 00 00       	call   a60 <printf>
    printf(1, "diff_ch_pass: %d\n", diff_ch_pass);
 296:	83 c4 0c             	add    $0xc,%esp
    int __attribute__((unused)) diff_ch_pass = now_ch_pass - old_ch_pass;
 299:	8b 85 d4 f8 ff ff    	mov    -0x72c(%ebp),%eax
 29f:	2b 85 e4 f8 ff ff    	sub    -0x71c(%ebp),%eax
    printf(1, "diff_ch_pass: %d\n", diff_ch_pass);
 2a5:	50                   	push   %eax
 2a6:	68 30 0e 00 00       	push   $0xe30
 2ab:	6a 01                	push   $0x1
 2ad:	e8 ae 07 00 00       	call   a60 <printf>
    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 2b2:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax

    printf(1, "exp_rtime: %d\n", exp_rtime);
 2b9:	83 c4 0c             	add    $0xc,%esp
    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 2bc:	99                   	cltd   
 2bd:	f7 fe                	idiv   %esi
    printf(1, "exp_rtime: %d\n", exp_rtime);
 2bf:	50                   	push   %eax
    int exp_rtime = (diff_ch_rtime * pa_tickets) / ch_tickets;
 2c0:	89 c6                	mov    %eax,%esi
    printf(1, "exp_rtime: %d\n", exp_rtime);
 2c2:	68 42 0e 00 00       	push   $0xe42
 2c7:	6a 01                	push   $0x1
 2c9:	e8 92 07 00 00       	call   a60 <printf>

    int margin = 2;
    ASSERT(diff_rtime <= exp_rtime + margin && diff_rtime >= exp_rtime - margin,
 2ce:	8b 8d dc f8 ff ff    	mov    -0x724(%ebp),%ecx
 2d4:	8d 46 02             	lea    0x2(%esi),%eax
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	39 c8                	cmp    %ecx,%eax
 2dc:	7c 0b                	jl     2e9 <main+0x2e9>
 2de:	83 ee 02             	sub    $0x2,%esi
 2e1:	39 ce                	cmp    %ecx,%esi
 2e3:	0f 8e 8c 00 00 00    	jle    375 <main+0x375>
 2e9:	83 ec 0c             	sub    $0xc,%esp
 2ec:	89 8d e4 f8 ff ff    	mov    %ecx,-0x71c(%ebp)
 2f2:	6a 54                	push   $0x54
 2f4:	68 f5 0d 00 00       	push   $0xdf5
 2f9:	68 88 0d 00 00       	push   $0xd88
 2fe:	68 eb 0d 00 00       	push   $0xdeb
 303:	6a 01                	push   $0x1
 305:	e8 56 07 00 00       	call   a60 <printf>
 30a:	8b 8d e4 f8 ff ff    	mov    -0x71c(%ebp),%ecx
 310:	83 c4 14             	add    $0x14,%esp
 313:	6a 02                	push   $0x2
 315:	53                   	push   %ebx
 316:	51                   	push   %ecx
 317:	68 a0 0f 00 00       	push   $0xfa0
 31c:	6a 01                	push   $0x1
 31e:	e8 3d 07 00 00       	call   a60 <printf>
 323:	83 c4 18             	add    $0x18,%esp
 326:	68 0c 0e 00 00       	push   $0xe0c
 32b:	6a 01                	push   $0x1
 32d:	e8 2e 07 00 00       	call   a60 <printf>
 332:	e8 bc 05 00 00       	call   8f3 <exit>
    ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 337:	83 ec 0c             	sub    $0xc,%esp
 33a:	6a 34                	push   $0x34
 33c:	e9 f3 fd ff ff       	jmp    134 <main+0x134>
    ASSERT(now_pass > old_pass, "Pass didn't increase: old_pass was %d, \
 341:	83 ec 0c             	sub    $0xc,%esp
 344:	6a 3e                	push   $0x3e
 346:	68 f5 0d 00 00       	push   $0xdf5
 34b:	68 88 0d 00 00       	push   $0xd88
 350:	68 eb 0d 00 00       	push   $0xdeb
 355:	6a 01                	push   $0x1
 357:	e8 04 07 00 00       	call   a60 <printf>
 35c:	83 c4 20             	add    $0x20,%esp
 35f:	53                   	push   %ebx
 360:	56                   	push   %esi
 361:	68 2c 0f 00 00       	push   $0xf2c
 366:	e9 7c fd ff ff       	jmp    e7 <main+0xe7>
    ASSERT(ch_idx != -1, "Could not get child process stats from pgetinfo");
 36b:	83 ec 0c             	sub    $0xc,%esp
 36e:	6a 36                	push   $0x36
 370:	e9 e4 fd ff ff       	jmp    159 <main+0x159>
    return -1;
}

#define SUCCESS_MSG "TEST PASSED"
static void test_passed() {
    PRINTF("%s", SUCCESS_MSG);
 375:	50                   	push   %eax
 376:	68 88 0d 00 00       	push   $0xd88
 37b:	68 92 0d 00 00       	push   $0xd92
 380:	6a 01                	push   $0x1
 382:	e8 d9 06 00 00       	call   a60 <printf>
 387:	83 c4 0c             	add    $0xc,%esp
 38a:	68 51 0e 00 00       	push   $0xe51
 38f:	68 5d 0e 00 00       	push   $0xe5d
 394:	6a 01                	push   $0x1
 396:	e8 c5 06 00 00       	call   a60 <printf>
 39b:	5a                   	pop    %edx
 39c:	59                   	pop    %ecx
 39d:	68 0c 0e 00 00       	push   $0xe0c
 3a2:	6a 01                	push   $0x1
 3a4:	e8 b7 06 00 00       	call   a60 <printf>
%d margin of half the child ticks",
           diff_rtime, diff_ch_rtime, margin);

    test_passed();

    wait();
 3a9:	e8 4d 05 00 00       	call   8fb <wait>

    exit();
 3ae:	e8 40 05 00 00       	call   8f3 <exit>
 3b3:	66 90                	xchg   %ax,%ax
 3b5:	66 90                	xchg   %ax,%ax
 3b7:	66 90                	xchg   %ax,%ax
 3b9:	66 90                	xchg   %ax,%ax
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <find_my_stats_index>:
static int find_my_stats_index(struct pstat *s) {
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
 3c5:	89 c3                	mov    %eax,%ebx
 3c7:	83 ec 10             	sub    $0x10,%esp
    int mypid = getpid();
 3ca:	e8 a4 05 00 00       	call   973 <getpid>
    if (getpinfo(s) == -1) {
 3cf:	83 ec 0c             	sub    $0xc,%esp
 3d2:	53                   	push   %ebx
    int mypid = getpid();
 3d3:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 3d5:	e8 c1 05 00 00       	call   99b <getpinfo>
 3da:	83 c4 10             	add    $0x10,%esp
 3dd:	83 f8 ff             	cmp    $0xffffffff,%eax
 3e0:	74 3a                	je     41c <find_my_stats_index+0x5c>
    for (int i = 0; i < NPROC; i++)
 3e2:	31 c0                	xor    %eax,%eax
 3e4:	eb 12                	jmp    3f8 <find_my_stats_index+0x38>
 3e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	83 c0 01             	add    $0x1,%eax
 3f3:	83 f8 40             	cmp    $0x40,%eax
 3f6:	74 18                	je     410 <find_my_stats_index+0x50>
        if (s->pid[i] == mypid)
 3f8:	39 b4 83 00 02 00 00 	cmp    %esi,0x200(%ebx,%eax,4)
 3ff:	75 ef                	jne    3f0 <find_my_stats_index+0x30>
}
 401:	8d 65 f8             	lea    -0x8(%ebp),%esp
 404:	5b                   	pop    %ebx
 405:	5e                   	pop    %esi
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40f:	90                   	nop
 410:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
 413:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 418:	5b                   	pop    %ebx
 419:	5e                   	pop    %esi
 41a:	5d                   	pop    %ebp
 41b:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 41c:	83 ec 04             	sub    $0x4,%esp
 41f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 422:	68 88 0d 00 00       	push   $0xd88
 427:	68 92 0d 00 00       	push   $0xd92
 42c:	6a 01                	push   $0x1
 42e:	e8 2d 06 00 00       	call   a60 <printf>
 433:	58                   	pop    %eax
 434:	5a                   	pop    %edx
 435:	68 97 0d 00 00       	push   $0xd97
 43a:	6a 01                	push   $0x1
 43c:	e8 1f 06 00 00       	call   a60 <printf>
 441:	59                   	pop    %ecx
 442:	5b                   	pop    %ebx
 443:	68 0c 0e 00 00       	push   $0xe0c
 448:	6a 01                	push   $0x1
 44a:	e8 11 06 00 00       	call   a60 <printf>
        return -1;
 44f:	8b 45 f4             	mov    -0xc(%ebp),%eax
        PRINTF("getpinfo failed\n"); 
 452:	83 c4 10             	add    $0x10,%esp
 455:	eb aa                	jmp    401 <find_my_stats_index+0x41>
 457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45e:	66 90                	xchg   %ax,%ax

00000460 <run_until>:

/*
 * Run at least until the specified target rtime
 * Might immediately return if the rtime is already reached
 */
static __attribute__((unused)) void run_until(int target_rtime) {
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	8d bd e8 f8 ff ff    	lea    -0x718(%ebp),%edi
 46b:	53                   	push   %ebx
 46c:	81 ec 1c 07 00 00    	sub    $0x71c,%esp
 472:	89 85 e4 f8 ff ff    	mov    %eax,-0x71c(%ebp)
 478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop
    int mypid = getpid();
 480:	e8 ee 04 00 00       	call   973 <getpid>
    if (getpinfo(s) == -1) {
 485:	83 ec 0c             	sub    $0xc,%esp
 488:	57                   	push   %edi
    int mypid = getpid();
 489:	89 c6                	mov    %eax,%esi
    if (getpinfo(s) == -1) {
 48b:	e8 0b 05 00 00       	call   99b <getpinfo>
 490:	83 c4 10             	add    $0x10,%esp
 493:	83 f8 ff             	cmp    $0xffffffff,%eax
 496:	0f 84 e2 00 00 00    	je     57e <run_until+0x11e>
    for (int i = 0; i < NPROC; i++)
 49c:	31 db                	xor    %ebx,%ebx
 49e:	eb 0c                	jmp    4ac <run_until+0x4c>
 4a0:	83 c3 01             	add    $0x1,%ebx
 4a3:	83 fb 40             	cmp    $0x40,%ebx
 4a6:	0f 84 03 01 00 00    	je     5af <run_until+0x14f>
        if (s->pid[i] == mypid)
 4ac:	3b b4 9f 00 02 00 00 	cmp    0x200(%edi,%ebx,4),%esi
 4b3:	75 eb                	jne    4a0 <run_until+0x40>
    struct pstat ps;
    while (1) {
        int my_idx = find_my_stats_index(&ps);
        PRINTF("TARGET RUNTIME: %d", target_rtime);
 4b5:	83 ec 04             	sub    $0x4,%esp

        PRINTF("ps[%d] rttime: %d",my_idx, ps.rtime[my_idx]); 
 4b8:	8d b3 80 01 00 00    	lea    0x180(%ebx),%esi
        PRINTF("TARGET RUNTIME: %d", target_rtime);
 4be:	68 88 0d 00 00       	push   $0xd88
 4c3:	68 92 0d 00 00       	push   $0xd92
 4c8:	6a 01                	push   $0x1
 4ca:	e8 91 05 00 00       	call   a60 <printf>
 4cf:	83 c4 0c             	add    $0xc,%esp
 4d2:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 4d8:	68 a8 0d 00 00       	push   $0xda8
 4dd:	6a 01                	push   $0x1
 4df:	e8 7c 05 00 00       	call   a60 <printf>
 4e4:	58                   	pop    %eax
 4e5:	5a                   	pop    %edx
 4e6:	68 0c 0e 00 00       	push   $0xe0c
 4eb:	6a 01                	push   $0x1
 4ed:	e8 6e 05 00 00       	call   a60 <printf>
        PRINTF("ps[%d] rttime: %d",my_idx, ps.rtime[my_idx]); 
 4f2:	83 c4 0c             	add    $0xc,%esp
 4f5:	68 88 0d 00 00       	push   $0xd88
 4fa:	68 92 0d 00 00       	push   $0xd92
 4ff:	6a 01                	push   $0x1
 501:	e8 5a 05 00 00       	call   a60 <printf>
 506:	ff b4 b5 e8 f8 ff ff 	push   -0x718(%ebp,%esi,4)
 50d:	53                   	push   %ebx
 50e:	68 bb 0d 00 00       	push   $0xdbb
 513:	6a 01                	push   $0x1
 515:	e8 46 05 00 00       	call   a60 <printf>
 51a:	83 c4 18             	add    $0x18,%esp
 51d:	68 0c 0e 00 00       	push   $0xe0c
 522:	6a 01                	push   $0x1
 524:	e8 37 05 00 00       	call   a60 <printf>
        PRINTF("ps[%d] pass: %d",my_idx, ps.pass[my_idx]); 
 529:	83 c4 0c             	add    $0xc,%esp
 52c:	68 88 0d 00 00       	push   $0xd88
 531:	68 92 0d 00 00       	push   $0xd92
 536:	6a 01                	push   $0x1
 538:	e8 23 05 00 00       	call   a60 <printf>
 53d:	ff b4 9d e8 fb ff ff 	push   -0x418(%ebp,%ebx,4)
 544:	53                   	push   %ebx
 545:	68 cd 0d 00 00       	push   $0xdcd
 54a:	6a 01                	push   $0x1
 54c:	e8 0f 05 00 00       	call   a60 <printf>
 551:	83 c4 18             	add    $0x18,%esp
 554:	68 0c 0e 00 00       	push   $0xe0c
 559:	6a 01                	push   $0x1
 55b:	e8 00 05 00 00       	call   a60 <printf>

        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");

        if (ps.rtime[my_idx] >= target_rtime)
 560:	8b 85 e4 f8 ff ff    	mov    -0x71c(%ebp),%eax
 566:	83 c4 10             	add    $0x10,%esp
 569:	39 84 b5 e8 f8 ff ff 	cmp    %eax,-0x718(%ebp,%esi,4)
 570:	0f 8c 0a ff ff ff    	jl     480 <run_until+0x20>
            return;
    }
}
 576:	8d 65 f4             	lea    -0xc(%ebp),%esp
 579:	5b                   	pop    %ebx
 57a:	5e                   	pop    %esi
 57b:	5f                   	pop    %edi
 57c:	5d                   	pop    %ebp
 57d:	c3                   	ret    
        PRINTF("getpinfo failed\n"); 
 57e:	50                   	push   %eax
 57f:	68 88 0d 00 00       	push   $0xd88
 584:	68 92 0d 00 00       	push   $0xd92
 589:	6a 01                	push   $0x1
 58b:	e8 d0 04 00 00       	call   a60 <printf>
 590:	58                   	pop    %eax
 591:	5a                   	pop    %edx
 592:	68 97 0d 00 00       	push   $0xd97
 597:	6a 01                	push   $0x1
 599:	e8 c2 04 00 00       	call   a60 <printf>
 59e:	59                   	pop    %ecx
 59f:	5b                   	pop    %ebx
 5a0:	68 0c 0e 00 00       	push   $0xe0c
 5a5:	6a 01                	push   $0x1
 5a7:	e8 b4 04 00 00       	call   a60 <printf>
 5ac:	83 c4 10             	add    $0x10,%esp
        PRINTF("TARGET RUNTIME: %d", target_rtime);
 5af:	51                   	push   %ecx
 5b0:	68 88 0d 00 00       	push   $0xd88
 5b5:	68 92 0d 00 00       	push   $0xd92
 5ba:	6a 01                	push   $0x1
 5bc:	e8 9f 04 00 00       	call   a60 <printf>
 5c1:	83 c4 0c             	add    $0xc,%esp
 5c4:	ff b5 e4 f8 ff ff    	push   -0x71c(%ebp)
 5ca:	68 a8 0d 00 00       	push   $0xda8
 5cf:	6a 01                	push   $0x1
 5d1:	e8 8a 04 00 00       	call   a60 <printf>
 5d6:	5b                   	pop    %ebx
 5d7:	5e                   	pop    %esi
 5d8:	68 0c 0e 00 00       	push   $0xe0c
 5dd:	6a 01                	push   $0x1
 5df:	e8 7c 04 00 00       	call   a60 <printf>
        PRINTF("ps[%d] rttime: %d",my_idx, ps.rtime[my_idx]); 
 5e4:	83 c4 0c             	add    $0xc,%esp
 5e7:	68 88 0d 00 00       	push   $0xd88
 5ec:	68 92 0d 00 00       	push   $0xd92
 5f1:	6a 01                	push   $0x1
 5f3:	e8 68 04 00 00       	call   a60 <printf>
 5f8:	ff b5 e4 fe ff ff    	push   -0x11c(%ebp)
 5fe:	6a ff                	push   $0xffffffff
 600:	68 bb 0d 00 00       	push   $0xdbb
 605:	6a 01                	push   $0x1
 607:	e8 54 04 00 00       	call   a60 <printf>
 60c:	83 c4 18             	add    $0x18,%esp
 60f:	68 0c 0e 00 00       	push   $0xe0c
 614:	6a 01                	push   $0x1
 616:	e8 45 04 00 00       	call   a60 <printf>
        PRINTF("ps[%d] pass: %d",my_idx, ps.pass[my_idx]); 
 61b:	83 c4 0c             	add    $0xc,%esp
 61e:	68 88 0d 00 00       	push   $0xd88
 623:	68 92 0d 00 00       	push   $0xd92
 628:	6a 01                	push   $0x1
 62a:	e8 31 04 00 00       	call   a60 <printf>
 62f:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
 635:	6a ff                	push   $0xffffffff
 637:	68 cd 0d 00 00       	push   $0xdcd
 63c:	6a 01                	push   $0x1
 63e:	e8 1d 04 00 00       	call   a60 <printf>
 643:	83 c4 18             	add    $0x18,%esp
 646:	68 0c 0e 00 00       	push   $0xe0c
 64b:	6a 01                	push   $0x1
 64d:	e8 0e 04 00 00       	call   a60 <printf>
        ASSERT(my_idx != -1, "Could not get process stats from pgetinfo");
 652:	c7 04 24 50 00 00 00 	movl   $0x50,(%esp)
 659:	68 dd 0d 00 00       	push   $0xddd
 65e:	68 88 0d 00 00       	push   $0xd88
 663:	68 eb 0d 00 00       	push   $0xdeb
 668:	6a 01                	push   $0x1
 66a:	e8 f1 03 00 00       	call   a60 <printf>
 66f:	83 c4 18             	add    $0x18,%esp
 672:	68 60 0e 00 00       	push   $0xe60
 677:	6a 01                	push   $0x1
 679:	e8 e2 03 00 00       	call   a60 <printf>
 67e:	5f                   	pop    %edi
 67f:	58                   	pop    %eax
 680:	68 0c 0e 00 00       	push   $0xe0c
 685:	6a 01                	push   $0x1
 687:	e8 d4 03 00 00       	call   a60 <printf>
 68c:	e8 62 02 00 00       	call   8f3 <exit>
 691:	66 90                	xchg   %ax,%ax
 693:	66 90                	xchg   %ax,%ax
 695:	66 90                	xchg   %ax,%ax
 697:	66 90                	xchg   %ax,%ax
 699:	66 90                	xchg   %ax,%ax
 69b:	66 90                	xchg   %ax,%ax
 69d:	66 90                	xchg   %ax,%ax
 69f:	90                   	nop

000006a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 6a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6a1:	31 c0                	xor    %eax,%eax
{
 6a3:	89 e5                	mov    %esp,%ebp
 6a5:	53                   	push   %ebx
 6a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 6b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 6b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 6b7:	83 c0 01             	add    $0x1,%eax
 6ba:	84 d2                	test   %dl,%dl
 6bc:	75 f2                	jne    6b0 <strcpy+0x10>
    ;
  return os;
}
 6be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c1:	89 c8                	mov    %ecx,%eax
 6c3:	c9                   	leave  
 6c4:	c3                   	ret    
 6c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	53                   	push   %ebx
 6d4:	8b 55 08             	mov    0x8(%ebp),%edx
 6d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 6da:	0f b6 02             	movzbl (%edx),%eax
 6dd:	84 c0                	test   %al,%al
 6df:	75 17                	jne    6f8 <strcmp+0x28>
 6e1:	eb 3a                	jmp    71d <strcmp+0x4d>
 6e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e7:	90                   	nop
 6e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 6ec:	83 c2 01             	add    $0x1,%edx
 6ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 6f2:	84 c0                	test   %al,%al
 6f4:	74 1a                	je     710 <strcmp+0x40>
    p++, q++;
 6f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 6f8:	0f b6 19             	movzbl (%ecx),%ebx
 6fb:	38 c3                	cmp    %al,%bl
 6fd:	74 e9                	je     6e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 6ff:	29 d8                	sub    %ebx,%eax
}
 701:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 704:	c9                   	leave  
 705:	c3                   	ret    
 706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 710:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 714:	31 c0                	xor    %eax,%eax
 716:	29 d8                	sub    %ebx,%eax
}
 718:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 71b:	c9                   	leave  
 71c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 71d:	0f b6 19             	movzbl (%ecx),%ebx
 720:	31 c0                	xor    %eax,%eax
 722:	eb db                	jmp    6ff <strcmp+0x2f>
 724:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop

00000730 <strlen>:

uint
strlen(const char *s)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 736:	80 3a 00             	cmpb   $0x0,(%edx)
 739:	74 15                	je     750 <strlen+0x20>
 73b:	31 c0                	xor    %eax,%eax
 73d:	8d 76 00             	lea    0x0(%esi),%esi
 740:	83 c0 01             	add    $0x1,%eax
 743:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 747:	89 c1                	mov    %eax,%ecx
 749:	75 f5                	jne    740 <strlen+0x10>
    ;
  return n;
}
 74b:	89 c8                	mov    %ecx,%eax
 74d:	5d                   	pop    %ebp
 74e:	c3                   	ret    
 74f:	90                   	nop
  for(n = 0; s[n]; n++)
 750:	31 c9                	xor    %ecx,%ecx
}
 752:	5d                   	pop    %ebp
 753:	89 c8                	mov    %ecx,%eax
 755:	c3                   	ret    
 756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75d:	8d 76 00             	lea    0x0(%esi),%esi

00000760 <memset>:

void*
memset(void *dst, int c, uint n)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 767:	8b 4d 10             	mov    0x10(%ebp),%ecx
 76a:	8b 45 0c             	mov    0xc(%ebp),%eax
 76d:	89 d7                	mov    %edx,%edi
 76f:	fc                   	cld    
 770:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 772:	8b 7d fc             	mov    -0x4(%ebp),%edi
 775:	89 d0                	mov    %edx,%eax
 777:	c9                   	leave  
 778:	c3                   	ret    
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000780 <strchr>:

char*
strchr(const char *s, char c)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	8b 45 08             	mov    0x8(%ebp),%eax
 786:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 78a:	0f b6 10             	movzbl (%eax),%edx
 78d:	84 d2                	test   %dl,%dl
 78f:	75 12                	jne    7a3 <strchr+0x23>
 791:	eb 1d                	jmp    7b0 <strchr+0x30>
 793:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 797:	90                   	nop
 798:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 79c:	83 c0 01             	add    $0x1,%eax
 79f:	84 d2                	test   %dl,%dl
 7a1:	74 0d                	je     7b0 <strchr+0x30>
    if(*s == c)
 7a3:	38 d1                	cmp    %dl,%cl
 7a5:	75 f1                	jne    798 <strchr+0x18>
      return (char*)s;
  return 0;
}
 7a7:	5d                   	pop    %ebp
 7a8:	c3                   	ret    
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 7b0:	31 c0                	xor    %eax,%eax
}
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret    
 7b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7bf:	90                   	nop

000007c0 <gets>:

char*
gets(char *buf, int max)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 7c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 7c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 7c9:	31 db                	xor    %ebx,%ebx
{
 7cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 7ce:	eb 27                	jmp    7f7 <gets+0x37>
    cc = read(0, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	6a 01                	push   $0x1
 7d5:	57                   	push   %edi
 7d6:	6a 00                	push   $0x0
 7d8:	e8 2e 01 00 00       	call   90b <read>
    if(cc < 1)
 7dd:	83 c4 10             	add    $0x10,%esp
 7e0:	85 c0                	test   %eax,%eax
 7e2:	7e 1d                	jle    801 <gets+0x41>
      break;
    buf[i++] = c;
 7e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7e8:	8b 55 08             	mov    0x8(%ebp),%edx
 7eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 7ef:	3c 0a                	cmp    $0xa,%al
 7f1:	74 1d                	je     810 <gets+0x50>
 7f3:	3c 0d                	cmp    $0xd,%al
 7f5:	74 19                	je     810 <gets+0x50>
  for(i=0; i+1 < max; ){
 7f7:	89 de                	mov    %ebx,%esi
 7f9:	83 c3 01             	add    $0x1,%ebx
 7fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 7ff:	7c cf                	jl     7d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 801:	8b 45 08             	mov    0x8(%ebp),%eax
 804:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
  buf[i] = '\0';
 810:	8b 45 08             	mov    0x8(%ebp),%eax
 813:	89 de                	mov    %ebx,%esi
 815:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 819:	8d 65 f4             	lea    -0xc(%ebp),%esp
 81c:	5b                   	pop    %ebx
 81d:	5e                   	pop    %esi
 81e:	5f                   	pop    %edi
 81f:	5d                   	pop    %ebp
 820:	c3                   	ret    
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82f:	90                   	nop

00000830 <stat>:

int
stat(const char *n, struct stat *st)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	56                   	push   %esi
 834:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 835:	83 ec 08             	sub    $0x8,%esp
 838:	6a 00                	push   $0x0
 83a:	ff 75 08             	push   0x8(%ebp)
 83d:	e8 f1 00 00 00       	call   933 <open>
  if(fd < 0)
 842:	83 c4 10             	add    $0x10,%esp
 845:	85 c0                	test   %eax,%eax
 847:	78 27                	js     870 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 849:	83 ec 08             	sub    $0x8,%esp
 84c:	ff 75 0c             	push   0xc(%ebp)
 84f:	89 c3                	mov    %eax,%ebx
 851:	50                   	push   %eax
 852:	e8 f4 00 00 00       	call   94b <fstat>
  close(fd);
 857:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 85a:	89 c6                	mov    %eax,%esi
  close(fd);
 85c:	e8 ba 00 00 00       	call   91b <close>
  return r;
 861:	83 c4 10             	add    $0x10,%esp
}
 864:	8d 65 f8             	lea    -0x8(%ebp),%esp
 867:	89 f0                	mov    %esi,%eax
 869:	5b                   	pop    %ebx
 86a:	5e                   	pop    %esi
 86b:	5d                   	pop    %ebp
 86c:	c3                   	ret    
 86d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 870:	be ff ff ff ff       	mov    $0xffffffff,%esi
 875:	eb ed                	jmp    864 <stat+0x34>
 877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87e:	66 90                	xchg   %ax,%ax

00000880 <atoi>:

int
atoi(const char *s)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	53                   	push   %ebx
 884:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 887:	0f be 02             	movsbl (%edx),%eax
 88a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 88d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 890:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 895:	77 1e                	ja     8b5 <atoi+0x35>
 897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 8a0:	83 c2 01             	add    $0x1,%edx
 8a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 8a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 8aa:	0f be 02             	movsbl (%edx),%eax
 8ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 8b0:	80 fb 09             	cmp    $0x9,%bl
 8b3:	76 eb                	jbe    8a0 <atoi+0x20>
  return n;
}
 8b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8b8:	89 c8                	mov    %ecx,%eax
 8ba:	c9                   	leave  
 8bb:	c3                   	ret    
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	8b 45 10             	mov    0x10(%ebp),%eax
 8c7:	8b 55 08             	mov    0x8(%ebp),%edx
 8ca:	56                   	push   %esi
 8cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 8ce:	85 c0                	test   %eax,%eax
 8d0:	7e 13                	jle    8e5 <memmove+0x25>
 8d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 8d4:	89 d7                	mov    %edx,%edi
 8d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 8e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 8e1:	39 f8                	cmp    %edi,%eax
 8e3:	75 fb                	jne    8e0 <memmove+0x20>
  return vdst;
}
 8e5:	5e                   	pop    %esi
 8e6:	89 d0                	mov    %edx,%eax
 8e8:	5f                   	pop    %edi
 8e9:	5d                   	pop    %ebp
 8ea:	c3                   	ret    

000008eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 8eb:	b8 01 00 00 00       	mov    $0x1,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    

000008f3 <exit>:
SYSCALL(exit)
 8f3:	b8 02 00 00 00       	mov    $0x2,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret    

000008fb <wait>:
SYSCALL(wait)
 8fb:	b8 03 00 00 00       	mov    $0x3,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret    

00000903 <pipe>:
SYSCALL(pipe)
 903:	b8 04 00 00 00       	mov    $0x4,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret    

0000090b <read>:
SYSCALL(read)
 90b:	b8 05 00 00 00       	mov    $0x5,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret    

00000913 <write>:
SYSCALL(write)
 913:	b8 10 00 00 00       	mov    $0x10,%eax
 918:	cd 40                	int    $0x40
 91a:	c3                   	ret    

0000091b <close>:
SYSCALL(close)
 91b:	b8 15 00 00 00       	mov    $0x15,%eax
 920:	cd 40                	int    $0x40
 922:	c3                   	ret    

00000923 <kill>:
SYSCALL(kill)
 923:	b8 06 00 00 00       	mov    $0x6,%eax
 928:	cd 40                	int    $0x40
 92a:	c3                   	ret    

0000092b <exec>:
SYSCALL(exec)
 92b:	b8 07 00 00 00       	mov    $0x7,%eax
 930:	cd 40                	int    $0x40
 932:	c3                   	ret    

00000933 <open>:
SYSCALL(open)
 933:	b8 0f 00 00 00       	mov    $0xf,%eax
 938:	cd 40                	int    $0x40
 93a:	c3                   	ret    

0000093b <mknod>:
SYSCALL(mknod)
 93b:	b8 11 00 00 00       	mov    $0x11,%eax
 940:	cd 40                	int    $0x40
 942:	c3                   	ret    

00000943 <unlink>:
SYSCALL(unlink)
 943:	b8 12 00 00 00       	mov    $0x12,%eax
 948:	cd 40                	int    $0x40
 94a:	c3                   	ret    

0000094b <fstat>:
SYSCALL(fstat)
 94b:	b8 08 00 00 00       	mov    $0x8,%eax
 950:	cd 40                	int    $0x40
 952:	c3                   	ret    

00000953 <link>:
SYSCALL(link)
 953:	b8 13 00 00 00       	mov    $0x13,%eax
 958:	cd 40                	int    $0x40
 95a:	c3                   	ret    

0000095b <mkdir>:
SYSCALL(mkdir)
 95b:	b8 14 00 00 00       	mov    $0x14,%eax
 960:	cd 40                	int    $0x40
 962:	c3                   	ret    

00000963 <chdir>:
SYSCALL(chdir)
 963:	b8 09 00 00 00       	mov    $0x9,%eax
 968:	cd 40                	int    $0x40
 96a:	c3                   	ret    

0000096b <dup>:
SYSCALL(dup)
 96b:	b8 0a 00 00 00       	mov    $0xa,%eax
 970:	cd 40                	int    $0x40
 972:	c3                   	ret    

00000973 <getpid>:
SYSCALL(getpid)
 973:	b8 0b 00 00 00       	mov    $0xb,%eax
 978:	cd 40                	int    $0x40
 97a:	c3                   	ret    

0000097b <sbrk>:
SYSCALL(sbrk)
 97b:	b8 0c 00 00 00       	mov    $0xc,%eax
 980:	cd 40                	int    $0x40
 982:	c3                   	ret    

00000983 <sleep>:
SYSCALL(sleep)
 983:	b8 0d 00 00 00       	mov    $0xd,%eax
 988:	cd 40                	int    $0x40
 98a:	c3                   	ret    

0000098b <uptime>:
SYSCALL(uptime)
 98b:	b8 0e 00 00 00       	mov    $0xe,%eax
 990:	cd 40                	int    $0x40
 992:	c3                   	ret    

00000993 <settickets>:
SYSCALL(settickets)
 993:	b8 16 00 00 00       	mov    $0x16,%eax
 998:	cd 40                	int    $0x40
 99a:	c3                   	ret    

0000099b <getpinfo>:
SYSCALL(getpinfo)
 99b:	b8 17 00 00 00       	mov    $0x17,%eax
 9a0:	cd 40                	int    $0x40
 9a2:	c3                   	ret    
 9a3:	66 90                	xchg   %ax,%ax
 9a5:	66 90                	xchg   %ax,%ax
 9a7:	66 90                	xchg   %ax,%ax
 9a9:	66 90                	xchg   %ax,%ax
 9ab:	66 90                	xchg   %ax,%ax
 9ad:	66 90                	xchg   %ax,%ax
 9af:	90                   	nop

000009b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	83 ec 3c             	sub    $0x3c,%esp
 9b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 9bc:	89 d1                	mov    %edx,%ecx
{
 9be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 9c1:	85 d2                	test   %edx,%edx
 9c3:	0f 89 7f 00 00 00    	jns    a48 <printint+0x98>
 9c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 9cd:	74 79                	je     a48 <printint+0x98>
    neg = 1;
 9cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 9d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 9d8:	31 db                	xor    %ebx,%ebx
 9da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 9dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 9e0:	89 c8                	mov    %ecx,%eax
 9e2:	31 d2                	xor    %edx,%edx
 9e4:	89 cf                	mov    %ecx,%edi
 9e6:	f7 75 c4             	divl   -0x3c(%ebp)
 9e9:	0f b6 92 98 10 00 00 	movzbl 0x1098(%edx),%edx
 9f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 9f3:	89 d8                	mov    %ebx,%eax
 9f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 9f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 9fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 9fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 a01:	76 dd                	jbe    9e0 <printint+0x30>
  if(neg)
 a03:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 a06:	85 c9                	test   %ecx,%ecx
 a08:	74 0c                	je     a16 <printint+0x66>
    buf[i++] = '-';
 a0a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 a0f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 a11:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 a16:	8b 7d b8             	mov    -0x48(%ebp),%edi
 a19:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 a1d:	eb 07                	jmp    a26 <printint+0x76>
 a1f:	90                   	nop
    putc(fd, buf[i]);
 a20:	0f b6 13             	movzbl (%ebx),%edx
 a23:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 a26:	83 ec 04             	sub    $0x4,%esp
 a29:	88 55 d7             	mov    %dl,-0x29(%ebp)
 a2c:	6a 01                	push   $0x1
 a2e:	56                   	push   %esi
 a2f:	57                   	push   %edi
 a30:	e8 de fe ff ff       	call   913 <write>
  while(--i >= 0)
 a35:	83 c4 10             	add    $0x10,%esp
 a38:	39 de                	cmp    %ebx,%esi
 a3a:	75 e4                	jne    a20 <printint+0x70>
}
 a3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a3f:	5b                   	pop    %ebx
 a40:	5e                   	pop    %esi
 a41:	5f                   	pop    %edi
 a42:	5d                   	pop    %ebp
 a43:	c3                   	ret    
 a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 a48:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 a4f:	eb 87                	jmp    9d8 <printint+0x28>
 a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5f:	90                   	nop

00000a60 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	57                   	push   %edi
 a64:	56                   	push   %esi
 a65:	53                   	push   %ebx
 a66:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 a6c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a6f:	0f b6 13             	movzbl (%ebx),%edx
 a72:	84 d2                	test   %dl,%dl
 a74:	74 6a                	je     ae0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 a76:	8d 45 10             	lea    0x10(%ebp),%eax
 a79:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a7c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 a7f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 a81:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a84:	eb 36                	jmp    abc <printf+0x5c>
 a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
 a90:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a93:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 a98:	83 f8 25             	cmp    $0x25,%eax
 a9b:	74 15                	je     ab2 <printf+0x52>
  write(fd, &c, 1);
 a9d:	83 ec 04             	sub    $0x4,%esp
 aa0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 aa3:	6a 01                	push   $0x1
 aa5:	57                   	push   %edi
 aa6:	56                   	push   %esi
 aa7:	e8 67 fe ff ff       	call   913 <write>
 aac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 aaf:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 ab2:	0f b6 13             	movzbl (%ebx),%edx
 ab5:	83 c3 01             	add    $0x1,%ebx
 ab8:	84 d2                	test   %dl,%dl
 aba:	74 24                	je     ae0 <printf+0x80>
    c = fmt[i] & 0xff;
 abc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 abf:	85 c9                	test   %ecx,%ecx
 ac1:	74 cd                	je     a90 <printf+0x30>
      }
    } else if(state == '%'){
 ac3:	83 f9 25             	cmp    $0x25,%ecx
 ac6:	75 ea                	jne    ab2 <printf+0x52>
      if(c == 'd'){
 ac8:	83 f8 25             	cmp    $0x25,%eax
 acb:	0f 84 07 01 00 00    	je     bd8 <printf+0x178>
 ad1:	83 e8 63             	sub    $0x63,%eax
 ad4:	83 f8 15             	cmp    $0x15,%eax
 ad7:	77 17                	ja     af0 <printf+0x90>
 ad9:	ff 24 85 40 10 00 00 	jmp    *0x1040(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 ae0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ae3:	5b                   	pop    %ebx
 ae4:	5e                   	pop    %esi
 ae5:	5f                   	pop    %edi
 ae6:	5d                   	pop    %ebp
 ae7:	c3                   	ret    
 ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 aef:	90                   	nop
  write(fd, &c, 1);
 af0:	83 ec 04             	sub    $0x4,%esp
 af3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 af6:	6a 01                	push   $0x1
 af8:	57                   	push   %edi
 af9:	56                   	push   %esi
 afa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 afe:	e8 10 fe ff ff       	call   913 <write>
        putc(fd, c);
 b03:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 b07:	83 c4 0c             	add    $0xc,%esp
 b0a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 b0d:	6a 01                	push   $0x1
 b0f:	57                   	push   %edi
 b10:	56                   	push   %esi
 b11:	e8 fd fd ff ff       	call   913 <write>
        putc(fd, c);
 b16:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b19:	31 c9                	xor    %ecx,%ecx
 b1b:	eb 95                	jmp    ab2 <printf+0x52>
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 b20:	83 ec 0c             	sub    $0xc,%esp
 b23:	b9 10 00 00 00       	mov    $0x10,%ecx
 b28:	6a 00                	push   $0x0
 b2a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b2d:	8b 10                	mov    (%eax),%edx
 b2f:	89 f0                	mov    %esi,%eax
 b31:	e8 7a fe ff ff       	call   9b0 <printint>
        ap++;
 b36:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b3a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b3d:	31 c9                	xor    %ecx,%ecx
 b3f:	e9 6e ff ff ff       	jmp    ab2 <printf+0x52>
 b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 b48:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b4b:	8b 10                	mov    (%eax),%edx
        ap++;
 b4d:	83 c0 04             	add    $0x4,%eax
 b50:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 b53:	85 d2                	test   %edx,%edx
 b55:	0f 84 8d 00 00 00    	je     be8 <printf+0x188>
        while(*s != 0){
 b5b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 b5e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 b60:	84 c0                	test   %al,%al
 b62:	0f 84 4a ff ff ff    	je     ab2 <printf+0x52>
 b68:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b6b:	89 d3                	mov    %edx,%ebx
 b6d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b70:	83 ec 04             	sub    $0x4,%esp
          s++;
 b73:	83 c3 01             	add    $0x1,%ebx
 b76:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b79:	6a 01                	push   $0x1
 b7b:	57                   	push   %edi
 b7c:	56                   	push   %esi
 b7d:	e8 91 fd ff ff       	call   913 <write>
        while(*s != 0){
 b82:	0f b6 03             	movzbl (%ebx),%eax
 b85:	83 c4 10             	add    $0x10,%esp
 b88:	84 c0                	test   %al,%al
 b8a:	75 e4                	jne    b70 <printf+0x110>
      state = 0;
 b8c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 b8f:	31 c9                	xor    %ecx,%ecx
 b91:	e9 1c ff ff ff       	jmp    ab2 <printf+0x52>
 b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b9d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 ba0:	83 ec 0c             	sub    $0xc,%esp
 ba3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 ba8:	6a 01                	push   $0x1
 baa:	e9 7b ff ff ff       	jmp    b2a <printf+0xca>
 baf:	90                   	nop
        putc(fd, *ap);
 bb0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 bb3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 bb6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 bb8:	6a 01                	push   $0x1
 bba:	57                   	push   %edi
 bbb:	56                   	push   %esi
        putc(fd, *ap);
 bbc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 bbf:	e8 4f fd ff ff       	call   913 <write>
        ap++;
 bc4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 bc8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bcb:	31 c9                	xor    %ecx,%ecx
 bcd:	e9 e0 fe ff ff       	jmp    ab2 <printf+0x52>
 bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 bd8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 bdb:	83 ec 04             	sub    $0x4,%esp
 bde:	e9 2a ff ff ff       	jmp    b0d <printf+0xad>
 be3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 be7:	90                   	nop
          s = "(null)";
 be8:	ba 38 10 00 00       	mov    $0x1038,%edx
        while(*s != 0){
 bed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 bf0:	b8 28 00 00 00       	mov    $0x28,%eax
 bf5:	89 d3                	mov    %edx,%ebx
 bf7:	e9 74 ff ff ff       	jmp    b70 <printf+0x110>
 bfc:	66 90                	xchg   %ax,%ax
 bfe:	66 90                	xchg   %ax,%ax

00000c00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c01:	a1 b8 13 00 00       	mov    0x13b8,%eax
{
 c06:	89 e5                	mov    %esp,%ebp
 c08:	57                   	push   %edi
 c09:	56                   	push   %esi
 c0a:	53                   	push   %ebx
 c0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 c0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c18:	89 c2                	mov    %eax,%edx
 c1a:	8b 00                	mov    (%eax),%eax
 c1c:	39 ca                	cmp    %ecx,%edx
 c1e:	73 30                	jae    c50 <free+0x50>
 c20:	39 c1                	cmp    %eax,%ecx
 c22:	72 04                	jb     c28 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c24:	39 c2                	cmp    %eax,%edx
 c26:	72 f0                	jb     c18 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c28:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c2b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c2e:	39 f8                	cmp    %edi,%eax
 c30:	74 30                	je     c62 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 c32:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 c35:	8b 42 04             	mov    0x4(%edx),%eax
 c38:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c3b:	39 f1                	cmp    %esi,%ecx
 c3d:	74 3a                	je     c79 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 c3f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 c41:	5b                   	pop    %ebx
  freep = p;
 c42:	89 15 b8 13 00 00    	mov    %edx,0x13b8
}
 c48:	5e                   	pop    %esi
 c49:	5f                   	pop    %edi
 c4a:	5d                   	pop    %ebp
 c4b:	c3                   	ret    
 c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c50:	39 c2                	cmp    %eax,%edx
 c52:	72 c4                	jb     c18 <free+0x18>
 c54:	39 c1                	cmp    %eax,%ecx
 c56:	73 c0                	jae    c18 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 c58:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c5b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c5e:	39 f8                	cmp    %edi,%eax
 c60:	75 d0                	jne    c32 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 c62:	03 70 04             	add    0x4(%eax),%esi
 c65:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c68:	8b 02                	mov    (%edx),%eax
 c6a:	8b 00                	mov    (%eax),%eax
 c6c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 c6f:	8b 42 04             	mov    0x4(%edx),%eax
 c72:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c75:	39 f1                	cmp    %esi,%ecx
 c77:	75 c6                	jne    c3f <free+0x3f>
    p->s.size += bp->s.size;
 c79:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 c7c:	89 15 b8 13 00 00    	mov    %edx,0x13b8
    p->s.size += bp->s.size;
 c82:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 c85:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c88:	89 0a                	mov    %ecx,(%edx)
}
 c8a:	5b                   	pop    %ebx
 c8b:	5e                   	pop    %esi
 c8c:	5f                   	pop    %edi
 c8d:	5d                   	pop    %ebp
 c8e:	c3                   	ret    
 c8f:	90                   	nop

00000c90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c90:	55                   	push   %ebp
 c91:	89 e5                	mov    %esp,%ebp
 c93:	57                   	push   %edi
 c94:	56                   	push   %esi
 c95:	53                   	push   %ebx
 c96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c9c:	8b 3d b8 13 00 00    	mov    0x13b8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ca2:	8d 70 07             	lea    0x7(%eax),%esi
 ca5:	c1 ee 03             	shr    $0x3,%esi
 ca8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 cab:	85 ff                	test   %edi,%edi
 cad:	0f 84 9d 00 00 00    	je     d50 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 cb5:	8b 4a 04             	mov    0x4(%edx),%ecx
 cb8:	39 f1                	cmp    %esi,%ecx
 cba:	73 6a                	jae    d26 <malloc+0x96>
 cbc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 cc1:	39 de                	cmp    %ebx,%esi
 cc3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 cc6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 ccd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 cd0:	eb 17                	jmp    ce9 <malloc+0x59>
 cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cd8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cda:	8b 48 04             	mov    0x4(%eax),%ecx
 cdd:	39 f1                	cmp    %esi,%ecx
 cdf:	73 4f                	jae    d30 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ce1:	8b 3d b8 13 00 00    	mov    0x13b8,%edi
 ce7:	89 c2                	mov    %eax,%edx
 ce9:	39 d7                	cmp    %edx,%edi
 ceb:	75 eb                	jne    cd8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 ced:	83 ec 0c             	sub    $0xc,%esp
 cf0:	ff 75 e4             	push   -0x1c(%ebp)
 cf3:	e8 83 fc ff ff       	call   97b <sbrk>
  if(p == (char*)-1)
 cf8:	83 c4 10             	add    $0x10,%esp
 cfb:	83 f8 ff             	cmp    $0xffffffff,%eax
 cfe:	74 1c                	je     d1c <malloc+0x8c>
  hp->s.size = nu;
 d00:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 d03:	83 ec 0c             	sub    $0xc,%esp
 d06:	83 c0 08             	add    $0x8,%eax
 d09:	50                   	push   %eax
 d0a:	e8 f1 fe ff ff       	call   c00 <free>
  return freep;
 d0f:	8b 15 b8 13 00 00    	mov    0x13b8,%edx
      if((p = morecore(nunits)) == 0)
 d15:	83 c4 10             	add    $0x10,%esp
 d18:	85 d2                	test   %edx,%edx
 d1a:	75 bc                	jne    cd8 <malloc+0x48>
        return 0;
  }
}
 d1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 d1f:	31 c0                	xor    %eax,%eax
}
 d21:	5b                   	pop    %ebx
 d22:	5e                   	pop    %esi
 d23:	5f                   	pop    %edi
 d24:	5d                   	pop    %ebp
 d25:	c3                   	ret    
    if(p->s.size >= nunits){
 d26:	89 d0                	mov    %edx,%eax
 d28:	89 fa                	mov    %edi,%edx
 d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d30:	39 ce                	cmp    %ecx,%esi
 d32:	74 4c                	je     d80 <malloc+0xf0>
        p->s.size -= nunits;
 d34:	29 f1                	sub    %esi,%ecx
 d36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d3c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 d3f:	89 15 b8 13 00 00    	mov    %edx,0x13b8
}
 d45:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 d48:	83 c0 08             	add    $0x8,%eax
}
 d4b:	5b                   	pop    %ebx
 d4c:	5e                   	pop    %esi
 d4d:	5f                   	pop    %edi
 d4e:	5d                   	pop    %ebp
 d4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 d50:	c7 05 b8 13 00 00 bc 	movl   $0x13bc,0x13b8
 d57:	13 00 00 
    base.s.size = 0;
 d5a:	bf bc 13 00 00       	mov    $0x13bc,%edi
    base.s.ptr = freep = prevp = &base;
 d5f:	c7 05 bc 13 00 00 bc 	movl   $0x13bc,0x13bc
 d66:	13 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d69:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 d6b:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 d72:	00 00 00 
    if(p->s.size >= nunits){
 d75:	e9 42 ff ff ff       	jmp    cbc <malloc+0x2c>
 d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 d80:	8b 08                	mov    (%eax),%ecx
 d82:	89 0a                	mov    %ecx,(%edx)
 d84:	eb b9                	jmp    d3f <malloc+0xaf>
