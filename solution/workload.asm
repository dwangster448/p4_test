
_workload:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void long_running_task(long duration);
void measure(int counter, int start_time, int fd);
void itoa(int n, char* s);
void write_csv_line(int fd, int current_time, int pid, int tickets, int pass, int stride, int runtime);

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 50             	sub    $0x50,%esp
  // printf(1, "In workload\n");
  
  int i;
  int pid;

  int fd = open(CSVFILE, O_CREATE | O_WRONLY);
  14:	68 01 02 00 00       	push   $0x201
  19:	68 04 0d 00 00       	push   $0xd04
  1e:	e8 60 08 00 00       	call   883 <open>
  if (fd < 0) {
  23:	83 c4 10             	add    $0x10,%esp
  26:	85 c0                	test   %eax,%eax
  28:	0f 88 1f 01 00 00    	js     14d <main+0x14d>
    printf(1, "Failed to open file for writing\n");
    exit();
  }
  write(fd, CSVHEADER, strlen(CSVHEADER));
  2e:	83 ec 0c             	sub    $0xc,%esp
  31:	89 c3                	mov    %eax,%ebx
  33:	8d 75 cc             	lea    -0x34(%ebp),%esi
  36:	68 a8 0d 00 00       	push   $0xda8
  3b:	e8 40 06 00 00       	call   680 <strlen>
  40:	83 c4 0c             	add    $0xc,%esp
  43:	50                   	push   %eax
  44:	68 a8 0d 00 00       	push   $0xda8
  49:	53                   	push   %ebx
  4a:	e8 14 08 00 00       	call   863 <write>

  int ticket_values[TOTAL_PROCESSES];
  // Assign tickets for the initial processes
  ticket_values[0] = 1;
  4f:	c7 45 a8 01 00 00 00 	movl   $0x1,-0x58(%ebp)
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  56:	8d 4d a8             	lea    -0x58(%ebp),%ecx
  59:	83 c4 10             	add    $0x10,%esp
  ticket_values[0] = 1;
  5c:	89 c8                	mov    %ecx,%eax
  5e:	66 90                	xchg   %ax,%ax
    ticket_values[i] = ticket_values[i - 1] * 2; // Tickets: 2, 4, 8, 16, 32, 32, 32, 32, 32
  60:	8b 38                	mov    (%eax),%edi
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  62:	83 c0 04             	add    $0x4,%eax
    ticket_values[i] = ticket_values[i - 1] * 2; // Tickets: 2, 4, 8, 16, 32, 32, 32, 32, 32
  65:	8d 14 3f             	lea    (%edi,%edi,1),%edx
  68:	89 10                	mov    %edx,(%eax)
  for (i = 1; i < INITIAL_PROCESSES; i++) {
  6a:	39 c6                	cmp    %eax,%esi
  6c:	75 f2                	jne    60 <main+0x60>
  }

  // Assign different tickets for the additional processes
  ticket_values[INITIAL_PROCESSES] = 128;
  6e:	c7 45 d0 80 00 00 00 	movl   $0x80,-0x30(%ebp)
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  75:	8d 51 14             	lea    0x14(%ecx),%edx
    ticket_values[i] = ticket_values[i - 1] / 4; // Tickets: 32, 8, 2, 0, 0, 0
  78:	8b 71 28             	mov    0x28(%ecx),%esi
  7b:	85 f6                	test   %esi,%esi
  7d:	8d 46 03             	lea    0x3(%esi),%eax
  80:	0f 49 c6             	cmovns %esi,%eax
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  83:	83 c1 04             	add    $0x4,%ecx
    ticket_values[i] = ticket_values[i - 1] / 4; // Tickets: 32, 8, 2, 0, 0, 0
  86:	c1 f8 02             	sar    $0x2,%eax
  89:	89 41 28             	mov    %eax,0x28(%ecx)
  for (i = INITIAL_PROCESSES + 1; i < TOTAL_PROCESSES; i++) {
  8c:	39 d1                	cmp    %edx,%ecx
  8e:	75 e8                	jne    78 <main+0x78>
  }

  printf(1, "Starting initial %d processes.\n", INITIAL_PROCESSES);
  90:	50                   	push   %eax
  for (i = 0; i < INITIAL_PROCESSES; i++) {
  91:	31 f6                	xor    %esi,%esi
  printf(1, "Starting initial %d processes.\n", INITIAL_PROCESSES);
  93:	6a 0a                	push   $0xa
  95:	68 d0 0d 00 00       	push   $0xdd0
  9a:	6a 01                	push   $0x1
  9c:	e8 0f 09 00 00       	call   9b0 <printf>
  a1:	83 c4 10             	add    $0x10,%esp
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
  a8:	e8 8e 07 00 00       	call   83b <fork>
    if (pid < 0) {
  ad:	85 c0                	test   %eax,%eax
  af:	0f 88 ab 00 00 00    	js     160 <main+0x160>
      printf(1, "Fork failed\n");
      exit();
    }
    else if (pid == 0) {
  b5:	0f 84 b8 00 00 00    	je     173 <main+0x173>
  for (i = 0; i < INITIAL_PROCESSES; i++) {
  bb:	83 c6 01             	add    $0x1,%esi
  be:	83 fe 0a             	cmp    $0xa,%esi
  c1:	75 e5                	jne    a8 <main+0xa8>
      exit();
    }
  }


  int start_time = uptime();
  c3:	e8 13 08 00 00       	call   8db <uptime>
  // Allow initial processes to run for a while
  sleep(100);
  c8:	83 ec 0c             	sub    $0xc,%esp
  cb:	6a 64                	push   $0x64
  int start_time = uptime();
  cd:	89 c7                	mov    %eax,%edi
  sleep(100);
  cf:	e8 ff 07 00 00       	call   8d3 <sleep>

  measure(20, start_time, fd);
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	53                   	push   %ebx
  d8:	57                   	push   %edi
  d9:	6a 14                	push   $0x14
  db:	e8 c0 03 00 00       	call   4a0 <measure>

  printf(1, "Adding additional %d processes with different tickets.\n", ADDITIONAL_PROCESSES);
  e0:	83 c4 0c             	add    $0xc,%esp
  e3:	6a 06                	push   $0x6
  e5:	68 f0 0d 00 00       	push   $0xdf0
  ea:	6a 01                	push   $0x1
  ec:	e8 bf 08 00 00       	call   9b0 <printf>
  f1:	83 c4 10             	add    $0x10,%esp
  for (i = INITIAL_PROCESSES; i < TOTAL_PROCESSES; i++) {
    pid = fork();
  f4:	e8 42 07 00 00       	call   83b <fork>
    if (pid < 0) {
  f9:	85 c0                	test   %eax,%eax
  fb:	78 63                	js     160 <main+0x160>
      printf(1, "Fork failed\n");
      exit();
    }
    else if (pid == 0) {
  fd:	74 74                	je     173 <main+0x173>
  for (i = INITIAL_PROCESSES; i < TOTAL_PROCESSES; i++) {
  ff:	83 c6 01             	add    $0x1,%esi
 102:	83 fe 10             	cmp    $0x10,%esi
 105:	75 ed                	jne    f4 <main+0xf4>
      exit();
    }
  }


  measure(20, start_time, fd);
 107:	52                   	push   %edx
 108:	53                   	push   %ebx
 109:	57                   	push   %edi
 10a:	6a 14                	push   $0x14
 10c:	e8 8f 03 00 00       	call   4a0 <measure>
  printf(1, "Done measuring.\n");
 111:	59                   	pop    %ecx
 112:	5e                   	pop    %esi
 113:	68 26 0d 00 00       	push   $0xd26
 118:	6a 01                	push   $0x1
 11a:	e8 91 08 00 00       	call   9b0 <printf>

  if (fd >= 0) {
    close(fd);
 11f:	89 1c 24             	mov    %ebx,(%esp)
 122:	bb 10 00 00 00       	mov    $0x10,%ebx
 127:	e8 3f 07 00 00       	call   86b <close>
 12c:	83 c4 10             	add    $0x10,%esp
 12f:	90                   	nop
  }

  for (i = 0; i < TOTAL_PROCESSES; i++) {
    wait();
 130:	e8 16 07 00 00       	call   84b <wait>
  for (i = 0; i < TOTAL_PROCESSES; i++) {
 135:	83 eb 01             	sub    $0x1,%ebx
 138:	75 f6                	jne    130 <main+0x130>
  }
  printf(1, "All child processes have completed.\n");
 13a:	50                   	push   %eax
 13b:	50                   	push   %eax
 13c:	68 28 0e 00 00       	push   $0xe28
 141:	6a 01                	push   $0x1
 143:	e8 68 08 00 00       	call   9b0 <printf>
  exit();
 148:	e8 f6 06 00 00       	call   843 <exit>
    printf(1, "Failed to open file for writing\n");
 14d:	50                   	push   %eax
 14e:	50                   	push   %eax
 14f:	68 84 0d 00 00       	push   $0xd84
 154:	6a 01                	push   $0x1
 156:	e8 55 08 00 00       	call   9b0 <printf>
    exit();
 15b:	e8 e3 06 00 00       	call   843 <exit>
      printf(1, "Fork failed\n");
 160:	57                   	push   %edi
 161:	57                   	push   %edi
 162:	68 19 0d 00 00       	push   $0xd19
 167:	6a 01                	push   $0x1
 169:	e8 42 08 00 00       	call   9b0 <printf>
      exit();
 16e:	e8 d0 06 00 00       	call   843 <exit>
      settickets(ticket_values[i]); // Set tickets for this process
 173:	83 ec 0c             	sub    $0xc,%esp
 176:	ff 74 b5 a8          	push   -0x58(%ebp,%esi,4)
 17a:	e8 64 07 00 00       	call   8e3 <settickets>
      long_running_task(WORKLOAD_TIME);
 17f:	c7 04 24 00 e1 f5 05 	movl   $0x5f5e100,(%esp)
 186:	e8 a5 00 00 00       	call   230 <long_running_task>
      exit();
 18b:	e8 b3 06 00 00       	call   843 <exit>

00000190 <itoa.part.0>:

  // Write to file
  write(fd, buffer, offset);
}

void itoa(int n, char* s) {
 190:	55                   	push   %ebp
 191:	89 c1                	mov    %eax,%ecx
 193:	89 e5                	mov    %esp,%ebp
 195:	57                   	push   %edi
 196:	56                   	push   %esi
 197:	89 d6                	mov    %edx,%esi
 199:	53                   	push   %ebx
 19a:	83 ec 04             	sub    $0x4,%esp
  int i = 0;
  int is_negative = 0;
 19d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if (n == 0) {
    s[i++] = '0';
    s[i] = '\0';
    return;
  }
  if (n < 0) {
 1a4:	85 c0                	test   %eax,%eax
 1a6:	78 78                	js     220 <itoa.part.0+0x90>
void itoa(int n, char* s) {
 1a8:	31 ff                	xor    %edi,%edi
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    is_negative = 1;
    n = -n;
  }
  while (n > 0) {
    s[i++] = (n % 10) + '0';
 1b0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 1b5:	89 fb                	mov    %edi,%ebx
 1b7:	8d 7f 01             	lea    0x1(%edi),%edi
 1ba:	f7 e1                	mul    %ecx
 1bc:	c1 ea 03             	shr    $0x3,%edx
 1bf:	8d 04 92             	lea    (%edx,%edx,4),%eax
 1c2:	01 c0                	add    %eax,%eax
 1c4:	29 c1                	sub    %eax,%ecx
 1c6:	83 c1 30             	add    $0x30,%ecx
 1c9:	88 4c 3e ff          	mov    %cl,-0x1(%esi,%edi,1)
    n /= 10;
 1cd:	89 d1                	mov    %edx,%ecx
  while (n > 0) {
 1cf:	85 d2                	test   %edx,%edx
 1d1:	75 dd                	jne    1b0 <itoa.part.0+0x20>
  }
  if (is_negative) {
 1d3:	8b 55 f0             	mov    -0x10(%ebp),%edx
    s[i++] = '-';
 1d6:	8d 04 3e             	lea    (%esi,%edi,1),%eax
  if (is_negative) {
 1d9:	85 d2                	test   %edx,%edx
 1db:	74 33                	je     210 <itoa.part.0+0x80>
    s[i++] = '-';
 1dd:	c6 00 2d             	movb   $0x2d,(%eax)
  }
  s[i] = '\0';
 1e0:	c6 44 1e 02 00       	movb   $0x0,0x2(%esi,%ebx,1)
    s[i++] = (n % 10) + '0';
 1e5:	89 fb                	mov    %edi,%ebx
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax
  // Reverse the string
  int start = 0;
  int end = i - 1;
  char temp;
  while (start < end) {
    temp = s[start];
 1f0:	0f b6 14 0e          	movzbl (%esi,%ecx,1),%edx
    s[start] = s[end];
 1f4:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
 1f8:	88 04 0e             	mov    %al,(%esi,%ecx,1)
    s[end] = temp;
    start++;
 1fb:	83 c1 01             	add    $0x1,%ecx
    s[end] = temp;
 1fe:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
    end--;
 201:	83 eb 01             	sub    $0x1,%ebx
  while (start < end) {
 204:	39 d9                	cmp    %ebx,%ecx
 206:	7c e8                	jl     1f0 <itoa.part.0+0x60>
  }
}
 208:	83 c4 04             	add    $0x4,%esp
 20b:	5b                   	pop    %ebx
 20c:	5e                   	pop    %esi
 20d:	5f                   	pop    %edi
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    
  s[i] = '\0';
 210:	c6 00 00             	movb   $0x0,(%eax)
  while (start < end) {
 213:	85 db                	test   %ebx,%ebx
 215:	75 d9                	jne    1f0 <itoa.part.0+0x60>
}
 217:	83 c4 04             	add    $0x4,%esp
 21a:	5b                   	pop    %ebx
 21b:	5e                   	pop    %esi
 21c:	5f                   	pop    %edi
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop
    is_negative = 1;
 220:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    n = -n;
 227:	f7 d9                	neg    %ecx
 229:	e9 7a ff ff ff       	jmp    1a8 <itoa.part.0+0x18>
 22e:	66 90                	xchg   %ax,%ax

00000230 <long_running_task>:
void long_running_task(long duration) {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	83 ec 10             	sub    $0x10,%esp
  for (i = 0; i < duration; i++) {
 236:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
void long_running_task(long duration) {
 23d:	8b 55 08             	mov    0x8(%ebp),%edx
  for (i = 0; i < duration; i++) {
 240:	8b 45 f8             	mov    -0x8(%ebp),%eax
 243:	39 c2                	cmp    %eax,%edx
 245:	7e 39                	jle    280 <long_running_task+0x50>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax
    for (j = 0; j < duration; j++) {
 250:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 257:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25a:	39 c2                	cmp    %eax,%edx
 25c:	7e 12                	jle    270 <long_running_task+0x40>
 25e:	66 90                	xchg   %ax,%ax
 260:	8b 45 fc             	mov    -0x4(%ebp),%eax
 263:	83 c0 01             	add    $0x1,%eax
 266:	89 45 fc             	mov    %eax,-0x4(%ebp)
 269:	8b 45 fc             	mov    -0x4(%ebp),%eax
 26c:	39 d0                	cmp    %edx,%eax
 26e:	7c f0                	jl     260 <long_running_task+0x30>
  for (i = 0; i < duration; i++) {
 270:	8b 45 f8             	mov    -0x8(%ebp),%eax
 273:	83 c0 01             	add    $0x1,%eax
 276:	89 45 f8             	mov    %eax,-0x8(%ebp)
 279:	8b 45 f8             	mov    -0x8(%ebp),%eax
 27c:	39 d0                	cmp    %edx,%eax
 27e:	7c d0                	jl     250 <long_running_task+0x20>
}
 280:	c9                   	leave  
 281:	c3                   	ret    
 282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <write_csv_line>:
void write_csv_line(int fd, int current_time, int pid, int tickets, int pass, int stride, int runtime) {
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
 296:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
 29c:	8b 45 0c             	mov    0xc(%ebp),%eax
  if (n == 0) {
 29f:	85 c0                	test   %eax,%eax
 2a1:	0f 84 71 01 00 00    	je     418 <write_csv_line+0x188>
 2a7:	8d 9d dc fe ff ff    	lea    -0x124(%ebp),%ebx
 2ad:	89 da                	mov    %ebx,%edx
 2af:	e8 dc fe ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 2b4:	83 ec 08             	sub    $0x8,%esp
 2b7:	8d b5 e8 fe ff ff    	lea    -0x118(%ebp),%esi
 2bd:	53                   	push   %ebx
 2be:	56                   	push   %esi
 2bf:	e8 2c 03 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 2c4:	89 1c 24             	mov    %ebx,(%esp)
 2c7:	e8 b4 03 00 00       	call   680 <strlen>
  if (n == 0) {
 2cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2cf:	83 c4 10             	add    $0x10,%esp
  buffer[offset++] = ',';
 2d2:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 2d9:	2c 
 2da:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 2dd:	85 c9                	test   %ecx,%ecx
 2df:	0f 84 a3 01 00 00    	je     488 <write_csv_line+0x1f8>
 2e5:	8b 45 10             	mov    0x10(%ebp),%eax
 2e8:	89 da                	mov    %ebx,%edx
 2ea:	e8 a1 fe ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 2ef:	83 ec 08             	sub    $0x8,%esp
 2f2:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 2f5:	53                   	push   %ebx
 2f6:	50                   	push   %eax
 2f7:	e8 f4 02 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 2fc:	89 1c 24             	mov    %ebx,(%esp)
 2ff:	e8 7c 03 00 00       	call   680 <strlen>
  if (n == 0) {
 304:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 307:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 309:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 310:	2c 
 311:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 314:	8b 45 14             	mov    0x14(%ebp),%eax
 317:	85 c0                	test   %eax,%eax
 319:	0f 84 51 01 00 00    	je     470 <write_csv_line+0x1e0>
 31f:	8b 45 14             	mov    0x14(%ebp),%eax
 322:	89 da                	mov    %ebx,%edx
 324:	e8 67 fe ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 32f:	53                   	push   %ebx
 330:	50                   	push   %eax
 331:	e8 ba 02 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 336:	89 1c 24             	mov    %ebx,(%esp)
 339:	e8 42 03 00 00       	call   680 <strlen>
  if (n == 0) {
 33e:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 341:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 343:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 34a:	2c 
 34b:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 34e:	8b 45 18             	mov    0x18(%ebp),%eax
 351:	85 c0                	test   %eax,%eax
 353:	0f 84 ff 00 00 00    	je     458 <write_csv_line+0x1c8>
 359:	8b 45 18             	mov    0x18(%ebp),%eax
 35c:	89 da                	mov    %ebx,%edx
 35e:	e8 2d fe ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 363:	83 ec 08             	sub    $0x8,%esp
 366:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 369:	53                   	push   %ebx
 36a:	50                   	push   %eax
 36b:	e8 80 02 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 370:	89 1c 24             	mov    %ebx,(%esp)
 373:	e8 08 03 00 00       	call   680 <strlen>
  if (n == 0) {
 378:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 37b:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 37d:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 384:	2c 
 385:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 388:	8b 45 1c             	mov    0x1c(%ebp),%eax
 38b:	85 c0                	test   %eax,%eax
 38d:	0f 84 ad 00 00 00    	je     440 <write_csv_line+0x1b0>
 393:	8b 45 1c             	mov    0x1c(%ebp),%eax
 396:	89 da                	mov    %ebx,%edx
 398:	e8 f3 fd ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 39d:	83 ec 08             	sub    $0x8,%esp
 3a0:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 3a3:	53                   	push   %ebx
 3a4:	50                   	push   %eax
 3a5:	e8 46 02 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 3aa:	89 1c 24             	mov    %ebx,(%esp)
 3ad:	e8 ce 02 00 00       	call   680 <strlen>
  if (n == 0) {
 3b2:	8b 55 20             	mov    0x20(%ebp),%edx
 3b5:	83 c4 10             	add    $0x10,%esp
  offset += strlen(temp_str);
 3b8:	01 f8                	add    %edi,%eax
  buffer[offset++] = ',';
 3ba:	c6 84 05 e8 fe ff ff 	movb   $0x2c,-0x118(%ebp,%eax,1)
 3c1:	2c 
 3c2:	8d 78 01             	lea    0x1(%eax),%edi
  if (n == 0) {
 3c5:	85 d2                	test   %edx,%edx
 3c7:	74 67                	je     430 <write_csv_line+0x1a0>
 3c9:	8b 45 20             	mov    0x20(%ebp),%eax
 3cc:	89 da                	mov    %ebx,%edx
 3ce:	e8 bd fd ff ff       	call   190 <itoa.part.0>
  strcpy(buffer + offset, temp_str);
 3d3:	83 ec 08             	sub    $0x8,%esp
 3d6:	8d 04 3e             	lea    (%esi,%edi,1),%eax
 3d9:	53                   	push   %ebx
 3da:	50                   	push   %eax
 3db:	e8 10 02 00 00       	call   5f0 <strcpy>
  offset += strlen(temp_str);
 3e0:	89 1c 24             	mov    %ebx,(%esp)
 3e3:	e8 98 02 00 00       	call   680 <strlen>
  write(fd, buffer, offset);
 3e8:	83 c4 0c             	add    $0xc,%esp
  offset += strlen(temp_str);
 3eb:	01 c7                	add    %eax,%edi
  buffer[offset++] = '\n';
 3ed:	8d 47 01             	lea    0x1(%edi),%eax
 3f0:	c6 84 3d e8 fe ff ff 	movb   $0xa,-0x118(%ebp,%edi,1)
 3f7:	0a 
  write(fd, buffer, offset);
 3f8:	50                   	push   %eax
 3f9:	56                   	push   %esi
 3fa:	ff 75 08             	push   0x8(%ebp)
  buffer[offset] = '\0';
 3fd:	c6 84 3d e9 fe ff ff 	movb   $0x0,-0x117(%ebp,%edi,1)
 404:	00 
  write(fd, buffer, offset);
 405:	e8 59 04 00 00       	call   863 <write>
}
 40a:	83 c4 10             	add    $0x10,%esp
 40d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 410:	5b                   	pop    %ebx
 411:	5e                   	pop    %esi
 412:	5f                   	pop    %edi
 413:	5d                   	pop    %ebp
 414:	c3                   	ret    
 415:	8d 76 00             	lea    0x0(%esi),%esi
    s[i++] = '0';
 418:	bb 30 00 00 00       	mov    $0x30,%ebx
 41d:	66 89 9d dc fe ff ff 	mov    %bx,-0x124(%ebp)
    return;
 424:	8d 9d dc fe ff ff    	lea    -0x124(%ebp),%ebx
 42a:	e9 85 fe ff ff       	jmp    2b4 <write_csv_line+0x24>
 42f:	90                   	nop
    s[i++] = '0';
 430:	b8 30 00 00 00       	mov    $0x30,%eax
 435:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 43c:	eb 95                	jmp    3d3 <write_csv_line+0x143>
 43e:	66 90                	xchg   %ax,%ax
    s[i++] = '0';
 440:	b9 30 00 00 00       	mov    $0x30,%ecx
 445:	66 89 8d dc fe ff ff 	mov    %cx,-0x124(%ebp)
    return;
 44c:	e9 4c ff ff ff       	jmp    39d <write_csv_line+0x10d>
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 458:	b8 30 00 00 00       	mov    $0x30,%eax
 45d:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 464:	e9 fa fe ff ff       	jmp    363 <write_csv_line+0xd3>
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 470:	b8 30 00 00 00       	mov    $0x30,%eax
 475:	66 89 85 dc fe ff ff 	mov    %ax,-0x124(%ebp)
    return;
 47c:	e9 a8 fe ff ff       	jmp    329 <write_csv_line+0x99>
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s[i++] = '0';
 488:	ba 30 00 00 00       	mov    $0x30,%edx
 48d:	66 89 95 dc fe ff ff 	mov    %dx,-0x124(%ebp)
    return;
 494:	e9 56 fe ff ff       	jmp    2ef <write_csv_line+0x5f>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <measure>:
void measure(int counter, int start_time, int fd) {
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	81 ec 0c 07 00 00    	sub    $0x70c,%esp
  while (counter) {
 4ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4af:	85 db                	test   %ebx,%ebx
 4b1:	0f 84 de 00 00 00    	je     595 <measure+0xf5>
 4b7:	8d bd e8 f9 ff ff    	lea    -0x618(%ebp),%edi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    if (getpinfo(&ps) != 0) {
 4c0:	83 ec 0c             	sub    $0xc,%esp
 4c3:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
 4c9:	50                   	push   %eax
 4ca:	e8 1c 04 00 00       	call   8eb <getpinfo>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	85 c0                	test   %eax,%eax
 4d4:	0f 85 c3 00 00 00    	jne    59d <measure+0xfd>
    int curr_time = uptime() - start_time;
 4da:	e8 fc 03 00 00       	call   8db <uptime>
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 4df:	83 ec 04             	sub    $0x4,%esp
    int curr_time = uptime() - start_time;
 4e2:	2b 45 0c             	sub    0xc(%ebp),%eax
 4e5:	8d b5 e8 f8 ff ff    	lea    -0x718(%ebp),%esi
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 4eb:	50                   	push   %eax
    int curr_time = uptime() - start_time;
 4ec:	89 c3                	mov    %eax,%ebx
    printf(1, "\nProcess statistics at time %d ticks:\n", curr_time);
 4ee:	68 38 0d 00 00       	push   $0xd38
 4f3:	6a 01                	push   $0x1
 4f5:	e8 b6 04 00 00       	call   9b0 <printf>
    printf(1, "PID\tTickets\tPass\tStride\tRuntime\n");
 4fa:	5a                   	pop    %edx
 4fb:	59                   	pop    %ecx
 4fc:	68 60 0d 00 00       	push   $0xd60
 501:	6a 01                	push   $0x1
 503:	e8 a8 04 00 00       	call   9b0 <printf>
    for (int i = 0; i < NPROC; i++) {
 508:	83 c4 10             	add    $0x10,%esp
 50b:	eb 0a                	jmp    517 <measure+0x77>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
 510:	83 c6 04             	add    $0x4,%esi
 513:	39 fe                	cmp    %edi,%esi
 515:	74 67                	je     57e <measure+0xde>
      if (ps.inuse[i]) {
 517:	8b 06                	mov    (%esi),%eax
 519:	85 c0                	test   %eax,%eax
 51b:	74 f3                	je     510 <measure+0x70>
        printf(1, "%d\t%d\t%d\t%d\t%d\n",
 51d:	83 ec 04             	sub    $0x4,%esp
 520:	ff b6 00 06 00 00    	push   0x600(%esi)
    for (int i = 0; i < NPROC; i++) {
 526:	83 c6 04             	add    $0x4,%esi
        printf(1, "%d\t%d\t%d\t%d\t%d\n",
 529:	ff b6 fc 04 00 00    	push   0x4fc(%esi)
 52f:	ff b6 fc 02 00 00    	push   0x2fc(%esi)
 535:	ff b6 fc 00 00 00    	push   0xfc(%esi)
 53b:	ff b6 fc 01 00 00    	push   0x1fc(%esi)
 541:	68 f4 0c 00 00       	push   $0xcf4
 546:	6a 01                	push   $0x1
 548:	e8 63 04 00 00       	call   9b0 <printf>
        write_csv_line(fd,
 54d:	83 c4 1c             	add    $0x1c,%esp
 550:	ff b6 fc 05 00 00    	push   0x5fc(%esi)
 556:	ff b6 fc 04 00 00    	push   0x4fc(%esi)
 55c:	ff b6 fc 02 00 00    	push   0x2fc(%esi)
 562:	ff b6 fc 00 00 00    	push   0xfc(%esi)
 568:	ff b6 fc 01 00 00    	push   0x1fc(%esi)
 56e:	53                   	push   %ebx
 56f:	ff 75 10             	push   0x10(%ebp)
 572:	e8 19 fd ff ff       	call   290 <write_csv_line>
 577:	83 c4 20             	add    $0x20,%esp
    for (int i = 0; i < NPROC; i++) {
 57a:	39 fe                	cmp    %edi,%esi
 57c:	75 99                	jne    517 <measure+0x77>
    sleep(50); // Collect data every 50 ticks
 57e:	83 ec 0c             	sub    $0xc,%esp
 581:	6a 32                	push   $0x32
 583:	e8 4b 03 00 00       	call   8d3 <sleep>
  while (counter) {
 588:	83 c4 10             	add    $0x10,%esp
 58b:	83 6d 08 01          	subl   $0x1,0x8(%ebp)
 58f:	0f 85 2b ff ff ff    	jne    4c0 <measure+0x20>
}
 595:	8d 65 f4             	lea    -0xc(%ebp),%esp
 598:	5b                   	pop    %ebx
 599:	5e                   	pop    %esi
 59a:	5f                   	pop    %edi
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret    
      printf(1, "Failed to get process info\n");
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	68 d8 0c 00 00       	push   $0xcd8
 5a5:	6a 01                	push   $0x1
 5a7:	e8 04 04 00 00       	call   9b0 <printf>
      exit();
 5ac:	e8 92 02 00 00       	call   843 <exit>
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop

000005c0 <itoa>:
void itoa(int n, char* s) {
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  if (n == 0) {
 5c9:	85 c0                	test   %eax,%eax
 5cb:	74 0b                	je     5d8 <itoa+0x18>
}
 5cd:	5d                   	pop    %ebp
 5ce:	e9 bd fb ff ff       	jmp    190 <itoa.part.0>
 5d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d7:	90                   	nop
    s[i++] = '0';
 5d8:	b8 30 00 00 00       	mov    $0x30,%eax
 5dd:	66 89 02             	mov    %ax,(%edx)
}
 5e0:	5d                   	pop    %ebp
 5e1:	c3                   	ret    
 5e2:	66 90                	xchg   %ax,%ax
 5e4:	66 90                	xchg   %ax,%ax
 5e6:	66 90                	xchg   %ax,%ax
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 5f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5f1:	31 c0                	xor    %eax,%eax
{
 5f3:	89 e5                	mov    %esp,%ebp
 5f5:	53                   	push   %ebx
 5f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 600:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 604:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 607:	83 c0 01             	add    $0x1,%eax
 60a:	84 d2                	test   %dl,%dl
 60c:	75 f2                	jne    600 <strcpy+0x10>
    ;
  return os;
}
 60e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 611:	89 c8                	mov    %ecx,%eax
 613:	c9                   	leave  
 614:	c3                   	ret    
 615:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	53                   	push   %ebx
 624:	8b 55 08             	mov    0x8(%ebp),%edx
 627:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 62a:	0f b6 02             	movzbl (%edx),%eax
 62d:	84 c0                	test   %al,%al
 62f:	75 17                	jne    648 <strcmp+0x28>
 631:	eb 3a                	jmp    66d <strcmp+0x4d>
 633:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 637:	90                   	nop
 638:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 63c:	83 c2 01             	add    $0x1,%edx
 63f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 642:	84 c0                	test   %al,%al
 644:	74 1a                	je     660 <strcmp+0x40>
    p++, q++;
 646:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 648:	0f b6 19             	movzbl (%ecx),%ebx
 64b:	38 c3                	cmp    %al,%bl
 64d:	74 e9                	je     638 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 64f:	29 d8                	sub    %ebx,%eax
}
 651:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 654:	c9                   	leave  
 655:	c3                   	ret    
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 660:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 664:	31 c0                	xor    %eax,%eax
 666:	29 d8                	sub    %ebx,%eax
}
 668:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 66b:	c9                   	leave  
 66c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 66d:	0f b6 19             	movzbl (%ecx),%ebx
 670:	31 c0                	xor    %eax,%eax
 672:	eb db                	jmp    64f <strcmp+0x2f>
 674:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop

00000680 <strlen>:

uint
strlen(const char *s)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 686:	80 3a 00             	cmpb   $0x0,(%edx)
 689:	74 15                	je     6a0 <strlen+0x20>
 68b:	31 c0                	xor    %eax,%eax
 68d:	8d 76 00             	lea    0x0(%esi),%esi
 690:	83 c0 01             	add    $0x1,%eax
 693:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 697:	89 c1                	mov    %eax,%ecx
 699:	75 f5                	jne    690 <strlen+0x10>
    ;
  return n;
}
 69b:	89 c8                	mov    %ecx,%eax
 69d:	5d                   	pop    %ebp
 69e:	c3                   	ret    
 69f:	90                   	nop
  for(n = 0; s[n]; n++)
 6a0:	31 c9                	xor    %ecx,%ecx
}
 6a2:	5d                   	pop    %ebp
 6a3:	89 c8                	mov    %ecx,%eax
 6a5:	c3                   	ret    
 6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi

000006b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 6b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 6bd:	89 d7                	mov    %edx,%edi
 6bf:	fc                   	cld    
 6c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 6c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 6c5:	89 d0                	mov    %edx,%eax
 6c7:	c9                   	leave  
 6c8:	c3                   	ret    
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <strchr>:

char*
strchr(const char *s, char c)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	8b 45 08             	mov    0x8(%ebp),%eax
 6d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 6da:	0f b6 10             	movzbl (%eax),%edx
 6dd:	84 d2                	test   %dl,%dl
 6df:	75 12                	jne    6f3 <strchr+0x23>
 6e1:	eb 1d                	jmp    700 <strchr+0x30>
 6e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e7:	90                   	nop
 6e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 6ec:	83 c0 01             	add    $0x1,%eax
 6ef:	84 d2                	test   %dl,%dl
 6f1:	74 0d                	je     700 <strchr+0x30>
    if(*s == c)
 6f3:	38 d1                	cmp    %dl,%cl
 6f5:	75 f1                	jne    6e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 6f7:	5d                   	pop    %ebp
 6f8:	c3                   	ret    
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 700:	31 c0                	xor    %eax,%eax
}
 702:	5d                   	pop    %ebp
 703:	c3                   	ret    
 704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop

00000710 <gets>:

char*
gets(char *buf, int max)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 715:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 718:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 719:	31 db                	xor    %ebx,%ebx
{
 71b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 71e:	eb 27                	jmp    747 <gets+0x37>
    cc = read(0, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
 723:	6a 01                	push   $0x1
 725:	57                   	push   %edi
 726:	6a 00                	push   $0x0
 728:	e8 2e 01 00 00       	call   85b <read>
    if(cc < 1)
 72d:	83 c4 10             	add    $0x10,%esp
 730:	85 c0                	test   %eax,%eax
 732:	7e 1d                	jle    751 <gets+0x41>
      break;
    buf[i++] = c;
 734:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 738:	8b 55 08             	mov    0x8(%ebp),%edx
 73b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 73f:	3c 0a                	cmp    $0xa,%al
 741:	74 1d                	je     760 <gets+0x50>
 743:	3c 0d                	cmp    $0xd,%al
 745:	74 19                	je     760 <gets+0x50>
  for(i=0; i+1 < max; ){
 747:	89 de                	mov    %ebx,%esi
 749:	83 c3 01             	add    $0x1,%ebx
 74c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 74f:	7c cf                	jl     720 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 751:	8b 45 08             	mov    0x8(%ebp),%eax
 754:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 758:	8d 65 f4             	lea    -0xc(%ebp),%esp
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret    
  buf[i] = '\0';
 760:	8b 45 08             	mov    0x8(%ebp),%eax
 763:	89 de                	mov    %ebx,%esi
 765:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 769:	8d 65 f4             	lea    -0xc(%ebp),%esp
 76c:	5b                   	pop    %ebx
 76d:	5e                   	pop    %esi
 76e:	5f                   	pop    %edi
 76f:	5d                   	pop    %ebp
 770:	c3                   	ret    
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop

00000780 <stat>:

int
stat(const char *n, struct stat *st)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	56                   	push   %esi
 784:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 785:	83 ec 08             	sub    $0x8,%esp
 788:	6a 00                	push   $0x0
 78a:	ff 75 08             	push   0x8(%ebp)
 78d:	e8 f1 00 00 00       	call   883 <open>
  if(fd < 0)
 792:	83 c4 10             	add    $0x10,%esp
 795:	85 c0                	test   %eax,%eax
 797:	78 27                	js     7c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 799:	83 ec 08             	sub    $0x8,%esp
 79c:	ff 75 0c             	push   0xc(%ebp)
 79f:	89 c3                	mov    %eax,%ebx
 7a1:	50                   	push   %eax
 7a2:	e8 f4 00 00 00       	call   89b <fstat>
  close(fd);
 7a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 7aa:	89 c6                	mov    %eax,%esi
  close(fd);
 7ac:	e8 ba 00 00 00       	call   86b <close>
  return r;
 7b1:	83 c4 10             	add    $0x10,%esp
}
 7b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 7b7:	89 f0                	mov    %esi,%eax
 7b9:	5b                   	pop    %ebx
 7ba:	5e                   	pop    %esi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret    
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 7c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 7c5:	eb ed                	jmp    7b4 <stat+0x34>
 7c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ce:	66 90                	xchg   %ax,%ax

000007d0 <atoi>:

int
atoi(const char *s)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	53                   	push   %ebx
 7d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 7d7:	0f be 02             	movsbl (%edx),%eax
 7da:	8d 48 d0             	lea    -0x30(%eax),%ecx
 7dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 7e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 7e5:	77 1e                	ja     805 <atoi+0x35>
 7e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ee:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 7f0:	83 c2 01             	add    $0x1,%edx
 7f3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 7f6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 7fa:	0f be 02             	movsbl (%edx),%eax
 7fd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 800:	80 fb 09             	cmp    $0x9,%bl
 803:	76 eb                	jbe    7f0 <atoi+0x20>
  return n;
}
 805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 808:	89 c8                	mov    %ecx,%eax
 80a:	c9                   	leave  
 80b:	c3                   	ret    
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000810 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	8b 45 10             	mov    0x10(%ebp),%eax
 817:	8b 55 08             	mov    0x8(%ebp),%edx
 81a:	56                   	push   %esi
 81b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 81e:	85 c0                	test   %eax,%eax
 820:	7e 13                	jle    835 <memmove+0x25>
 822:	01 d0                	add    %edx,%eax
  dst = vdst;
 824:	89 d7                	mov    %edx,%edi
 826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 830:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 831:	39 f8                	cmp    %edi,%eax
 833:	75 fb                	jne    830 <memmove+0x20>
  return vdst;
}
 835:	5e                   	pop    %esi
 836:	89 d0                	mov    %edx,%eax
 838:	5f                   	pop    %edi
 839:	5d                   	pop    %ebp
 83a:	c3                   	ret    

0000083b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 83b:	b8 01 00 00 00       	mov    $0x1,%eax
 840:	cd 40                	int    $0x40
 842:	c3                   	ret    

00000843 <exit>:
SYSCALL(exit)
 843:	b8 02 00 00 00       	mov    $0x2,%eax
 848:	cd 40                	int    $0x40
 84a:	c3                   	ret    

0000084b <wait>:
SYSCALL(wait)
 84b:	b8 03 00 00 00       	mov    $0x3,%eax
 850:	cd 40                	int    $0x40
 852:	c3                   	ret    

00000853 <pipe>:
SYSCALL(pipe)
 853:	b8 04 00 00 00       	mov    $0x4,%eax
 858:	cd 40                	int    $0x40
 85a:	c3                   	ret    

0000085b <read>:
SYSCALL(read)
 85b:	b8 05 00 00 00       	mov    $0x5,%eax
 860:	cd 40                	int    $0x40
 862:	c3                   	ret    

00000863 <write>:
SYSCALL(write)
 863:	b8 10 00 00 00       	mov    $0x10,%eax
 868:	cd 40                	int    $0x40
 86a:	c3                   	ret    

0000086b <close>:
SYSCALL(close)
 86b:	b8 15 00 00 00       	mov    $0x15,%eax
 870:	cd 40                	int    $0x40
 872:	c3                   	ret    

00000873 <kill>:
SYSCALL(kill)
 873:	b8 06 00 00 00       	mov    $0x6,%eax
 878:	cd 40                	int    $0x40
 87a:	c3                   	ret    

0000087b <exec>:
SYSCALL(exec)
 87b:	b8 07 00 00 00       	mov    $0x7,%eax
 880:	cd 40                	int    $0x40
 882:	c3                   	ret    

00000883 <open>:
SYSCALL(open)
 883:	b8 0f 00 00 00       	mov    $0xf,%eax
 888:	cd 40                	int    $0x40
 88a:	c3                   	ret    

0000088b <mknod>:
SYSCALL(mknod)
 88b:	b8 11 00 00 00       	mov    $0x11,%eax
 890:	cd 40                	int    $0x40
 892:	c3                   	ret    

00000893 <unlink>:
SYSCALL(unlink)
 893:	b8 12 00 00 00       	mov    $0x12,%eax
 898:	cd 40                	int    $0x40
 89a:	c3                   	ret    

0000089b <fstat>:
SYSCALL(fstat)
 89b:	b8 08 00 00 00       	mov    $0x8,%eax
 8a0:	cd 40                	int    $0x40
 8a2:	c3                   	ret    

000008a3 <link>:
SYSCALL(link)
 8a3:	b8 13 00 00 00       	mov    $0x13,%eax
 8a8:	cd 40                	int    $0x40
 8aa:	c3                   	ret    

000008ab <mkdir>:
SYSCALL(mkdir)
 8ab:	b8 14 00 00 00       	mov    $0x14,%eax
 8b0:	cd 40                	int    $0x40
 8b2:	c3                   	ret    

000008b3 <chdir>:
SYSCALL(chdir)
 8b3:	b8 09 00 00 00       	mov    $0x9,%eax
 8b8:	cd 40                	int    $0x40
 8ba:	c3                   	ret    

000008bb <dup>:
SYSCALL(dup)
 8bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 8c0:	cd 40                	int    $0x40
 8c2:	c3                   	ret    

000008c3 <getpid>:
SYSCALL(getpid)
 8c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 8c8:	cd 40                	int    $0x40
 8ca:	c3                   	ret    

000008cb <sbrk>:
SYSCALL(sbrk)
 8cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 8d0:	cd 40                	int    $0x40
 8d2:	c3                   	ret    

000008d3 <sleep>:
SYSCALL(sleep)
 8d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 8d8:	cd 40                	int    $0x40
 8da:	c3                   	ret    

000008db <uptime>:
SYSCALL(uptime)
 8db:	b8 0e 00 00 00       	mov    $0xe,%eax
 8e0:	cd 40                	int    $0x40
 8e2:	c3                   	ret    

000008e3 <settickets>:
SYSCALL(settickets)
 8e3:	b8 16 00 00 00       	mov    $0x16,%eax
 8e8:	cd 40                	int    $0x40
 8ea:	c3                   	ret    

000008eb <getpinfo>:
SYSCALL(getpinfo)
 8eb:	b8 17 00 00 00       	mov    $0x17,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    
 8f3:	66 90                	xchg   %ax,%ax
 8f5:	66 90                	xchg   %ax,%ax
 8f7:	66 90                	xchg   %ax,%ax
 8f9:	66 90                	xchg   %ax,%ax
 8fb:	66 90                	xchg   %ax,%ax
 8fd:	66 90                	xchg   %ax,%ax
 8ff:	90                   	nop

00000900 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	57                   	push   %edi
 904:	56                   	push   %esi
 905:	53                   	push   %ebx
 906:	83 ec 3c             	sub    $0x3c,%esp
 909:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 90c:	89 d1                	mov    %edx,%ecx
{
 90e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 911:	85 d2                	test   %edx,%edx
 913:	0f 89 7f 00 00 00    	jns    998 <printint+0x98>
 919:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 91d:	74 79                	je     998 <printint+0x98>
    neg = 1;
 91f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 926:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 928:	31 db                	xor    %ebx,%ebx
 92a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 92d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 930:	89 c8                	mov    %ecx,%eax
 932:	31 d2                	xor    %edx,%edx
 934:	89 cf                	mov    %ecx,%edi
 936:	f7 75 c4             	divl   -0x3c(%ebp)
 939:	0f b6 92 ac 0e 00 00 	movzbl 0xeac(%edx),%edx
 940:	89 45 c0             	mov    %eax,-0x40(%ebp)
 943:	89 d8                	mov    %ebx,%eax
 945:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 948:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 94b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 94e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 951:	76 dd                	jbe    930 <printint+0x30>
  if(neg)
 953:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 956:	85 c9                	test   %ecx,%ecx
 958:	74 0c                	je     966 <printint+0x66>
    buf[i++] = '-';
 95a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 95f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 961:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 966:	8b 7d b8             	mov    -0x48(%ebp),%edi
 969:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 96d:	eb 07                	jmp    976 <printint+0x76>
 96f:	90                   	nop
    putc(fd, buf[i]);
 970:	0f b6 13             	movzbl (%ebx),%edx
 973:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 976:	83 ec 04             	sub    $0x4,%esp
 979:	88 55 d7             	mov    %dl,-0x29(%ebp)
 97c:	6a 01                	push   $0x1
 97e:	56                   	push   %esi
 97f:	57                   	push   %edi
 980:	e8 de fe ff ff       	call   863 <write>
  while(--i >= 0)
 985:	83 c4 10             	add    $0x10,%esp
 988:	39 de                	cmp    %ebx,%esi
 98a:	75 e4                	jne    970 <printint+0x70>
}
 98c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 98f:	5b                   	pop    %ebx
 990:	5e                   	pop    %esi
 991:	5f                   	pop    %edi
 992:	5d                   	pop    %ebp
 993:	c3                   	ret    
 994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 998:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 99f:	eb 87                	jmp    928 <printint+0x28>
 9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9af:	90                   	nop

000009b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 9bc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 9bf:	0f b6 13             	movzbl (%ebx),%edx
 9c2:	84 d2                	test   %dl,%dl
 9c4:	74 6a                	je     a30 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 9c6:	8d 45 10             	lea    0x10(%ebp),%eax
 9c9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9cc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 9cf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 9d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9d4:	eb 36                	jmp    a0c <printf+0x5c>
 9d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9dd:	8d 76 00             	lea    0x0(%esi),%esi
 9e0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 9e3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 9e8:	83 f8 25             	cmp    $0x25,%eax
 9eb:	74 15                	je     a02 <printf+0x52>
  write(fd, &c, 1);
 9ed:	83 ec 04             	sub    $0x4,%esp
 9f0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9f3:	6a 01                	push   $0x1
 9f5:	57                   	push   %edi
 9f6:	56                   	push   %esi
 9f7:	e8 67 fe ff ff       	call   863 <write>
 9fc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 9ff:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a02:	0f b6 13             	movzbl (%ebx),%edx
 a05:	83 c3 01             	add    $0x1,%ebx
 a08:	84 d2                	test   %dl,%dl
 a0a:	74 24                	je     a30 <printf+0x80>
    c = fmt[i] & 0xff;
 a0c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 a0f:	85 c9                	test   %ecx,%ecx
 a11:	74 cd                	je     9e0 <printf+0x30>
      }
    } else if(state == '%'){
 a13:	83 f9 25             	cmp    $0x25,%ecx
 a16:	75 ea                	jne    a02 <printf+0x52>
      if(c == 'd'){
 a18:	83 f8 25             	cmp    $0x25,%eax
 a1b:	0f 84 07 01 00 00    	je     b28 <printf+0x178>
 a21:	83 e8 63             	sub    $0x63,%eax
 a24:	83 f8 15             	cmp    $0x15,%eax
 a27:	77 17                	ja     a40 <printf+0x90>
 a29:	ff 24 85 54 0e 00 00 	jmp    *0xe54(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a33:	5b                   	pop    %ebx
 a34:	5e                   	pop    %esi
 a35:	5f                   	pop    %edi
 a36:	5d                   	pop    %ebp
 a37:	c3                   	ret    
 a38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a3f:	90                   	nop
  write(fd, &c, 1);
 a40:	83 ec 04             	sub    $0x4,%esp
 a43:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 a46:	6a 01                	push   $0x1
 a48:	57                   	push   %edi
 a49:	56                   	push   %esi
 a4a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a4e:	e8 10 fe ff ff       	call   863 <write>
        putc(fd, c);
 a53:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 a57:	83 c4 0c             	add    $0xc,%esp
 a5a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a5d:	6a 01                	push   $0x1
 a5f:	57                   	push   %edi
 a60:	56                   	push   %esi
 a61:	e8 fd fd ff ff       	call   863 <write>
        putc(fd, c);
 a66:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a69:	31 c9                	xor    %ecx,%ecx
 a6b:	eb 95                	jmp    a02 <printf+0x52>
 a6d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a70:	83 ec 0c             	sub    $0xc,%esp
 a73:	b9 10 00 00 00       	mov    $0x10,%ecx
 a78:	6a 00                	push   $0x0
 a7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a7d:	8b 10                	mov    (%eax),%edx
 a7f:	89 f0                	mov    %esi,%eax
 a81:	e8 7a fe ff ff       	call   900 <printint>
        ap++;
 a86:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a8a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a8d:	31 c9                	xor    %ecx,%ecx
 a8f:	e9 6e ff ff ff       	jmp    a02 <printf+0x52>
 a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a98:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a9b:	8b 10                	mov    (%eax),%edx
        ap++;
 a9d:	83 c0 04             	add    $0x4,%eax
 aa0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 aa3:	85 d2                	test   %edx,%edx
 aa5:	0f 84 8d 00 00 00    	je     b38 <printf+0x188>
        while(*s != 0){
 aab:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 aae:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 ab0:	84 c0                	test   %al,%al
 ab2:	0f 84 4a ff ff ff    	je     a02 <printf+0x52>
 ab8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 abb:	89 d3                	mov    %edx,%ebx
 abd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 ac0:	83 ec 04             	sub    $0x4,%esp
          s++;
 ac3:	83 c3 01             	add    $0x1,%ebx
 ac6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ac9:	6a 01                	push   $0x1
 acb:	57                   	push   %edi
 acc:	56                   	push   %esi
 acd:	e8 91 fd ff ff       	call   863 <write>
        while(*s != 0){
 ad2:	0f b6 03             	movzbl (%ebx),%eax
 ad5:	83 c4 10             	add    $0x10,%esp
 ad8:	84 c0                	test   %al,%al
 ada:	75 e4                	jne    ac0 <printf+0x110>
      state = 0;
 adc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 adf:	31 c9                	xor    %ecx,%ecx
 ae1:	e9 1c ff ff ff       	jmp    a02 <printf+0x52>
 ae6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 aed:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 af0:	83 ec 0c             	sub    $0xc,%esp
 af3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 af8:	6a 01                	push   $0x1
 afa:	e9 7b ff ff ff       	jmp    a7a <printf+0xca>
 aff:	90                   	nop
        putc(fd, *ap);
 b00:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 b03:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 b06:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 b08:	6a 01                	push   $0x1
 b0a:	57                   	push   %edi
 b0b:	56                   	push   %esi
        putc(fd, *ap);
 b0c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b0f:	e8 4f fd ff ff       	call   863 <write>
        ap++;
 b14:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b18:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b1b:	31 c9                	xor    %ecx,%ecx
 b1d:	e9 e0 fe ff ff       	jmp    a02 <printf+0x52>
 b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 b28:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 b2b:	83 ec 04             	sub    $0x4,%esp
 b2e:	e9 2a ff ff ff       	jmp    a5d <printf+0xad>
 b33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b37:	90                   	nop
          s = "(null)";
 b38:	ba 4d 0e 00 00       	mov    $0xe4d,%edx
        while(*s != 0){
 b3d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b40:	b8 28 00 00 00       	mov    $0x28,%eax
 b45:	89 d3                	mov    %edx,%ebx
 b47:	e9 74 ff ff ff       	jmp    ac0 <printf+0x110>
 b4c:	66 90                	xchg   %ax,%ax
 b4e:	66 90                	xchg   %ax,%ax

00000b50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b50:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b51:	a1 48 12 00 00       	mov    0x1248,%eax
{
 b56:	89 e5                	mov    %esp,%ebp
 b58:	57                   	push   %edi
 b59:	56                   	push   %esi
 b5a:	53                   	push   %ebx
 b5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b5e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b68:	89 c2                	mov    %eax,%edx
 b6a:	8b 00                	mov    (%eax),%eax
 b6c:	39 ca                	cmp    %ecx,%edx
 b6e:	73 30                	jae    ba0 <free+0x50>
 b70:	39 c1                	cmp    %eax,%ecx
 b72:	72 04                	jb     b78 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b74:	39 c2                	cmp    %eax,%edx
 b76:	72 f0                	jb     b68 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b78:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b7b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b7e:	39 f8                	cmp    %edi,%eax
 b80:	74 30                	je     bb2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b82:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b85:	8b 42 04             	mov    0x4(%edx),%eax
 b88:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b8b:	39 f1                	cmp    %esi,%ecx
 b8d:	74 3a                	je     bc9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b8f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b91:	5b                   	pop    %ebx
  freep = p;
 b92:	89 15 48 12 00 00    	mov    %edx,0x1248
}
 b98:	5e                   	pop    %esi
 b99:	5f                   	pop    %edi
 b9a:	5d                   	pop    %ebp
 b9b:	c3                   	ret    
 b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ba0:	39 c2                	cmp    %eax,%edx
 ba2:	72 c4                	jb     b68 <free+0x18>
 ba4:	39 c1                	cmp    %eax,%ecx
 ba6:	73 c0                	jae    b68 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 ba8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 bab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 bae:	39 f8                	cmp    %edi,%eax
 bb0:	75 d0                	jne    b82 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 bb2:	03 70 04             	add    0x4(%eax),%esi
 bb5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bb8:	8b 02                	mov    (%edx),%eax
 bba:	8b 00                	mov    (%eax),%eax
 bbc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 bbf:	8b 42 04             	mov    0x4(%edx),%eax
 bc2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 bc5:	39 f1                	cmp    %esi,%ecx
 bc7:	75 c6                	jne    b8f <free+0x3f>
    p->s.size += bp->s.size;
 bc9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 bcc:	89 15 48 12 00 00    	mov    %edx,0x1248
    p->s.size += bp->s.size;
 bd2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 bd5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 bd8:	89 0a                	mov    %ecx,(%edx)
}
 bda:	5b                   	pop    %ebx
 bdb:	5e                   	pop    %esi
 bdc:	5f                   	pop    %edi
 bdd:	5d                   	pop    %ebp
 bde:	c3                   	ret    
 bdf:	90                   	nop

00000be0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 be0:	55                   	push   %ebp
 be1:	89 e5                	mov    %esp,%ebp
 be3:	57                   	push   %edi
 be4:	56                   	push   %esi
 be5:	53                   	push   %ebx
 be6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 be9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bec:	8b 3d 48 12 00 00    	mov    0x1248,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf2:	8d 70 07             	lea    0x7(%eax),%esi
 bf5:	c1 ee 03             	shr    $0x3,%esi
 bf8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 bfb:	85 ff                	test   %edi,%edi
 bfd:	0f 84 9d 00 00 00    	je     ca0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c03:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 c05:	8b 4a 04             	mov    0x4(%edx),%ecx
 c08:	39 f1                	cmp    %esi,%ecx
 c0a:	73 6a                	jae    c76 <malloc+0x96>
 c0c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 c11:	39 de                	cmp    %ebx,%esi
 c13:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 c16:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 c1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c20:	eb 17                	jmp    c39 <malloc+0x59>
 c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c2a:	8b 48 04             	mov    0x4(%eax),%ecx
 c2d:	39 f1                	cmp    %esi,%ecx
 c2f:	73 4f                	jae    c80 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c31:	8b 3d 48 12 00 00    	mov    0x1248,%edi
 c37:	89 c2                	mov    %eax,%edx
 c39:	39 d7                	cmp    %edx,%edi
 c3b:	75 eb                	jne    c28 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 c3d:	83 ec 0c             	sub    $0xc,%esp
 c40:	ff 75 e4             	push   -0x1c(%ebp)
 c43:	e8 83 fc ff ff       	call   8cb <sbrk>
  if(p == (char*)-1)
 c48:	83 c4 10             	add    $0x10,%esp
 c4b:	83 f8 ff             	cmp    $0xffffffff,%eax
 c4e:	74 1c                	je     c6c <malloc+0x8c>
  hp->s.size = nu;
 c50:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c53:	83 ec 0c             	sub    $0xc,%esp
 c56:	83 c0 08             	add    $0x8,%eax
 c59:	50                   	push   %eax
 c5a:	e8 f1 fe ff ff       	call   b50 <free>
  return freep;
 c5f:	8b 15 48 12 00 00    	mov    0x1248,%edx
      if((p = morecore(nunits)) == 0)
 c65:	83 c4 10             	add    $0x10,%esp
 c68:	85 d2                	test   %edx,%edx
 c6a:	75 bc                	jne    c28 <malloc+0x48>
        return 0;
  }
}
 c6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c6f:	31 c0                	xor    %eax,%eax
}
 c71:	5b                   	pop    %ebx
 c72:	5e                   	pop    %esi
 c73:	5f                   	pop    %edi
 c74:	5d                   	pop    %ebp
 c75:	c3                   	ret    
    if(p->s.size >= nunits){
 c76:	89 d0                	mov    %edx,%eax
 c78:	89 fa                	mov    %edi,%edx
 c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c80:	39 ce                	cmp    %ecx,%esi
 c82:	74 4c                	je     cd0 <malloc+0xf0>
        p->s.size -= nunits;
 c84:	29 f1                	sub    %esi,%ecx
 c86:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c89:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c8c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 c8f:	89 15 48 12 00 00    	mov    %edx,0x1248
}
 c95:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c98:	83 c0 08             	add    $0x8,%eax
}
 c9b:	5b                   	pop    %ebx
 c9c:	5e                   	pop    %esi
 c9d:	5f                   	pop    %edi
 c9e:	5d                   	pop    %ebp
 c9f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 ca0:	c7 05 48 12 00 00 4c 	movl   $0x124c,0x1248
 ca7:	12 00 00 
    base.s.size = 0;
 caa:	bf 4c 12 00 00       	mov    $0x124c,%edi
    base.s.ptr = freep = prevp = &base;
 caf:	c7 05 4c 12 00 00 4c 	movl   $0x124c,0x124c
 cb6:	12 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cb9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 cbb:	c7 05 50 12 00 00 00 	movl   $0x0,0x1250
 cc2:	00 00 00 
    if(p->s.size >= nunits){
 cc5:	e9 42 ff ff ff       	jmp    c0c <malloc+0x2c>
 cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 cd0:	8b 08                	mov    (%eax),%ecx
 cd2:	89 0a                	mov    %ecx,(%edx)
 cd4:	eb b9                	jmp    c8f <malloc+0xaf>
