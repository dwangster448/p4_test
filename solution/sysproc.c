#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "pstat.h"
#include <stdio.h>

extern struct pstat stat;

int sys_fork(void)
{
  return fork();
}

int sys_exit(void)
{
  exit();
  return 0; // not reached
}

int sys_wait(void)
{
  return wait();
}

int sys_kill(void)
{
  int pid;

  if (argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int sys_getpid(void)
{
  return myproc()->pid;
}

int sys_sbrk(void)
{
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if (growproc(n) < 0)
    return -1;
  return addr;
}

int sys_sleep(void)
{
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n)
  {
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int settickets(void) //This is not a normal syscall, need to use argint, argptr to retrieve values
{
  acquire(&tickslock);

  int n = 0;
  //use a argint here to retrieve int n argument

  if (n < 1)
  {
    n = 8;
  }
  if (n > 5)
  {
    return 1; // TODO: Check if return value = -1
  }
  myproc()->tickets = n;
  // TODO: Update global values

  // TODO change process's stride value
  // myproc()->stride = STRIDE1 / myproc()->tickets;

  // TODO change process's remain?? It's not leaving the queue tho
  //

  // TODO change process's pass value

  release(&tickslock);
  return 0;
}

// Function to initialize a pstat structure
void init_pstat(struct pstat *stat)
{
  for (int i = 0; i < NPROC; i++)
  {
    stat->inuse[i] = 0;
    stat->tickets[i] = 8;
    stat->pid[i] = 0;
    stat->pass[i] = 0;
    stat->remain[i] = 0;
    stat->stride[i] = 0;
    stat->rtime[i] = 0;
  }
}

int getpinfo(void) //This is not a normal syscall, need to use argint, argptr to retrieve values
{
  // acquire(&tickslock);
  // struct pstat local_stat;

  // init_pstat(&local_stat);

  // init_pstat(&stat);

  struct pstat *stat;

  if (argptr(0, (char **)&stat, sizeof(stat)) < 0) //0 indexing arguments
  {
    return -1; // Failed fetching pointer to stat structure
  }

  struct proc *p = myproc();

  if (p == 0)
  {
    return -1;
  }

  int index = procindex(p); // Index to insert into
  if (index < 0 || index >= NPROC)
  {
    release(&tickslock);
    return -1; // Out-of-bounds error
  }

  // cprintf("getpinfo called for PID: %d, Index: %d, State: %d\n", p->pid, index, p->state);

  stat->inuse[index] = (p->state != UNUSED) ? 1 : 0;
  stat->tickets[index] = p->tickets;
  stat->pid[index] = p->pid;
  stat->pass[index] = p->pass;
  stat->remain[index] = p->remain;
  stat->stride[index] = p->stride;
  stat->rtime[index] = p->rtime;

  // Update the local_stat with current process information
  // local_stat.inuse[index] = (p->state != UNUSED) ? 1 : 0;
  // local_stat.tickets[index] = p->tickets;
  // local_stat.pid[index] = p->pid;
  // local_stat.pass[index] = p->pass;
  // local_stat.remain[index] = p->remain;
  // local_stat.stride[index] = p->stride;
  // local_stat.rtime[index] = p->rtime;

  // Copy the filled local_stat to the pointer passed to the function
  // *stat = local_stat;

  // release(&tickslock);

  // cprintf("Reached end of getpinfo for PID: %d\n", p->pid);
  return 0;
}
