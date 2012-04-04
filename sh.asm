
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 53 11 00 00       	call   1164 <exit>

  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 d0 16 00 00 	mov    0x16d0(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	c7 04 24 a4 16 00 00 	movl   $0x16a4,(%esp)
      2b:	e8 33 05 00 00       	call   563 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      30:	8b 45 08             	mov    0x8(%ebp),%eax
      33:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(ecmd->argv[0] == 0)
      36:	8b 45 e8             	mov    -0x18(%ebp),%eax
      39:	8b 40 04             	mov    0x4(%eax),%eax
      3c:	85 c0                	test   %eax,%eax
      3e:	75 05                	jne    45 <runcmd+0x45>
      exit();
      40:	e8 1f 11 00 00       	call   1164 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      45:	8b 45 e8             	mov    -0x18(%ebp),%eax
      48:	8d 50 04             	lea    0x4(%eax),%edx
      4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
      4e:	8b 40 04             	mov    0x4(%eax),%eax
      51:	89 54 24 04          	mov    %edx,0x4(%esp)
      55:	89 04 24             	mov    %eax,(%esp)
      58:	e8 3f 11 00 00       	call   119c <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      5d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      60:	8b 40 04             	mov    0x4(%eax),%eax
      63:	89 44 24 08          	mov    %eax,0x8(%esp)
      67:	c7 44 24 04 ab 16 00 	movl   $0x16ab,0x4(%esp)
      6e:	00 
      6f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      76:	e8 62 12 00 00       	call   12dd <printf>
    break;
      7b:	e9 83 01 00 00       	jmp    203 <runcmd+0x203>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f4             	mov    %eax,-0xc(%ebp)
    close(rcmd->fd);
      86:	8b 45 f4             	mov    -0xc(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	89 04 24             	mov    %eax,(%esp)
      8f:	e8 f8 10 00 00       	call   118c <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      94:	8b 45 f4             	mov    -0xc(%ebp),%eax
      97:	8b 50 10             	mov    0x10(%eax),%edx
      9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      9d:	8b 40 08             	mov    0x8(%eax),%eax
      a0:	89 54 24 04          	mov    %edx,0x4(%esp)
      a4:	89 04 24             	mov    %eax,(%esp)
      a7:	e8 f8 10 00 00       	call   11a4 <open>
      ac:	85 c0                	test   %eax,%eax
      ae:	79 23                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
      b3:	8b 40 08             	mov    0x8(%eax),%eax
      b6:	89 44 24 08          	mov    %eax,0x8(%esp)
      ba:	c7 44 24 04 bb 16 00 	movl   $0x16bb,0x4(%esp)
      c1:	00 
      c2:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      c9:	e8 0f 12 00 00       	call   12dd <printf>
      exit();
      ce:	e8 91 10 00 00       	call   1164 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	89 04 24             	mov    %eax,(%esp)
      dc:	e8 1f ff ff ff       	call   0 <runcmd>
    break;
      e1:	e9 1d 01 00 00       	jmp    203 <runcmd+0x203>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      e6:	8b 45 08             	mov    0x8(%ebp),%eax
      e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      ec:	e8 98 04 00 00       	call   589 <fork1>
      f1:	85 c0                	test   %eax,%eax
      f3:	75 0e                	jne    103 <runcmd+0x103>
      runcmd(lcmd->left);
      f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
      f8:	8b 40 04             	mov    0x4(%eax),%eax
      fb:	89 04 24             	mov    %eax,(%esp)
      fe:	e8 fd fe ff ff       	call   0 <runcmd>
    wait();
     103:	e8 64 10 00 00       	call   116c <wait>
    runcmd(lcmd->right);
     108:	8b 45 ec             	mov    -0x14(%ebp),%eax
     10b:	8b 40 08             	mov    0x8(%eax),%eax
     10e:	89 04 24             	mov    %eax,(%esp)
     111:	e8 ea fe ff ff       	call   0 <runcmd>
    break;
     116:	e9 e8 00 00 00       	jmp    203 <runcmd+0x203>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     11b:	8b 45 08             	mov    0x8(%ebp),%eax
     11e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pipe(p) < 0)
     121:	8d 45 dc             	lea    -0x24(%ebp),%eax
     124:	89 04 24             	mov    %eax,(%esp)
     127:	e8 48 10 00 00       	call   1174 <pipe>
     12c:	85 c0                	test   %eax,%eax
     12e:	79 0c                	jns    13c <runcmd+0x13c>
      panic("pipe");
     130:	c7 04 24 cb 16 00 00 	movl   $0x16cb,(%esp)
     137:	e8 27 04 00 00       	call   563 <panic>
    if(fork1() == 0){
     13c:	e8 48 04 00 00       	call   589 <fork1>
     141:	85 c0                	test   %eax,%eax
     143:	75 3b                	jne    180 <runcmd+0x180>
      close(1);
     145:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     14c:	e8 3b 10 00 00       	call   118c <close>
      dup(p[1]);
     151:	8b 45 e0             	mov    -0x20(%ebp),%eax
     154:	89 04 24             	mov    %eax,(%esp)
     157:	e8 80 10 00 00       	call   11dc <dup>
      close(p[0]);
     15c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     15f:	89 04 24             	mov    %eax,(%esp)
     162:	e8 25 10 00 00       	call   118c <close>
      close(p[1]);
     167:	8b 45 e0             	mov    -0x20(%ebp),%eax
     16a:	89 04 24             	mov    %eax,(%esp)
     16d:	e8 1a 10 00 00       	call   118c <close>
      runcmd(pcmd->left);
     172:	8b 45 f0             	mov    -0x10(%ebp),%eax
     175:	8b 40 04             	mov    0x4(%eax),%eax
     178:	89 04 24             	mov    %eax,(%esp)
     17b:	e8 80 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     180:	e8 04 04 00 00       	call   589 <fork1>
     185:	85 c0                	test   %eax,%eax
     187:	75 3b                	jne    1c4 <runcmd+0x1c4>
      close(0);
     189:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     190:	e8 f7 0f 00 00       	call   118c <close>
      dup(p[0]);
     195:	8b 45 dc             	mov    -0x24(%ebp),%eax
     198:	89 04 24             	mov    %eax,(%esp)
     19b:	e8 3c 10 00 00       	call   11dc <dup>
      close(p[0]);
     1a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1a3:	89 04 24             	mov    %eax,(%esp)
     1a6:	e8 e1 0f 00 00       	call   118c <close>
      close(p[1]);
     1ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1ae:	89 04 24             	mov    %eax,(%esp)
     1b1:	e8 d6 0f 00 00       	call   118c <close>
      runcmd(pcmd->right);
     1b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1b9:	8b 40 08             	mov    0x8(%eax),%eax
     1bc:	89 04 24             	mov    %eax,(%esp)
     1bf:	e8 3c fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1c7:	89 04 24             	mov    %eax,(%esp)
     1ca:	e8 bd 0f 00 00       	call   118c <close>
    close(p[1]);
     1cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1d2:	89 04 24             	mov    %eax,(%esp)
     1d5:	e8 b2 0f 00 00       	call   118c <close>
    wait();
     1da:	e8 8d 0f 00 00       	call   116c <wait>
    wait();
     1df:	e8 88 0f 00 00       	call   116c <wait>
    break;
     1e4:	eb 1d                	jmp    203 <runcmd+0x203>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
     1e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     1ec:	e8 98 03 00 00       	call   589 <fork1>
     1f1:	85 c0                	test   %eax,%eax
     1f3:	75 0e                	jne    203 <runcmd+0x203>
      runcmd(bcmd->cmd);
     1f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     1f8:	8b 40 04             	mov    0x4(%eax),%eax
     1fb:	89 04 24             	mov    %eax,(%esp)
     1fe:	e8 fd fd ff ff       	call   0 <runcmd>
    break;
  }
  exit();
     203:	e8 5c 0f 00 00       	call   1164 <exit>

00000208 <getcmd>:
}

int
getcmd(char *buf, int nbuf, char* pwd)
{
     208:	55                   	push   %ebp
     209:	89 e5                	mov    %esp,%ebp
     20b:	83 ec 18             	sub    $0x18,%esp
  printf(2, pwd);
     20e:	8b 45 10             	mov    0x10(%ebp),%eax
     211:	89 44 24 04          	mov    %eax,0x4(%esp)
     215:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     21c:	e8 bc 10 00 00       	call   12dd <printf>
  printf(2, " ");
     221:	c7 44 24 04 e8 16 00 	movl   $0x16e8,0x4(%esp)
     228:	00 
     229:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     230:	e8 a8 10 00 00       	call   12dd <printf>
  memset(buf, 0, nbuf);
     235:	8b 45 0c             	mov    0xc(%ebp),%eax
     238:	89 44 24 08          	mov    %eax,0x8(%esp)
     23c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     243:	00 
     244:	8b 45 08             	mov    0x8(%ebp),%eax
     247:	89 04 24             	mov    %eax,(%esp)
     24a:	e8 6f 0d 00 00       	call   fbe <memset>
  gets(buf, nbuf);
     24f:	8b 45 0c             	mov    0xc(%ebp),%eax
     252:	89 44 24 04          	mov    %eax,0x4(%esp)
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	89 04 24             	mov    %eax,(%esp)
     25c:	e8 b4 0d 00 00       	call   1015 <gets>
  if(buf[0] == 0) // EOF
     261:	8b 45 08             	mov    0x8(%ebp),%eax
     264:	0f b6 00             	movzbl (%eax),%eax
     267:	84 c0                	test   %al,%al
     269:	75 07                	jne    272 <getcmd+0x6a>
    return -1;
     26b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     270:	eb 05                	jmp    277 <getcmd+0x6f>
  return 0;
     272:	b8 00 00 00 00       	mov    $0x0,%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <updatePwd>:
// A&T - updates the current dir according to the buffer
void
updatePwd(char *pwd,char *buf ) {
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
     27c:	83 ec 28             	sub    $0x28,%esp
    int i;

    if (*buf == 0)
     27f:	8b 45 0c             	mov    0xc(%ebp),%eax
     282:	0f b6 00             	movzbl (%eax),%eax
     285:	84 c0                	test   %al,%al
     287:	0f 84 8c 01 00 00    	je     419 <updatePwd+0x1a0>
        return;
    if  (*buf == '/') { //A&T - buffer is  "/" - return to home dir
     28d:	8b 45 0c             	mov    0xc(%ebp),%eax
     290:	0f b6 00             	movzbl (%eax),%eax
     293:	3c 2f                	cmp    $0x2f,%al
     295:	75 3e                	jne    2d5 <updatePwd+0x5c>
        *pwd = '/';
     297:	8b 45 08             	mov    0x8(%ebp),%eax
     29a:	c6 00 2f             	movb   $0x2f,(%eax)
        memset(pwd+1,0,255);
     29d:	8b 45 08             	mov    0x8(%ebp),%eax
     2a0:	83 c0 01             	add    $0x1,%eax
     2a3:	c7 44 24 08 ff 00 00 	movl   $0xff,0x8(%esp)
     2aa:	00 
     2ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2b2:	00 
     2b3:	89 04 24             	mov    %eax,(%esp)
     2b6:	e8 03 0d 00 00       	call   fbe <memset>
        updatePwd(pwd, &buf[1]);
     2bb:	8b 45 0c             	mov    0xc(%ebp),%eax
     2be:	83 c0 01             	add    $0x1,%eax
     2c1:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c5:	8b 45 08             	mov    0x8(%ebp),%eax
     2c8:	89 04 24             	mov    %eax,(%esp)
     2cb:	e8 a9 ff ff ff       	call   279 <updatePwd>
        return;
     2d0:	e9 4b 01 00 00       	jmp    420 <updatePwd+0x1a7>
    }
    // A&T buffer is  "../" or  ".." - go back 1 dir
    if ((*buf == '.') && (buf[1] == '.') &&
     2d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d8:	0f b6 00             	movzbl (%eax),%eax
     2db:	3c 2e                	cmp    $0x2e,%al
     2dd:	0f 85 82 00 00 00    	jne    365 <updatePwd+0xec>
     2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     2e6:	83 c0 01             	add    $0x1,%eax
     2e9:	0f b6 00             	movzbl (%eax),%eax
     2ec:	3c 2e                	cmp    $0x2e,%al
     2ee:	75 75                	jne    365 <updatePwd+0xec>
        ((buf[2] == '/') || (buf[2] == 0)))  {
     2f0:	8b 45 0c             	mov    0xc(%ebp),%eax
     2f3:	83 c0 02             	add    $0x2,%eax
     2f6:	0f b6 00             	movzbl (%eax),%eax
        memset(pwd+1,0,255);
        updatePwd(pwd, &buf[1]);
        return;
    }
    // A&T buffer is  "../" or  ".." - go back 1 dir
    if ((*buf == '.') && (buf[1] == '.') &&
     2f9:	3c 2f                	cmp    $0x2f,%al
     2fb:	74 0d                	je     30a <updatePwd+0x91>
        ((buf[2] == '/') || (buf[2] == 0)))  {
     2fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     300:	83 c0 02             	add    $0x2,%eax
     303:	0f b6 00             	movzbl (%eax),%eax
        memset(pwd+1,0,255);
        updatePwd(pwd, &buf[1]);
        return;
    }
    // A&T buffer is  "../" or  ".." - go back 1 dir
    if ((*buf == '.') && (buf[1] == '.') &&
     306:	84 c0                	test   %al,%al
     308:	75 5b                	jne    365 <updatePwd+0xec>
        ((buf[2] == '/') || (buf[2] == 0)))  {
        i=strlen(pwd);
     30a:	8b 45 08             	mov    0x8(%ebp),%eax
     30d:	89 04 24             	mov    %eax,(%esp)
     310:	e8 84 0c 00 00       	call   f99 <strlen>
     315:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while ((i > 0) && (pwd[i] != '/'))
     318:	eb 0d                	jmp    327 <updatePwd+0xae>
            pwd[i--]=0;
     31a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31d:	03 45 08             	add    0x8(%ebp),%eax
     320:	c6 00 00             	movb   $0x0,(%eax)
     323:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    }
    // A&T buffer is  "../" or  ".." - go back 1 dir
    if ((*buf == '.') && (buf[1] == '.') &&
        ((buf[2] == '/') || (buf[2] == 0)))  {
        i=strlen(pwd);
        while ((i > 0) && (pwd[i] != '/'))
     327:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     32b:	7e 0d                	jle    33a <updatePwd+0xc1>
     32d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     330:	03 45 08             	add    0x8(%ebp),%eax
     333:	0f b6 00             	movzbl (%eax),%eax
     336:	3c 2f                	cmp    $0x2f,%al
     338:	75 e0                	jne    31a <updatePwd+0xa1>
            pwd[i--]=0;
        if (buf[2] != 0) // not end of given path
     33a:	8b 45 0c             	mov    0xc(%ebp),%eax
     33d:	83 c0 02             	add    $0x2,%eax
     340:	0f b6 00             	movzbl (%eax),%eax
     343:	84 c0                	test   %al,%al
     345:	0f 84 d1 00 00 00    	je     41c <updatePwd+0x1a3>
            updatePwd(pwd,&buf[3]);
     34b:	8b 45 0c             	mov    0xc(%ebp),%eax
     34e:	83 c0 03             	add    $0x3,%eax
     351:	89 44 24 04          	mov    %eax,0x4(%esp)
     355:	8b 45 08             	mov    0x8(%ebp),%eax
     358:	89 04 24             	mov    %eax,(%esp)
     35b:	e8 19 ff ff ff       	call   279 <updatePwd>
        return;
     360:	e9 bb 00 00 00       	jmp    420 <updatePwd+0x1a7>
    }
    //A&T buffer is "./" or ." - ignore this
    if ((*buf == '.') && ((buf[1] == '/') || (buf[1] == 0))) {
     365:	8b 45 0c             	mov    0xc(%ebp),%eax
     368:	0f b6 00             	movzbl (%eax),%eax
     36b:	3c 2e                	cmp    $0x2e,%al
     36d:	75 42                	jne    3b1 <updatePwd+0x138>
     36f:	8b 45 0c             	mov    0xc(%ebp),%eax
     372:	83 c0 01             	add    $0x1,%eax
     375:	0f b6 00             	movzbl (%eax),%eax
     378:	3c 2f                	cmp    $0x2f,%al
     37a:	74 0d                	je     389 <updatePwd+0x110>
     37c:	8b 45 0c             	mov    0xc(%ebp),%eax
     37f:	83 c0 01             	add    $0x1,%eax
     382:	0f b6 00             	movzbl (%eax),%eax
     385:	84 c0                	test   %al,%al
     387:	75 28                	jne    3b1 <updatePwd+0x138>
        if (buf[1] != 0) // not end of given path
     389:	8b 45 0c             	mov    0xc(%ebp),%eax
     38c:	83 c0 01             	add    $0x1,%eax
     38f:	0f b6 00             	movzbl (%eax),%eax
     392:	84 c0                	test   %al,%al
     394:	0f 84 85 00 00 00    	je     41f <updatePwd+0x1a6>
            updatePwd(pwd,&buf[2]);
     39a:	8b 45 0c             	mov    0xc(%ebp),%eax
     39d:	83 c0 02             	add    $0x2,%eax
     3a0:	89 44 24 04          	mov    %eax,0x4(%esp)
     3a4:	8b 45 08             	mov    0x8(%ebp),%eax
     3a7:	89 04 24             	mov    %eax,(%esp)
     3aa:	e8 ca fe ff ff       	call   279 <updatePwd>
        return;
     3af:	eb 6f                	jmp    420 <updatePwd+0x1a7>
    }
    //A&T current buffer is not a special mark
    i=strlen(pwd);
     3b1:	8b 45 08             	mov    0x8(%ebp),%eax
     3b4:	89 04 24             	mov    %eax,(%esp)
     3b7:	e8 dd 0b 00 00       	call   f99 <strlen>
     3bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pwd[i++] = '/';
     3bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3c2:	03 45 08             	add    0x8(%ebp),%eax
     3c5:	c6 00 2f             	movb   $0x2f,(%eax)
     3c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while ((*buf != 0) && (*buf != '/')) {
     3cc:	eb 16                	jmp    3e4 <updatePwd+0x16b>
        pwd[i++] = *buf;
     3ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3d1:	03 45 08             	add    0x8(%ebp),%eax
     3d4:	8b 55 0c             	mov    0xc(%ebp),%edx
     3d7:	0f b6 12             	movzbl (%edx),%edx
     3da:	88 10                	mov    %dl,(%eax)
     3dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        buf++;
     3e0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        return;
    }
    //A&T current buffer is not a special mark
    i=strlen(pwd);
    pwd[i++] = '/';
    while ((*buf != 0) && (*buf != '/')) {
     3e4:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e7:	0f b6 00             	movzbl (%eax),%eax
     3ea:	84 c0                	test   %al,%al
     3ec:	74 0a                	je     3f8 <updatePwd+0x17f>
     3ee:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f1:	0f b6 00             	movzbl (%eax),%eax
     3f4:	3c 2f                	cmp    $0x2f,%al
     3f6:	75 d6                	jne    3ce <updatePwd+0x155>
        pwd[i++] = *buf;
        buf++;
    }
    if (*buf == '/')
     3f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fb:	0f b6 00             	movzbl (%eax),%eax
     3fe:	3c 2f                	cmp    $0x2f,%al
     400:	75 1e                	jne    420 <updatePwd+0x1a7>
        updatePwd(pwd,&buf[1]);
     402:	8b 45 0c             	mov    0xc(%ebp),%eax
     405:	83 c0 01             	add    $0x1,%eax
     408:	89 44 24 04          	mov    %eax,0x4(%esp)
     40c:	8b 45 08             	mov    0x8(%ebp),%eax
     40f:	89 04 24             	mov    %eax,(%esp)
     412:	e8 62 fe ff ff       	call   279 <updatePwd>
     417:	eb 07                	jmp    420 <updatePwd+0x1a7>
void
updatePwd(char *pwd,char *buf ) {
    int i;

    if (*buf == 0)
        return;
     419:	90                   	nop
     41a:	eb 04                	jmp    420 <updatePwd+0x1a7>
        i=strlen(pwd);
        while ((i > 0) && (pwd[i] != '/'))
            pwd[i--]=0;
        if (buf[2] != 0) // not end of given path
            updatePwd(pwd,&buf[3]);
        return;
     41c:	90                   	nop
     41d:	eb 01                	jmp    420 <updatePwd+0x1a7>
    }
    //A&T buffer is "./" or ." - ignore this
    if ((*buf == '.') && ((buf[1] == '/') || (buf[1] == 0))) {
        if (buf[1] != 0) // not end of given path
            updatePwd(pwd,&buf[2]);
        return;
     41f:	90                   	nop
        pwd[i++] = *buf;
        buf++;
    }
    if (*buf == '/')
        updatePwd(pwd,&buf[1]);
}
     420:	c9                   	leave  
     421:	c3                   	ret    

00000422 <main>:

int
main(void)
{
     422:	55                   	push   %ebp
     423:	89 e5                	mov    %esp,%ebp
     425:	83 e4 f0             	and    $0xfffffff0,%esp
     428:	83 ec 20             	sub    $0x20,%esp
  static char buf[100];
  char *pwd = malloc(256*sizeof(char)); // current dir string
     42b:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
     432:	e8 8c 11 00 00       	call   15c3 <malloc>
     437:	89 44 24 18          	mov    %eax,0x18(%esp)

  int fd;
  // A&T - initialze the current dir string to "/000...0"
  memset(pwd,0,256);
     43b:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
     442:	00 
     443:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     44a:	00 
     44b:	8b 44 24 18          	mov    0x18(%esp),%eax
     44f:	89 04 24             	mov    %eax,(%esp)
     452:	e8 67 0b 00 00       	call   fbe <memset>
  pwd[0]='/';
     457:	8b 44 24 18          	mov    0x18(%esp),%eax
     45b:	c6 00 2f             	movb   $0x2f,(%eax)

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     45e:	eb 19                	jmp    479 <main+0x57>
    if(fd >= 3){
     460:	83 7c 24 1c 02       	cmpl   $0x2,0x1c(%esp)
     465:	7e 12                	jle    479 <main+0x57>
      close(fd);
     467:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     46b:	89 04 24             	mov    %eax,(%esp)
     46e:	e8 19 0d 00 00       	call   118c <close>
      break;
     473:	90                   	nop
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf), pwd) >= 0){
     474:	e9 c1 00 00 00       	jmp    53a <main+0x118>
  // A&T - initialze the current dir string to "/000...0"
  memset(pwd,0,256);
  pwd[0]='/';

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     479:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     480:	00 
     481:	c7 04 24 ea 16 00 00 	movl   $0x16ea,(%esp)
     488:	e8 17 0d 00 00       	call   11a4 <open>
     48d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     491:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
     496:	79 c8                	jns    460 <main+0x3e>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf), pwd) >= 0){
     498:	e9 9d 00 00 00       	jmp    53a <main+0x118>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     49d:	0f b6 05 40 18 00 00 	movzbl 0x1840,%eax
     4a4:	3c 63                	cmp    $0x63,%al
     4a6:	75 70                	jne    518 <main+0xf6>
     4a8:	0f b6 05 41 18 00 00 	movzbl 0x1841,%eax
     4af:	3c 64                	cmp    $0x64,%al
     4b1:	75 65                	jne    518 <main+0xf6>
     4b3:	0f b6 05 42 18 00 00 	movzbl 0x1842,%eax
     4ba:	3c 20                	cmp    $0x20,%al
     4bc:	75 5a                	jne    518 <main+0xf6>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     4be:	c7 04 24 40 18 00 00 	movl   $0x1840,(%esp)
     4c5:	e8 cf 0a 00 00       	call   f99 <strlen>
     4ca:	83 e8 01             	sub    $0x1,%eax
     4cd:	c6 80 40 18 00 00 00 	movb   $0x0,0x1840(%eax)
      if(chdir(buf+3) < 0)
     4d4:	c7 04 24 43 18 00 00 	movl   $0x1843,(%esp)
     4db:	e8 f4 0c 00 00       	call   11d4 <chdir>
     4e0:	85 c0                	test   %eax,%eax
     4e2:	79 1e                	jns    502 <main+0xe0>
        printf(2, "cannot cd %s\n", buf+3);
     4e4:	c7 44 24 08 43 18 00 	movl   $0x1843,0x8(%esp)
     4eb:	00 
     4ec:	c7 44 24 04 f2 16 00 	movl   $0x16f2,0x4(%esp)
     4f3:	00 
     4f4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4fb:	e8 dd 0d 00 00       	call   12dd <printf>
              /*          } */
              /* pwd[strlen(pwd)]= (pwd[strlen(pwd)-1] == '/' ? 0 : '/' ); */
              /* strcpy(&pwd[strlen(pwd)],buf+3); */
              updatePwd(pwd,&buf[3]);
          }
      continue;
     500:	eb 38                	jmp    53a <main+0x118>
              /* /\* switch (buf[i]) { *\/ */
              /* /\* case '' *\/ */
              /*          } */
              /* pwd[strlen(pwd)]= (pwd[strlen(pwd)-1] == '/' ? 0 : '/' ); */
              /* strcpy(&pwd[strlen(pwd)],buf+3); */
              updatePwd(pwd,&buf[3]);
     502:	c7 44 24 04 43 18 00 	movl   $0x1843,0x4(%esp)
     509:	00 
     50a:	8b 44 24 18          	mov    0x18(%esp),%eax
     50e:	89 04 24             	mov    %eax,(%esp)
     511:	e8 63 fd ff ff       	call   279 <updatePwd>
          }
      continue;
     516:	eb 22                	jmp    53a <main+0x118>
    }
    if(fork1() == 0)
     518:	e8 6c 00 00 00       	call   589 <fork1>
     51d:	85 c0                	test   %eax,%eax
     51f:	75 14                	jne    535 <main+0x113>
      runcmd(parsecmd(buf));
     521:	c7 04 24 40 18 00 00 	movl   $0x1840,(%esp)
     528:	e8 cb 03 00 00       	call   8f8 <parsecmd>
     52d:	89 04 24             	mov    %eax,(%esp)
     530:	e8 cb fa ff ff       	call   0 <runcmd>
    wait();
     535:	e8 32 0c 00 00       	call   116c <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf), pwd) >= 0){
     53a:	8b 44 24 18          	mov    0x18(%esp),%eax
     53e:	89 44 24 08          	mov    %eax,0x8(%esp)
     542:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     549:	00 
     54a:	c7 04 24 40 18 00 00 	movl   $0x1840,(%esp)
     551:	e8 b2 fc ff ff       	call   208 <getcmd>
     556:	85 c0                	test   %eax,%eax
     558:	0f 89 3f ff ff ff    	jns    49d <main+0x7b>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     55e:	e8 01 0c 00 00       	call   1164 <exit>

00000563 <panic>:
}


void
panic(char *s)
{
     563:	55                   	push   %ebp
     564:	89 e5                	mov    %esp,%ebp
     566:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     569:	8b 45 08             	mov    0x8(%ebp),%eax
     56c:	89 44 24 08          	mov    %eax,0x8(%esp)
     570:	c7 44 24 04 00 17 00 	movl   $0x1700,0x4(%esp)
     577:	00 
     578:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     57f:	e8 59 0d 00 00       	call   12dd <printf>
  exit();
     584:	e8 db 0b 00 00       	call   1164 <exit>

00000589 <fork1>:
}

int
fork1(void)
{
     589:	55                   	push   %ebp
     58a:	89 e5                	mov    %esp,%ebp
     58c:	83 ec 28             	sub    $0x28,%esp
  int pid;

  pid = fork();
     58f:	e8 c8 0b 00 00       	call   115c <fork>
     594:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     597:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     59b:	75 0c                	jne    5a9 <fork1+0x20>
    panic("fork");
     59d:	c7 04 24 04 17 00 00 	movl   $0x1704,(%esp)
     5a4:	e8 ba ff ff ff       	call   563 <panic>
  return pid;
     5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5ac:	c9                   	leave  
     5ad:	c3                   	ret    

000005ae <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     5ae:	55                   	push   %ebp
     5af:	89 e5                	mov    %esp,%ebp
     5b1:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5b4:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     5bb:	e8 03 10 00 00       	call   15c3 <malloc>
     5c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     5c3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     5ca:	00 
     5cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     5d2:	00 
     5d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5d6:	89 04 24             	mov    %eax,(%esp)
     5d9:	e8 e0 09 00 00       	call   fbe <memset>
  cmd->type = EXEC;
     5de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     5e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5ea:	c9                   	leave  
     5eb:	c3                   	ret    

000005ec <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     5ec:	55                   	push   %ebp
     5ed:	89 e5                	mov    %esp,%ebp
     5ef:	83 ec 28             	sub    $0x28,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5f2:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     5f9:	e8 c5 0f 00 00       	call   15c3 <malloc>
     5fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     601:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     608:	00 
     609:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     610:	00 
     611:	8b 45 f4             	mov    -0xc(%ebp),%eax
     614:	89 04 24             	mov    %eax,(%esp)
     617:	e8 a2 09 00 00       	call   fbe <memset>
  cmd->type = REDIR;
     61c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61f:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     625:	8b 45 f4             	mov    -0xc(%ebp),%eax
     628:	8b 55 08             	mov    0x8(%ebp),%edx
     62b:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     62e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     631:	8b 55 0c             	mov    0xc(%ebp),%edx
     634:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     637:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63a:	8b 55 10             	mov    0x10(%ebp),%edx
     63d:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     640:	8b 45 f4             	mov    -0xc(%ebp),%eax
     643:	8b 55 14             	mov    0x14(%ebp),%edx
     646:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     649:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64c:	8b 55 18             	mov    0x18(%ebp),%edx
     64f:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     652:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     655:	c9                   	leave  
     656:	c3                   	ret    

00000657 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     657:	55                   	push   %ebp
     658:	89 e5                	mov    %esp,%ebp
     65a:	83 ec 28             	sub    $0x28,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     65d:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     664:	e8 5a 0f 00 00       	call   15c3 <malloc>
     669:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     66c:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     673:	00 
     674:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     67b:	00 
     67c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     67f:	89 04 24             	mov    %eax,(%esp)
     682:	e8 37 09 00 00       	call   fbe <memset>
  cmd->type = PIPE;
     687:	8b 45 f4             	mov    -0xc(%ebp),%eax
     68a:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     690:	8b 45 f4             	mov    -0xc(%ebp),%eax
     693:	8b 55 08             	mov    0x8(%ebp),%edx
     696:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     699:	8b 45 f4             	mov    -0xc(%ebp),%eax
     69c:	8b 55 0c             	mov    0xc(%ebp),%edx
     69f:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     6a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     6a5:	c9                   	leave  
     6a6:	c3                   	ret    

000006a7 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     6a7:	55                   	push   %ebp
     6a8:	89 e5                	mov    %esp,%ebp
     6aa:	83 ec 28             	sub    $0x28,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6ad:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     6b4:	e8 0a 0f 00 00       	call   15c3 <malloc>
     6b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     6bc:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     6c3:	00 
     6c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     6cb:	00 
     6cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6cf:	89 04 24             	mov    %eax,(%esp)
     6d2:	e8 e7 08 00 00       	call   fbe <memset>
  cmd->type = LIST;
     6d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6da:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e3:	8b 55 08             	mov    0x8(%ebp),%edx
     6e6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     6e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ec:	8b 55 0c             	mov    0xc(%ebp),%edx
     6ef:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     6f5:	c9                   	leave  
     6f6:	c3                   	ret    

000006f7 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     6f7:	55                   	push   %ebp
     6f8:	89 e5                	mov    %esp,%ebp
     6fa:	83 ec 28             	sub    $0x28,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     704:	e8 ba 0e 00 00       	call   15c3 <malloc>
     709:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     70c:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     713:	00 
     714:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     71b:	00 
     71c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71f:	89 04 24             	mov    %eax,(%esp)
     722:	e8 97 08 00 00       	call   fbe <memset>
  cmd->type = BACK;
     727:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72a:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     730:	8b 45 f4             	mov    -0xc(%ebp),%eax
     733:	8b 55 08             	mov    0x8(%ebp),%edx
     736:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     739:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     73c:	c9                   	leave  
     73d:	c3                   	ret    

0000073e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     73e:	55                   	push   %ebp
     73f:	89 e5                	mov    %esp,%ebp
     741:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int ret;

  s = *ps;
     744:	8b 45 08             	mov    0x8(%ebp),%eax
     747:	8b 00                	mov    (%eax),%eax
     749:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(s < es && strchr(whitespace, *s))
     74c:	eb 04                	jmp    752 <gettoken+0x14>
    s++;
     74e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     752:	8b 45 f0             	mov    -0x10(%ebp),%eax
     755:	3b 45 0c             	cmp    0xc(%ebp),%eax
     758:	73 1d                	jae    777 <gettoken+0x39>
     75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75d:	0f b6 00             	movzbl (%eax),%eax
     760:	0f be c0             	movsbl %al,%eax
     763:	89 44 24 04          	mov    %eax,0x4(%esp)
     767:	c7 04 24 14 18 00 00 	movl   $0x1814,(%esp)
     76e:	e8 6f 08 00 00       	call   fe2 <strchr>
     773:	85 c0                	test   %eax,%eax
     775:	75 d7                	jne    74e <gettoken+0x10>
    s++;
  if(q)
     777:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     77b:	74 08                	je     785 <gettoken+0x47>
    *q = s;
     77d:	8b 45 10             	mov    0x10(%ebp),%eax
     780:	8b 55 f0             	mov    -0x10(%ebp),%edx
     783:	89 10                	mov    %edx,(%eax)
  ret = *s;
     785:	8b 45 f0             	mov    -0x10(%ebp),%eax
     788:	0f b6 00             	movzbl (%eax),%eax
     78b:	0f be c0             	movsbl %al,%eax
     78e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  switch(*s){
     791:	8b 45 f0             	mov    -0x10(%ebp),%eax
     794:	0f b6 00             	movzbl (%eax),%eax
     797:	0f be c0             	movsbl %al,%eax
     79a:	83 f8 3c             	cmp    $0x3c,%eax
     79d:	7f 1e                	jg     7bd <gettoken+0x7f>
     79f:	83 f8 3b             	cmp    $0x3b,%eax
     7a2:	7d 23                	jge    7c7 <gettoken+0x89>
     7a4:	83 f8 29             	cmp    $0x29,%eax
     7a7:	7f 3f                	jg     7e8 <gettoken+0xaa>
     7a9:	83 f8 28             	cmp    $0x28,%eax
     7ac:	7d 19                	jge    7c7 <gettoken+0x89>
     7ae:	85 c0                	test   %eax,%eax
     7b0:	0f 84 83 00 00 00    	je     839 <gettoken+0xfb>
     7b6:	83 f8 26             	cmp    $0x26,%eax
     7b9:	74 0c                	je     7c7 <gettoken+0x89>
     7bb:	eb 2b                	jmp    7e8 <gettoken+0xaa>
     7bd:	83 f8 3e             	cmp    $0x3e,%eax
     7c0:	74 0b                	je     7cd <gettoken+0x8f>
     7c2:	83 f8 7c             	cmp    $0x7c,%eax
     7c5:	75 21                	jne    7e8 <gettoken+0xaa>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     7c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    break;
     7cb:	eb 70                	jmp    83d <gettoken+0xff>
  case '>':
    s++;
     7cd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(*s == '>'){
     7d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d4:	0f b6 00             	movzbl (%eax),%eax
     7d7:	3c 3e                	cmp    $0x3e,%al
     7d9:	75 61                	jne    83c <gettoken+0xfe>
      ret = '+';
     7db:	c7 45 f4 2b 00 00 00 	movl   $0x2b,-0xc(%ebp)
      s++;
     7e2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    break;
     7e6:	eb 55                	jmp    83d <gettoken+0xff>
  default:
    ret = 'a';
     7e8:	c7 45 f4 61 00 00 00 	movl   $0x61,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7ef:	eb 04                	jmp    7f5 <gettoken+0xb7>
      s++;
     7f1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     7fb:	73 40                	jae    83d <gettoken+0xff>
     7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     800:	0f b6 00             	movzbl (%eax),%eax
     803:	0f be c0             	movsbl %al,%eax
     806:	89 44 24 04          	mov    %eax,0x4(%esp)
     80a:	c7 04 24 14 18 00 00 	movl   $0x1814,(%esp)
     811:	e8 cc 07 00 00       	call   fe2 <strchr>
     816:	85 c0                	test   %eax,%eax
     818:	75 23                	jne    83d <gettoken+0xff>
     81a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     81d:	0f b6 00             	movzbl (%eax),%eax
     820:	0f be c0             	movsbl %al,%eax
     823:	89 44 24 04          	mov    %eax,0x4(%esp)
     827:	c7 04 24 1a 18 00 00 	movl   $0x181a,(%esp)
     82e:	e8 af 07 00 00       	call   fe2 <strchr>
     833:	85 c0                	test   %eax,%eax
     835:	74 ba                	je     7f1 <gettoken+0xb3>
     837:	eb 04                	jmp    83d <gettoken+0xff>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     839:	90                   	nop
     83a:	eb 01                	jmp    83d <gettoken+0xff>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     83c:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     83d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     841:	74 0e                	je     851 <gettoken+0x113>
    *eq = s;
     843:	8b 45 14             	mov    0x14(%ebp),%eax
     846:	8b 55 f0             	mov    -0x10(%ebp),%edx
     849:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     84b:	eb 04                	jmp    851 <gettoken+0x113>
    s++;
     84d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     851:	8b 45 f0             	mov    -0x10(%ebp),%eax
     854:	3b 45 0c             	cmp    0xc(%ebp),%eax
     857:	73 1d                	jae    876 <gettoken+0x138>
     859:	8b 45 f0             	mov    -0x10(%ebp),%eax
     85c:	0f b6 00             	movzbl (%eax),%eax
     85f:	0f be c0             	movsbl %al,%eax
     862:	89 44 24 04          	mov    %eax,0x4(%esp)
     866:	c7 04 24 14 18 00 00 	movl   $0x1814,(%esp)
     86d:	e8 70 07 00 00       	call   fe2 <strchr>
     872:	85 c0                	test   %eax,%eax
     874:	75 d7                	jne    84d <gettoken+0x10f>
    s++;
  *ps = s;
     876:	8b 45 08             	mov    0x8(%ebp),%eax
     879:	8b 55 f0             	mov    -0x10(%ebp),%edx
     87c:	89 10                	mov    %edx,(%eax)
  return ret;
     87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     881:	c9                   	leave  
     882:	c3                   	ret    

00000883 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     883:	55                   	push   %ebp
     884:	89 e5                	mov    %esp,%ebp
     886:	83 ec 28             	sub    $0x28,%esp
  char *s;

  s = *ps;
     889:	8b 45 08             	mov    0x8(%ebp),%eax
     88c:	8b 00                	mov    (%eax),%eax
     88e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     891:	eb 04                	jmp    897 <peek+0x14>
    s++;
     893:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     897:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     89d:	73 1d                	jae    8bc <peek+0x39>
     89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a2:	0f b6 00             	movzbl (%eax),%eax
     8a5:	0f be c0             	movsbl %al,%eax
     8a8:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ac:	c7 04 24 14 18 00 00 	movl   $0x1814,(%esp)
     8b3:	e8 2a 07 00 00       	call   fe2 <strchr>
     8b8:	85 c0                	test   %eax,%eax
     8ba:	75 d7                	jne    893 <peek+0x10>
    s++;
  *ps = s;
     8bc:	8b 45 08             	mov    0x8(%ebp),%eax
     8bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8c2:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     8c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c7:	0f b6 00             	movzbl (%eax),%eax
     8ca:	84 c0                	test   %al,%al
     8cc:	74 23                	je     8f1 <peek+0x6e>
     8ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d1:	0f b6 00             	movzbl (%eax),%eax
     8d4:	0f be c0             	movsbl %al,%eax
     8d7:	89 44 24 04          	mov    %eax,0x4(%esp)
     8db:	8b 45 10             	mov    0x10(%ebp),%eax
     8de:	89 04 24             	mov    %eax,(%esp)
     8e1:	e8 fc 06 00 00       	call   fe2 <strchr>
     8e6:	85 c0                	test   %eax,%eax
     8e8:	74 07                	je     8f1 <peek+0x6e>
     8ea:	b8 01 00 00 00       	mov    $0x1,%eax
     8ef:	eb 05                	jmp    8f6 <peek+0x73>
     8f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     8f6:	c9                   	leave  
     8f7:	c3                   	ret    

000008f8 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     8f8:	55                   	push   %ebp
     8f9:	89 e5                	mov    %esp,%ebp
     8fb:	53                   	push   %ebx
     8fc:	83 ec 24             	sub    $0x24,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     8ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
     902:	8b 45 08             	mov    0x8(%ebp),%eax
     905:	89 04 24             	mov    %eax,(%esp)
     908:	e8 8c 06 00 00       	call   f99 <strlen>
     90d:	8d 04 03             	lea    (%ebx,%eax,1),%eax
     910:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = parseline(&s, es);
     913:	8b 45 f0             	mov    -0x10(%ebp),%eax
     916:	89 44 24 04          	mov    %eax,0x4(%esp)
     91a:	8d 45 08             	lea    0x8(%ebp),%eax
     91d:	89 04 24             	mov    %eax,(%esp)
     920:	e8 60 00 00 00       	call   985 <parseline>
     925:	89 45 f4             	mov    %eax,-0xc(%ebp)
  peek(&s, es, "");
     928:	c7 44 24 08 09 17 00 	movl   $0x1709,0x8(%esp)
     92f:	00 
     930:	8b 45 f0             	mov    -0x10(%ebp),%eax
     933:	89 44 24 04          	mov    %eax,0x4(%esp)
     937:	8d 45 08             	lea    0x8(%ebp),%eax
     93a:	89 04 24             	mov    %eax,(%esp)
     93d:	e8 41 ff ff ff       	call   883 <peek>
  if(s != es){
     942:	8b 45 08             	mov    0x8(%ebp),%eax
     945:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     948:	74 27                	je     971 <parsecmd+0x79>
    printf(2, "leftovers: %s\n", s);
     94a:	8b 45 08             	mov    0x8(%ebp),%eax
     94d:	89 44 24 08          	mov    %eax,0x8(%esp)
     951:	c7 44 24 04 0a 17 00 	movl   $0x170a,0x4(%esp)
     958:	00 
     959:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     960:	e8 78 09 00 00       	call   12dd <printf>
    panic("syntax");
     965:	c7 04 24 19 17 00 00 	movl   $0x1719,(%esp)
     96c:	e8 f2 fb ff ff       	call   563 <panic>
  }
  nulterminate(cmd);
     971:	8b 45 f4             	mov    -0xc(%ebp),%eax
     974:	89 04 24             	mov    %eax,(%esp)
     977:	e8 a4 04 00 00       	call   e20 <nulterminate>
  return cmd;
     97c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     97f:	83 c4 24             	add    $0x24,%esp
     982:	5b                   	pop    %ebx
     983:	5d                   	pop    %ebp
     984:	c3                   	ret    

00000985 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     985:	55                   	push   %ebp
     986:	89 e5                	mov    %esp,%ebp
     988:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     98b:	8b 45 0c             	mov    0xc(%ebp),%eax
     98e:	89 44 24 04          	mov    %eax,0x4(%esp)
     992:	8b 45 08             	mov    0x8(%ebp),%eax
     995:	89 04 24             	mov    %eax,(%esp)
     998:	e8 bc 00 00 00       	call   a59 <parsepipe>
     99d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     9a0:	eb 30                	jmp    9d2 <parseline+0x4d>
    gettoken(ps, es, 0, 0);
     9a2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9a9:	00 
     9aa:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9b1:	00 
     9b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9b5:	89 44 24 04          	mov    %eax,0x4(%esp)
     9b9:	8b 45 08             	mov    0x8(%ebp),%eax
     9bc:	89 04 24             	mov    %eax,(%esp)
     9bf:	e8 7a fd ff ff       	call   73e <gettoken>
    cmd = backcmd(cmd);
     9c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c7:	89 04 24             	mov    %eax,(%esp)
     9ca:	e8 28 fd ff ff       	call   6f7 <backcmd>
     9cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     9d2:	c7 44 24 08 20 17 00 	movl   $0x1720,0x8(%esp)
     9d9:	00 
     9da:	8b 45 0c             	mov    0xc(%ebp),%eax
     9dd:	89 44 24 04          	mov    %eax,0x4(%esp)
     9e1:	8b 45 08             	mov    0x8(%ebp),%eax
     9e4:	89 04 24             	mov    %eax,(%esp)
     9e7:	e8 97 fe ff ff       	call   883 <peek>
     9ec:	85 c0                	test   %eax,%eax
     9ee:	75 b2                	jne    9a2 <parseline+0x1d>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     9f0:	c7 44 24 08 22 17 00 	movl   $0x1722,0x8(%esp)
     9f7:	00 
     9f8:	8b 45 0c             	mov    0xc(%ebp),%eax
     9fb:	89 44 24 04          	mov    %eax,0x4(%esp)
     9ff:	8b 45 08             	mov    0x8(%ebp),%eax
     a02:	89 04 24             	mov    %eax,(%esp)
     a05:	e8 79 fe ff ff       	call   883 <peek>
     a0a:	85 c0                	test   %eax,%eax
     a0c:	74 46                	je     a54 <parseline+0xcf>
    gettoken(ps, es, 0, 0);
     a0e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a15:	00 
     a16:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a1d:	00 
     a1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     a21:	89 44 24 04          	mov    %eax,0x4(%esp)
     a25:	8b 45 08             	mov    0x8(%ebp),%eax
     a28:	89 04 24             	mov    %eax,(%esp)
     a2b:	e8 0e fd ff ff       	call   73e <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a30:	8b 45 0c             	mov    0xc(%ebp),%eax
     a33:	89 44 24 04          	mov    %eax,0x4(%esp)
     a37:	8b 45 08             	mov    0x8(%ebp),%eax
     a3a:	89 04 24             	mov    %eax,(%esp)
     a3d:	e8 43 ff ff ff       	call   985 <parseline>
     a42:	89 44 24 04          	mov    %eax,0x4(%esp)
     a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a49:	89 04 24             	mov    %eax,(%esp)
     a4c:	e8 56 fc ff ff       	call   6a7 <listcmd>
     a51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a57:	c9                   	leave  
     a58:	c3                   	ret    

00000a59 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     a59:	55                   	push   %ebp
     a5a:	89 e5                	mov    %esp,%ebp
     a5c:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     a5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     a62:	89 44 24 04          	mov    %eax,0x4(%esp)
     a66:	8b 45 08             	mov    0x8(%ebp),%eax
     a69:	89 04 24             	mov    %eax,(%esp)
     a6c:	e8 67 02 00 00       	call   cd8 <parseexec>
     a71:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     a74:	c7 44 24 08 24 17 00 	movl   $0x1724,0x8(%esp)
     a7b:	00 
     a7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     a7f:	89 44 24 04          	mov    %eax,0x4(%esp)
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	89 04 24             	mov    %eax,(%esp)
     a89:	e8 f5 fd ff ff       	call   883 <peek>
     a8e:	85 c0                	test   %eax,%eax
     a90:	74 46                	je     ad8 <parsepipe+0x7f>
    gettoken(ps, es, 0, 0);
     a92:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a99:	00 
     a9a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     aa1:	00 
     aa2:	8b 45 0c             	mov    0xc(%ebp),%eax
     aa5:	89 44 24 04          	mov    %eax,0x4(%esp)
     aa9:	8b 45 08             	mov    0x8(%ebp),%eax
     aac:	89 04 24             	mov    %eax,(%esp)
     aaf:	e8 8a fc ff ff       	call   73e <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ab7:	89 44 24 04          	mov    %eax,0x4(%esp)
     abb:	8b 45 08             	mov    0x8(%ebp),%eax
     abe:	89 04 24             	mov    %eax,(%esp)
     ac1:	e8 93 ff ff ff       	call   a59 <parsepipe>
     ac6:	89 44 24 04          	mov    %eax,0x4(%esp)
     aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acd:	89 04 24             	mov    %eax,(%esp)
     ad0:	e8 82 fb ff ff       	call   657 <pipecmd>
     ad5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     adb:	c9                   	leave  
     adc:	c3                   	ret    

00000add <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     add:	55                   	push   %ebp
     ade:	89 e5                	mov    %esp,%ebp
     ae0:	83 ec 38             	sub    $0x38,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     ae3:	e9 f5 00 00 00       	jmp    bdd <parseredirs+0x100>
    tok = gettoken(ps, es, 0, 0);
     ae8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     aef:	00 
     af0:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     af7:	00 
     af8:	8b 45 10             	mov    0x10(%ebp),%eax
     afb:	89 44 24 04          	mov    %eax,0x4(%esp)
     aff:	8b 45 0c             	mov    0xc(%ebp),%eax
     b02:	89 04 24             	mov    %eax,(%esp)
     b05:	e8 34 fc ff ff       	call   73e <gettoken>
     b0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     b0d:	8d 45 ec             	lea    -0x14(%ebp),%eax
     b10:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b14:	8d 45 f0             	lea    -0x10(%ebp),%eax
     b17:	89 44 24 08          	mov    %eax,0x8(%esp)
     b1b:	8b 45 10             	mov    0x10(%ebp),%eax
     b1e:	89 44 24 04          	mov    %eax,0x4(%esp)
     b22:	8b 45 0c             	mov    0xc(%ebp),%eax
     b25:	89 04 24             	mov    %eax,(%esp)
     b28:	e8 11 fc ff ff       	call   73e <gettoken>
     b2d:	83 f8 61             	cmp    $0x61,%eax
     b30:	74 0c                	je     b3e <parseredirs+0x61>
      panic("missing file for redirection");
     b32:	c7 04 24 26 17 00 00 	movl   $0x1726,(%esp)
     b39:	e8 25 fa ff ff       	call   563 <panic>
    switch(tok){
     b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b41:	83 f8 3c             	cmp    $0x3c,%eax
     b44:	74 0f                	je     b55 <parseredirs+0x78>
     b46:	83 f8 3e             	cmp    $0x3e,%eax
     b49:	74 38                	je     b83 <parseredirs+0xa6>
     b4b:	83 f8 2b             	cmp    $0x2b,%eax
     b4e:	74 61                	je     bb1 <parseredirs+0xd4>
     b50:	e9 88 00 00 00       	jmp    bdd <parseredirs+0x100>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     b55:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b58:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b5b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     b62:	00 
     b63:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     b6a:	00 
     b6b:	89 54 24 08          	mov    %edx,0x8(%esp)
     b6f:	89 44 24 04          	mov    %eax,0x4(%esp)
     b73:	8b 45 08             	mov    0x8(%ebp),%eax
     b76:	89 04 24             	mov    %eax,(%esp)
     b79:	e8 6e fa ff ff       	call   5ec <redircmd>
     b7e:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     b81:	eb 5a                	jmp    bdd <parseredirs+0x100>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     b83:	8b 55 ec             	mov    -0x14(%ebp),%edx
     b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b89:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     b90:	00 
     b91:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     b98:	00 
     b99:	89 54 24 08          	mov    %edx,0x8(%esp)
     b9d:	89 44 24 04          	mov    %eax,0x4(%esp)
     ba1:	8b 45 08             	mov    0x8(%ebp),%eax
     ba4:	89 04 24             	mov    %eax,(%esp)
     ba7:	e8 40 fa ff ff       	call   5ec <redircmd>
     bac:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     baf:	eb 2c                	jmp    bdd <parseredirs+0x100>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     bb1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     bb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bb7:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     bbe:	00 
     bbf:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     bc6:	00 
     bc7:	89 54 24 08          	mov    %edx,0x8(%esp)
     bcb:	89 44 24 04          	mov    %eax,0x4(%esp)
     bcf:	8b 45 08             	mov    0x8(%ebp),%eax
     bd2:	89 04 24             	mov    %eax,(%esp)
     bd5:	e8 12 fa ff ff       	call   5ec <redircmd>
     bda:	89 45 08             	mov    %eax,0x8(%ebp)
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     bdd:	c7 44 24 08 43 17 00 	movl   $0x1743,0x8(%esp)
     be4:	00 
     be5:	8b 45 10             	mov    0x10(%ebp),%eax
     be8:	89 44 24 04          	mov    %eax,0x4(%esp)
     bec:	8b 45 0c             	mov    0xc(%ebp),%eax
     bef:	89 04 24             	mov    %eax,(%esp)
     bf2:	e8 8c fc ff ff       	call   883 <peek>
     bf7:	85 c0                	test   %eax,%eax
     bf9:	0f 85 e9 fe ff ff    	jne    ae8 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     bff:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c02:	c9                   	leave  
     c03:	c3                   	ret    

00000c04 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     c04:	55                   	push   %ebp
     c05:	89 e5                	mov    %esp,%ebp
     c07:	83 ec 28             	sub    $0x28,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     c0a:	c7 44 24 08 46 17 00 	movl   $0x1746,0x8(%esp)
     c11:	00 
     c12:	8b 45 0c             	mov    0xc(%ebp),%eax
     c15:	89 44 24 04          	mov    %eax,0x4(%esp)
     c19:	8b 45 08             	mov    0x8(%ebp),%eax
     c1c:	89 04 24             	mov    %eax,(%esp)
     c1f:	e8 5f fc ff ff       	call   883 <peek>
     c24:	85 c0                	test   %eax,%eax
     c26:	75 0c                	jne    c34 <parseblock+0x30>
    panic("parseblock");
     c28:	c7 04 24 48 17 00 00 	movl   $0x1748,(%esp)
     c2f:	e8 2f f9 ff ff       	call   563 <panic>
  gettoken(ps, es, 0, 0);
     c34:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     c3b:	00 
     c3c:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     c43:	00 
     c44:	8b 45 0c             	mov    0xc(%ebp),%eax
     c47:	89 44 24 04          	mov    %eax,0x4(%esp)
     c4b:	8b 45 08             	mov    0x8(%ebp),%eax
     c4e:	89 04 24             	mov    %eax,(%esp)
     c51:	e8 e8 fa ff ff       	call   73e <gettoken>
  cmd = parseline(ps, es);
     c56:	8b 45 0c             	mov    0xc(%ebp),%eax
     c59:	89 44 24 04          	mov    %eax,0x4(%esp)
     c5d:	8b 45 08             	mov    0x8(%ebp),%eax
     c60:	89 04 24             	mov    %eax,(%esp)
     c63:	e8 1d fd ff ff       	call   985 <parseline>
     c68:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     c6b:	c7 44 24 08 53 17 00 	movl   $0x1753,0x8(%esp)
     c72:	00 
     c73:	8b 45 0c             	mov    0xc(%ebp),%eax
     c76:	89 44 24 04          	mov    %eax,0x4(%esp)
     c7a:	8b 45 08             	mov    0x8(%ebp),%eax
     c7d:	89 04 24             	mov    %eax,(%esp)
     c80:	e8 fe fb ff ff       	call   883 <peek>
     c85:	85 c0                	test   %eax,%eax
     c87:	75 0c                	jne    c95 <parseblock+0x91>
    panic("syntax - missing )");
     c89:	c7 04 24 55 17 00 00 	movl   $0x1755,(%esp)
     c90:	e8 ce f8 ff ff       	call   563 <panic>
  gettoken(ps, es, 0, 0);
     c95:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     c9c:	00 
     c9d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     ca4:	00 
     ca5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca8:	89 44 24 04          	mov    %eax,0x4(%esp)
     cac:	8b 45 08             	mov    0x8(%ebp),%eax
     caf:	89 04 24             	mov    %eax,(%esp)
     cb2:	e8 87 fa ff ff       	call   73e <gettoken>
  cmd = parseredirs(cmd, ps, es);
     cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     cba:	89 44 24 08          	mov    %eax,0x8(%esp)
     cbe:	8b 45 08             	mov    0x8(%ebp),%eax
     cc1:	89 44 24 04          	mov    %eax,0x4(%esp)
     cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc8:	89 04 24             	mov    %eax,(%esp)
     ccb:	e8 0d fe ff ff       	call   add <parseredirs>
     cd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cd6:	c9                   	leave  
     cd7:	c3                   	ret    

00000cd8 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     cd8:	55                   	push   %ebp
     cd9:	89 e5                	mov    %esp,%ebp
     cdb:	83 ec 38             	sub    $0x38,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     cde:	c7 44 24 08 46 17 00 	movl   $0x1746,0x8(%esp)
     ce5:	00 
     ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ced:	8b 45 08             	mov    0x8(%ebp),%eax
     cf0:	89 04 24             	mov    %eax,(%esp)
     cf3:	e8 8b fb ff ff       	call   883 <peek>
     cf8:	85 c0                	test   %eax,%eax
     cfa:	74 17                	je     d13 <parseexec+0x3b>
    return parseblock(ps, es);
     cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cff:	89 44 24 04          	mov    %eax,0x4(%esp)
     d03:	8b 45 08             	mov    0x8(%ebp),%eax
     d06:	89 04 24             	mov    %eax,(%esp)
     d09:	e8 f6 fe ff ff       	call   c04 <parseblock>
     d0e:	e9 0b 01 00 00       	jmp    e1e <parseexec+0x146>

  ret = execcmd();
     d13:	e8 96 f8 ff ff       	call   5ae <execcmd>
     d18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = (struct execcmd*)ret;
     d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  argc = 0;
     d21:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ret = parseredirs(ret, ps, es);
     d28:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2b:	89 44 24 08          	mov    %eax,0x8(%esp)
     d2f:	8b 45 08             	mov    0x8(%ebp),%eax
     d32:	89 44 24 04          	mov    %eax,0x4(%esp)
     d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d39:	89 04 24             	mov    %eax,(%esp)
     d3c:	e8 9c fd ff ff       	call   add <parseredirs>
     d41:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(!peek(ps, es, "|)&;")){
     d44:	e9 8e 00 00 00       	jmp    dd7 <parseexec+0xff>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     d49:	8d 45 e0             	lea    -0x20(%ebp),%eax
     d4c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d50:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     d53:	89 44 24 08          	mov    %eax,0x8(%esp)
     d57:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5a:	89 44 24 04          	mov    %eax,0x4(%esp)
     d5e:	8b 45 08             	mov    0x8(%ebp),%eax
     d61:	89 04 24             	mov    %eax,(%esp)
     d64:	e8 d5 f9 ff ff       	call   73e <gettoken>
     d69:	89 45 e8             	mov    %eax,-0x18(%ebp)
     d6c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d70:	0f 84 85 00 00 00    	je     dfb <parseexec+0x123>
      break;
    if(tok != 'a')
     d76:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     d7a:	74 0c                	je     d88 <parseexec+0xb0>
      panic("syntax");
     d7c:	c7 04 24 19 17 00 00 	movl   $0x1719,(%esp)
     d83:	e8 db f7 ff ff       	call   563 <panic>
    cmd->argv[argc] = q;
     d88:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d8b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     d8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d91:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     d95:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     d98:	8b 55 e0             	mov    -0x20(%ebp),%edx
     d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d9e:	83 c1 08             	add    $0x8,%ecx
     da1:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     da5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    if(argc >= MAXARGS)
     da9:	83 7d ec 09          	cmpl   $0x9,-0x14(%ebp)
     dad:	7e 0c                	jle    dbb <parseexec+0xe3>
      panic("too many args");
     daf:	c7 04 24 68 17 00 00 	movl   $0x1768,(%esp)
     db6:	e8 a8 f7 ff ff       	call   563 <panic>
    ret = parseredirs(ret, ps, es);
     dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbe:	89 44 24 08          	mov    %eax,0x8(%esp)
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
     dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dcc:	89 04 24             	mov    %eax,(%esp)
     dcf:	e8 09 fd ff ff       	call   add <parseredirs>
     dd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     dd7:	c7 44 24 08 76 17 00 	movl   $0x1776,0x8(%esp)
     dde:	00 
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	89 44 24 04          	mov    %eax,0x4(%esp)
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	89 04 24             	mov    %eax,(%esp)
     dec:	e8 92 fa ff ff       	call   883 <peek>
     df1:	85 c0                	test   %eax,%eax
     df3:	0f 84 50 ff ff ff    	je     d49 <parseexec+0x71>
     df9:	eb 01                	jmp    dfc <parseexec+0x124>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     dfb:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     dfc:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e02:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     e09:	00 
  cmd->eargv[argc] = 0;
     e0a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e10:	83 c2 08             	add    $0x8,%edx
     e13:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     e1a:	00 
  return ret;
     e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e1e:	c9                   	leave  
     e1f:	c3                   	ret    

00000e20 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     e26:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     e2a:	75 0a                	jne    e36 <nulterminate+0x16>
    return 0;
     e2c:	b8 00 00 00 00       	mov    $0x0,%eax
     e31:	e9 c8 00 00 00       	jmp    efe <nulterminate+0xde>

  switch(cmd->type){
     e36:	8b 45 08             	mov    0x8(%ebp),%eax
     e39:	8b 00                	mov    (%eax),%eax
     e3b:	83 f8 05             	cmp    $0x5,%eax
     e3e:	0f 87 b7 00 00 00    	ja     efb <nulterminate+0xdb>
     e44:	8b 04 85 7c 17 00 00 	mov    0x177c(,%eax,4),%eax
     e4b:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     e4d:	8b 45 08             	mov    0x8(%ebp),%eax
     e50:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     e53:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     e5a:	eb 14                	jmp    e70 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     e5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
     e5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e62:	83 c2 08             	add    $0x8,%edx
     e65:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     e69:	c6 00 00             	movb   $0x0,(%eax)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     e6c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     e70:	8b 55 e0             	mov    -0x20(%ebp),%edx
     e73:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e76:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     e7a:	85 c0                	test   %eax,%eax
     e7c:	75 de                	jne    e5c <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     e7e:	eb 7b                	jmp    efb <nulterminate+0xdb>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     e80:	8b 45 08             	mov    0x8(%ebp),%eax
     e83:	89 45 f4             	mov    %eax,-0xc(%ebp)
    nulterminate(rcmd->cmd);
     e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e89:	8b 40 04             	mov    0x4(%eax),%eax
     e8c:	89 04 24             	mov    %eax,(%esp)
     e8f:	e8 8c ff ff ff       	call   e20 <nulterminate>
    *rcmd->efile = 0;
     e94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e97:	8b 40 0c             	mov    0xc(%eax),%eax
     e9a:	c6 00 00             	movb   $0x0,(%eax)
    break;
     e9d:	eb 5c                	jmp    efb <nulterminate+0xdb>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     e9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(pcmd->left);
     ea5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ea8:	8b 40 04             	mov    0x4(%eax),%eax
     eab:	89 04 24             	mov    %eax,(%esp)
     eae:	e8 6d ff ff ff       	call   e20 <nulterminate>
    nulterminate(pcmd->right);
     eb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eb6:	8b 40 08             	mov    0x8(%eax),%eax
     eb9:	89 04 24             	mov    %eax,(%esp)
     ebc:	e8 5f ff ff ff       	call   e20 <nulterminate>
    break;
     ec1:	eb 38                	jmp    efb <nulterminate+0xdb>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     ec9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ecc:	8b 40 04             	mov    0x4(%eax),%eax
     ecf:	89 04 24             	mov    %eax,(%esp)
     ed2:	e8 49 ff ff ff       	call   e20 <nulterminate>
    nulterminate(lcmd->right);
     ed7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     eda:	8b 40 08             	mov    0x8(%eax),%eax
     edd:	89 04 24             	mov    %eax,(%esp)
     ee0:	e8 3b ff ff ff       	call   e20 <nulterminate>
    break;
     ee5:	eb 14                	jmp    efb <nulterminate+0xdb>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     ee7:	8b 45 08             	mov    0x8(%ebp),%eax
     eea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(bcmd->cmd);
     eed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ef0:	8b 40 04             	mov    0x4(%eax),%eax
     ef3:	89 04 24             	mov    %eax,(%esp)
     ef6:	e8 25 ff ff ff       	call   e20 <nulterminate>
    break;
  }
  return cmd;
     efb:	8b 45 08             	mov    0x8(%ebp),%eax
}
     efe:	c9                   	leave  
     eff:	c3                   	ret    

00000f00 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	57                   	push   %edi
     f04:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     f05:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f08:	8b 55 10             	mov    0x10(%ebp),%edx
     f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f0e:	89 cb                	mov    %ecx,%ebx
     f10:	89 df                	mov    %ebx,%edi
     f12:	89 d1                	mov    %edx,%ecx
     f14:	fc                   	cld    
     f15:	f3 aa                	rep stos %al,%es:(%edi)
     f17:	89 ca                	mov    %ecx,%edx
     f19:	89 fb                	mov    %edi,%ebx
     f1b:	89 5d 08             	mov    %ebx,0x8(%ebp)
     f1e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     f21:	5b                   	pop    %ebx
     f22:	5f                   	pop    %edi
     f23:	5d                   	pop    %ebp
     f24:	c3                   	ret    

00000f25 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     f25:	55                   	push   %ebp
     f26:	89 e5                	mov    %esp,%ebp
     f28:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     f2b:	8b 45 08             	mov    0x8(%ebp),%eax
     f2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     f31:	8b 45 0c             	mov    0xc(%ebp),%eax
     f34:	0f b6 10             	movzbl (%eax),%edx
     f37:	8b 45 08             	mov    0x8(%ebp),%eax
     f3a:	88 10                	mov    %dl,(%eax)
     f3c:	8b 45 08             	mov    0x8(%ebp),%eax
     f3f:	0f b6 00             	movzbl (%eax),%eax
     f42:	84 c0                	test   %al,%al
     f44:	0f 95 c0             	setne  %al
     f47:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f4b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     f4f:	84 c0                	test   %al,%al
     f51:	75 de                	jne    f31 <strcpy+0xc>
    ;
  return os;
     f53:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     f56:	c9                   	leave  
     f57:	c3                   	ret    

00000f58 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f58:	55                   	push   %ebp
     f59:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     f5b:	eb 08                	jmp    f65 <strcmp+0xd>
    p++, q++;
     f5d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f61:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     f65:	8b 45 08             	mov    0x8(%ebp),%eax
     f68:	0f b6 00             	movzbl (%eax),%eax
     f6b:	84 c0                	test   %al,%al
     f6d:	74 10                	je     f7f <strcmp+0x27>
     f6f:	8b 45 08             	mov    0x8(%ebp),%eax
     f72:	0f b6 10             	movzbl (%eax),%edx
     f75:	8b 45 0c             	mov    0xc(%ebp),%eax
     f78:	0f b6 00             	movzbl (%eax),%eax
     f7b:	38 c2                	cmp    %al,%dl
     f7d:	74 de                	je     f5d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     f7f:	8b 45 08             	mov    0x8(%ebp),%eax
     f82:	0f b6 00             	movzbl (%eax),%eax
     f85:	0f b6 d0             	movzbl %al,%edx
     f88:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8b:	0f b6 00             	movzbl (%eax),%eax
     f8e:	0f b6 c0             	movzbl %al,%eax
     f91:	89 d1                	mov    %edx,%ecx
     f93:	29 c1                	sub    %eax,%ecx
     f95:	89 c8                	mov    %ecx,%eax
}
     f97:	5d                   	pop    %ebp
     f98:	c3                   	ret    

00000f99 <strlen>:

uint
strlen(char *s)
{
     f99:	55                   	push   %ebp
     f9a:	89 e5                	mov    %esp,%ebp
     f9c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     f9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     fa6:	eb 04                	jmp    fac <strlen+0x13>
     fa8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     faf:	03 45 08             	add    0x8(%ebp),%eax
     fb2:	0f b6 00             	movzbl (%eax),%eax
     fb5:	84 c0                	test   %al,%al
     fb7:	75 ef                	jne    fa8 <strlen+0xf>
    ;
  return n;
     fb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     fbc:	c9                   	leave  
     fbd:	c3                   	ret    

00000fbe <memset>:

void*
memset(void *dst, int c, uint n)
{
     fbe:	55                   	push   %ebp
     fbf:	89 e5                	mov    %esp,%ebp
     fc1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     fc4:	8b 45 10             	mov    0x10(%ebp),%eax
     fc7:	89 44 24 08          	mov    %eax,0x8(%esp)
     fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fce:	89 44 24 04          	mov    %eax,0x4(%esp)
     fd2:	8b 45 08             	mov    0x8(%ebp),%eax
     fd5:	89 04 24             	mov    %eax,(%esp)
     fd8:	e8 23 ff ff ff       	call   f00 <stosb>
  return dst;
     fdd:	8b 45 08             	mov    0x8(%ebp),%eax
}
     fe0:	c9                   	leave  
     fe1:	c3                   	ret    

00000fe2 <strchr>:

char*
strchr(const char *s, char c)
{
     fe2:	55                   	push   %ebp
     fe3:	89 e5                	mov    %esp,%ebp
     fe5:	83 ec 04             	sub    $0x4,%esp
     fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
     feb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     fee:	eb 14                	jmp    1004 <strchr+0x22>
    if(*s == c)
     ff0:	8b 45 08             	mov    0x8(%ebp),%eax
     ff3:	0f b6 00             	movzbl (%eax),%eax
     ff6:	3a 45 fc             	cmp    -0x4(%ebp),%al
     ff9:	75 05                	jne    1000 <strchr+0x1e>
      return (char*)s;
     ffb:	8b 45 08             	mov    0x8(%ebp),%eax
     ffe:	eb 13                	jmp    1013 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1000:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1004:	8b 45 08             	mov    0x8(%ebp),%eax
    1007:	0f b6 00             	movzbl (%eax),%eax
    100a:	84 c0                	test   %al,%al
    100c:	75 e2                	jne    ff0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    100e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1013:	c9                   	leave  
    1014:	c3                   	ret    

00001015 <gets>:

char*
gets(char *buf, int max)
{
    1015:	55                   	push   %ebp
    1016:	89 e5                	mov    %esp,%ebp
    1018:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    101b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1022:	eb 44                	jmp    1068 <gets+0x53>
    cc = read(0, &c, 1);
    1024:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    102b:	00 
    102c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    102f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1033:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    103a:	e8 3d 01 00 00       	call   117c <read>
    103f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1042:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1046:	7e 2d                	jle    1075 <gets+0x60>
      break;
    buf[i++] = c;
    1048:	8b 45 f0             	mov    -0x10(%ebp),%eax
    104b:	03 45 08             	add    0x8(%ebp),%eax
    104e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1052:	88 10                	mov    %dl,(%eax)
    1054:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1058:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    105c:	3c 0a                	cmp    $0xa,%al
    105e:	74 16                	je     1076 <gets+0x61>
    1060:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1064:	3c 0d                	cmp    $0xd,%al
    1066:	74 0e                	je     1076 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1068:	8b 45 f0             	mov    -0x10(%ebp),%eax
    106b:	83 c0 01             	add    $0x1,%eax
    106e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1071:	7c b1                	jl     1024 <gets+0xf>
    1073:	eb 01                	jmp    1076 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1075:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1076:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1079:	03 45 08             	add    0x8(%ebp),%eax
    107c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1082:	c9                   	leave  
    1083:	c3                   	ret    

00001084 <stat>:

int
stat(char *n, struct stat *st)
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
    1087:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    108a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1091:	00 
    1092:	8b 45 08             	mov    0x8(%ebp),%eax
    1095:	89 04 24             	mov    %eax,(%esp)
    1098:	e8 07 01 00 00       	call   11a4 <open>
    109d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    10a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10a4:	79 07                	jns    10ad <stat+0x29>
    return -1;
    10a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10ab:	eb 23                	jmp    10d0 <stat+0x4c>
  r = fstat(fd, st);
    10ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    10b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10b7:	89 04 24             	mov    %eax,(%esp)
    10ba:	e8 fd 00 00 00       	call   11bc <fstat>
    10bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    10c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c5:	89 04 24             	mov    %eax,(%esp)
    10c8:	e8 bf 00 00 00       	call   118c <close>
  return r;
    10cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10d0:	c9                   	leave  
    10d1:	c3                   	ret    

000010d2 <atoi>:

int
atoi(const char *s)
{
    10d2:	55                   	push   %ebp
    10d3:	89 e5                	mov    %esp,%ebp
    10d5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    10d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    10df:	eb 24                	jmp    1105 <atoi+0x33>
    n = n*10 + *s++ - '0';
    10e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10e4:	89 d0                	mov    %edx,%eax
    10e6:	c1 e0 02             	shl    $0x2,%eax
    10e9:	01 d0                	add    %edx,%eax
    10eb:	01 c0                	add    %eax,%eax
    10ed:	89 c2                	mov    %eax,%edx
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	0f b6 00             	movzbl (%eax),%eax
    10f5:	0f be c0             	movsbl %al,%eax
    10f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    10fb:	83 e8 30             	sub    $0x30,%eax
    10fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1101:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1105:	8b 45 08             	mov    0x8(%ebp),%eax
    1108:	0f b6 00             	movzbl (%eax),%eax
    110b:	3c 2f                	cmp    $0x2f,%al
    110d:	7e 0a                	jle    1119 <atoi+0x47>
    110f:	8b 45 08             	mov    0x8(%ebp),%eax
    1112:	0f b6 00             	movzbl (%eax),%eax
    1115:	3c 39                	cmp    $0x39,%al
    1117:	7e c8                	jle    10e1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1119:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    111c:	c9                   	leave  
    111d:	c3                   	ret    

0000111e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    111e:	55                   	push   %ebp
    111f:	89 e5                	mov    %esp,%ebp
    1121:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1124:	8b 45 08             	mov    0x8(%ebp),%eax
    1127:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    112a:	8b 45 0c             	mov    0xc(%ebp),%eax
    112d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1130:	eb 13                	jmp    1145 <memmove+0x27>
    *dst++ = *src++;
    1132:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1135:	0f b6 10             	movzbl (%eax),%edx
    1138:	8b 45 f8             	mov    -0x8(%ebp),%eax
    113b:	88 10                	mov    %dl,(%eax)
    113d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1141:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1145:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1149:	0f 9f c0             	setg   %al
    114c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1150:	84 c0                	test   %al,%al
    1152:	75 de                	jne    1132 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1157:	c9                   	leave  
    1158:	c3                   	ret    
    1159:	90                   	nop
    115a:	90                   	nop
    115b:	90                   	nop

0000115c <fork>:
    115c:	b8 01 00 00 00       	mov    $0x1,%eax
    1161:	cd 40                	int    $0x40
    1163:	c3                   	ret    

00001164 <exit>:
    1164:	b8 02 00 00 00       	mov    $0x2,%eax
    1169:	cd 40                	int    $0x40
    116b:	c3                   	ret    

0000116c <wait>:
    116c:	b8 03 00 00 00       	mov    $0x3,%eax
    1171:	cd 40                	int    $0x40
    1173:	c3                   	ret    

00001174 <pipe>:
    1174:	b8 04 00 00 00       	mov    $0x4,%eax
    1179:	cd 40                	int    $0x40
    117b:	c3                   	ret    

0000117c <read>:
    117c:	b8 05 00 00 00       	mov    $0x5,%eax
    1181:	cd 40                	int    $0x40
    1183:	c3                   	ret    

00001184 <write>:
    1184:	b8 10 00 00 00       	mov    $0x10,%eax
    1189:	cd 40                	int    $0x40
    118b:	c3                   	ret    

0000118c <close>:
    118c:	b8 15 00 00 00       	mov    $0x15,%eax
    1191:	cd 40                	int    $0x40
    1193:	c3                   	ret    

00001194 <kill>:
    1194:	b8 06 00 00 00       	mov    $0x6,%eax
    1199:	cd 40                	int    $0x40
    119b:	c3                   	ret    

0000119c <exec>:
    119c:	b8 07 00 00 00       	mov    $0x7,%eax
    11a1:	cd 40                	int    $0x40
    11a3:	c3                   	ret    

000011a4 <open>:
    11a4:	b8 0f 00 00 00       	mov    $0xf,%eax
    11a9:	cd 40                	int    $0x40
    11ab:	c3                   	ret    

000011ac <mknod>:
    11ac:	b8 11 00 00 00       	mov    $0x11,%eax
    11b1:	cd 40                	int    $0x40
    11b3:	c3                   	ret    

000011b4 <unlink>:
    11b4:	b8 12 00 00 00       	mov    $0x12,%eax
    11b9:	cd 40                	int    $0x40
    11bb:	c3                   	ret    

000011bc <fstat>:
    11bc:	b8 08 00 00 00       	mov    $0x8,%eax
    11c1:	cd 40                	int    $0x40
    11c3:	c3                   	ret    

000011c4 <link>:
    11c4:	b8 13 00 00 00       	mov    $0x13,%eax
    11c9:	cd 40                	int    $0x40
    11cb:	c3                   	ret    

000011cc <mkdir>:
    11cc:	b8 14 00 00 00       	mov    $0x14,%eax
    11d1:	cd 40                	int    $0x40
    11d3:	c3                   	ret    

000011d4 <chdir>:
    11d4:	b8 09 00 00 00       	mov    $0x9,%eax
    11d9:	cd 40                	int    $0x40
    11db:	c3                   	ret    

000011dc <dup>:
    11dc:	b8 0a 00 00 00       	mov    $0xa,%eax
    11e1:	cd 40                	int    $0x40
    11e3:	c3                   	ret    

000011e4 <getpid>:
    11e4:	b8 0b 00 00 00       	mov    $0xb,%eax
    11e9:	cd 40                	int    $0x40
    11eb:	c3                   	ret    

000011ec <sbrk>:
    11ec:	b8 0c 00 00 00       	mov    $0xc,%eax
    11f1:	cd 40                	int    $0x40
    11f3:	c3                   	ret    

000011f4 <sleep>:
    11f4:	b8 0d 00 00 00       	mov    $0xd,%eax
    11f9:	cd 40                	int    $0x40
    11fb:	c3                   	ret    

000011fc <uptime>:
    11fc:	b8 0e 00 00 00       	mov    $0xe,%eax
    1201:	cd 40                	int    $0x40
    1203:	c3                   	ret    

00001204 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1204:	55                   	push   %ebp
    1205:	89 e5                	mov    %esp,%ebp
    1207:	83 ec 28             	sub    $0x28,%esp
    120a:	8b 45 0c             	mov    0xc(%ebp),%eax
    120d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1210:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1217:	00 
    1218:	8d 45 f4             	lea    -0xc(%ebp),%eax
    121b:	89 44 24 04          	mov    %eax,0x4(%esp)
    121f:	8b 45 08             	mov    0x8(%ebp),%eax
    1222:	89 04 24             	mov    %eax,(%esp)
    1225:	e8 5a ff ff ff       	call   1184 <write>
}
    122a:	c9                   	leave  
    122b:	c3                   	ret    

0000122c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    122c:	55                   	push   %ebp
    122d:	89 e5                	mov    %esp,%ebp
    122f:	53                   	push   %ebx
    1230:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1233:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    123a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    123e:	74 17                	je     1257 <printint+0x2b>
    1240:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1244:	79 11                	jns    1257 <printint+0x2b>
    neg = 1;
    1246:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    124d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1250:	f7 d8                	neg    %eax
    1252:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1255:	eb 06                	jmp    125d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1257:	8b 45 0c             	mov    0xc(%ebp),%eax
    125a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    125d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1264:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1267:	8b 5d 10             	mov    0x10(%ebp),%ebx
    126a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    126d:	ba 00 00 00 00       	mov    $0x0,%edx
    1272:	f7 f3                	div    %ebx
    1274:	89 d0                	mov    %edx,%eax
    1276:	0f b6 80 24 18 00 00 	movzbl 0x1824(%eax),%eax
    127d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1281:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1285:	8b 45 10             	mov    0x10(%ebp),%eax
    1288:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    128b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    128e:	ba 00 00 00 00       	mov    $0x0,%edx
    1293:	f7 75 d4             	divl   -0x2c(%ebp)
    1296:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    129d:	75 c5                	jne    1264 <printint+0x38>
  if(neg)
    129f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12a3:	74 28                	je     12cd <printint+0xa1>
    buf[i++] = '-';
    12a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12a8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    12ad:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    12b1:	eb 1a                	jmp    12cd <printint+0xa1>
    putc(fd, buf[i]);
    12b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12b6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    12bb:	0f be c0             	movsbl %al,%eax
    12be:	89 44 24 04          	mov    %eax,0x4(%esp)
    12c2:	8b 45 08             	mov    0x8(%ebp),%eax
    12c5:	89 04 24             	mov    %eax,(%esp)
    12c8:	e8 37 ff ff ff       	call   1204 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    12cd:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    12d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12d5:	79 dc                	jns    12b3 <printint+0x87>
    putc(fd, buf[i]);
}
    12d7:	83 c4 44             	add    $0x44,%esp
    12da:	5b                   	pop    %ebx
    12db:	5d                   	pop    %ebp
    12dc:	c3                   	ret    

000012dd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    12dd:	55                   	push   %ebp
    12de:	89 e5                	mov    %esp,%ebp
    12e0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    12e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    12ea:	8d 45 0c             	lea    0xc(%ebp),%eax
    12ed:	83 c0 04             	add    $0x4,%eax
    12f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    12f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12fa:	e9 7e 01 00 00       	jmp    147d <printf+0x1a0>
    c = fmt[i] & 0xff;
    12ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1302:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1305:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1308:	0f b6 00             	movzbl (%eax),%eax
    130b:	0f be c0             	movsbl %al,%eax
    130e:	25 ff 00 00 00       	and    $0xff,%eax
    1313:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1316:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    131a:	75 2c                	jne    1348 <printf+0x6b>
      if(c == '%'){
    131c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1320:	75 0c                	jne    132e <printf+0x51>
        state = '%';
    1322:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
      } else {
        putc(fd, c);
    1329:	e9 4b 01 00 00       	jmp    1479 <printf+0x19c>
    132e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1331:	0f be c0             	movsbl %al,%eax
    1334:	89 44 24 04          	mov    %eax,0x4(%esp)
    1338:	8b 45 08             	mov    0x8(%ebp),%eax
    133b:	89 04 24             	mov    %eax,(%esp)
    133e:	e8 c1 fe ff ff       	call   1204 <putc>
    1343:	e9 31 01 00 00       	jmp    1479 <printf+0x19c>
      }
    } else if(state == '%'){
    1348:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    134c:	0f 85 27 01 00 00    	jne    1479 <printf+0x19c>
      if(c == 'd'){
    1352:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1356:	75 2d                	jne    1385 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1358:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135b:	8b 00                	mov    (%eax),%eax
    135d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1364:	00 
    1365:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    136c:	00 
    136d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1371:	8b 45 08             	mov    0x8(%ebp),%eax
    1374:	89 04 24             	mov    %eax,(%esp)
    1377:	e8 b0 fe ff ff       	call   122c <printint>
        ap++;
    137c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1380:	e9 ed 00 00 00       	jmp    1472 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1385:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1389:	74 06                	je     1391 <printf+0xb4>
    138b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    138f:	75 2d                	jne    13be <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1391:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1394:	8b 00                	mov    (%eax),%eax
    1396:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    139d:	00 
    139e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    13a5:	00 
    13a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    13aa:	8b 45 08             	mov    0x8(%ebp),%eax
    13ad:	89 04 24             	mov    %eax,(%esp)
    13b0:	e8 77 fe ff ff       	call   122c <printint>
        ap++;
    13b5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    13b9:	e9 b4 00 00 00       	jmp    1472 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    13be:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    13c2:	75 46                	jne    140a <printf+0x12d>
        s = (char*)*ap;
    13c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c7:	8b 00                	mov    (%eax),%eax
    13c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    13cc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    13d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    13d4:	75 27                	jne    13fd <printf+0x120>
          s = "(null)";
    13d6:	c7 45 e4 94 17 00 00 	movl   $0x1794,-0x1c(%ebp)
        while(*s != 0){
    13dd:	eb 1f                	jmp    13fe <printf+0x121>
          putc(fd, *s);
    13df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    13e2:	0f b6 00             	movzbl (%eax),%eax
    13e5:	0f be c0             	movsbl %al,%eax
    13e8:	89 44 24 04          	mov    %eax,0x4(%esp)
    13ec:	8b 45 08             	mov    0x8(%ebp),%eax
    13ef:	89 04 24             	mov    %eax,(%esp)
    13f2:	e8 0d fe ff ff       	call   1204 <putc>
          s++;
    13f7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    13fb:	eb 01                	jmp    13fe <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    13fd:	90                   	nop
    13fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1401:	0f b6 00             	movzbl (%eax),%eax
    1404:	84 c0                	test   %al,%al
    1406:	75 d7                	jne    13df <printf+0x102>
    1408:	eb 68                	jmp    1472 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    140a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    140e:	75 1d                	jne    142d <printf+0x150>
        putc(fd, *ap);
    1410:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1413:	8b 00                	mov    (%eax),%eax
    1415:	0f be c0             	movsbl %al,%eax
    1418:	89 44 24 04          	mov    %eax,0x4(%esp)
    141c:	8b 45 08             	mov    0x8(%ebp),%eax
    141f:	89 04 24             	mov    %eax,(%esp)
    1422:	e8 dd fd ff ff       	call   1204 <putc>
        ap++;
    1427:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    142b:	eb 45                	jmp    1472 <printf+0x195>
      } else if(c == '%'){
    142d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1431:	75 17                	jne    144a <printf+0x16d>
        putc(fd, c);
    1433:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1436:	0f be c0             	movsbl %al,%eax
    1439:	89 44 24 04          	mov    %eax,0x4(%esp)
    143d:	8b 45 08             	mov    0x8(%ebp),%eax
    1440:	89 04 24             	mov    %eax,(%esp)
    1443:	e8 bc fd ff ff       	call   1204 <putc>
    1448:	eb 28                	jmp    1472 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    144a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1451:	00 
    1452:	8b 45 08             	mov    0x8(%ebp),%eax
    1455:	89 04 24             	mov    %eax,(%esp)
    1458:	e8 a7 fd ff ff       	call   1204 <putc>
        putc(fd, c);
    145d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1460:	0f be c0             	movsbl %al,%eax
    1463:	89 44 24 04          	mov    %eax,0x4(%esp)
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	89 04 24             	mov    %eax,(%esp)
    146d:	e8 92 fd ff ff       	call   1204 <putc>
      }
      state = 0;
    1472:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1479:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    147d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1480:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1483:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1486:	0f b6 00             	movzbl (%eax),%eax
    1489:	84 c0                	test   %al,%al
    148b:	0f 85 6e fe ff ff    	jne    12ff <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1491:	c9                   	leave  
    1492:	c3                   	ret    
    1493:	90                   	nop

00001494 <free>:
    1494:	55                   	push   %ebp
    1495:	89 e5                	mov    %esp,%ebp
    1497:	83 ec 10             	sub    $0x10,%esp
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	83 e8 08             	sub    $0x8,%eax
    14a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    14a3:	a1 ac 18 00 00       	mov    0x18ac,%eax
    14a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14ab:	eb 24                	jmp    14d1 <free+0x3d>
    14ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14b0:	8b 00                	mov    (%eax),%eax
    14b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14b5:	77 12                	ja     14c9 <free+0x35>
    14b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14bd:	77 24                	ja     14e3 <free+0x4f>
    14bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14c2:	8b 00                	mov    (%eax),%eax
    14c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14c7:	77 1a                	ja     14e3 <free+0x4f>
    14c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14cc:	8b 00                	mov    (%eax),%eax
    14ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14d7:	76 d4                	jbe    14ad <free+0x19>
    14d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14dc:	8b 00                	mov    (%eax),%eax
    14de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14e1:	76 ca                	jbe    14ad <free+0x19>
    14e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14e6:	8b 40 04             	mov    0x4(%eax),%eax
    14e9:	c1 e0 03             	shl    $0x3,%eax
    14ec:	89 c2                	mov    %eax,%edx
    14ee:	03 55 f8             	add    -0x8(%ebp),%edx
    14f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14f4:	8b 00                	mov    (%eax),%eax
    14f6:	39 c2                	cmp    %eax,%edx
    14f8:	75 24                	jne    151e <free+0x8a>
    14fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14fd:	8b 50 04             	mov    0x4(%eax),%edx
    1500:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1503:	8b 00                	mov    (%eax),%eax
    1505:	8b 40 04             	mov    0x4(%eax),%eax
    1508:	01 c2                	add    %eax,%edx
    150a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    150d:	89 50 04             	mov    %edx,0x4(%eax)
    1510:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1513:	8b 00                	mov    (%eax),%eax
    1515:	8b 10                	mov    (%eax),%edx
    1517:	8b 45 f8             	mov    -0x8(%ebp),%eax
    151a:	89 10                	mov    %edx,(%eax)
    151c:	eb 0a                	jmp    1528 <free+0x94>
    151e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1521:	8b 10                	mov    (%eax),%edx
    1523:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1526:	89 10                	mov    %edx,(%eax)
    1528:	8b 45 fc             	mov    -0x4(%ebp),%eax
    152b:	8b 40 04             	mov    0x4(%eax),%eax
    152e:	c1 e0 03             	shl    $0x3,%eax
    1531:	03 45 fc             	add    -0x4(%ebp),%eax
    1534:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1537:	75 20                	jne    1559 <free+0xc5>
    1539:	8b 45 fc             	mov    -0x4(%ebp),%eax
    153c:	8b 50 04             	mov    0x4(%eax),%edx
    153f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1542:	8b 40 04             	mov    0x4(%eax),%eax
    1545:	01 c2                	add    %eax,%edx
    1547:	8b 45 fc             	mov    -0x4(%ebp),%eax
    154a:	89 50 04             	mov    %edx,0x4(%eax)
    154d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1550:	8b 10                	mov    (%eax),%edx
    1552:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1555:	89 10                	mov    %edx,(%eax)
    1557:	eb 08                	jmp    1561 <free+0xcd>
    1559:	8b 45 fc             	mov    -0x4(%ebp),%eax
    155c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    155f:	89 10                	mov    %edx,(%eax)
    1561:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1564:	a3 ac 18 00 00       	mov    %eax,0x18ac
    1569:	c9                   	leave  
    156a:	c3                   	ret    

0000156b <morecore>:
    156b:	55                   	push   %ebp
    156c:	89 e5                	mov    %esp,%ebp
    156e:	83 ec 28             	sub    $0x28,%esp
    1571:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1578:	77 07                	ja     1581 <morecore+0x16>
    157a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    1581:	8b 45 08             	mov    0x8(%ebp),%eax
    1584:	c1 e0 03             	shl    $0x3,%eax
    1587:	89 04 24             	mov    %eax,(%esp)
    158a:	e8 5d fc ff ff       	call   11ec <sbrk>
    158f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1592:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1596:	75 07                	jne    159f <morecore+0x34>
    1598:	b8 00 00 00 00       	mov    $0x0,%eax
    159d:	eb 22                	jmp    15c1 <morecore+0x56>
    159f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    15a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15a8:	8b 55 08             	mov    0x8(%ebp),%edx
    15ab:	89 50 04             	mov    %edx,0x4(%eax)
    15ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b1:	83 c0 08             	add    $0x8,%eax
    15b4:	89 04 24             	mov    %eax,(%esp)
    15b7:	e8 d8 fe ff ff       	call   1494 <free>
    15bc:	a1 ac 18 00 00       	mov    0x18ac,%eax
    15c1:	c9                   	leave  
    15c2:	c3                   	ret    

000015c3 <malloc>:
    15c3:	55                   	push   %ebp
    15c4:	89 e5                	mov    %esp,%ebp
    15c6:	83 ec 28             	sub    $0x28,%esp
    15c9:	8b 45 08             	mov    0x8(%ebp),%eax
    15cc:	83 c0 07             	add    $0x7,%eax
    15cf:	c1 e8 03             	shr    $0x3,%eax
    15d2:	83 c0 01             	add    $0x1,%eax
    15d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    15d8:	a1 ac 18 00 00       	mov    0x18ac,%eax
    15dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    15e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15e4:	75 23                	jne    1609 <malloc+0x46>
    15e6:	c7 45 f0 a4 18 00 00 	movl   $0x18a4,-0x10(%ebp)
    15ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15f0:	a3 ac 18 00 00       	mov    %eax,0x18ac
    15f5:	a1 ac 18 00 00       	mov    0x18ac,%eax
    15fa:	a3 a4 18 00 00       	mov    %eax,0x18a4
    15ff:	c7 05 a8 18 00 00 00 	movl   $0x0,0x18a8
    1606:	00 00 00 
    1609:	8b 45 f0             	mov    -0x10(%ebp),%eax
    160c:	8b 00                	mov    (%eax),%eax
    160e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1611:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1614:	8b 40 04             	mov    0x4(%eax),%eax
    1617:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    161a:	72 4d                	jb     1669 <malloc+0xa6>
    161c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161f:	8b 40 04             	mov    0x4(%eax),%eax
    1622:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1625:	75 0c                	jne    1633 <malloc+0x70>
    1627:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162a:	8b 10                	mov    (%eax),%edx
    162c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    162f:	89 10                	mov    %edx,(%eax)
    1631:	eb 26                	jmp    1659 <malloc+0x96>
    1633:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1636:	8b 40 04             	mov    0x4(%eax),%eax
    1639:	89 c2                	mov    %eax,%edx
    163b:	2b 55 ec             	sub    -0x14(%ebp),%edx
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	89 50 04             	mov    %edx,0x4(%eax)
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	8b 40 04             	mov    0x4(%eax),%eax
    164a:	c1 e0 03             	shl    $0x3,%eax
    164d:	01 45 f4             	add    %eax,-0xc(%ebp)
    1650:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1653:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1656:	89 50 04             	mov    %edx,0x4(%eax)
    1659:	8b 45 f0             	mov    -0x10(%ebp),%eax
    165c:	a3 ac 18 00 00       	mov    %eax,0x18ac
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	83 c0 08             	add    $0x8,%eax
    1667:	eb 38                	jmp    16a1 <malloc+0xde>
    1669:	a1 ac 18 00 00       	mov    0x18ac,%eax
    166e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1671:	75 1b                	jne    168e <malloc+0xcb>
    1673:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1676:	89 04 24             	mov    %eax,(%esp)
    1679:	e8 ed fe ff ff       	call   156b <morecore>
    167e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1681:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1685:	75 07                	jne    168e <malloc+0xcb>
    1687:	b8 00 00 00 00       	mov    $0x0,%eax
    168c:	eb 13                	jmp    16a1 <malloc+0xde>
    168e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1691:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1694:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1697:	8b 00                	mov    (%eax),%eax
    1699:	89 45 f4             	mov    %eax,-0xc(%ebp)
    169c:	e9 70 ff ff ff       	jmp    1611 <malloc+0x4e>
    16a1:	c9                   	leave  
    16a2:	c3                   	ret    
