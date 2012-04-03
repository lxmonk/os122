
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
       6:	a1 18 5d 00 00       	mov    0x5d18,%eax
       b:	c7 44 24 04 7e 41 00 	movl   $0x417e,0x4(%esp)
      12:	00 
      13:	89 04 24             	mov    %eax,(%esp)
      16:	e8 86 3d 00 00       	call   3da1 <printf>
      1b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      22:	00 
      23:	c7 04 24 68 41 00 00 	movl   $0x4168,(%esp)
      2a:	e8 39 3c 00 00       	call   3c68 <open>
      2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      32:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      36:	79 1a                	jns    52 <opentest+0x52>
      38:	a1 18 5d 00 00       	mov    0x5d18,%eax
      3d:	c7 44 24 04 89 41 00 	movl   $0x4189,0x4(%esp)
      44:	00 
      45:	89 04 24             	mov    %eax,(%esp)
      48:	e8 54 3d 00 00       	call   3da1 <printf>
      4d:	e8 d6 3b 00 00       	call   3c28 <exit>
      52:	8b 45 f4             	mov    -0xc(%ebp),%eax
      55:	89 04 24             	mov    %eax,(%esp)
      58:	e8 f3 3b 00 00       	call   3c50 <close>
      5d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      64:	00 
      65:	c7 04 24 9c 41 00 00 	movl   $0x419c,(%esp)
      6c:	e8 f7 3b 00 00       	call   3c68 <open>
      71:	89 45 f4             	mov    %eax,-0xc(%ebp)
      74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      78:	78 1a                	js     94 <opentest+0x94>
      7a:	a1 18 5d 00 00       	mov    0x5d18,%eax
      7f:	c7 44 24 04 a9 41 00 	movl   $0x41a9,0x4(%esp)
      86:	00 
      87:	89 04 24             	mov    %eax,(%esp)
      8a:	e8 12 3d 00 00       	call   3da1 <printf>
      8f:	e8 94 3b 00 00       	call   3c28 <exit>
      94:	a1 18 5d 00 00       	mov    0x5d18,%eax
      99:	c7 44 24 04 c7 41 00 	movl   $0x41c7,0x4(%esp)
      a0:	00 
      a1:	89 04 24             	mov    %eax,(%esp)
      a4:	e8 f8 3c 00 00       	call   3da1 <printf>
      a9:	c9                   	leave  
      aa:	c3                   	ret    

000000ab <writetest>:
      ab:	55                   	push   %ebp
      ac:	89 e5                	mov    %esp,%ebp
      ae:	83 ec 28             	sub    $0x28,%esp
      b1:	a1 18 5d 00 00       	mov    0x5d18,%eax
      b6:	c7 44 24 04 d5 41 00 	movl   $0x41d5,0x4(%esp)
      bd:	00 
      be:	89 04 24             	mov    %eax,(%esp)
      c1:	e8 db 3c 00 00       	call   3da1 <printf>
      c6:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
      cd:	00 
      ce:	c7 04 24 e6 41 00 00 	movl   $0x41e6,(%esp)
      d5:	e8 8e 3b 00 00       	call   3c68 <open>
      da:	89 45 f0             	mov    %eax,-0x10(%ebp)
      dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      e1:	78 21                	js     104 <writetest+0x59>
      e3:	a1 18 5d 00 00       	mov    0x5d18,%eax
      e8:	c7 44 24 04 ec 41 00 	movl   $0x41ec,0x4(%esp)
      ef:	00 
      f0:	89 04 24             	mov    %eax,(%esp)
      f3:	e8 a9 3c 00 00       	call   3da1 <printf>
      f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      ff:	e9 a0 00 00 00       	jmp    1a4 <writetest+0xf9>
     104:	a1 18 5d 00 00       	mov    0x5d18,%eax
     109:	c7 44 24 04 07 42 00 	movl   $0x4207,0x4(%esp)
     110:	00 
     111:	89 04 24             	mov    %eax,(%esp)
     114:	e8 88 3c 00 00       	call   3da1 <printf>
     119:	e8 0a 3b 00 00       	call   3c28 <exit>
     11e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     125:	00 
     126:	c7 44 24 04 23 42 00 	movl   $0x4223,0x4(%esp)
     12d:	00 
     12e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     131:	89 04 24             	mov    %eax,(%esp)
     134:	e8 0f 3b 00 00       	call   3c48 <write>
     139:	83 f8 0a             	cmp    $0xa,%eax
     13c:	74 21                	je     15f <writetest+0xb4>
     13e:	a1 18 5d 00 00       	mov    0x5d18,%eax
     143:	8b 55 f4             	mov    -0xc(%ebp),%edx
     146:	89 54 24 08          	mov    %edx,0x8(%esp)
     14a:	c7 44 24 04 30 42 00 	movl   $0x4230,0x4(%esp)
     151:	00 
     152:	89 04 24             	mov    %eax,(%esp)
     155:	e8 47 3c 00 00       	call   3da1 <printf>
     15a:	e8 c9 3a 00 00       	call   3c28 <exit>
     15f:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     166:	00 
     167:	c7 44 24 04 54 42 00 	movl   $0x4254,0x4(%esp)
     16e:	00 
     16f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     172:	89 04 24             	mov    %eax,(%esp)
     175:	e8 ce 3a 00 00       	call   3c48 <write>
     17a:	83 f8 0a             	cmp    $0xa,%eax
     17d:	74 21                	je     1a0 <writetest+0xf5>
     17f:	a1 18 5d 00 00       	mov    0x5d18,%eax
     184:	8b 55 f4             	mov    -0xc(%ebp),%edx
     187:	89 54 24 08          	mov    %edx,0x8(%esp)
     18b:	c7 44 24 04 60 42 00 	movl   $0x4260,0x4(%esp)
     192:	00 
     193:	89 04 24             	mov    %eax,(%esp)
     196:	e8 06 3c 00 00       	call   3da1 <printf>
     19b:	e8 88 3a 00 00       	call   3c28 <exit>
     1a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1a4:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     1a8:	0f 8e 70 ff ff ff    	jle    11e <writetest+0x73>
     1ae:	a1 18 5d 00 00       	mov    0x5d18,%eax
     1b3:	c7 44 24 04 84 42 00 	movl   $0x4284,0x4(%esp)
     1ba:	00 
     1bb:	89 04 24             	mov    %eax,(%esp)
     1be:	e8 de 3b 00 00       	call   3da1 <printf>
     1c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1c6:	89 04 24             	mov    %eax,(%esp)
     1c9:	e8 82 3a 00 00       	call   3c50 <close>
     1ce:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     1d5:	00 
     1d6:	c7 04 24 e6 41 00 00 	movl   $0x41e6,(%esp)
     1dd:	e8 86 3a 00 00       	call   3c68 <open>
     1e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     1e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1e9:	78 3e                	js     229 <writetest+0x17e>
     1eb:	a1 18 5d 00 00       	mov    0x5d18,%eax
     1f0:	c7 44 24 04 8f 42 00 	movl   $0x428f,0x4(%esp)
     1f7:	00 
     1f8:	89 04 24             	mov    %eax,(%esp)
     1fb:	e8 a1 3b 00 00       	call   3da1 <printf>
     200:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     207:	00 
     208:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     20f:	00 
     210:	8b 45 f0             	mov    -0x10(%ebp),%eax
     213:	89 04 24             	mov    %eax,(%esp)
     216:	e8 25 3a 00 00       	call   3c40 <read>
     21b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     21e:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     225:	74 1c                	je     243 <writetest+0x198>
     227:	eb 4c                	jmp    275 <writetest+0x1ca>
     229:	a1 18 5d 00 00       	mov    0x5d18,%eax
     22e:	c7 44 24 04 a8 42 00 	movl   $0x42a8,0x4(%esp)
     235:	00 
     236:	89 04 24             	mov    %eax,(%esp)
     239:	e8 63 3b 00 00       	call   3da1 <printf>
     23e:	e8 e5 39 00 00       	call   3c28 <exit>
     243:	a1 18 5d 00 00       	mov    0x5d18,%eax
     248:	c7 44 24 04 c3 42 00 	movl   $0x42c3,0x4(%esp)
     24f:	00 
     250:	89 04 24             	mov    %eax,(%esp)
     253:	e8 49 3b 00 00       	call   3da1 <printf>
     258:	8b 45 f0             	mov    -0x10(%ebp),%eax
     25b:	89 04 24             	mov    %eax,(%esp)
     25e:	e8 ed 39 00 00       	call   3c50 <close>
     263:	c7 04 24 e6 41 00 00 	movl   $0x41e6,(%esp)
     26a:	e8 09 3a 00 00       	call   3c78 <unlink>
     26f:	85 c0                	test   %eax,%eax
     271:	78 1c                	js     28f <writetest+0x1e4>
     273:	eb 34                	jmp    2a9 <writetest+0x1fe>
     275:	a1 18 5d 00 00       	mov    0x5d18,%eax
     27a:	c7 44 24 04 d6 42 00 	movl   $0x42d6,0x4(%esp)
     281:	00 
     282:	89 04 24             	mov    %eax,(%esp)
     285:	e8 17 3b 00 00       	call   3da1 <printf>
     28a:	e8 99 39 00 00       	call   3c28 <exit>
     28f:	a1 18 5d 00 00       	mov    0x5d18,%eax
     294:	c7 44 24 04 e3 42 00 	movl   $0x42e3,0x4(%esp)
     29b:	00 
     29c:	89 04 24             	mov    %eax,(%esp)
     29f:	e8 fd 3a 00 00       	call   3da1 <printf>
     2a4:	e8 7f 39 00 00       	call   3c28 <exit>
     2a9:	a1 18 5d 00 00       	mov    0x5d18,%eax
     2ae:	c7 44 24 04 f8 42 00 	movl   $0x42f8,0x4(%esp)
     2b5:	00 
     2b6:	89 04 24             	mov    %eax,(%esp)
     2b9:	e8 e3 3a 00 00       	call   3da1 <printf>
     2be:	c9                   	leave  
     2bf:	c3                   	ret    

000002c0 <writetest1>:
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 28             	sub    $0x28,%esp
     2c6:	a1 18 5d 00 00       	mov    0x5d18,%eax
     2cb:	c7 44 24 04 0c 43 00 	movl   $0x430c,0x4(%esp)
     2d2:	00 
     2d3:	89 04 24             	mov    %eax,(%esp)
     2d6:	e8 c6 3a 00 00       	call   3da1 <printf>
     2db:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     2e2:	00 
     2e3:	c7 04 24 1c 43 00 00 	movl   $0x431c,(%esp)
     2ea:	e8 79 39 00 00       	call   3c68 <open>
     2ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
     2f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2f6:	79 1a                	jns    312 <writetest1+0x52>
     2f8:	a1 18 5d 00 00       	mov    0x5d18,%eax
     2fd:	c7 44 24 04 20 43 00 	movl   $0x4320,0x4(%esp)
     304:	00 
     305:	89 04 24             	mov    %eax,(%esp)
     308:	e8 94 3a 00 00       	call   3da1 <printf>
     30d:	e8 16 39 00 00       	call   3c28 <exit>
     312:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     319:	eb 51                	jmp    36c <writetest1+0xac>
     31b:	b8 00 85 00 00       	mov    $0x8500,%eax
     320:	8b 55 f4             	mov    -0xc(%ebp),%edx
     323:	89 10                	mov    %edx,(%eax)
     325:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     32c:	00 
     32d:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     334:	00 
     335:	8b 45 ec             	mov    -0x14(%ebp),%eax
     338:	89 04 24             	mov    %eax,(%esp)
     33b:	e8 08 39 00 00       	call   3c48 <write>
     340:	3d 00 02 00 00       	cmp    $0x200,%eax
     345:	74 21                	je     368 <writetest1+0xa8>
     347:	a1 18 5d 00 00       	mov    0x5d18,%eax
     34c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     34f:	89 54 24 08          	mov    %edx,0x8(%esp)
     353:	c7 44 24 04 3a 43 00 	movl   $0x433a,0x4(%esp)
     35a:	00 
     35b:	89 04 24             	mov    %eax,(%esp)
     35e:	e8 3e 3a 00 00       	call   3da1 <printf>
     363:	e8 c0 38 00 00       	call   3c28 <exit>
     368:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     36c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     36f:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     374:	76 a5                	jbe    31b <writetest1+0x5b>
     376:	8b 45 ec             	mov    -0x14(%ebp),%eax
     379:	89 04 24             	mov    %eax,(%esp)
     37c:	e8 cf 38 00 00       	call   3c50 <close>
     381:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     388:	00 
     389:	c7 04 24 1c 43 00 00 	movl   $0x431c,(%esp)
     390:	e8 d3 38 00 00       	call   3c68 <open>
     395:	89 45 ec             	mov    %eax,-0x14(%ebp)
     398:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     39c:	79 1a                	jns    3b8 <writetest1+0xf8>
     39e:	a1 18 5d 00 00       	mov    0x5d18,%eax
     3a3:	c7 44 24 04 58 43 00 	movl   $0x4358,0x4(%esp)
     3aa:	00 
     3ab:	89 04 24             	mov    %eax,(%esp)
     3ae:	e8 ee 39 00 00       	call   3da1 <printf>
     3b3:	e8 70 38 00 00       	call   3c28 <exit>
     3b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     3bf:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     3c6:	00 
     3c7:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     3ce:	00 
     3cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3d2:	89 04 24             	mov    %eax,(%esp)
     3d5:	e8 66 38 00 00       	call   3c40 <read>
     3da:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3e1:	75 2e                	jne    411 <writetest1+0x151>
     3e3:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     3ea:	0f 85 8c 00 00 00    	jne    47c <writetest1+0x1bc>
     3f0:	a1 18 5d 00 00       	mov    0x5d18,%eax
     3f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
     3f8:	89 54 24 08          	mov    %edx,0x8(%esp)
     3fc:	c7 44 24 04 71 43 00 	movl   $0x4371,0x4(%esp)
     403:	00 
     404:	89 04 24             	mov    %eax,(%esp)
     407:	e8 95 39 00 00       	call   3da1 <printf>
     40c:	e8 17 38 00 00       	call   3c28 <exit>
     411:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     418:	74 21                	je     43b <writetest1+0x17b>
     41a:	a1 18 5d 00 00       	mov    0x5d18,%eax
     41f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     422:	89 54 24 08          	mov    %edx,0x8(%esp)
     426:	c7 44 24 04 8e 43 00 	movl   $0x438e,0x4(%esp)
     42d:	00 
     42e:	89 04 24             	mov    %eax,(%esp)
     431:	e8 6b 39 00 00       	call   3da1 <printf>
     436:	e8 ed 37 00 00       	call   3c28 <exit>
     43b:	b8 00 85 00 00       	mov    $0x8500,%eax
     440:	8b 00                	mov    (%eax),%eax
     442:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     445:	74 2c                	je     473 <writetest1+0x1b3>
     447:	b8 00 85 00 00       	mov    $0x8500,%eax
     44c:	8b 10                	mov    (%eax),%edx
     44e:	a1 18 5d 00 00       	mov    0x5d18,%eax
     453:	89 54 24 0c          	mov    %edx,0xc(%esp)
     457:	8b 55 f0             	mov    -0x10(%ebp),%edx
     45a:	89 54 24 08          	mov    %edx,0x8(%esp)
     45e:	c7 44 24 04 a0 43 00 	movl   $0x43a0,0x4(%esp)
     465:	00 
     466:	89 04 24             	mov    %eax,(%esp)
     469:	e8 33 39 00 00       	call   3da1 <printf>
     46e:	e8 b5 37 00 00       	call   3c28 <exit>
     473:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     477:	e9 43 ff ff ff       	jmp    3bf <writetest1+0xff>
     47c:	90                   	nop
     47d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     480:	89 04 24             	mov    %eax,(%esp)
     483:	e8 c8 37 00 00       	call   3c50 <close>
     488:	c7 04 24 1c 43 00 00 	movl   $0x431c,(%esp)
     48f:	e8 e4 37 00 00       	call   3c78 <unlink>
     494:	85 c0                	test   %eax,%eax
     496:	79 1a                	jns    4b2 <writetest1+0x1f2>
     498:	a1 18 5d 00 00       	mov    0x5d18,%eax
     49d:	c7 44 24 04 c0 43 00 	movl   $0x43c0,0x4(%esp)
     4a4:	00 
     4a5:	89 04 24             	mov    %eax,(%esp)
     4a8:	e8 f4 38 00 00       	call   3da1 <printf>
     4ad:	e8 76 37 00 00       	call   3c28 <exit>
     4b2:	a1 18 5d 00 00       	mov    0x5d18,%eax
     4b7:	c7 44 24 04 d3 43 00 	movl   $0x43d3,0x4(%esp)
     4be:	00 
     4bf:	89 04 24             	mov    %eax,(%esp)
     4c2:	e8 da 38 00 00       	call   3da1 <printf>
     4c7:	c9                   	leave  
     4c8:	c3                   	ret    

000004c9 <createtest>:
     4c9:	55                   	push   %ebp
     4ca:	89 e5                	mov    %esp,%ebp
     4cc:	83 ec 28             	sub    $0x28,%esp
     4cf:	a1 18 5d 00 00       	mov    0x5d18,%eax
     4d4:	c7 44 24 04 e4 43 00 	movl   $0x43e4,0x4(%esp)
     4db:	00 
     4dc:	89 04 24             	mov    %eax,(%esp)
     4df:	e8 bd 38 00 00       	call   3da1 <printf>
     4e4:	c6 05 00 a5 00 00 61 	movb   $0x61,0xa500
     4eb:	c6 05 02 a5 00 00 00 	movb   $0x0,0xa502
     4f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4f9:	eb 31                	jmp    52c <createtest+0x63>
     4fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fe:	83 c0 30             	add    $0x30,%eax
     501:	a2 01 a5 00 00       	mov    %al,0xa501
     506:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     50d:	00 
     50e:	c7 04 24 00 a5 00 00 	movl   $0xa500,(%esp)
     515:	e8 4e 37 00 00       	call   3c68 <open>
     51a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     51d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     520:	89 04 24             	mov    %eax,(%esp)
     523:	e8 28 37 00 00       	call   3c50 <close>
     528:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     52c:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     530:	7e c9                	jle    4fb <createtest+0x32>
     532:	c6 05 00 a5 00 00 61 	movb   $0x61,0xa500
     539:	c6 05 02 a5 00 00 00 	movb   $0x0,0xa502
     540:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     547:	eb 1b                	jmp    564 <createtest+0x9b>
     549:	8b 45 f4             	mov    -0xc(%ebp),%eax
     54c:	83 c0 30             	add    $0x30,%eax
     54f:	a2 01 a5 00 00       	mov    %al,0xa501
     554:	c7 04 24 00 a5 00 00 	movl   $0xa500,(%esp)
     55b:	e8 18 37 00 00       	call   3c78 <unlink>
     560:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     564:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     568:	7e df                	jle    549 <createtest+0x80>
     56a:	a1 18 5d 00 00       	mov    0x5d18,%eax
     56f:	c7 44 24 04 0c 44 00 	movl   $0x440c,0x4(%esp)
     576:	00 
     577:	89 04 24             	mov    %eax,(%esp)
     57a:	e8 22 38 00 00       	call   3da1 <printf>
     57f:	c9                   	leave  
     580:	c3                   	ret    

00000581 <dirtest>:
     581:	55                   	push   %ebp
     582:	89 e5                	mov    %esp,%ebp
     584:	83 ec 18             	sub    $0x18,%esp
     587:	a1 18 5d 00 00       	mov    0x5d18,%eax
     58c:	c7 44 24 04 32 44 00 	movl   $0x4432,0x4(%esp)
     593:	00 
     594:	89 04 24             	mov    %eax,(%esp)
     597:	e8 05 38 00 00       	call   3da1 <printf>
     59c:	c7 04 24 3e 44 00 00 	movl   $0x443e,(%esp)
     5a3:	e8 e8 36 00 00       	call   3c90 <mkdir>
     5a8:	85 c0                	test   %eax,%eax
     5aa:	79 1a                	jns    5c6 <dirtest+0x45>
     5ac:	a1 18 5d 00 00       	mov    0x5d18,%eax
     5b1:	c7 44 24 04 43 44 00 	movl   $0x4443,0x4(%esp)
     5b8:	00 
     5b9:	89 04 24             	mov    %eax,(%esp)
     5bc:	e8 e0 37 00 00       	call   3da1 <printf>
     5c1:	e8 62 36 00 00       	call   3c28 <exit>
     5c6:	c7 04 24 3e 44 00 00 	movl   $0x443e,(%esp)
     5cd:	e8 c6 36 00 00       	call   3c98 <chdir>
     5d2:	85 c0                	test   %eax,%eax
     5d4:	79 1a                	jns    5f0 <dirtest+0x6f>
     5d6:	a1 18 5d 00 00       	mov    0x5d18,%eax
     5db:	c7 44 24 04 51 44 00 	movl   $0x4451,0x4(%esp)
     5e2:	00 
     5e3:	89 04 24             	mov    %eax,(%esp)
     5e6:	e8 b6 37 00 00       	call   3da1 <printf>
     5eb:	e8 38 36 00 00       	call   3c28 <exit>
     5f0:	c7 04 24 64 44 00 00 	movl   $0x4464,(%esp)
     5f7:	e8 9c 36 00 00       	call   3c98 <chdir>
     5fc:	85 c0                	test   %eax,%eax
     5fe:	79 1a                	jns    61a <dirtest+0x99>
     600:	a1 18 5d 00 00       	mov    0x5d18,%eax
     605:	c7 44 24 04 67 44 00 	movl   $0x4467,0x4(%esp)
     60c:	00 
     60d:	89 04 24             	mov    %eax,(%esp)
     610:	e8 8c 37 00 00       	call   3da1 <printf>
     615:	e8 0e 36 00 00       	call   3c28 <exit>
     61a:	c7 04 24 3e 44 00 00 	movl   $0x443e,(%esp)
     621:	e8 52 36 00 00       	call   3c78 <unlink>
     626:	85 c0                	test   %eax,%eax
     628:	79 1a                	jns    644 <dirtest+0xc3>
     62a:	a1 18 5d 00 00       	mov    0x5d18,%eax
     62f:	c7 44 24 04 78 44 00 	movl   $0x4478,0x4(%esp)
     636:	00 
     637:	89 04 24             	mov    %eax,(%esp)
     63a:	e8 62 37 00 00       	call   3da1 <printf>
     63f:	e8 e4 35 00 00       	call   3c28 <exit>
     644:	a1 18 5d 00 00       	mov    0x5d18,%eax
     649:	c7 44 24 04 32 44 00 	movl   $0x4432,0x4(%esp)
     650:	00 
     651:	89 04 24             	mov    %eax,(%esp)
     654:	e8 48 37 00 00       	call   3da1 <printf>
     659:	c9                   	leave  
     65a:	c3                   	ret    

0000065b <exectest>:
     65b:	55                   	push   %ebp
     65c:	89 e5                	mov    %esp,%ebp
     65e:	83 ec 18             	sub    $0x18,%esp
     661:	a1 18 5d 00 00       	mov    0x5d18,%eax
     666:	c7 44 24 04 8c 44 00 	movl   $0x448c,0x4(%esp)
     66d:	00 
     66e:	89 04 24             	mov    %eax,(%esp)
     671:	e8 2b 37 00 00       	call   3da1 <printf>
     676:	c7 44 24 04 04 5d 00 	movl   $0x5d04,0x4(%esp)
     67d:	00 
     67e:	c7 04 24 68 41 00 00 	movl   $0x4168,(%esp)
     685:	e8 d6 35 00 00       	call   3c60 <exec>
     68a:	85 c0                	test   %eax,%eax
     68c:	79 1a                	jns    6a8 <exectest+0x4d>
     68e:	a1 18 5d 00 00       	mov    0x5d18,%eax
     693:	c7 44 24 04 97 44 00 	movl   $0x4497,0x4(%esp)
     69a:	00 
     69b:	89 04 24             	mov    %eax,(%esp)
     69e:	e8 fe 36 00 00       	call   3da1 <printf>
     6a3:	e8 80 35 00 00       	call   3c28 <exit>
     6a8:	c9                   	leave  
     6a9:	c3                   	ret    

000006aa <pipe1>:
     6aa:	55                   	push   %ebp
     6ab:	89 e5                	mov    %esp,%ebp
     6ad:	83 ec 38             	sub    $0x38,%esp
     6b0:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6b3:	89 04 24             	mov    %eax,(%esp)
     6b6:	e8 7d 35 00 00       	call   3c38 <pipe>
     6bb:	85 c0                	test   %eax,%eax
     6bd:	74 19                	je     6d8 <pipe1+0x2e>
     6bf:	c7 44 24 04 a9 44 00 	movl   $0x44a9,0x4(%esp)
     6c6:	00 
     6c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6ce:	e8 ce 36 00 00       	call   3da1 <printf>
     6d3:	e8 50 35 00 00       	call   3c28 <exit>
     6d8:	e8 43 35 00 00       	call   3c20 <fork>
     6dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
     6e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     6e7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     6eb:	0f 85 86 00 00 00    	jne    777 <pipe1+0xcd>
     6f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     6f4:	89 04 24             	mov    %eax,(%esp)
     6f7:	e8 54 35 00 00       	call   3c50 <close>
     6fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     703:	eb 67                	jmp    76c <pipe1+0xc2>
     705:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     70c:	eb 16                	jmp    724 <pipe1+0x7a>
     70e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     711:	8b 55 f0             	mov    -0x10(%ebp),%edx
     714:	81 c2 00 85 00 00    	add    $0x8500,%edx
     71a:	88 02                	mov    %al,(%edx)
     71c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     720:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     724:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     72b:	7e e1                	jle    70e <pipe1+0x64>
     72d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     730:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     737:	00 
     738:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     73f:	00 
     740:	89 04 24             	mov    %eax,(%esp)
     743:	e8 00 35 00 00       	call   3c48 <write>
     748:	3d 09 04 00 00       	cmp    $0x409,%eax
     74d:	74 19                	je     768 <pipe1+0xbe>
     74f:	c7 44 24 04 b8 44 00 	movl   $0x44b8,0x4(%esp)
     756:	00 
     757:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     75e:	e8 3e 36 00 00       	call   3da1 <printf>
     763:	e8 c0 34 00 00       	call   3c28 <exit>
     768:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     76c:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     770:	7e 93                	jle    705 <pipe1+0x5b>
     772:	e8 b1 34 00 00       	call   3c28 <exit>
     777:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     77b:	0f 8e fc 00 00 00    	jle    87d <pipe1+0x1d3>
     781:	8b 45 dc             	mov    -0x24(%ebp),%eax
     784:	89 04 24             	mov    %eax,(%esp)
     787:	e8 c4 34 00 00       	call   3c50 <close>
     78c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     793:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
     79a:	eb 6b                	jmp    807 <pipe1+0x15d>
     79c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7a3:	eb 40                	jmp    7e5 <pipe1+0x13b>
     7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a8:	05 00 85 00 00       	add    $0x8500,%eax
     7ad:	0f b6 00             	movzbl (%eax),%eax
     7b0:	0f be c0             	movsbl %al,%eax
     7b3:	33 45 f4             	xor    -0xc(%ebp),%eax
     7b6:	25 ff 00 00 00       	and    $0xff,%eax
     7bb:	85 c0                	test   %eax,%eax
     7bd:	0f 95 c0             	setne  %al
     7c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     7c4:	84 c0                	test   %al,%al
     7c6:	74 19                	je     7e1 <pipe1+0x137>
     7c8:	c7 44 24 04 c6 44 00 	movl   $0x44c6,0x4(%esp)
     7cf:	00 
     7d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     7d7:	e8 c5 35 00 00       	call   3da1 <printf>
     7dc:	e9 b5 00 00 00       	jmp    896 <pipe1+0x1ec>
     7e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7eb:	7c b8                	jl     7a5 <pipe1+0xfb>
     7ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7f0:	01 45 e4             	add    %eax,-0x1c(%ebp)
     7f3:	d1 65 e8             	shll   -0x18(%ebp)
     7f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f9:	3d 00 20 00 00       	cmp    $0x2000,%eax
     7fe:	76 07                	jbe    807 <pipe1+0x15d>
     800:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
     807:	8b 45 d8             	mov    -0x28(%ebp),%eax
     80a:	8b 55 e8             	mov    -0x18(%ebp),%edx
     80d:	89 54 24 08          	mov    %edx,0x8(%esp)
     811:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     818:	00 
     819:	89 04 24             	mov    %eax,(%esp)
     81c:	e8 1f 34 00 00       	call   3c40 <read>
     821:	89 45 ec             	mov    %eax,-0x14(%ebp)
     824:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     828:	0f 8f 6e ff ff ff    	jg     79c <pipe1+0xf2>
     82e:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     835:	74 20                	je     857 <pipe1+0x1ad>
     837:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     83a:	89 44 24 08          	mov    %eax,0x8(%esp)
     83e:	c7 44 24 04 d4 44 00 	movl   $0x44d4,0x4(%esp)
     845:	00 
     846:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     84d:	e8 4f 35 00 00       	call   3da1 <printf>
     852:	e8 d1 33 00 00       	call   3c28 <exit>
     857:	8b 45 d8             	mov    -0x28(%ebp),%eax
     85a:	89 04 24             	mov    %eax,(%esp)
     85d:	e8 ee 33 00 00       	call   3c50 <close>
     862:	e8 c9 33 00 00       	call   3c30 <wait>
     867:	c7 44 24 04 eb 44 00 	movl   $0x44eb,0x4(%esp)
     86e:	00 
     86f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     876:	e8 26 35 00 00       	call   3da1 <printf>
     87b:	eb 19                	jmp    896 <pipe1+0x1ec>
     87d:	c7 44 24 04 f5 44 00 	movl   $0x44f5,0x4(%esp)
     884:	00 
     885:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     88c:	e8 10 35 00 00       	call   3da1 <printf>
     891:	e8 92 33 00 00       	call   3c28 <exit>
     896:	c9                   	leave  
     897:	c3                   	ret    

00000898 <preempt>:
     898:	55                   	push   %ebp
     899:	89 e5                	mov    %esp,%ebp
     89b:	83 ec 38             	sub    $0x38,%esp
     89e:	c7 44 24 04 04 45 00 	movl   $0x4504,0x4(%esp)
     8a5:	00 
     8a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8ad:	e8 ef 34 00 00       	call   3da1 <printf>
     8b2:	e8 69 33 00 00       	call   3c20 <fork>
     8b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8be:	75 02                	jne    8c2 <preempt+0x2a>
     8c0:	eb fe                	jmp    8c0 <preempt+0x28>
     8c2:	e8 59 33 00 00       	call   3c20 <fork>
     8c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8ce:	75 02                	jne    8d2 <preempt+0x3a>
     8d0:	eb fe                	jmp    8d0 <preempt+0x38>
     8d2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8d5:	89 04 24             	mov    %eax,(%esp)
     8d8:	e8 5b 33 00 00       	call   3c38 <pipe>
     8dd:	e8 3e 33 00 00       	call   3c20 <fork>
     8e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     8e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8e9:	75 4c                	jne    937 <preempt+0x9f>
     8eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ee:	89 04 24             	mov    %eax,(%esp)
     8f1:	e8 5a 33 00 00       	call   3c50 <close>
     8f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     8f9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     900:	00 
     901:	c7 44 24 04 0e 45 00 	movl   $0x450e,0x4(%esp)
     908:	00 
     909:	89 04 24             	mov    %eax,(%esp)
     90c:	e8 37 33 00 00       	call   3c48 <write>
     911:	83 f8 01             	cmp    $0x1,%eax
     914:	74 14                	je     92a <preempt+0x92>
     916:	c7 44 24 04 10 45 00 	movl   $0x4510,0x4(%esp)
     91d:	00 
     91e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     925:	e8 77 34 00 00       	call   3da1 <printf>
     92a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     92d:	89 04 24             	mov    %eax,(%esp)
     930:	e8 1b 33 00 00       	call   3c50 <close>
     935:	eb fe                	jmp    935 <preempt+0x9d>
     937:	8b 45 e8             	mov    -0x18(%ebp),%eax
     93a:	89 04 24             	mov    %eax,(%esp)
     93d:	e8 0e 33 00 00       	call   3c50 <close>
     942:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     945:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     94c:	00 
     94d:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     954:	00 
     955:	89 04 24             	mov    %eax,(%esp)
     958:	e8 e3 32 00 00       	call   3c40 <read>
     95d:	83 f8 01             	cmp    $0x1,%eax
     960:	74 16                	je     978 <preempt+0xe0>
     962:	c7 44 24 04 24 45 00 	movl   $0x4524,0x4(%esp)
     969:	00 
     96a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     971:	e8 2b 34 00 00       	call   3da1 <printf>
     976:	eb 77                	jmp    9ef <preempt+0x157>
     978:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     97b:	89 04 24             	mov    %eax,(%esp)
     97e:	e8 cd 32 00 00       	call   3c50 <close>
     983:	c7 44 24 04 37 45 00 	movl   $0x4537,0x4(%esp)
     98a:	00 
     98b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     992:	e8 0a 34 00 00       	call   3da1 <printf>
     997:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99a:	89 04 24             	mov    %eax,(%esp)
     99d:	e8 b6 32 00 00       	call   3c58 <kill>
     9a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9a5:	89 04 24             	mov    %eax,(%esp)
     9a8:	e8 ab 32 00 00       	call   3c58 <kill>
     9ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9b0:	89 04 24             	mov    %eax,(%esp)
     9b3:	e8 a0 32 00 00       	call   3c58 <kill>
     9b8:	c7 44 24 04 40 45 00 	movl   $0x4540,0x4(%esp)
     9bf:	00 
     9c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9c7:	e8 d5 33 00 00       	call   3da1 <printf>
     9cc:	e8 5f 32 00 00       	call   3c30 <wait>
     9d1:	e8 5a 32 00 00       	call   3c30 <wait>
     9d6:	e8 55 32 00 00       	call   3c30 <wait>
     9db:	c7 44 24 04 49 45 00 	movl   $0x4549,0x4(%esp)
     9e2:	00 
     9e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9ea:	e8 b2 33 00 00       	call   3da1 <printf>
     9ef:	c9                   	leave  
     9f0:	c3                   	ret    

000009f1 <exitwait>:
     9f1:	55                   	push   %ebp
     9f2:	89 e5                	mov    %esp,%ebp
     9f4:	83 ec 28             	sub    $0x28,%esp
     9f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9fe:	eb 53                	jmp    a53 <exitwait+0x62>
     a00:	e8 1b 32 00 00       	call   3c20 <fork>
     a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a0c:	79 16                	jns    a24 <exitwait+0x33>
     a0e:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
     a15:	00 
     a16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a1d:	e8 7f 33 00 00       	call   3da1 <printf>
     a22:	eb 49                	jmp    a6d <exitwait+0x7c>
     a24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a28:	74 20                	je     a4a <exitwait+0x59>
     a2a:	e8 01 32 00 00       	call   3c30 <wait>
     a2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     a32:	74 1b                	je     a4f <exitwait+0x5e>
     a34:	c7 44 24 04 62 45 00 	movl   $0x4562,0x4(%esp)
     a3b:	00 
     a3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a43:	e8 59 33 00 00       	call   3da1 <printf>
     a48:	eb 23                	jmp    a6d <exitwait+0x7c>
     a4a:	e8 d9 31 00 00       	call   3c28 <exit>
     a4f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a53:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a57:	7e a7                	jle    a00 <exitwait+0xf>
     a59:	c7 44 24 04 72 45 00 	movl   $0x4572,0x4(%esp)
     a60:	00 
     a61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a68:	e8 34 33 00 00       	call   3da1 <printf>
     a6d:	c9                   	leave  
     a6e:	c3                   	ret    

00000a6f <mem>:
     a6f:	55                   	push   %ebp
     a70:	89 e5                	mov    %esp,%ebp
     a72:	83 ec 28             	sub    $0x28,%esp
     a75:	c7 44 24 04 7f 45 00 	movl   $0x457f,0x4(%esp)
     a7c:	00 
     a7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a84:	e8 18 33 00 00       	call   3da1 <printf>
     a89:	e8 1a 32 00 00       	call   3ca8 <getpid>
     a8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a91:	e8 8a 31 00 00       	call   3c20 <fork>
     a96:	89 45 ec             	mov    %eax,-0x14(%ebp)
     a99:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a9d:	0f 85 aa 00 00 00    	jne    b4d <mem+0xde>
     aa3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aaa:	eb 0e                	jmp    aba <mem+0x4b>
     aac:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ab2:	89 10                	mov    %edx,(%eax)
     ab4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     aba:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     ac1:	e8 c1 35 00 00       	call   4087 <malloc>
     ac6:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ac9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     acd:	75 dd                	jne    aac <mem+0x3d>
     acf:	eb 19                	jmp    aea <mem+0x7b>
     ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad4:	8b 00                	mov    (%eax),%eax
     ad6:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adc:	89 04 24             	mov    %eax,(%esp)
     adf:	e8 74 34 00 00       	call   3f58 <free>
     ae4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ae7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     aea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     aee:	75 e1                	jne    ad1 <mem+0x62>
     af0:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     af7:	e8 8b 35 00 00       	call   4087 <malloc>
     afc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     aff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b03:	75 24                	jne    b29 <mem+0xba>
     b05:	c7 44 24 04 89 45 00 	movl   $0x4589,0x4(%esp)
     b0c:	00 
     b0d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b14:	e8 88 32 00 00       	call   3da1 <printf>
     b19:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1c:	89 04 24             	mov    %eax,(%esp)
     b1f:	e8 34 31 00 00       	call   3c58 <kill>
     b24:	e8 ff 30 00 00       	call   3c28 <exit>
     b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2c:	89 04 24             	mov    %eax,(%esp)
     b2f:	e8 24 34 00 00       	call   3f58 <free>
     b34:	c7 44 24 04 a3 45 00 	movl   $0x45a3,0x4(%esp)
     b3b:	00 
     b3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b43:	e8 59 32 00 00       	call   3da1 <printf>
     b48:	e8 db 30 00 00       	call   3c28 <exit>
     b4d:	e8 de 30 00 00       	call   3c30 <wait>
     b52:	c9                   	leave  
     b53:	c3                   	ret    

00000b54 <sharedfd>:
     b54:	55                   	push   %ebp
     b55:	89 e5                	mov    %esp,%ebp
     b57:	83 ec 48             	sub    $0x48,%esp
     b5a:	c7 44 24 04 ab 45 00 	movl   $0x45ab,0x4(%esp)
     b61:	00 
     b62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b69:	e8 33 32 00 00       	call   3da1 <printf>
     b6e:	c7 04 24 ba 45 00 00 	movl   $0x45ba,(%esp)
     b75:	e8 fe 30 00 00       	call   3c78 <unlink>
     b7a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     b81:	00 
     b82:	c7 04 24 ba 45 00 00 	movl   $0x45ba,(%esp)
     b89:	e8 da 30 00 00       	call   3c68 <open>
     b8e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     b91:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     b95:	79 19                	jns    bb0 <sharedfd+0x5c>
     b97:	c7 44 24 04 c4 45 00 	movl   $0x45c4,0x4(%esp)
     b9e:	00 
     b9f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ba6:	e8 f6 31 00 00       	call   3da1 <printf>
     bab:	e9 9c 01 00 00       	jmp    d4c <sharedfd+0x1f8>
     bb0:	e8 6b 30 00 00       	call   3c20 <fork>
     bb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     bb8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bbc:	75 07                	jne    bc5 <sharedfd+0x71>
     bbe:	b8 63 00 00 00       	mov    $0x63,%eax
     bc3:	eb 05                	jmp    bca <sharedfd+0x76>
     bc5:	b8 70 00 00 00       	mov    $0x70,%eax
     bca:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     bd1:	00 
     bd2:	89 44 24 04          	mov    %eax,0x4(%esp)
     bd6:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     bd9:	89 04 24             	mov    %eax,(%esp)
     bdc:	e8 a1 2e 00 00       	call   3a82 <memset>
     be1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     be8:	eb 39                	jmp    c23 <sharedfd+0xcf>
     bea:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     bf1:	00 
     bf2:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     bf5:	89 44 24 04          	mov    %eax,0x4(%esp)
     bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bfc:	89 04 24             	mov    %eax,(%esp)
     bff:	e8 44 30 00 00       	call   3c48 <write>
     c04:	83 f8 0a             	cmp    $0xa,%eax
     c07:	74 16                	je     c1f <sharedfd+0xcb>
     c09:	c7 44 24 04 f0 45 00 	movl   $0x45f0,0x4(%esp)
     c10:	00 
     c11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c18:	e8 84 31 00 00       	call   3da1 <printf>
     c1d:	eb 0d                	jmp    c2c <sharedfd+0xd8>
     c1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c23:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c2a:	7e be                	jle    bea <sharedfd+0x96>
     c2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c30:	75 05                	jne    c37 <sharedfd+0xe3>
     c32:	e8 f1 2f 00 00       	call   3c28 <exit>
     c37:	e8 f4 2f 00 00       	call   3c30 <wait>
     c3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3f:	89 04 24             	mov    %eax,(%esp)
     c42:	e8 09 30 00 00       	call   3c50 <close>
     c47:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c4e:	00 
     c4f:	c7 04 24 ba 45 00 00 	movl   $0x45ba,(%esp)
     c56:	e8 0d 30 00 00       	call   3c68 <open>
     c5b:	89 45 e8             	mov    %eax,-0x18(%ebp)
     c5e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c62:	79 19                	jns    c7d <sharedfd+0x129>
     c64:	c7 44 24 04 10 46 00 	movl   $0x4610,0x4(%esp)
     c6b:	00 
     c6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c73:	e8 29 31 00 00       	call   3da1 <printf>
     c78:	e9 cf 00 00 00       	jmp    d4c <sharedfd+0x1f8>
     c7d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     c84:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c87:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c8a:	eb 37                	jmp    cc3 <sharedfd+0x16f>
     c8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c93:	eb 26                	jmp    cbb <sharedfd+0x167>
     c95:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c98:	03 45 f4             	add    -0xc(%ebp),%eax
     c9b:	0f b6 00             	movzbl (%eax),%eax
     c9e:	3c 63                	cmp    $0x63,%al
     ca0:	75 04                	jne    ca6 <sharedfd+0x152>
     ca2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ca6:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ca9:	03 45 f4             	add    -0xc(%ebp),%eax
     cac:	0f b6 00             	movzbl (%eax),%eax
     caf:	3c 70                	cmp    $0x70,%al
     cb1:	75 04                	jne    cb7 <sharedfd+0x163>
     cb3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     cb7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbe:	83 f8 09             	cmp    $0x9,%eax
     cc1:	76 d2                	jbe    c95 <sharedfd+0x141>
     cc3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     cca:	00 
     ccb:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     cce:	89 44 24 04          	mov    %eax,0x4(%esp)
     cd2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cd5:	89 04 24             	mov    %eax,(%esp)
     cd8:	e8 63 2f 00 00       	call   3c40 <read>
     cdd:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ce0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     ce4:	7f a6                	jg     c8c <sharedfd+0x138>
     ce6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ce9:	89 04 24             	mov    %eax,(%esp)
     cec:	e8 5f 2f 00 00       	call   3c50 <close>
     cf1:	c7 04 24 ba 45 00 00 	movl   $0x45ba,(%esp)
     cf8:	e8 7b 2f 00 00       	call   3c78 <unlink>
     cfd:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d04:	75 1f                	jne    d25 <sharedfd+0x1d1>
     d06:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d0d:	75 16                	jne    d25 <sharedfd+0x1d1>
     d0f:	c7 44 24 04 3b 46 00 	movl   $0x463b,0x4(%esp)
     d16:	00 
     d17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d1e:	e8 7e 30 00 00       	call   3da1 <printf>
     d23:	eb 27                	jmp    d4c <sharedfd+0x1f8>
     d25:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d28:	89 44 24 0c          	mov    %eax,0xc(%esp)
     d2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d2f:	89 44 24 08          	mov    %eax,0x8(%esp)
     d33:	c7 44 24 04 48 46 00 	movl   $0x4648,0x4(%esp)
     d3a:	00 
     d3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d42:	e8 5a 30 00 00       	call   3da1 <printf>
     d47:	e8 dc 2e 00 00       	call   3c28 <exit>
     d4c:	c9                   	leave  
     d4d:	c3                   	ret    

00000d4e <twofiles>:
     d4e:	55                   	push   %ebp
     d4f:	89 e5                	mov    %esp,%ebp
     d51:	83 ec 38             	sub    $0x38,%esp
     d54:	c7 44 24 04 5d 46 00 	movl   $0x465d,0x4(%esp)
     d5b:	00 
     d5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d63:	e8 39 30 00 00       	call   3da1 <printf>
     d68:	c7 04 24 6c 46 00 00 	movl   $0x466c,(%esp)
     d6f:	e8 04 2f 00 00       	call   3c78 <unlink>
     d74:	c7 04 24 6f 46 00 00 	movl   $0x466f,(%esp)
     d7b:	e8 f8 2e 00 00       	call   3c78 <unlink>
     d80:	e8 9b 2e 00 00       	call   3c20 <fork>
     d85:	89 45 e8             	mov    %eax,-0x18(%ebp)
     d88:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d8c:	79 19                	jns    da7 <twofiles+0x59>
     d8e:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
     d95:	00 
     d96:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d9d:	e8 ff 2f 00 00       	call   3da1 <printf>
     da2:	e8 81 2e 00 00       	call   3c28 <exit>
     da7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dab:	74 07                	je     db4 <twofiles+0x66>
     dad:	b8 6c 46 00 00       	mov    $0x466c,%eax
     db2:	eb 05                	jmp    db9 <twofiles+0x6b>
     db4:	b8 6f 46 00 00       	mov    $0x466f,%eax
     db9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     dbc:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     dc3:	00 
     dc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dc7:	89 04 24             	mov    %eax,(%esp)
     dca:	e8 99 2e 00 00       	call   3c68 <open>
     dcf:	89 45 e0             	mov    %eax,-0x20(%ebp)
     dd2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     dd6:	79 19                	jns    df1 <twofiles+0xa3>
     dd8:	c7 44 24 04 72 46 00 	movl   $0x4672,0x4(%esp)
     ddf:	00 
     de0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     de7:	e8 b5 2f 00 00       	call   3da1 <printf>
     dec:	e8 37 2e 00 00       	call   3c28 <exit>
     df1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     df5:	74 07                	je     dfe <twofiles+0xb0>
     df7:	b8 70 00 00 00       	mov    $0x70,%eax
     dfc:	eb 05                	jmp    e03 <twofiles+0xb5>
     dfe:	b8 63 00 00 00       	mov    $0x63,%eax
     e03:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     e0a:	00 
     e0b:	89 44 24 04          	mov    %eax,0x4(%esp)
     e0f:	c7 04 24 00 85 00 00 	movl   $0x8500,(%esp)
     e16:	e8 67 2c 00 00       	call   3a82 <memset>
     e1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e22:	eb 4b                	jmp    e6f <twofiles+0x121>
     e24:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
     e2b:	00 
     e2c:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     e33:	00 
     e34:	8b 45 e0             	mov    -0x20(%ebp),%eax
     e37:	89 04 24             	mov    %eax,(%esp)
     e3a:	e8 09 2e 00 00       	call   3c48 <write>
     e3f:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e42:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e49:	74 20                	je     e6b <twofiles+0x11d>
     e4b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4e:	89 44 24 08          	mov    %eax,0x8(%esp)
     e52:	c7 44 24 04 81 46 00 	movl   $0x4681,0x4(%esp)
     e59:	00 
     e5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e61:	e8 3b 2f 00 00       	call   3da1 <printf>
     e66:	e8 bd 2d 00 00       	call   3c28 <exit>
     e6b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e6f:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     e73:	7e af                	jle    e24 <twofiles+0xd6>
     e75:	8b 45 e0             	mov    -0x20(%ebp),%eax
     e78:	89 04 24             	mov    %eax,(%esp)
     e7b:	e8 d0 2d 00 00       	call   3c50 <close>
     e80:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e84:	74 11                	je     e97 <twofiles+0x149>
     e86:	e8 a5 2d 00 00       	call   3c30 <wait>
     e8b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e92:	e9 e7 00 00 00       	jmp    f7e <twofiles+0x230>
     e97:	e8 8c 2d 00 00       	call   3c28 <exit>
     e9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea0:	74 07                	je     ea9 <twofiles+0x15b>
     ea2:	b8 6c 46 00 00       	mov    $0x466c,%eax
     ea7:	eb 05                	jmp    eae <twofiles+0x160>
     ea9:	b8 6f 46 00 00       	mov    $0x466f,%eax
     eae:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     eb5:	00 
     eb6:	89 04 24             	mov    %eax,(%esp)
     eb9:	e8 aa 2d 00 00       	call   3c68 <open>
     ebe:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ec1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ec8:	eb 58                	jmp    f22 <twofiles+0x1d4>
     eca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ed1:	eb 41                	jmp    f14 <twofiles+0x1c6>
     ed3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed6:	05 00 85 00 00       	add    $0x8500,%eax
     edb:	0f b6 00             	movzbl (%eax),%eax
     ede:	0f be d0             	movsbl %al,%edx
     ee1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ee5:	74 07                	je     eee <twofiles+0x1a0>
     ee7:	b8 70 00 00 00       	mov    $0x70,%eax
     eec:	eb 05                	jmp    ef3 <twofiles+0x1a5>
     eee:	b8 63 00 00 00       	mov    $0x63,%eax
     ef3:	39 c2                	cmp    %eax,%edx
     ef5:	74 19                	je     f10 <twofiles+0x1c2>
     ef7:	c7 44 24 04 92 46 00 	movl   $0x4692,0x4(%esp)
     efe:	00 
     eff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f06:	e8 96 2e 00 00       	call   3da1 <printf>
     f0b:	e8 18 2d 00 00       	call   3c28 <exit>
     f10:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f17:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f1a:	7c b7                	jl     ed3 <twofiles+0x185>
     f1c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f1f:	01 45 ec             	add    %eax,-0x14(%ebp)
     f22:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     f29:	00 
     f2a:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
     f31:	00 
     f32:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f35:	89 04 24             	mov    %eax,(%esp)
     f38:	e8 03 2d 00 00       	call   3c40 <read>
     f3d:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f40:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f44:	7f 84                	jg     eca <twofiles+0x17c>
     f46:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f49:	89 04 24             	mov    %eax,(%esp)
     f4c:	e8 ff 2c 00 00       	call   3c50 <close>
     f51:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f58:	74 20                	je     f7a <twofiles+0x22c>
     f5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f5d:	89 44 24 08          	mov    %eax,0x8(%esp)
     f61:	c7 44 24 04 9e 46 00 	movl   $0x469e,0x4(%esp)
     f68:	00 
     f69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f70:	e8 2c 2e 00 00       	call   3da1 <printf>
     f75:	e8 ae 2c 00 00       	call   3c28 <exit>
     f7a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f7e:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     f82:	0f 8e 14 ff ff ff    	jle    e9c <twofiles+0x14e>
     f88:	c7 04 24 6c 46 00 00 	movl   $0x466c,(%esp)
     f8f:	e8 e4 2c 00 00       	call   3c78 <unlink>
     f94:	c7 04 24 6f 46 00 00 	movl   $0x466f,(%esp)
     f9b:	e8 d8 2c 00 00       	call   3c78 <unlink>
     fa0:	c7 44 24 04 af 46 00 	movl   $0x46af,0x4(%esp)
     fa7:	00 
     fa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     faf:	e8 ed 2d 00 00       	call   3da1 <printf>
     fb4:	c9                   	leave  
     fb5:	c3                   	ret    

00000fb6 <createdelete>:
     fb6:	55                   	push   %ebp
     fb7:	89 e5                	mov    %esp,%ebp
     fb9:	83 ec 48             	sub    $0x48,%esp
     fbc:	c7 44 24 04 bc 46 00 	movl   $0x46bc,0x4(%esp)
     fc3:	00 
     fc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fcb:	e8 d1 2d 00 00       	call   3da1 <printf>
     fd0:	e8 4b 2c 00 00       	call   3c20 <fork>
     fd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     fd8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fdc:	79 19                	jns    ff7 <createdelete+0x41>
     fde:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
     fe5:	00 
     fe6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fed:	e8 af 2d 00 00       	call   3da1 <printf>
     ff2:	e8 31 2c 00 00       	call   3c28 <exit>
     ff7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ffb:	74 07                	je     1004 <createdelete+0x4e>
     ffd:	b8 70 00 00 00       	mov    $0x70,%eax
    1002:	eb 05                	jmp    1009 <createdelete+0x53>
    1004:	b8 63 00 00 00       	mov    $0x63,%eax
    1009:	88 45 cc             	mov    %al,-0x34(%ebp)
    100c:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    1010:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1017:	e9 97 00 00 00       	jmp    10b3 <createdelete+0xfd>
    101c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101f:	83 c0 30             	add    $0x30,%eax
    1022:	88 45 cd             	mov    %al,-0x33(%ebp)
    1025:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    102c:	00 
    102d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1030:	89 04 24             	mov    %eax,(%esp)
    1033:	e8 30 2c 00 00       	call   3c68 <open>
    1038:	89 45 ec             	mov    %eax,-0x14(%ebp)
    103b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    103f:	79 19                	jns    105a <createdelete+0xa4>
    1041:	c7 44 24 04 72 46 00 	movl   $0x4672,0x4(%esp)
    1048:	00 
    1049:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1050:	e8 4c 2d 00 00       	call   3da1 <printf>
    1055:	e8 ce 2b 00 00       	call   3c28 <exit>
    105a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    105d:	89 04 24             	mov    %eax,(%esp)
    1060:	e8 eb 2b 00 00       	call   3c50 <close>
    1065:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1069:	7e 44                	jle    10af <createdelete+0xf9>
    106b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106e:	83 e0 01             	and    $0x1,%eax
    1071:	85 c0                	test   %eax,%eax
    1073:	75 3a                	jne    10af <createdelete+0xf9>
    1075:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1078:	89 c2                	mov    %eax,%edx
    107a:	c1 ea 1f             	shr    $0x1f,%edx
    107d:	01 d0                	add    %edx,%eax
    107f:	d1 f8                	sar    %eax
    1081:	83 c0 30             	add    $0x30,%eax
    1084:	88 45 cd             	mov    %al,-0x33(%ebp)
    1087:	8d 45 cc             	lea    -0x34(%ebp),%eax
    108a:	89 04 24             	mov    %eax,(%esp)
    108d:	e8 e6 2b 00 00       	call   3c78 <unlink>
    1092:	85 c0                	test   %eax,%eax
    1094:	79 19                	jns    10af <createdelete+0xf9>
    1096:	c7 44 24 04 cf 46 00 	movl   $0x46cf,0x4(%esp)
    109d:	00 
    109e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a5:	e8 f7 2c 00 00       	call   3da1 <printf>
    10aa:	e8 79 2b 00 00       	call   3c28 <exit>
    10af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10b7:	0f 8e 5f ff ff ff    	jle    101c <createdelete+0x66>
    10bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10c1:	75 05                	jne    10c8 <createdelete+0x112>
    10c3:	e8 60 2b 00 00       	call   3c28 <exit>
    10c8:	e8 63 2b 00 00       	call   3c30 <wait>
    10cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10d4:	e9 34 01 00 00       	jmp    120d <createdelete+0x257>
    10d9:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    10dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e0:	83 c0 30             	add    $0x30,%eax
    10e3:	88 45 cd             	mov    %al,-0x33(%ebp)
    10e6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ed:	00 
    10ee:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10f1:	89 04 24             	mov    %eax,(%esp)
    10f4:	e8 6f 2b 00 00       	call   3c68 <open>
    10f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    10fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1100:	74 06                	je     1108 <createdelete+0x152>
    1102:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1106:	7e 26                	jle    112e <createdelete+0x178>
    1108:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    110c:	79 20                	jns    112e <createdelete+0x178>
    110e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1111:	89 44 24 08          	mov    %eax,0x8(%esp)
    1115:	c7 44 24 04 e0 46 00 	movl   $0x46e0,0x4(%esp)
    111c:	00 
    111d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1124:	e8 78 2c 00 00       	call   3da1 <printf>
    1129:	e8 fa 2a 00 00       	call   3c28 <exit>
    112e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1132:	7e 2c                	jle    1160 <createdelete+0x1aa>
    1134:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1138:	7f 26                	jg     1160 <createdelete+0x1aa>
    113a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    113e:	78 20                	js     1160 <createdelete+0x1aa>
    1140:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1143:	89 44 24 08          	mov    %eax,0x8(%esp)
    1147:	c7 44 24 04 04 47 00 	movl   $0x4704,0x4(%esp)
    114e:	00 
    114f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1156:	e8 46 2c 00 00       	call   3da1 <printf>
    115b:	e8 c8 2a 00 00       	call   3c28 <exit>
    1160:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1164:	78 0b                	js     1171 <createdelete+0x1bb>
    1166:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1169:	89 04 24             	mov    %eax,(%esp)
    116c:	e8 df 2a 00 00       	call   3c50 <close>
    1171:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    1175:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1178:	83 c0 30             	add    $0x30,%eax
    117b:	88 45 cd             	mov    %al,-0x33(%ebp)
    117e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1185:	00 
    1186:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1189:	89 04 24             	mov    %eax,(%esp)
    118c:	e8 d7 2a 00 00       	call   3c68 <open>
    1191:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1194:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1198:	74 06                	je     11a0 <createdelete+0x1ea>
    119a:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    119e:	7e 26                	jle    11c6 <createdelete+0x210>
    11a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11a4:	79 20                	jns    11c6 <createdelete+0x210>
    11a6:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11a9:	89 44 24 08          	mov    %eax,0x8(%esp)
    11ad:	c7 44 24 04 e0 46 00 	movl   $0x46e0,0x4(%esp)
    11b4:	00 
    11b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11bc:	e8 e0 2b 00 00       	call   3da1 <printf>
    11c1:	e8 62 2a 00 00       	call   3c28 <exit>
    11c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ca:	7e 2c                	jle    11f8 <createdelete+0x242>
    11cc:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11d0:	7f 26                	jg     11f8 <createdelete+0x242>
    11d2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11d6:	78 20                	js     11f8 <createdelete+0x242>
    11d8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11db:	89 44 24 08          	mov    %eax,0x8(%esp)
    11df:	c7 44 24 04 04 47 00 	movl   $0x4704,0x4(%esp)
    11e6:	00 
    11e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11ee:	e8 ae 2b 00 00       	call   3da1 <printf>
    11f3:	e8 30 2a 00 00       	call   3c28 <exit>
    11f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11fc:	78 0b                	js     1209 <createdelete+0x253>
    11fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1201:	89 04 24             	mov    %eax,(%esp)
    1204:	e8 47 2a 00 00       	call   3c50 <close>
    1209:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    120d:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1211:	0f 8e c2 fe ff ff    	jle    10d9 <createdelete+0x123>
    1217:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    121e:	eb 2b                	jmp    124b <createdelete+0x295>
    1220:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    1224:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1227:	83 c0 30             	add    $0x30,%eax
    122a:	88 45 cd             	mov    %al,-0x33(%ebp)
    122d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1230:	89 04 24             	mov    %eax,(%esp)
    1233:	e8 40 2a 00 00       	call   3c78 <unlink>
    1238:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    123c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    123f:	89 04 24             	mov    %eax,(%esp)
    1242:	e8 31 2a 00 00       	call   3c78 <unlink>
    1247:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    124b:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    124f:	7e cf                	jle    1220 <createdelete+0x26a>
    1251:	c7 44 24 04 24 47 00 	movl   $0x4724,0x4(%esp)
    1258:	00 
    1259:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1260:	e8 3c 2b 00 00       	call   3da1 <printf>
    1265:	c9                   	leave  
    1266:	c3                   	ret    

00001267 <unlinkread>:
    1267:	55                   	push   %ebp
    1268:	89 e5                	mov    %esp,%ebp
    126a:	83 ec 28             	sub    $0x28,%esp
    126d:	c7 44 24 04 35 47 00 	movl   $0x4735,0x4(%esp)
    1274:	00 
    1275:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    127c:	e8 20 2b 00 00       	call   3da1 <printf>
    1281:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1288:	00 
    1289:	c7 04 24 46 47 00 00 	movl   $0x4746,(%esp)
    1290:	e8 d3 29 00 00       	call   3c68 <open>
    1295:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1298:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    129c:	79 19                	jns    12b7 <unlinkread+0x50>
    129e:	c7 44 24 04 51 47 00 	movl   $0x4751,0x4(%esp)
    12a5:	00 
    12a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12ad:	e8 ef 2a 00 00       	call   3da1 <printf>
    12b2:	e8 71 29 00 00       	call   3c28 <exit>
    12b7:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    12be:	00 
    12bf:	c7 44 24 04 6b 47 00 	movl   $0x476b,0x4(%esp)
    12c6:	00 
    12c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12ca:	89 04 24             	mov    %eax,(%esp)
    12cd:	e8 76 29 00 00       	call   3c48 <write>
    12d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12d5:	89 04 24             	mov    %eax,(%esp)
    12d8:	e8 73 29 00 00       	call   3c50 <close>
    12dd:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    12e4:	00 
    12e5:	c7 04 24 46 47 00 00 	movl   $0x4746,(%esp)
    12ec:	e8 77 29 00 00       	call   3c68 <open>
    12f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12f8:	79 19                	jns    1313 <unlinkread+0xac>
    12fa:	c7 44 24 04 71 47 00 	movl   $0x4771,0x4(%esp)
    1301:	00 
    1302:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1309:	e8 93 2a 00 00       	call   3da1 <printf>
    130e:	e8 15 29 00 00       	call   3c28 <exit>
    1313:	c7 04 24 46 47 00 00 	movl   $0x4746,(%esp)
    131a:	e8 59 29 00 00       	call   3c78 <unlink>
    131f:	85 c0                	test   %eax,%eax
    1321:	74 19                	je     133c <unlinkread+0xd5>
    1323:	c7 44 24 04 89 47 00 	movl   $0x4789,0x4(%esp)
    132a:	00 
    132b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1332:	e8 6a 2a 00 00       	call   3da1 <printf>
    1337:	e8 ec 28 00 00       	call   3c28 <exit>
    133c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1343:	00 
    1344:	c7 04 24 46 47 00 00 	movl   $0x4746,(%esp)
    134b:	e8 18 29 00 00       	call   3c68 <open>
    1350:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1353:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    135a:	00 
    135b:	c7 44 24 04 a3 47 00 	movl   $0x47a3,0x4(%esp)
    1362:	00 
    1363:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1366:	89 04 24             	mov    %eax,(%esp)
    1369:	e8 da 28 00 00       	call   3c48 <write>
    136e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1371:	89 04 24             	mov    %eax,(%esp)
    1374:	e8 d7 28 00 00       	call   3c50 <close>
    1379:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1380:	00 
    1381:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    1388:	00 
    1389:	8b 45 f4             	mov    -0xc(%ebp),%eax
    138c:	89 04 24             	mov    %eax,(%esp)
    138f:	e8 ac 28 00 00       	call   3c40 <read>
    1394:	83 f8 05             	cmp    $0x5,%eax
    1397:	74 19                	je     13b2 <unlinkread+0x14b>
    1399:	c7 44 24 04 a7 47 00 	movl   $0x47a7,0x4(%esp)
    13a0:	00 
    13a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a8:	e8 f4 29 00 00       	call   3da1 <printf>
    13ad:	e8 76 28 00 00       	call   3c28 <exit>
    13b2:	0f b6 05 00 85 00 00 	movzbl 0x8500,%eax
    13b9:	3c 68                	cmp    $0x68,%al
    13bb:	74 19                	je     13d6 <unlinkread+0x16f>
    13bd:	c7 44 24 04 be 47 00 	movl   $0x47be,0x4(%esp)
    13c4:	00 
    13c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13cc:	e8 d0 29 00 00       	call   3da1 <printf>
    13d1:	e8 52 28 00 00       	call   3c28 <exit>
    13d6:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    13dd:	00 
    13de:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    13e5:	00 
    13e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e9:	89 04 24             	mov    %eax,(%esp)
    13ec:	e8 57 28 00 00       	call   3c48 <write>
    13f1:	83 f8 0a             	cmp    $0xa,%eax
    13f4:	74 19                	je     140f <unlinkread+0x1a8>
    13f6:	c7 44 24 04 d5 47 00 	movl   $0x47d5,0x4(%esp)
    13fd:	00 
    13fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1405:	e8 97 29 00 00       	call   3da1 <printf>
    140a:	e8 19 28 00 00       	call   3c28 <exit>
    140f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1412:	89 04 24             	mov    %eax,(%esp)
    1415:	e8 36 28 00 00       	call   3c50 <close>
    141a:	c7 04 24 46 47 00 00 	movl   $0x4746,(%esp)
    1421:	e8 52 28 00 00       	call   3c78 <unlink>
    1426:	c7 44 24 04 ee 47 00 	movl   $0x47ee,0x4(%esp)
    142d:	00 
    142e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1435:	e8 67 29 00 00       	call   3da1 <printf>
    143a:	c9                   	leave  
    143b:	c3                   	ret    

0000143c <linktest>:
    143c:	55                   	push   %ebp
    143d:	89 e5                	mov    %esp,%ebp
    143f:	83 ec 28             	sub    $0x28,%esp
    1442:	c7 44 24 04 fd 47 00 	movl   $0x47fd,0x4(%esp)
    1449:	00 
    144a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1451:	e8 4b 29 00 00       	call   3da1 <printf>
    1456:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
    145d:	e8 16 28 00 00       	call   3c78 <unlink>
    1462:	c7 04 24 0b 48 00 00 	movl   $0x480b,(%esp)
    1469:	e8 0a 28 00 00       	call   3c78 <unlink>
    146e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1475:	00 
    1476:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
    147d:	e8 e6 27 00 00       	call   3c68 <open>
    1482:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1485:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1489:	79 19                	jns    14a4 <linktest+0x68>
    148b:	c7 44 24 04 0f 48 00 	movl   $0x480f,0x4(%esp)
    1492:	00 
    1493:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    149a:	e8 02 29 00 00       	call   3da1 <printf>
    149f:	e8 84 27 00 00       	call   3c28 <exit>
    14a4:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    14ab:	00 
    14ac:	c7 44 24 04 6b 47 00 	movl   $0x476b,0x4(%esp)
    14b3:	00 
    14b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b7:	89 04 24             	mov    %eax,(%esp)
    14ba:	e8 89 27 00 00       	call   3c48 <write>
    14bf:	83 f8 05             	cmp    $0x5,%eax
    14c2:	74 19                	je     14dd <linktest+0xa1>
    14c4:	c7 44 24 04 22 48 00 	movl   $0x4822,0x4(%esp)
    14cb:	00 
    14cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14d3:	e8 c9 28 00 00       	call   3da1 <printf>
    14d8:	e8 4b 27 00 00       	call   3c28 <exit>
    14dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e0:	89 04 24             	mov    %eax,(%esp)
    14e3:	e8 68 27 00 00       	call   3c50 <close>
    14e8:	c7 44 24 04 0b 48 00 	movl   $0x480b,0x4(%esp)
    14ef:	00 
    14f0:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
    14f7:	e8 8c 27 00 00       	call   3c88 <link>
    14fc:	85 c0                	test   %eax,%eax
    14fe:	79 19                	jns    1519 <linktest+0xdd>
    1500:	c7 44 24 04 34 48 00 	movl   $0x4834,0x4(%esp)
    1507:	00 
    1508:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    150f:	e8 8d 28 00 00       	call   3da1 <printf>
    1514:	e8 0f 27 00 00       	call   3c28 <exit>
    1519:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
    1520:	e8 53 27 00 00       	call   3c78 <unlink>
    1525:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    152c:	00 
    152d:	c7 04 24 07 48 00 00 	movl   $0x4807,(%esp)
    1534:	e8 2f 27 00 00       	call   3c68 <open>
    1539:	85 c0                	test   %eax,%eax
    153b:	78 19                	js     1556 <linktest+0x11a>
    153d:	c7 44 24 04 4c 48 00 	movl   $0x484c,0x4(%esp)
    1544:	00 
    1545:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154c:	e8 50 28 00 00       	call   3da1 <printf>
    1551:	e8 d2 26 00 00       	call   3c28 <exit>
    1556:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    155d:	00 
    155e:	c7 04 24 0b 48 00 00 	movl   $0x480b,(%esp)
    1565:	e8 fe 26 00 00       	call   3c68 <open>
    156a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    156d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1571:	79 19                	jns    158c <linktest+0x150>
    1573:	c7 44 24 04 71 48 00 	movl   $0x4871,0x4(%esp)
    157a:	00 
    157b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1582:	e8 1a 28 00 00       	call   3da1 <printf>
    1587:	e8 9c 26 00 00       	call   3c28 <exit>
    158c:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1593:	00 
    1594:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    159b:	00 
    159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159f:	89 04 24             	mov    %eax,(%esp)
    15a2:	e8 99 26 00 00       	call   3c40 <read>
    15a7:	83 f8 05             	cmp    $0x5,%eax
    15aa:	74 19                	je     15c5 <linktest+0x189>
    15ac:	c7 44 24 04 82 48 00 	movl   $0x4882,0x4(%esp)
    15b3:	00 
    15b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15bb:	e8 e1 27 00 00       	call   3da1 <printf>
    15c0:	e8 63 26 00 00       	call   3c28 <exit>
    15c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c8:	89 04 24             	mov    %eax,(%esp)
    15cb:	e8 80 26 00 00       	call   3c50 <close>
    15d0:	c7 44 24 04 0b 48 00 	movl   $0x480b,0x4(%esp)
    15d7:	00 
    15d8:	c7 04 24 0b 48 00 00 	movl   $0x480b,(%esp)
    15df:	e8 a4 26 00 00       	call   3c88 <link>
    15e4:	85 c0                	test   %eax,%eax
    15e6:	78 19                	js     1601 <linktest+0x1c5>
    15e8:	c7 44 24 04 93 48 00 	movl   $0x4893,0x4(%esp)
    15ef:	00 
    15f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15f7:	e8 a5 27 00 00       	call   3da1 <printf>
    15fc:	e8 27 26 00 00       	call   3c28 <exit>
    1601:	c7 04 24 0b 48 00 00 	movl   $0x480b,(%esp)
    1608:	e8 6b 26 00 00       	call   3c78 <unlink>
    160d:	c7 44 24 04 07 48 00 	movl   $0x4807,0x4(%esp)
    1614:	00 
    1615:	c7 04 24 0b 48 00 00 	movl   $0x480b,(%esp)
    161c:	e8 67 26 00 00       	call   3c88 <link>
    1621:	85 c0                	test   %eax,%eax
    1623:	78 19                	js     163e <linktest+0x202>
    1625:	c7 44 24 04 b4 48 00 	movl   $0x48b4,0x4(%esp)
    162c:	00 
    162d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1634:	e8 68 27 00 00       	call   3da1 <printf>
    1639:	e8 ea 25 00 00       	call   3c28 <exit>
    163e:	c7 44 24 04 07 48 00 	movl   $0x4807,0x4(%esp)
    1645:	00 
    1646:	c7 04 24 d7 48 00 00 	movl   $0x48d7,(%esp)
    164d:	e8 36 26 00 00       	call   3c88 <link>
    1652:	85 c0                	test   %eax,%eax
    1654:	78 19                	js     166f <linktest+0x233>
    1656:	c7 44 24 04 d9 48 00 	movl   $0x48d9,0x4(%esp)
    165d:	00 
    165e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1665:	e8 37 27 00 00       	call   3da1 <printf>
    166a:	e8 b9 25 00 00       	call   3c28 <exit>
    166f:	c7 44 24 04 f5 48 00 	movl   $0x48f5,0x4(%esp)
    1676:	00 
    1677:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    167e:	e8 1e 27 00 00       	call   3da1 <printf>
    1683:	c9                   	leave  
    1684:	c3                   	ret    

00001685 <concreate>:
    1685:	55                   	push   %ebp
    1686:	89 e5                	mov    %esp,%ebp
    1688:	83 ec 68             	sub    $0x68,%esp
    168b:	c7 44 24 04 02 49 00 	movl   $0x4902,0x4(%esp)
    1692:	00 
    1693:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    169a:	e8 02 27 00 00       	call   3da1 <printf>
    169f:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
    16a3:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    16a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16ae:	e9 f7 00 00 00       	jmp    17aa <concreate+0x125>
    16b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b6:	83 c0 30             	add    $0x30,%eax
    16b9:	88 45 e6             	mov    %al,-0x1a(%ebp)
    16bc:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16bf:	89 04 24             	mov    %eax,(%esp)
    16c2:	e8 b1 25 00 00       	call   3c78 <unlink>
    16c7:	e8 54 25 00 00       	call   3c20 <fork>
    16cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    16cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16d3:	74 3a                	je     170f <concreate+0x8a>
    16d5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16d8:	ba 56 55 55 55       	mov    $0x55555556,%edx
    16dd:	89 c8                	mov    %ecx,%eax
    16df:	f7 ea                	imul   %edx
    16e1:	89 c8                	mov    %ecx,%eax
    16e3:	c1 f8 1f             	sar    $0x1f,%eax
    16e6:	29 c2                	sub    %eax,%edx
    16e8:	89 d0                	mov    %edx,%eax
    16ea:	01 c0                	add    %eax,%eax
    16ec:	01 d0                	add    %edx,%eax
    16ee:	89 ca                	mov    %ecx,%edx
    16f0:	29 c2                	sub    %eax,%edx
    16f2:	83 fa 01             	cmp    $0x1,%edx
    16f5:	75 18                	jne    170f <concreate+0x8a>
    16f7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fe:	c7 04 24 12 49 00 00 	movl   $0x4912,(%esp)
    1705:	e8 7e 25 00 00       	call   3c88 <link>
    170a:	e9 87 00 00 00       	jmp    1796 <concreate+0x111>
    170f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1713:	75 3a                	jne    174f <concreate+0xca>
    1715:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1718:	ba 67 66 66 66       	mov    $0x66666667,%edx
    171d:	89 c8                	mov    %ecx,%eax
    171f:	f7 ea                	imul   %edx
    1721:	d1 fa                	sar    %edx
    1723:	89 c8                	mov    %ecx,%eax
    1725:	c1 f8 1f             	sar    $0x1f,%eax
    1728:	29 c2                	sub    %eax,%edx
    172a:	89 d0                	mov    %edx,%eax
    172c:	c1 e0 02             	shl    $0x2,%eax
    172f:	01 d0                	add    %edx,%eax
    1731:	89 ca                	mov    %ecx,%edx
    1733:	29 c2                	sub    %eax,%edx
    1735:	83 fa 01             	cmp    $0x1,%edx
    1738:	75 15                	jne    174f <concreate+0xca>
    173a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    173d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1741:	c7 04 24 12 49 00 00 	movl   $0x4912,(%esp)
    1748:	e8 3b 25 00 00       	call   3c88 <link>
    174d:	eb 47                	jmp    1796 <concreate+0x111>
    174f:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1756:	00 
    1757:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    175a:	89 04 24             	mov    %eax,(%esp)
    175d:	e8 06 25 00 00       	call   3c68 <open>
    1762:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1765:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1769:	79 20                	jns    178b <concreate+0x106>
    176b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    176e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1772:	c7 44 24 04 15 49 00 	movl   $0x4915,0x4(%esp)
    1779:	00 
    177a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1781:	e8 1b 26 00 00       	call   3da1 <printf>
    1786:	e8 9d 24 00 00       	call   3c28 <exit>
    178b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    178e:	89 04 24             	mov    %eax,(%esp)
    1791:	e8 ba 24 00 00       	call   3c50 <close>
    1796:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    179a:	75 05                	jne    17a1 <concreate+0x11c>
    179c:	e8 87 24 00 00       	call   3c28 <exit>
    17a1:	e8 8a 24 00 00       	call   3c30 <wait>
    17a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    17aa:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    17ae:	0f 8e ff fe ff ff    	jle    16b3 <concreate+0x2e>
    17b4:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    17bb:	00 
    17bc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17c3:	00 
    17c4:	8d 45 bd             	lea    -0x43(%ebp),%eax
    17c7:	89 04 24             	mov    %eax,(%esp)
    17ca:	e8 b3 22 00 00       	call   3a82 <memset>
    17cf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17d6:	00 
    17d7:	c7 04 24 d7 48 00 00 	movl   $0x48d7,(%esp)
    17de:	e8 85 24 00 00       	call   3c68 <open>
    17e3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    17e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17ed:	e9 9f 00 00 00       	jmp    1891 <concreate+0x20c>
    17f2:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    17f6:	66 85 c0             	test   %ax,%ax
    17f9:	0f 84 91 00 00 00    	je     1890 <concreate+0x20b>
    17ff:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1803:	3c 43                	cmp    $0x43,%al
    1805:	0f 85 86 00 00 00    	jne    1891 <concreate+0x20c>
    180b:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    180f:	84 c0                	test   %al,%al
    1811:	75 7e                	jne    1891 <concreate+0x20c>
    1813:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1817:	0f be c0             	movsbl %al,%eax
    181a:	83 e8 30             	sub    $0x30,%eax
    181d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1824:	78 08                	js     182e <concreate+0x1a9>
    1826:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1829:	83 f8 27             	cmp    $0x27,%eax
    182c:	76 23                	jbe    1851 <concreate+0x1cc>
    182e:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1831:	83 c0 02             	add    $0x2,%eax
    1834:	89 44 24 08          	mov    %eax,0x8(%esp)
    1838:	c7 44 24 04 31 49 00 	movl   $0x4931,0x4(%esp)
    183f:	00 
    1840:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1847:	e8 55 25 00 00       	call   3da1 <printf>
    184c:	e8 d7 23 00 00       	call   3c28 <exit>
    1851:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1854:	03 45 f4             	add    -0xc(%ebp),%eax
    1857:	0f b6 00             	movzbl (%eax),%eax
    185a:	84 c0                	test   %al,%al
    185c:	74 23                	je     1881 <concreate+0x1fc>
    185e:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1861:	83 c0 02             	add    $0x2,%eax
    1864:	89 44 24 08          	mov    %eax,0x8(%esp)
    1868:	c7 44 24 04 4a 49 00 	movl   $0x494a,0x4(%esp)
    186f:	00 
    1870:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1877:	e8 25 25 00 00       	call   3da1 <printf>
    187c:	e8 a7 23 00 00       	call   3c28 <exit>
    1881:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1884:	03 45 f4             	add    -0xc(%ebp),%eax
    1887:	c6 00 01             	movb   $0x1,(%eax)
    188a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    188e:	eb 01                	jmp    1891 <concreate+0x20c>
    1890:	90                   	nop
    1891:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1898:	00 
    1899:	8d 45 ac             	lea    -0x54(%ebp),%eax
    189c:	89 44 24 04          	mov    %eax,0x4(%esp)
    18a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18a3:	89 04 24             	mov    %eax,(%esp)
    18a6:	e8 95 23 00 00       	call   3c40 <read>
    18ab:	85 c0                	test   %eax,%eax
    18ad:	0f 8f 3f ff ff ff    	jg     17f2 <concreate+0x16d>
    18b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18b6:	89 04 24             	mov    %eax,(%esp)
    18b9:	e8 92 23 00 00       	call   3c50 <close>
    18be:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    18c2:	74 19                	je     18dd <concreate+0x258>
    18c4:	c7 44 24 04 68 49 00 	movl   $0x4968,0x4(%esp)
    18cb:	00 
    18cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18d3:	e8 c9 24 00 00       	call   3da1 <printf>
    18d8:	e8 4b 23 00 00       	call   3c28 <exit>
    18dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18e4:	e9 2d 01 00 00       	jmp    1a16 <concreate+0x391>
    18e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ec:	83 c0 30             	add    $0x30,%eax
    18ef:	88 45 e6             	mov    %al,-0x1a(%ebp)
    18f2:	e8 29 23 00 00       	call   3c20 <fork>
    18f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18fe:	79 19                	jns    1919 <concreate+0x294>
    1900:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
    1907:	00 
    1908:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    190f:	e8 8d 24 00 00       	call   3da1 <printf>
    1914:	e8 0f 23 00 00       	call   3c28 <exit>
    1919:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    191c:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1921:	89 c8                	mov    %ecx,%eax
    1923:	f7 ea                	imul   %edx
    1925:	89 c8                	mov    %ecx,%eax
    1927:	c1 f8 1f             	sar    $0x1f,%eax
    192a:	29 c2                	sub    %eax,%edx
    192c:	89 d0                	mov    %edx,%eax
    192e:	01 c0                	add    %eax,%eax
    1930:	01 d0                	add    %edx,%eax
    1932:	89 ca                	mov    %ecx,%edx
    1934:	29 c2                	sub    %eax,%edx
    1936:	85 d2                	test   %edx,%edx
    1938:	75 06                	jne    1940 <concreate+0x2bb>
    193a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    193e:	74 28                	je     1968 <concreate+0x2e3>
    1940:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1943:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1948:	89 c8                	mov    %ecx,%eax
    194a:	f7 ea                	imul   %edx
    194c:	89 c8                	mov    %ecx,%eax
    194e:	c1 f8 1f             	sar    $0x1f,%eax
    1951:	29 c2                	sub    %eax,%edx
    1953:	89 d0                	mov    %edx,%eax
    1955:	01 c0                	add    %eax,%eax
    1957:	01 d0                	add    %edx,%eax
    1959:	89 ca                	mov    %ecx,%edx
    195b:	29 c2                	sub    %eax,%edx
    195d:	83 fa 01             	cmp    $0x1,%edx
    1960:	75 74                	jne    19d6 <concreate+0x351>
    1962:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1966:	74 6e                	je     19d6 <concreate+0x351>
    1968:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    196f:	00 
    1970:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1973:	89 04 24             	mov    %eax,(%esp)
    1976:	e8 ed 22 00 00       	call   3c68 <open>
    197b:	89 04 24             	mov    %eax,(%esp)
    197e:	e8 cd 22 00 00       	call   3c50 <close>
    1983:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    198a:	00 
    198b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    198e:	89 04 24             	mov    %eax,(%esp)
    1991:	e8 d2 22 00 00       	call   3c68 <open>
    1996:	89 04 24             	mov    %eax,(%esp)
    1999:	e8 b2 22 00 00       	call   3c50 <close>
    199e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19a5:	00 
    19a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19a9:	89 04 24             	mov    %eax,(%esp)
    19ac:	e8 b7 22 00 00       	call   3c68 <open>
    19b1:	89 04 24             	mov    %eax,(%esp)
    19b4:	e8 97 22 00 00       	call   3c50 <close>
    19b9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19c0:	00 
    19c1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19c4:	89 04 24             	mov    %eax,(%esp)
    19c7:	e8 9c 22 00 00       	call   3c68 <open>
    19cc:	89 04 24             	mov    %eax,(%esp)
    19cf:	e8 7c 22 00 00       	call   3c50 <close>
    19d4:	eb 2c                	jmp    1a02 <concreate+0x37d>
    19d6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19d9:	89 04 24             	mov    %eax,(%esp)
    19dc:	e8 97 22 00 00       	call   3c78 <unlink>
    19e1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19e4:	89 04 24             	mov    %eax,(%esp)
    19e7:	e8 8c 22 00 00       	call   3c78 <unlink>
    19ec:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ef:	89 04 24             	mov    %eax,(%esp)
    19f2:	e8 81 22 00 00       	call   3c78 <unlink>
    19f7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19fa:	89 04 24             	mov    %eax,(%esp)
    19fd:	e8 76 22 00 00       	call   3c78 <unlink>
    1a02:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a06:	75 05                	jne    1a0d <concreate+0x388>
    1a08:	e8 1b 22 00 00       	call   3c28 <exit>
    1a0d:	e8 1e 22 00 00       	call   3c30 <wait>
    1a12:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a16:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a1a:	0f 8e c9 fe ff ff    	jle    18e9 <concreate+0x264>
    1a20:	c7 44 24 04 99 49 00 	movl   $0x4999,0x4(%esp)
    1a27:	00 
    1a28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a2f:	e8 6d 23 00 00       	call   3da1 <printf>
    1a34:	c9                   	leave  
    1a35:	c3                   	ret    

00001a36 <linkunlink>:
    1a36:	55                   	push   %ebp
    1a37:	89 e5                	mov    %esp,%ebp
    1a39:	83 ec 28             	sub    $0x28,%esp
    1a3c:	c7 44 24 04 a7 49 00 	movl   $0x49a7,0x4(%esp)
    1a43:	00 
    1a44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a4b:	e8 51 23 00 00       	call   3da1 <printf>
    1a50:	c7 04 24 0e 45 00 00 	movl   $0x450e,(%esp)
    1a57:	e8 1c 22 00 00       	call   3c78 <unlink>
    1a5c:	e8 bf 21 00 00       	call   3c20 <fork>
    1a61:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1a64:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a68:	79 19                	jns    1a83 <linkunlink+0x4d>
    1a6a:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
    1a71:	00 
    1a72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a79:	e8 23 23 00 00       	call   3da1 <printf>
    1a7e:	e8 a5 21 00 00       	call   3c28 <exit>
    1a83:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a87:	74 07                	je     1a90 <linkunlink+0x5a>
    1a89:	b8 01 00 00 00       	mov    $0x1,%eax
    1a8e:	eb 05                	jmp    1a95 <linkunlink+0x5f>
    1a90:	b8 61 00 00 00       	mov    $0x61,%eax
    1a95:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a9f:	e9 8e 00 00 00       	jmp    1b32 <linkunlink+0xfc>
    1aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aa7:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1aad:	05 39 30 00 00       	add    $0x3039,%eax
    1ab2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ab5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1ab8:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1abd:	89 c8                	mov    %ecx,%eax
    1abf:	f7 e2                	mul    %edx
    1ac1:	d1 ea                	shr    %edx
    1ac3:	89 d0                	mov    %edx,%eax
    1ac5:	01 c0                	add    %eax,%eax
    1ac7:	01 d0                	add    %edx,%eax
    1ac9:	89 ca                	mov    %ecx,%edx
    1acb:	29 c2                	sub    %eax,%edx
    1acd:	85 d2                	test   %edx,%edx
    1acf:	75 1e                	jne    1aef <linkunlink+0xb9>
    1ad1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1ad8:	00 
    1ad9:	c7 04 24 0e 45 00 00 	movl   $0x450e,(%esp)
    1ae0:	e8 83 21 00 00       	call   3c68 <open>
    1ae5:	89 04 24             	mov    %eax,(%esp)
    1ae8:	e8 63 21 00 00       	call   3c50 <close>
    1aed:	eb 3f                	jmp    1b2e <linkunlink+0xf8>
    1aef:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1af2:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1af7:	89 c8                	mov    %ecx,%eax
    1af9:	f7 e2                	mul    %edx
    1afb:	d1 ea                	shr    %edx
    1afd:	89 d0                	mov    %edx,%eax
    1aff:	01 c0                	add    %eax,%eax
    1b01:	01 d0                	add    %edx,%eax
    1b03:	89 ca                	mov    %ecx,%edx
    1b05:	29 c2                	sub    %eax,%edx
    1b07:	83 fa 01             	cmp    $0x1,%edx
    1b0a:	75 16                	jne    1b22 <linkunlink+0xec>
    1b0c:	c7 44 24 04 0e 45 00 	movl   $0x450e,0x4(%esp)
    1b13:	00 
    1b14:	c7 04 24 b8 49 00 00 	movl   $0x49b8,(%esp)
    1b1b:	e8 68 21 00 00       	call   3c88 <link>
    1b20:	eb 0c                	jmp    1b2e <linkunlink+0xf8>
    1b22:	c7 04 24 0e 45 00 00 	movl   $0x450e,(%esp)
    1b29:	e8 4a 21 00 00       	call   3c78 <unlink>
    1b2e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b32:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b36:	0f 8e 68 ff ff ff    	jle    1aa4 <linkunlink+0x6e>
    1b3c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b40:	74 1b                	je     1b5d <linkunlink+0x127>
    1b42:	e8 e9 20 00 00       	call   3c30 <wait>
    1b47:	c7 44 24 04 bc 49 00 	movl   $0x49bc,0x4(%esp)
    1b4e:	00 
    1b4f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b56:	e8 46 22 00 00       	call   3da1 <printf>
    1b5b:	c9                   	leave  
    1b5c:	c3                   	ret    
    1b5d:	e8 c6 20 00 00       	call   3c28 <exit>

00001b62 <bigdir>:
    1b62:	55                   	push   %ebp
    1b63:	89 e5                	mov    %esp,%ebp
    1b65:	83 ec 38             	sub    $0x38,%esp
    1b68:	c7 44 24 04 cb 49 00 	movl   $0x49cb,0x4(%esp)
    1b6f:	00 
    1b70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b77:	e8 25 22 00 00       	call   3da1 <printf>
    1b7c:	c7 04 24 d8 49 00 00 	movl   $0x49d8,(%esp)
    1b83:	e8 f0 20 00 00       	call   3c78 <unlink>
    1b88:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1b8f:	00 
    1b90:	c7 04 24 d8 49 00 00 	movl   $0x49d8,(%esp)
    1b97:	e8 cc 20 00 00       	call   3c68 <open>
    1b9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b9f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ba3:	79 19                	jns    1bbe <bigdir+0x5c>
    1ba5:	c7 44 24 04 db 49 00 	movl   $0x49db,0x4(%esp)
    1bac:	00 
    1bad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bb4:	e8 e8 21 00 00       	call   3da1 <printf>
    1bb9:	e8 6a 20 00 00       	call   3c28 <exit>
    1bbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bc1:	89 04 24             	mov    %eax,(%esp)
    1bc4:	e8 87 20 00 00       	call   3c50 <close>
    1bc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bd0:	eb 68                	jmp    1c3a <bigdir+0xd8>
    1bd2:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd9:	8d 50 3f             	lea    0x3f(%eax),%edx
    1bdc:	85 c0                	test   %eax,%eax
    1bde:	0f 48 c2             	cmovs  %edx,%eax
    1be1:	c1 f8 06             	sar    $0x6,%eax
    1be4:	83 c0 30             	add    $0x30,%eax
    1be7:	88 45 e7             	mov    %al,-0x19(%ebp)
    1bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bed:	89 c2                	mov    %eax,%edx
    1bef:	c1 fa 1f             	sar    $0x1f,%edx
    1bf2:	c1 ea 1a             	shr    $0x1a,%edx
    1bf5:	01 d0                	add    %edx,%eax
    1bf7:	83 e0 3f             	and    $0x3f,%eax
    1bfa:	29 d0                	sub    %edx,%eax
    1bfc:	83 c0 30             	add    $0x30,%eax
    1bff:	88 45 e8             	mov    %al,-0x18(%ebp)
    1c02:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1c06:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c09:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c0d:	c7 04 24 d8 49 00 00 	movl   $0x49d8,(%esp)
    1c14:	e8 6f 20 00 00       	call   3c88 <link>
    1c19:	85 c0                	test   %eax,%eax
    1c1b:	74 19                	je     1c36 <bigdir+0xd4>
    1c1d:	c7 44 24 04 f1 49 00 	movl   $0x49f1,0x4(%esp)
    1c24:	00 
    1c25:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c2c:	e8 70 21 00 00       	call   3da1 <printf>
    1c31:	e8 f2 1f 00 00       	call   3c28 <exit>
    1c36:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c3a:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c41:	7e 8f                	jle    1bd2 <bigdir+0x70>
    1c43:	c7 04 24 d8 49 00 00 	movl   $0x49d8,(%esp)
    1c4a:	e8 29 20 00 00       	call   3c78 <unlink>
    1c4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c56:	eb 60                	jmp    1cb8 <bigdir+0x156>
    1c58:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5f:	8d 50 3f             	lea    0x3f(%eax),%edx
    1c62:	85 c0                	test   %eax,%eax
    1c64:	0f 48 c2             	cmovs  %edx,%eax
    1c67:	c1 f8 06             	sar    $0x6,%eax
    1c6a:	83 c0 30             	add    $0x30,%eax
    1c6d:	88 45 e7             	mov    %al,-0x19(%ebp)
    1c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c73:	89 c2                	mov    %eax,%edx
    1c75:	c1 fa 1f             	sar    $0x1f,%edx
    1c78:	c1 ea 1a             	shr    $0x1a,%edx
    1c7b:	01 d0                	add    %edx,%eax
    1c7d:	83 e0 3f             	and    $0x3f,%eax
    1c80:	29 d0                	sub    %edx,%eax
    1c82:	83 c0 30             	add    $0x30,%eax
    1c85:	88 45 e8             	mov    %al,-0x18(%ebp)
    1c88:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1c8c:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c8f:	89 04 24             	mov    %eax,(%esp)
    1c92:	e8 e1 1f 00 00       	call   3c78 <unlink>
    1c97:	85 c0                	test   %eax,%eax
    1c99:	74 19                	je     1cb4 <bigdir+0x152>
    1c9b:	c7 44 24 04 05 4a 00 	movl   $0x4a05,0x4(%esp)
    1ca2:	00 
    1ca3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1caa:	e8 f2 20 00 00       	call   3da1 <printf>
    1caf:	e8 74 1f 00 00       	call   3c28 <exit>
    1cb4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cb8:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1cbf:	7e 97                	jle    1c58 <bigdir+0xf6>
    1cc1:	c7 44 24 04 1a 4a 00 	movl   $0x4a1a,0x4(%esp)
    1cc8:	00 
    1cc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cd0:	e8 cc 20 00 00       	call   3da1 <printf>
    1cd5:	c9                   	leave  
    1cd6:	c3                   	ret    

00001cd7 <subdir>:
    1cd7:	55                   	push   %ebp
    1cd8:	89 e5                	mov    %esp,%ebp
    1cda:	83 ec 28             	sub    $0x28,%esp
    1cdd:	c7 44 24 04 25 4a 00 	movl   $0x4a25,0x4(%esp)
    1ce4:	00 
    1ce5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cec:	e8 b0 20 00 00       	call   3da1 <printf>
    1cf1:	c7 04 24 32 4a 00 00 	movl   $0x4a32,(%esp)
    1cf8:	e8 7b 1f 00 00       	call   3c78 <unlink>
    1cfd:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    1d04:	e8 87 1f 00 00       	call   3c90 <mkdir>
    1d09:	85 c0                	test   %eax,%eax
    1d0b:	74 19                	je     1d26 <subdir+0x4f>
    1d0d:	c7 44 24 04 38 4a 00 	movl   $0x4a38,0x4(%esp)
    1d14:	00 
    1d15:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d1c:	e8 80 20 00 00       	call   3da1 <printf>
    1d21:	e8 02 1f 00 00       	call   3c28 <exit>
    1d26:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1d2d:	00 
    1d2e:	c7 04 24 50 4a 00 00 	movl   $0x4a50,(%esp)
    1d35:	e8 2e 1f 00 00       	call   3c68 <open>
    1d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d41:	79 19                	jns    1d5c <subdir+0x85>
    1d43:	c7 44 24 04 56 4a 00 	movl   $0x4a56,0x4(%esp)
    1d4a:	00 
    1d4b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d52:	e8 4a 20 00 00       	call   3da1 <printf>
    1d57:	e8 cc 1e 00 00       	call   3c28 <exit>
    1d5c:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1d63:	00 
    1d64:	c7 44 24 04 32 4a 00 	movl   $0x4a32,0x4(%esp)
    1d6b:	00 
    1d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d6f:	89 04 24             	mov    %eax,(%esp)
    1d72:	e8 d1 1e 00 00       	call   3c48 <write>
    1d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d7a:	89 04 24             	mov    %eax,(%esp)
    1d7d:	e8 ce 1e 00 00       	call   3c50 <close>
    1d82:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    1d89:	e8 ea 1e 00 00       	call   3c78 <unlink>
    1d8e:	85 c0                	test   %eax,%eax
    1d90:	78 19                	js     1dab <subdir+0xd4>
    1d92:	c7 44 24 04 6c 4a 00 	movl   $0x4a6c,0x4(%esp)
    1d99:	00 
    1d9a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1da1:	e8 fb 1f 00 00       	call   3da1 <printf>
    1da6:	e8 7d 1e 00 00       	call   3c28 <exit>
    1dab:	c7 04 24 92 4a 00 00 	movl   $0x4a92,(%esp)
    1db2:	e8 d9 1e 00 00       	call   3c90 <mkdir>
    1db7:	85 c0                	test   %eax,%eax
    1db9:	74 19                	je     1dd4 <subdir+0xfd>
    1dbb:	c7 44 24 04 99 4a 00 	movl   $0x4a99,0x4(%esp)
    1dc2:	00 
    1dc3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dca:	e8 d2 1f 00 00       	call   3da1 <printf>
    1dcf:	e8 54 1e 00 00       	call   3c28 <exit>
    1dd4:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1ddb:	00 
    1ddc:	c7 04 24 b4 4a 00 00 	movl   $0x4ab4,(%esp)
    1de3:	e8 80 1e 00 00       	call   3c68 <open>
    1de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1deb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1def:	79 19                	jns    1e0a <subdir+0x133>
    1df1:	c7 44 24 04 bd 4a 00 	movl   $0x4abd,0x4(%esp)
    1df8:	00 
    1df9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e00:	e8 9c 1f 00 00       	call   3da1 <printf>
    1e05:	e8 1e 1e 00 00       	call   3c28 <exit>
    1e0a:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1e11:	00 
    1e12:	c7 44 24 04 d5 4a 00 	movl   $0x4ad5,0x4(%esp)
    1e19:	00 
    1e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e1d:	89 04 24             	mov    %eax,(%esp)
    1e20:	e8 23 1e 00 00       	call   3c48 <write>
    1e25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e28:	89 04 24             	mov    %eax,(%esp)
    1e2b:	e8 20 1e 00 00       	call   3c50 <close>
    1e30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1e37:	00 
    1e38:	c7 04 24 d8 4a 00 00 	movl   $0x4ad8,(%esp)
    1e3f:	e8 24 1e 00 00       	call   3c68 <open>
    1e44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1e47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e4b:	79 19                	jns    1e66 <subdir+0x18f>
    1e4d:	c7 44 24 04 e4 4a 00 	movl   $0x4ae4,0x4(%esp)
    1e54:	00 
    1e55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e5c:	e8 40 1f 00 00       	call   3da1 <printf>
    1e61:	e8 c2 1d 00 00       	call   3c28 <exit>
    1e66:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1e6d:	00 
    1e6e:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    1e75:	00 
    1e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e79:	89 04 24             	mov    %eax,(%esp)
    1e7c:	e8 bf 1d 00 00       	call   3c40 <read>
    1e81:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e84:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1e88:	75 0b                	jne    1e95 <subdir+0x1be>
    1e8a:	0f b6 05 00 85 00 00 	movzbl 0x8500,%eax
    1e91:	3c 66                	cmp    $0x66,%al
    1e93:	74 19                	je     1eae <subdir+0x1d7>
    1e95:	c7 44 24 04 fd 4a 00 	movl   $0x4afd,0x4(%esp)
    1e9c:	00 
    1e9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ea4:	e8 f8 1e 00 00       	call   3da1 <printf>
    1ea9:	e8 7a 1d 00 00       	call   3c28 <exit>
    1eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb1:	89 04 24             	mov    %eax,(%esp)
    1eb4:	e8 97 1d 00 00       	call   3c50 <close>
    1eb9:	c7 44 24 04 18 4b 00 	movl   $0x4b18,0x4(%esp)
    1ec0:	00 
    1ec1:	c7 04 24 b4 4a 00 00 	movl   $0x4ab4,(%esp)
    1ec8:	e8 bb 1d 00 00       	call   3c88 <link>
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	74 19                	je     1eea <subdir+0x213>
    1ed1:	c7 44 24 04 24 4b 00 	movl   $0x4b24,0x4(%esp)
    1ed8:	00 
    1ed9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ee0:	e8 bc 1e 00 00       	call   3da1 <printf>
    1ee5:	e8 3e 1d 00 00       	call   3c28 <exit>
    1eea:	c7 04 24 b4 4a 00 00 	movl   $0x4ab4,(%esp)
    1ef1:	e8 82 1d 00 00       	call   3c78 <unlink>
    1ef6:	85 c0                	test   %eax,%eax
    1ef8:	74 19                	je     1f13 <subdir+0x23c>
    1efa:	c7 44 24 04 45 4b 00 	movl   $0x4b45,0x4(%esp)
    1f01:	00 
    1f02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f09:	e8 93 1e 00 00       	call   3da1 <printf>
    1f0e:	e8 15 1d 00 00       	call   3c28 <exit>
    1f13:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f1a:	00 
    1f1b:	c7 04 24 b4 4a 00 00 	movl   $0x4ab4,(%esp)
    1f22:	e8 41 1d 00 00       	call   3c68 <open>
    1f27:	85 c0                	test   %eax,%eax
    1f29:	78 19                	js     1f44 <subdir+0x26d>
    1f2b:	c7 44 24 04 60 4b 00 	movl   $0x4b60,0x4(%esp)
    1f32:	00 
    1f33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f3a:	e8 62 1e 00 00       	call   3da1 <printf>
    1f3f:	e8 e4 1c 00 00       	call   3c28 <exit>
    1f44:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    1f4b:	e8 48 1d 00 00       	call   3c98 <chdir>
    1f50:	85 c0                	test   %eax,%eax
    1f52:	74 19                	je     1f6d <subdir+0x296>
    1f54:	c7 44 24 04 84 4b 00 	movl   $0x4b84,0x4(%esp)
    1f5b:	00 
    1f5c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f63:	e8 39 1e 00 00       	call   3da1 <printf>
    1f68:	e8 bb 1c 00 00       	call   3c28 <exit>
    1f6d:	c7 04 24 95 4b 00 00 	movl   $0x4b95,(%esp)
    1f74:	e8 1f 1d 00 00       	call   3c98 <chdir>
    1f79:	85 c0                	test   %eax,%eax
    1f7b:	74 19                	je     1f96 <subdir+0x2bf>
    1f7d:	c7 44 24 04 a1 4b 00 	movl   $0x4ba1,0x4(%esp)
    1f84:	00 
    1f85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f8c:	e8 10 1e 00 00       	call   3da1 <printf>
    1f91:	e8 92 1c 00 00       	call   3c28 <exit>
    1f96:	c7 04 24 bb 4b 00 00 	movl   $0x4bbb,(%esp)
    1f9d:	e8 f6 1c 00 00       	call   3c98 <chdir>
    1fa2:	85 c0                	test   %eax,%eax
    1fa4:	74 19                	je     1fbf <subdir+0x2e8>
    1fa6:	c7 44 24 04 a1 4b 00 	movl   $0x4ba1,0x4(%esp)
    1fad:	00 
    1fae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fb5:	e8 e7 1d 00 00       	call   3da1 <printf>
    1fba:	e8 69 1c 00 00       	call   3c28 <exit>
    1fbf:	c7 04 24 ca 4b 00 00 	movl   $0x4bca,(%esp)
    1fc6:	e8 cd 1c 00 00       	call   3c98 <chdir>
    1fcb:	85 c0                	test   %eax,%eax
    1fcd:	74 19                	je     1fe8 <subdir+0x311>
    1fcf:	c7 44 24 04 cf 4b 00 	movl   $0x4bcf,0x4(%esp)
    1fd6:	00 
    1fd7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fde:	e8 be 1d 00 00       	call   3da1 <printf>
    1fe3:	e8 40 1c 00 00       	call   3c28 <exit>
    1fe8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1fef:	00 
    1ff0:	c7 04 24 18 4b 00 00 	movl   $0x4b18,(%esp)
    1ff7:	e8 6c 1c 00 00       	call   3c68 <open>
    1ffc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1fff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2003:	79 19                	jns    201e <subdir+0x347>
    2005:	c7 44 24 04 e2 4b 00 	movl   $0x4be2,0x4(%esp)
    200c:	00 
    200d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2014:	e8 88 1d 00 00       	call   3da1 <printf>
    2019:	e8 0a 1c 00 00       	call   3c28 <exit>
    201e:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    2025:	00 
    2026:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    202d:	00 
    202e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2031:	89 04 24             	mov    %eax,(%esp)
    2034:	e8 07 1c 00 00       	call   3c40 <read>
    2039:	83 f8 02             	cmp    $0x2,%eax
    203c:	74 19                	je     2057 <subdir+0x380>
    203e:	c7 44 24 04 fa 4b 00 	movl   $0x4bfa,0x4(%esp)
    2045:	00 
    2046:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    204d:	e8 4f 1d 00 00       	call   3da1 <printf>
    2052:	e8 d1 1b 00 00       	call   3c28 <exit>
    2057:	8b 45 f4             	mov    -0xc(%ebp),%eax
    205a:	89 04 24             	mov    %eax,(%esp)
    205d:	e8 ee 1b 00 00       	call   3c50 <close>
    2062:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2069:	00 
    206a:	c7 04 24 b4 4a 00 00 	movl   $0x4ab4,(%esp)
    2071:	e8 f2 1b 00 00       	call   3c68 <open>
    2076:	85 c0                	test   %eax,%eax
    2078:	78 19                	js     2093 <subdir+0x3bc>
    207a:	c7 44 24 04 18 4c 00 	movl   $0x4c18,0x4(%esp)
    2081:	00 
    2082:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2089:	e8 13 1d 00 00       	call   3da1 <printf>
    208e:	e8 95 1b 00 00       	call   3c28 <exit>
    2093:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    209a:	00 
    209b:	c7 04 24 3d 4c 00 00 	movl   $0x4c3d,(%esp)
    20a2:	e8 c1 1b 00 00       	call   3c68 <open>
    20a7:	85 c0                	test   %eax,%eax
    20a9:	78 19                	js     20c4 <subdir+0x3ed>
    20ab:	c7 44 24 04 46 4c 00 	movl   $0x4c46,0x4(%esp)
    20b2:	00 
    20b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20ba:	e8 e2 1c 00 00       	call   3da1 <printf>
    20bf:	e8 64 1b 00 00       	call   3c28 <exit>
    20c4:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    20cb:	00 
    20cc:	c7 04 24 62 4c 00 00 	movl   $0x4c62,(%esp)
    20d3:	e8 90 1b 00 00       	call   3c68 <open>
    20d8:	85 c0                	test   %eax,%eax
    20da:	78 19                	js     20f5 <subdir+0x41e>
    20dc:	c7 44 24 04 6b 4c 00 	movl   $0x4c6b,0x4(%esp)
    20e3:	00 
    20e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20eb:	e8 b1 1c 00 00       	call   3da1 <printf>
    20f0:	e8 33 1b 00 00       	call   3c28 <exit>
    20f5:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    20fc:	00 
    20fd:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    2104:	e8 5f 1b 00 00       	call   3c68 <open>
    2109:	85 c0                	test   %eax,%eax
    210b:	78 19                	js     2126 <subdir+0x44f>
    210d:	c7 44 24 04 87 4c 00 	movl   $0x4c87,0x4(%esp)
    2114:	00 
    2115:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    211c:	e8 80 1c 00 00       	call   3da1 <printf>
    2121:	e8 02 1b 00 00       	call   3c28 <exit>
    2126:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    212d:	00 
    212e:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    2135:	e8 2e 1b 00 00       	call   3c68 <open>
    213a:	85 c0                	test   %eax,%eax
    213c:	78 19                	js     2157 <subdir+0x480>
    213e:	c7 44 24 04 9d 4c 00 	movl   $0x4c9d,0x4(%esp)
    2145:	00 
    2146:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    214d:	e8 4f 1c 00 00       	call   3da1 <printf>
    2152:	e8 d1 1a 00 00       	call   3c28 <exit>
    2157:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    215e:	00 
    215f:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    2166:	e8 fd 1a 00 00       	call   3c68 <open>
    216b:	85 c0                	test   %eax,%eax
    216d:	78 19                	js     2188 <subdir+0x4b1>
    216f:	c7 44 24 04 b6 4c 00 	movl   $0x4cb6,0x4(%esp)
    2176:	00 
    2177:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    217e:	e8 1e 1c 00 00       	call   3da1 <printf>
    2183:	e8 a0 1a 00 00       	call   3c28 <exit>
    2188:	c7 44 24 04 d1 4c 00 	movl   $0x4cd1,0x4(%esp)
    218f:	00 
    2190:	c7 04 24 3d 4c 00 00 	movl   $0x4c3d,(%esp)
    2197:	e8 ec 1a 00 00       	call   3c88 <link>
    219c:	85 c0                	test   %eax,%eax
    219e:	75 19                	jne    21b9 <subdir+0x4e2>
    21a0:	c7 44 24 04 dc 4c 00 	movl   $0x4cdc,0x4(%esp)
    21a7:	00 
    21a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21af:	e8 ed 1b 00 00       	call   3da1 <printf>
    21b4:	e8 6f 1a 00 00       	call   3c28 <exit>
    21b9:	c7 44 24 04 d1 4c 00 	movl   $0x4cd1,0x4(%esp)
    21c0:	00 
    21c1:	c7 04 24 62 4c 00 00 	movl   $0x4c62,(%esp)
    21c8:	e8 bb 1a 00 00       	call   3c88 <link>
    21cd:	85 c0                	test   %eax,%eax
    21cf:	75 19                	jne    21ea <subdir+0x513>
    21d1:	c7 44 24 04 00 4d 00 	movl   $0x4d00,0x4(%esp)
    21d8:	00 
    21d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21e0:	e8 bc 1b 00 00       	call   3da1 <printf>
    21e5:	e8 3e 1a 00 00       	call   3c28 <exit>
    21ea:	c7 44 24 04 18 4b 00 	movl   $0x4b18,0x4(%esp)
    21f1:	00 
    21f2:	c7 04 24 50 4a 00 00 	movl   $0x4a50,(%esp)
    21f9:	e8 8a 1a 00 00       	call   3c88 <link>
    21fe:	85 c0                	test   %eax,%eax
    2200:	75 19                	jne    221b <subdir+0x544>
    2202:	c7 44 24 04 24 4d 00 	movl   $0x4d24,0x4(%esp)
    2209:	00 
    220a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2211:	e8 8b 1b 00 00       	call   3da1 <printf>
    2216:	e8 0d 1a 00 00       	call   3c28 <exit>
    221b:	c7 04 24 3d 4c 00 00 	movl   $0x4c3d,(%esp)
    2222:	e8 69 1a 00 00       	call   3c90 <mkdir>
    2227:	85 c0                	test   %eax,%eax
    2229:	75 19                	jne    2244 <subdir+0x56d>
    222b:	c7 44 24 04 46 4d 00 	movl   $0x4d46,0x4(%esp)
    2232:	00 
    2233:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    223a:	e8 62 1b 00 00       	call   3da1 <printf>
    223f:	e8 e4 19 00 00       	call   3c28 <exit>
    2244:	c7 04 24 62 4c 00 00 	movl   $0x4c62,(%esp)
    224b:	e8 40 1a 00 00       	call   3c90 <mkdir>
    2250:	85 c0                	test   %eax,%eax
    2252:	75 19                	jne    226d <subdir+0x596>
    2254:	c7 44 24 04 61 4d 00 	movl   $0x4d61,0x4(%esp)
    225b:	00 
    225c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2263:	e8 39 1b 00 00       	call   3da1 <printf>
    2268:	e8 bb 19 00 00       	call   3c28 <exit>
    226d:	c7 04 24 18 4b 00 00 	movl   $0x4b18,(%esp)
    2274:	e8 17 1a 00 00       	call   3c90 <mkdir>
    2279:	85 c0                	test   %eax,%eax
    227b:	75 19                	jne    2296 <subdir+0x5bf>
    227d:	c7 44 24 04 7c 4d 00 	movl   $0x4d7c,0x4(%esp)
    2284:	00 
    2285:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    228c:	e8 10 1b 00 00       	call   3da1 <printf>
    2291:	e8 92 19 00 00       	call   3c28 <exit>
    2296:	c7 04 24 62 4c 00 00 	movl   $0x4c62,(%esp)
    229d:	e8 d6 19 00 00       	call   3c78 <unlink>
    22a2:	85 c0                	test   %eax,%eax
    22a4:	75 19                	jne    22bf <subdir+0x5e8>
    22a6:	c7 44 24 04 99 4d 00 	movl   $0x4d99,0x4(%esp)
    22ad:	00 
    22ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22b5:	e8 e7 1a 00 00       	call   3da1 <printf>
    22ba:	e8 69 19 00 00       	call   3c28 <exit>
    22bf:	c7 04 24 3d 4c 00 00 	movl   $0x4c3d,(%esp)
    22c6:	e8 ad 19 00 00       	call   3c78 <unlink>
    22cb:	85 c0                	test   %eax,%eax
    22cd:	75 19                	jne    22e8 <subdir+0x611>
    22cf:	c7 44 24 04 b5 4d 00 	movl   $0x4db5,0x4(%esp)
    22d6:	00 
    22d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22de:	e8 be 1a 00 00       	call   3da1 <printf>
    22e3:	e8 40 19 00 00       	call   3c28 <exit>
    22e8:	c7 04 24 50 4a 00 00 	movl   $0x4a50,(%esp)
    22ef:	e8 a4 19 00 00       	call   3c98 <chdir>
    22f4:	85 c0                	test   %eax,%eax
    22f6:	75 19                	jne    2311 <subdir+0x63a>
    22f8:	c7 44 24 04 d1 4d 00 	movl   $0x4dd1,0x4(%esp)
    22ff:	00 
    2300:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2307:	e8 95 1a 00 00       	call   3da1 <printf>
    230c:	e8 17 19 00 00       	call   3c28 <exit>
    2311:	c7 04 24 e9 4d 00 00 	movl   $0x4de9,(%esp)
    2318:	e8 7b 19 00 00       	call   3c98 <chdir>
    231d:	85 c0                	test   %eax,%eax
    231f:	75 19                	jne    233a <subdir+0x663>
    2321:	c7 44 24 04 ef 4d 00 	movl   $0x4def,0x4(%esp)
    2328:	00 
    2329:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2330:	e8 6c 1a 00 00       	call   3da1 <printf>
    2335:	e8 ee 18 00 00       	call   3c28 <exit>
    233a:	c7 04 24 18 4b 00 00 	movl   $0x4b18,(%esp)
    2341:	e8 32 19 00 00       	call   3c78 <unlink>
    2346:	85 c0                	test   %eax,%eax
    2348:	74 19                	je     2363 <subdir+0x68c>
    234a:	c7 44 24 04 45 4b 00 	movl   $0x4b45,0x4(%esp)
    2351:	00 
    2352:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2359:	e8 43 1a 00 00       	call   3da1 <printf>
    235e:	e8 c5 18 00 00       	call   3c28 <exit>
    2363:	c7 04 24 50 4a 00 00 	movl   $0x4a50,(%esp)
    236a:	e8 09 19 00 00       	call   3c78 <unlink>
    236f:	85 c0                	test   %eax,%eax
    2371:	74 19                	je     238c <subdir+0x6b5>
    2373:	c7 44 24 04 07 4e 00 	movl   $0x4e07,0x4(%esp)
    237a:	00 
    237b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2382:	e8 1a 1a 00 00       	call   3da1 <printf>
    2387:	e8 9c 18 00 00       	call   3c28 <exit>
    238c:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    2393:	e8 e0 18 00 00       	call   3c78 <unlink>
    2398:	85 c0                	test   %eax,%eax
    239a:	75 19                	jne    23b5 <subdir+0x6de>
    239c:	c7 44 24 04 1c 4e 00 	movl   $0x4e1c,0x4(%esp)
    23a3:	00 
    23a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23ab:	e8 f1 19 00 00       	call   3da1 <printf>
    23b0:	e8 73 18 00 00       	call   3c28 <exit>
    23b5:	c7 04 24 3c 4e 00 00 	movl   $0x4e3c,(%esp)
    23bc:	e8 b7 18 00 00       	call   3c78 <unlink>
    23c1:	85 c0                	test   %eax,%eax
    23c3:	79 19                	jns    23de <subdir+0x707>
    23c5:	c7 44 24 04 42 4e 00 	movl   $0x4e42,0x4(%esp)
    23cc:	00 
    23cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23d4:	e8 c8 19 00 00       	call   3da1 <printf>
    23d9:	e8 4a 18 00 00       	call   3c28 <exit>
    23de:	c7 04 24 35 4a 00 00 	movl   $0x4a35,(%esp)
    23e5:	e8 8e 18 00 00       	call   3c78 <unlink>
    23ea:	85 c0                	test   %eax,%eax
    23ec:	79 19                	jns    2407 <subdir+0x730>
    23ee:	c7 44 24 04 57 4e 00 	movl   $0x4e57,0x4(%esp)
    23f5:	00 
    23f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23fd:	e8 9f 19 00 00       	call   3da1 <printf>
    2402:	e8 21 18 00 00       	call   3c28 <exit>
    2407:	c7 44 24 04 69 4e 00 	movl   $0x4e69,0x4(%esp)
    240e:	00 
    240f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2416:	e8 86 19 00 00       	call   3da1 <printf>
    241b:	c9                   	leave  
    241c:	c3                   	ret    

0000241d <bigwrite>:
    241d:	55                   	push   %ebp
    241e:	89 e5                	mov    %esp,%ebp
    2420:	83 ec 28             	sub    $0x28,%esp
    2423:	c7 44 24 04 74 4e 00 	movl   $0x4e74,0x4(%esp)
    242a:	00 
    242b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2432:	e8 6a 19 00 00       	call   3da1 <printf>
    2437:	c7 04 24 83 4e 00 00 	movl   $0x4e83,(%esp)
    243e:	e8 35 18 00 00       	call   3c78 <unlink>
    2443:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    244a:	e9 b3 00 00 00       	jmp    2502 <bigwrite+0xe5>
    244f:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2456:	00 
    2457:	c7 04 24 83 4e 00 00 	movl   $0x4e83,(%esp)
    245e:	e8 05 18 00 00       	call   3c68 <open>
    2463:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2466:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    246a:	79 19                	jns    2485 <bigwrite+0x68>
    246c:	c7 44 24 04 8c 4e 00 	movl   $0x4e8c,0x4(%esp)
    2473:	00 
    2474:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    247b:	e8 21 19 00 00       	call   3da1 <printf>
    2480:	e8 a3 17 00 00       	call   3c28 <exit>
    2485:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    248c:	eb 50                	jmp    24de <bigwrite+0xc1>
    248e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2491:	89 44 24 08          	mov    %eax,0x8(%esp)
    2495:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    249c:	00 
    249d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24a0:	89 04 24             	mov    %eax,(%esp)
    24a3:	e8 a0 17 00 00       	call   3c48 <write>
    24a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    24ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24ae:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    24b1:	74 27                	je     24da <bigwrite+0xbd>
    24b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24b6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    24ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24bd:	89 44 24 08          	mov    %eax,0x8(%esp)
    24c1:	c7 44 24 04 a4 4e 00 	movl   $0x4ea4,0x4(%esp)
    24c8:	00 
    24c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d0:	e8 cc 18 00 00       	call   3da1 <printf>
    24d5:	e8 4e 17 00 00       	call   3c28 <exit>
    24da:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24de:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    24e2:	7e aa                	jle    248e <bigwrite+0x71>
    24e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24e7:	89 04 24             	mov    %eax,(%esp)
    24ea:	e8 61 17 00 00       	call   3c50 <close>
    24ef:	c7 04 24 83 4e 00 00 	movl   $0x4e83,(%esp)
    24f6:	e8 7d 17 00 00       	call   3c78 <unlink>
    24fb:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    2502:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2509:	0f 8e 40 ff ff ff    	jle    244f <bigwrite+0x32>
    250f:	c7 44 24 04 b6 4e 00 	movl   $0x4eb6,0x4(%esp)
    2516:	00 
    2517:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    251e:	e8 7e 18 00 00       	call   3da1 <printf>
    2523:	c9                   	leave  
    2524:	c3                   	ret    

00002525 <bigfile>:
    2525:	55                   	push   %ebp
    2526:	89 e5                	mov    %esp,%ebp
    2528:	83 ec 28             	sub    $0x28,%esp
    252b:	c7 44 24 04 c3 4e 00 	movl   $0x4ec3,0x4(%esp)
    2532:	00 
    2533:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    253a:	e8 62 18 00 00       	call   3da1 <printf>
    253f:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    2546:	e8 2d 17 00 00       	call   3c78 <unlink>
    254b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2552:	00 
    2553:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    255a:	e8 09 17 00 00       	call   3c68 <open>
    255f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2562:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2566:	79 19                	jns    2581 <bigfile+0x5c>
    2568:	c7 44 24 04 d9 4e 00 	movl   $0x4ed9,0x4(%esp)
    256f:	00 
    2570:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2577:	e8 25 18 00 00       	call   3da1 <printf>
    257c:	e8 a7 16 00 00       	call   3c28 <exit>
    2581:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2588:	eb 5a                	jmp    25e4 <bigfile+0xbf>
    258a:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2591:	00 
    2592:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2595:	89 44 24 04          	mov    %eax,0x4(%esp)
    2599:	c7 04 24 00 85 00 00 	movl   $0x8500,(%esp)
    25a0:	e8 dd 14 00 00       	call   3a82 <memset>
    25a5:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    25ac:	00 
    25ad:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    25b4:	00 
    25b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25b8:	89 04 24             	mov    %eax,(%esp)
    25bb:	e8 88 16 00 00       	call   3c48 <write>
    25c0:	3d 58 02 00 00       	cmp    $0x258,%eax
    25c5:	74 19                	je     25e0 <bigfile+0xbb>
    25c7:	c7 44 24 04 ef 4e 00 	movl   $0x4eef,0x4(%esp)
    25ce:	00 
    25cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25d6:	e8 c6 17 00 00       	call   3da1 <printf>
    25db:	e8 48 16 00 00       	call   3c28 <exit>
    25e0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25e4:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    25e8:	7e a0                	jle    258a <bigfile+0x65>
    25ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
    25ed:	89 04 24             	mov    %eax,(%esp)
    25f0:	e8 5b 16 00 00       	call   3c50 <close>
    25f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    25fc:	00 
    25fd:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    2604:	e8 5f 16 00 00       	call   3c68 <open>
    2609:	89 45 ec             	mov    %eax,-0x14(%ebp)
    260c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2610:	79 19                	jns    262b <bigfile+0x106>
    2612:	c7 44 24 04 05 4f 00 	movl   $0x4f05,0x4(%esp)
    2619:	00 
    261a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2621:	e8 7b 17 00 00       	call   3da1 <printf>
    2626:	e8 fd 15 00 00       	call   3c28 <exit>
    262b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2632:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2639:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    2640:	00 
    2641:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    2648:	00 
    2649:	8b 45 ec             	mov    -0x14(%ebp),%eax
    264c:	89 04 24             	mov    %eax,(%esp)
    264f:	e8 ec 15 00 00       	call   3c40 <read>
    2654:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2657:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    265b:	79 19                	jns    2676 <bigfile+0x151>
    265d:	c7 44 24 04 1a 4f 00 	movl   $0x4f1a,0x4(%esp)
    2664:	00 
    2665:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    266c:	e8 30 17 00 00       	call   3da1 <printf>
    2671:	e8 b2 15 00 00       	call   3c28 <exit>
    2676:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    267a:	74 7e                	je     26fa <bigfile+0x1d5>
    267c:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2683:	74 19                	je     269e <bigfile+0x179>
    2685:	c7 44 24 04 2f 4f 00 	movl   $0x4f2f,0x4(%esp)
    268c:	00 
    268d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2694:	e8 08 17 00 00       	call   3da1 <printf>
    2699:	e8 8a 15 00 00       	call   3c28 <exit>
    269e:	0f b6 05 00 85 00 00 	movzbl 0x8500,%eax
    26a5:	0f be d0             	movsbl %al,%edx
    26a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26ab:	89 c1                	mov    %eax,%ecx
    26ad:	c1 e9 1f             	shr    $0x1f,%ecx
    26b0:	01 c8                	add    %ecx,%eax
    26b2:	d1 f8                	sar    %eax
    26b4:	39 c2                	cmp    %eax,%edx
    26b6:	75 1a                	jne    26d2 <bigfile+0x1ad>
    26b8:	0f b6 05 2b 86 00 00 	movzbl 0x862b,%eax
    26bf:	0f be d0             	movsbl %al,%edx
    26c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26c5:	89 c1                	mov    %eax,%ecx
    26c7:	c1 e9 1f             	shr    $0x1f,%ecx
    26ca:	01 c8                	add    %ecx,%eax
    26cc:	d1 f8                	sar    %eax
    26ce:	39 c2                	cmp    %eax,%edx
    26d0:	74 19                	je     26eb <bigfile+0x1c6>
    26d2:	c7 44 24 04 43 4f 00 	movl   $0x4f43,0x4(%esp)
    26d9:	00 
    26da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26e1:	e8 bb 16 00 00       	call   3da1 <printf>
    26e6:	e8 3d 15 00 00       	call   3c28 <exit>
    26eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26ee:	01 45 f0             	add    %eax,-0x10(%ebp)
    26f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    26f5:	e9 3f ff ff ff       	jmp    2639 <bigfile+0x114>
    26fa:	90                   	nop
    26fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    26fe:	89 04 24             	mov    %eax,(%esp)
    2701:	e8 4a 15 00 00       	call   3c50 <close>
    2706:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    270d:	74 19                	je     2728 <bigfile+0x203>
    270f:	c7 44 24 04 5c 4f 00 	movl   $0x4f5c,0x4(%esp)
    2716:	00 
    2717:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    271e:	e8 7e 16 00 00       	call   3da1 <printf>
    2723:	e8 00 15 00 00       	call   3c28 <exit>
    2728:	c7 04 24 d1 4e 00 00 	movl   $0x4ed1,(%esp)
    272f:	e8 44 15 00 00       	call   3c78 <unlink>
    2734:	c7 44 24 04 76 4f 00 	movl   $0x4f76,0x4(%esp)
    273b:	00 
    273c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2743:	e8 59 16 00 00       	call   3da1 <printf>
    2748:	c9                   	leave  
    2749:	c3                   	ret    

0000274a <fourteen>:
    274a:	55                   	push   %ebp
    274b:	89 e5                	mov    %esp,%ebp
    274d:	83 ec 28             	sub    $0x28,%esp
    2750:	c7 44 24 04 87 4f 00 	movl   $0x4f87,0x4(%esp)
    2757:	00 
    2758:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    275f:	e8 3d 16 00 00       	call   3da1 <printf>
    2764:	c7 04 24 96 4f 00 00 	movl   $0x4f96,(%esp)
    276b:	e8 20 15 00 00       	call   3c90 <mkdir>
    2770:	85 c0                	test   %eax,%eax
    2772:	74 19                	je     278d <fourteen+0x43>
    2774:	c7 44 24 04 a5 4f 00 	movl   $0x4fa5,0x4(%esp)
    277b:	00 
    277c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2783:	e8 19 16 00 00       	call   3da1 <printf>
    2788:	e8 9b 14 00 00       	call   3c28 <exit>
    278d:	c7 04 24 c4 4f 00 00 	movl   $0x4fc4,(%esp)
    2794:	e8 f7 14 00 00       	call   3c90 <mkdir>
    2799:	85 c0                	test   %eax,%eax
    279b:	74 19                	je     27b6 <fourteen+0x6c>
    279d:	c7 44 24 04 e4 4f 00 	movl   $0x4fe4,0x4(%esp)
    27a4:	00 
    27a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ac:	e8 f0 15 00 00       	call   3da1 <printf>
    27b1:	e8 72 14 00 00       	call   3c28 <exit>
    27b6:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    27bd:	00 
    27be:	c7 04 24 14 50 00 00 	movl   $0x5014,(%esp)
    27c5:	e8 9e 14 00 00       	call   3c68 <open>
    27ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    27cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27d1:	79 19                	jns    27ec <fourteen+0xa2>
    27d3:	c7 44 24 04 44 50 00 	movl   $0x5044,0x4(%esp)
    27da:	00 
    27db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27e2:	e8 ba 15 00 00       	call   3da1 <printf>
    27e7:	e8 3c 14 00 00       	call   3c28 <exit>
    27ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27ef:	89 04 24             	mov    %eax,(%esp)
    27f2:	e8 59 14 00 00       	call   3c50 <close>
    27f7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    27fe:	00 
    27ff:	c7 04 24 84 50 00 00 	movl   $0x5084,(%esp)
    2806:	e8 5d 14 00 00       	call   3c68 <open>
    280b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    280e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2812:	79 19                	jns    282d <fourteen+0xe3>
    2814:	c7 44 24 04 b4 50 00 	movl   $0x50b4,0x4(%esp)
    281b:	00 
    281c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2823:	e8 79 15 00 00       	call   3da1 <printf>
    2828:	e8 fb 13 00 00       	call   3c28 <exit>
    282d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2830:	89 04 24             	mov    %eax,(%esp)
    2833:	e8 18 14 00 00       	call   3c50 <close>
    2838:	c7 04 24 ee 50 00 00 	movl   $0x50ee,(%esp)
    283f:	e8 4c 14 00 00       	call   3c90 <mkdir>
    2844:	85 c0                	test   %eax,%eax
    2846:	75 19                	jne    2861 <fourteen+0x117>
    2848:	c7 44 24 04 0c 51 00 	movl   $0x510c,0x4(%esp)
    284f:	00 
    2850:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2857:	e8 45 15 00 00       	call   3da1 <printf>
    285c:	e8 c7 13 00 00       	call   3c28 <exit>
    2861:	c7 04 24 3c 51 00 00 	movl   $0x513c,(%esp)
    2868:	e8 23 14 00 00       	call   3c90 <mkdir>
    286d:	85 c0                	test   %eax,%eax
    286f:	75 19                	jne    288a <fourteen+0x140>
    2871:	c7 44 24 04 5c 51 00 	movl   $0x515c,0x4(%esp)
    2878:	00 
    2879:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2880:	e8 1c 15 00 00       	call   3da1 <printf>
    2885:	e8 9e 13 00 00       	call   3c28 <exit>
    288a:	c7 44 24 04 8d 51 00 	movl   $0x518d,0x4(%esp)
    2891:	00 
    2892:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2899:	e8 03 15 00 00       	call   3da1 <printf>
    289e:	c9                   	leave  
    289f:	c3                   	ret    

000028a0 <rmdot>:
    28a0:	55                   	push   %ebp
    28a1:	89 e5                	mov    %esp,%ebp
    28a3:	83 ec 18             	sub    $0x18,%esp
    28a6:	c7 44 24 04 9a 51 00 	movl   $0x519a,0x4(%esp)
    28ad:	00 
    28ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28b5:	e8 e7 14 00 00       	call   3da1 <printf>
    28ba:	c7 04 24 a6 51 00 00 	movl   $0x51a6,(%esp)
    28c1:	e8 ca 13 00 00       	call   3c90 <mkdir>
    28c6:	85 c0                	test   %eax,%eax
    28c8:	74 19                	je     28e3 <rmdot+0x43>
    28ca:	c7 44 24 04 ab 51 00 	movl   $0x51ab,0x4(%esp)
    28d1:	00 
    28d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28d9:	e8 c3 14 00 00       	call   3da1 <printf>
    28de:	e8 45 13 00 00       	call   3c28 <exit>
    28e3:	c7 04 24 a6 51 00 00 	movl   $0x51a6,(%esp)
    28ea:	e8 a9 13 00 00       	call   3c98 <chdir>
    28ef:	85 c0                	test   %eax,%eax
    28f1:	74 19                	je     290c <rmdot+0x6c>
    28f3:	c7 44 24 04 be 51 00 	movl   $0x51be,0x4(%esp)
    28fa:	00 
    28fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2902:	e8 9a 14 00 00       	call   3da1 <printf>
    2907:	e8 1c 13 00 00       	call   3c28 <exit>
    290c:	c7 04 24 d7 48 00 00 	movl   $0x48d7,(%esp)
    2913:	e8 60 13 00 00       	call   3c78 <unlink>
    2918:	85 c0                	test   %eax,%eax
    291a:	75 19                	jne    2935 <rmdot+0x95>
    291c:	c7 44 24 04 d1 51 00 	movl   $0x51d1,0x4(%esp)
    2923:	00 
    2924:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    292b:	e8 71 14 00 00       	call   3da1 <printf>
    2930:	e8 f3 12 00 00       	call   3c28 <exit>
    2935:	c7 04 24 64 44 00 00 	movl   $0x4464,(%esp)
    293c:	e8 37 13 00 00       	call   3c78 <unlink>
    2941:	85 c0                	test   %eax,%eax
    2943:	75 19                	jne    295e <rmdot+0xbe>
    2945:	c7 44 24 04 df 51 00 	movl   $0x51df,0x4(%esp)
    294c:	00 
    294d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2954:	e8 48 14 00 00       	call   3da1 <printf>
    2959:	e8 ca 12 00 00       	call   3c28 <exit>
    295e:	c7 04 24 ee 51 00 00 	movl   $0x51ee,(%esp)
    2965:	e8 2e 13 00 00       	call   3c98 <chdir>
    296a:	85 c0                	test   %eax,%eax
    296c:	74 19                	je     2987 <rmdot+0xe7>
    296e:	c7 44 24 04 f0 51 00 	movl   $0x51f0,0x4(%esp)
    2975:	00 
    2976:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    297d:	e8 1f 14 00 00       	call   3da1 <printf>
    2982:	e8 a1 12 00 00       	call   3c28 <exit>
    2987:	c7 04 24 00 52 00 00 	movl   $0x5200,(%esp)
    298e:	e8 e5 12 00 00       	call   3c78 <unlink>
    2993:	85 c0                	test   %eax,%eax
    2995:	75 19                	jne    29b0 <rmdot+0x110>
    2997:	c7 44 24 04 07 52 00 	movl   $0x5207,0x4(%esp)
    299e:	00 
    299f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29a6:	e8 f6 13 00 00       	call   3da1 <printf>
    29ab:	e8 78 12 00 00       	call   3c28 <exit>
    29b0:	c7 04 24 1e 52 00 00 	movl   $0x521e,(%esp)
    29b7:	e8 bc 12 00 00       	call   3c78 <unlink>
    29bc:	85 c0                	test   %eax,%eax
    29be:	75 19                	jne    29d9 <rmdot+0x139>
    29c0:	c7 44 24 04 26 52 00 	movl   $0x5226,0x4(%esp)
    29c7:	00 
    29c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29cf:	e8 cd 13 00 00       	call   3da1 <printf>
    29d4:	e8 4f 12 00 00       	call   3c28 <exit>
    29d9:	c7 04 24 a6 51 00 00 	movl   $0x51a6,(%esp)
    29e0:	e8 93 12 00 00       	call   3c78 <unlink>
    29e5:	85 c0                	test   %eax,%eax
    29e7:	74 19                	je     2a02 <rmdot+0x162>
    29e9:	c7 44 24 04 3e 52 00 	movl   $0x523e,0x4(%esp)
    29f0:	00 
    29f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29f8:	e8 a4 13 00 00       	call   3da1 <printf>
    29fd:	e8 26 12 00 00       	call   3c28 <exit>
    2a02:	c7 44 24 04 53 52 00 	movl   $0x5253,0x4(%esp)
    2a09:	00 
    2a0a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a11:	e8 8b 13 00 00       	call   3da1 <printf>
    2a16:	c9                   	leave  
    2a17:	c3                   	ret    

00002a18 <dirfile>:
    2a18:	55                   	push   %ebp
    2a19:	89 e5                	mov    %esp,%ebp
    2a1b:	83 ec 28             	sub    $0x28,%esp
    2a1e:	c7 44 24 04 5d 52 00 	movl   $0x525d,0x4(%esp)
    2a25:	00 
    2a26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a2d:	e8 6f 13 00 00       	call   3da1 <printf>
    2a32:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2a39:	00 
    2a3a:	c7 04 24 6a 52 00 00 	movl   $0x526a,(%esp)
    2a41:	e8 22 12 00 00       	call   3c68 <open>
    2a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a4d:	79 19                	jns    2a68 <dirfile+0x50>
    2a4f:	c7 44 24 04 72 52 00 	movl   $0x5272,0x4(%esp)
    2a56:	00 
    2a57:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a5e:	e8 3e 13 00 00       	call   3da1 <printf>
    2a63:	e8 c0 11 00 00       	call   3c28 <exit>
    2a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2a6b:	89 04 24             	mov    %eax,(%esp)
    2a6e:	e8 dd 11 00 00       	call   3c50 <close>
    2a73:	c7 04 24 6a 52 00 00 	movl   $0x526a,(%esp)
    2a7a:	e8 19 12 00 00       	call   3c98 <chdir>
    2a7f:	85 c0                	test   %eax,%eax
    2a81:	75 19                	jne    2a9c <dirfile+0x84>
    2a83:	c7 44 24 04 89 52 00 	movl   $0x5289,0x4(%esp)
    2a8a:	00 
    2a8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a92:	e8 0a 13 00 00       	call   3da1 <printf>
    2a97:	e8 8c 11 00 00       	call   3c28 <exit>
    2a9c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2aa3:	00 
    2aa4:	c7 04 24 a3 52 00 00 	movl   $0x52a3,(%esp)
    2aab:	e8 b8 11 00 00       	call   3c68 <open>
    2ab0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2ab3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ab7:	78 19                	js     2ad2 <dirfile+0xba>
    2ab9:	c7 44 24 04 ae 52 00 	movl   $0x52ae,0x4(%esp)
    2ac0:	00 
    2ac1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ac8:	e8 d4 12 00 00       	call   3da1 <printf>
    2acd:	e8 56 11 00 00       	call   3c28 <exit>
    2ad2:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2ad9:	00 
    2ada:	c7 04 24 a3 52 00 00 	movl   $0x52a3,(%esp)
    2ae1:	e8 82 11 00 00       	call   3c68 <open>
    2ae6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2ae9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2aed:	78 19                	js     2b08 <dirfile+0xf0>
    2aef:	c7 44 24 04 ae 52 00 	movl   $0x52ae,0x4(%esp)
    2af6:	00 
    2af7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2afe:	e8 9e 12 00 00       	call   3da1 <printf>
    2b03:	e8 20 11 00 00       	call   3c28 <exit>
    2b08:	c7 04 24 a3 52 00 00 	movl   $0x52a3,(%esp)
    2b0f:	e8 7c 11 00 00       	call   3c90 <mkdir>
    2b14:	85 c0                	test   %eax,%eax
    2b16:	75 19                	jne    2b31 <dirfile+0x119>
    2b18:	c7 44 24 04 cc 52 00 	movl   $0x52cc,0x4(%esp)
    2b1f:	00 
    2b20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b27:	e8 75 12 00 00       	call   3da1 <printf>
    2b2c:	e8 f7 10 00 00       	call   3c28 <exit>
    2b31:	c7 04 24 a3 52 00 00 	movl   $0x52a3,(%esp)
    2b38:	e8 3b 11 00 00       	call   3c78 <unlink>
    2b3d:	85 c0                	test   %eax,%eax
    2b3f:	75 19                	jne    2b5a <dirfile+0x142>
    2b41:	c7 44 24 04 e9 52 00 	movl   $0x52e9,0x4(%esp)
    2b48:	00 
    2b49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b50:	e8 4c 12 00 00       	call   3da1 <printf>
    2b55:	e8 ce 10 00 00       	call   3c28 <exit>
    2b5a:	c7 44 24 04 a3 52 00 	movl   $0x52a3,0x4(%esp)
    2b61:	00 
    2b62:	c7 04 24 07 53 00 00 	movl   $0x5307,(%esp)
    2b69:	e8 1a 11 00 00       	call   3c88 <link>
    2b6e:	85 c0                	test   %eax,%eax
    2b70:	75 19                	jne    2b8b <dirfile+0x173>
    2b72:	c7 44 24 04 10 53 00 	movl   $0x5310,0x4(%esp)
    2b79:	00 
    2b7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b81:	e8 1b 12 00 00       	call   3da1 <printf>
    2b86:	e8 9d 10 00 00       	call   3c28 <exit>
    2b8b:	c7 04 24 6a 52 00 00 	movl   $0x526a,(%esp)
    2b92:	e8 e1 10 00 00       	call   3c78 <unlink>
    2b97:	85 c0                	test   %eax,%eax
    2b99:	74 19                	je     2bb4 <dirfile+0x19c>
    2b9b:	c7 44 24 04 2f 53 00 	movl   $0x532f,0x4(%esp)
    2ba2:	00 
    2ba3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2baa:	e8 f2 11 00 00       	call   3da1 <printf>
    2baf:	e8 74 10 00 00       	call   3c28 <exit>
    2bb4:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2bbb:	00 
    2bbc:	c7 04 24 d7 48 00 00 	movl   $0x48d7,(%esp)
    2bc3:	e8 a0 10 00 00       	call   3c68 <open>
    2bc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2bcb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bcf:	78 19                	js     2bea <dirfile+0x1d2>
    2bd1:	c7 44 24 04 48 53 00 	movl   $0x5348,0x4(%esp)
    2bd8:	00 
    2bd9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2be0:	e8 bc 11 00 00       	call   3da1 <printf>
    2be5:	e8 3e 10 00 00       	call   3c28 <exit>
    2bea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2bf1:	00 
    2bf2:	c7 04 24 d7 48 00 00 	movl   $0x48d7,(%esp)
    2bf9:	e8 6a 10 00 00       	call   3c68 <open>
    2bfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2c01:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2c08:	00 
    2c09:	c7 44 24 04 0e 45 00 	movl   $0x450e,0x4(%esp)
    2c10:	00 
    2c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c14:	89 04 24             	mov    %eax,(%esp)
    2c17:	e8 2c 10 00 00       	call   3c48 <write>
    2c1c:	85 c0                	test   %eax,%eax
    2c1e:	7e 19                	jle    2c39 <dirfile+0x221>
    2c20:	c7 44 24 04 67 53 00 	movl   $0x5367,0x4(%esp)
    2c27:	00 
    2c28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c2f:	e8 6d 11 00 00       	call   3da1 <printf>
    2c34:	e8 ef 0f 00 00       	call   3c28 <exit>
    2c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c3c:	89 04 24             	mov    %eax,(%esp)
    2c3f:	e8 0c 10 00 00       	call   3c50 <close>
    2c44:	c7 44 24 04 7b 53 00 	movl   $0x537b,0x4(%esp)
    2c4b:	00 
    2c4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c53:	e8 49 11 00 00       	call   3da1 <printf>
    2c58:	c9                   	leave  
    2c59:	c3                   	ret    

00002c5a <iref>:
    2c5a:	55                   	push   %ebp
    2c5b:	89 e5                	mov    %esp,%ebp
    2c5d:	83 ec 28             	sub    $0x28,%esp
    2c60:	c7 44 24 04 8b 53 00 	movl   $0x538b,0x4(%esp)
    2c67:	00 
    2c68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c6f:	e8 2d 11 00 00       	call   3da1 <printf>
    2c74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c7b:	e9 d2 00 00 00       	jmp    2d52 <iref+0xf8>
    2c80:	c7 04 24 9c 53 00 00 	movl   $0x539c,(%esp)
    2c87:	e8 04 10 00 00       	call   3c90 <mkdir>
    2c8c:	85 c0                	test   %eax,%eax
    2c8e:	74 19                	je     2ca9 <iref+0x4f>
    2c90:	c7 44 24 04 a2 53 00 	movl   $0x53a2,0x4(%esp)
    2c97:	00 
    2c98:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c9f:	e8 fd 10 00 00       	call   3da1 <printf>
    2ca4:	e8 7f 0f 00 00       	call   3c28 <exit>
    2ca9:	c7 04 24 9c 53 00 00 	movl   $0x539c,(%esp)
    2cb0:	e8 e3 0f 00 00       	call   3c98 <chdir>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	74 19                	je     2cd2 <iref+0x78>
    2cb9:	c7 44 24 04 b6 53 00 	movl   $0x53b6,0x4(%esp)
    2cc0:	00 
    2cc1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cc8:	e8 d4 10 00 00       	call   3da1 <printf>
    2ccd:	e8 56 0f 00 00       	call   3c28 <exit>
    2cd2:	c7 04 24 ca 53 00 00 	movl   $0x53ca,(%esp)
    2cd9:	e8 b2 0f 00 00       	call   3c90 <mkdir>
    2cde:	c7 44 24 04 ca 53 00 	movl   $0x53ca,0x4(%esp)
    2ce5:	00 
    2ce6:	c7 04 24 07 53 00 00 	movl   $0x5307,(%esp)
    2ced:	e8 96 0f 00 00       	call   3c88 <link>
    2cf2:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2cf9:	00 
    2cfa:	c7 04 24 ca 53 00 00 	movl   $0x53ca,(%esp)
    2d01:	e8 62 0f 00 00       	call   3c68 <open>
    2d06:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d0d:	78 0b                	js     2d1a <iref+0xc0>
    2d0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d12:	89 04 24             	mov    %eax,(%esp)
    2d15:	e8 36 0f 00 00       	call   3c50 <close>
    2d1a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2d21:	00 
    2d22:	c7 04 24 cb 53 00 00 	movl   $0x53cb,(%esp)
    2d29:	e8 3a 0f 00 00       	call   3c68 <open>
    2d2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2d31:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d35:	78 0b                	js     2d42 <iref+0xe8>
    2d37:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d3a:	89 04 24             	mov    %eax,(%esp)
    2d3d:	e8 0e 0f 00 00       	call   3c50 <close>
    2d42:	c7 04 24 cb 53 00 00 	movl   $0x53cb,(%esp)
    2d49:	e8 2a 0f 00 00       	call   3c78 <unlink>
    2d4e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d52:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2d56:	0f 8e 24 ff ff ff    	jle    2c80 <iref+0x26>
    2d5c:	c7 04 24 ee 51 00 00 	movl   $0x51ee,(%esp)
    2d63:	e8 30 0f 00 00       	call   3c98 <chdir>
    2d68:	c7 44 24 04 ce 53 00 	movl   $0x53ce,0x4(%esp)
    2d6f:	00 
    2d70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d77:	e8 25 10 00 00       	call   3da1 <printf>
    2d7c:	c9                   	leave  
    2d7d:	c3                   	ret    

00002d7e <forktest>:
    2d7e:	55                   	push   %ebp
    2d7f:	89 e5                	mov    %esp,%ebp
    2d81:	83 ec 28             	sub    $0x28,%esp
    2d84:	c7 44 24 04 e2 53 00 	movl   $0x53e2,0x4(%esp)
    2d8b:	00 
    2d8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d93:	e8 09 10 00 00       	call   3da1 <printf>
    2d98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d9f:	eb 1d                	jmp    2dbe <forktest+0x40>
    2da1:	e8 7a 0e 00 00       	call   3c20 <fork>
    2da6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2da9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2dad:	78 1a                	js     2dc9 <forktest+0x4b>
    2daf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2db3:	75 05                	jne    2dba <forktest+0x3c>
    2db5:	e8 6e 0e 00 00       	call   3c28 <exit>
    2dba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2dbe:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2dc5:	7e da                	jle    2da1 <forktest+0x23>
    2dc7:	eb 01                	jmp    2dca <forktest+0x4c>
    2dc9:	90                   	nop
    2dca:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2dd1:	75 3f                	jne    2e12 <forktest+0x94>
    2dd3:	c7 44 24 04 f0 53 00 	movl   $0x53f0,0x4(%esp)
    2dda:	00 
    2ddb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2de2:	e8 ba 0f 00 00       	call   3da1 <printf>
    2de7:	e8 3c 0e 00 00       	call   3c28 <exit>
    2dec:	e8 3f 0e 00 00       	call   3c30 <wait>
    2df1:	85 c0                	test   %eax,%eax
    2df3:	79 19                	jns    2e0e <forktest+0x90>
    2df5:	c7 44 24 04 12 54 00 	movl   $0x5412,0x4(%esp)
    2dfc:	00 
    2dfd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e04:	e8 98 0f 00 00       	call   3da1 <printf>
    2e09:	e8 1a 0e 00 00       	call   3c28 <exit>
    2e0e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2e12:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e16:	7f d4                	jg     2dec <forktest+0x6e>
    2e18:	e8 13 0e 00 00       	call   3c30 <wait>
    2e1d:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e20:	74 19                	je     2e3b <forktest+0xbd>
    2e22:	c7 44 24 04 26 54 00 	movl   $0x5426,0x4(%esp)
    2e29:	00 
    2e2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e31:	e8 6b 0f 00 00       	call   3da1 <printf>
    2e36:	e8 ed 0d 00 00       	call   3c28 <exit>
    2e3b:	c7 44 24 04 39 54 00 	movl   $0x5439,0x4(%esp)
    2e42:	00 
    2e43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e4a:	e8 52 0f 00 00       	call   3da1 <printf>
    2e4f:	c9                   	leave  
    2e50:	c3                   	ret    

00002e51 <sbrktest>:
    2e51:	55                   	push   %ebp
    2e52:	89 e5                	mov    %esp,%ebp
    2e54:	53                   	push   %ebx
    2e55:	81 ec 84 00 00 00    	sub    $0x84,%esp
    2e5b:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2e60:	c7 44 24 04 47 54 00 	movl   $0x5447,0x4(%esp)
    2e67:	00 
    2e68:	89 04 24             	mov    %eax,(%esp)
    2e6b:	e8 31 0f 00 00       	call   3da1 <printf>
    2e70:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e77:	e8 34 0e 00 00       	call   3cb0 <sbrk>
    2e7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2e7f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e86:	e8 25 0e 00 00       	call   3cb0 <sbrk>
    2e8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2e8e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2e95:	eb 59                	jmp    2ef0 <sbrktest+0x9f>
    2e97:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e9e:	e8 0d 0e 00 00       	call   3cb0 <sbrk>
    2ea3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2ea6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ea9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2eac:	74 2f                	je     2edd <sbrktest+0x8c>
    2eae:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2eb3:	8b 55 e8             	mov    -0x18(%ebp),%edx
    2eb6:	89 54 24 10          	mov    %edx,0x10(%esp)
    2eba:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2ebd:	89 54 24 0c          	mov    %edx,0xc(%esp)
    2ec1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    2ec4:	89 54 24 08          	mov    %edx,0x8(%esp)
    2ec8:	c7 44 24 04 52 54 00 	movl   $0x5452,0x4(%esp)
    2ecf:	00 
    2ed0:	89 04 24             	mov    %eax,(%esp)
    2ed3:	e8 c9 0e 00 00       	call   3da1 <printf>
    2ed8:	e8 4b 0d 00 00       	call   3c28 <exit>
    2edd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ee0:	c6 00 01             	movb   $0x1,(%eax)
    2ee3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ee6:	83 c0 01             	add    $0x1,%eax
    2ee9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2eec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2ef0:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2ef7:	7e 9e                	jle    2e97 <sbrktest+0x46>
    2ef9:	e8 22 0d 00 00       	call   3c20 <fork>
    2efe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2f01:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f05:	79 1a                	jns    2f21 <sbrktest+0xd0>
    2f07:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2f0c:	c7 44 24 04 6d 54 00 	movl   $0x546d,0x4(%esp)
    2f13:	00 
    2f14:	89 04 24             	mov    %eax,(%esp)
    2f17:	e8 85 0e 00 00       	call   3da1 <printf>
    2f1c:	e8 07 0d 00 00       	call   3c28 <exit>
    2f21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f28:	e8 83 0d 00 00       	call   3cb0 <sbrk>
    2f2d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2f30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f37:	e8 74 0d 00 00       	call   3cb0 <sbrk>
    2f3c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2f3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f42:	83 c0 01             	add    $0x1,%eax
    2f45:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    2f48:	74 1a                	je     2f64 <sbrktest+0x113>
    2f4a:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2f4f:	c7 44 24 04 84 54 00 	movl   $0x5484,0x4(%esp)
    2f56:	00 
    2f57:	89 04 24             	mov    %eax,(%esp)
    2f5a:	e8 42 0e 00 00       	call   3da1 <printf>
    2f5f:	e8 c4 0c 00 00       	call   3c28 <exit>
    2f64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f68:	75 05                	jne    2f6f <sbrktest+0x11e>
    2f6a:	e8 b9 0c 00 00       	call   3c28 <exit>
    2f6f:	e8 bc 0c 00 00       	call   3c30 <wait>
    2f74:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f7b:	e8 30 0d 00 00       	call   3cb0 <sbrk>
    2f80:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f86:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f8b:	89 d1                	mov    %edx,%ecx
    2f8d:	29 c1                	sub    %eax,%ecx
    2f8f:	89 c8                	mov    %ecx,%eax
    2f91:	89 45 dc             	mov    %eax,-0x24(%ebp)
    2f94:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2f97:	89 04 24             	mov    %eax,(%esp)
    2f9a:	e8 11 0d 00 00       	call   3cb0 <sbrk>
    2f9f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    2fa2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2fa5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2fa8:	74 1a                	je     2fc4 <sbrktest+0x173>
    2faa:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2faf:	c7 44 24 04 a0 54 00 	movl   $0x54a0,0x4(%esp)
    2fb6:	00 
    2fb7:	89 04 24             	mov    %eax,(%esp)
    2fba:	e8 e2 0d 00 00       	call   3da1 <printf>
    2fbf:	e8 64 0c 00 00       	call   3c28 <exit>
    2fc4:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
    2fcb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2fce:	c6 00 63             	movb   $0x63,(%eax)
    2fd1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fd8:	e8 d3 0c 00 00       	call   3cb0 <sbrk>
    2fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2fe0:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2fe7:	e8 c4 0c 00 00       	call   3cb0 <sbrk>
    2fec:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2fef:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    2ff3:	75 1a                	jne    300f <sbrktest+0x1be>
    2ff5:	a1 18 5d 00 00       	mov    0x5d18,%eax
    2ffa:	c7 44 24 04 de 54 00 	movl   $0x54de,0x4(%esp)
    3001:	00 
    3002:	89 04 24             	mov    %eax,(%esp)
    3005:	e8 97 0d 00 00       	call   3da1 <printf>
    300a:	e8 19 0c 00 00       	call   3c28 <exit>
    300f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3016:	e8 95 0c 00 00       	call   3cb0 <sbrk>
    301b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    301e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3021:	2d 00 10 00 00       	sub    $0x1000,%eax
    3026:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3029:	74 28                	je     3053 <sbrktest+0x202>
    302b:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3030:	8b 55 e0             	mov    -0x20(%ebp),%edx
    3033:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3037:	8b 55 f4             	mov    -0xc(%ebp),%edx
    303a:	89 54 24 08          	mov    %edx,0x8(%esp)
    303e:	c7 44 24 04 fc 54 00 	movl   $0x54fc,0x4(%esp)
    3045:	00 
    3046:	89 04 24             	mov    %eax,(%esp)
    3049:	e8 53 0d 00 00       	call   3da1 <printf>
    304e:	e8 d5 0b 00 00       	call   3c28 <exit>
    3053:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    305a:	e8 51 0c 00 00       	call   3cb0 <sbrk>
    305f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3062:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    3069:	e8 42 0c 00 00       	call   3cb0 <sbrk>
    306e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    3071:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3074:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3077:	75 19                	jne    3092 <sbrktest+0x241>
    3079:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3080:	e8 2b 0c 00 00       	call   3cb0 <sbrk>
    3085:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3088:	81 c2 00 10 00 00    	add    $0x1000,%edx
    308e:	39 d0                	cmp    %edx,%eax
    3090:	74 28                	je     30ba <sbrktest+0x269>
    3092:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3097:	8b 55 e0             	mov    -0x20(%ebp),%edx
    309a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    309e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    30a1:	89 54 24 08          	mov    %edx,0x8(%esp)
    30a5:	c7 44 24 04 34 55 00 	movl   $0x5534,0x4(%esp)
    30ac:	00 
    30ad:	89 04 24             	mov    %eax,(%esp)
    30b0:	e8 ec 0c 00 00       	call   3da1 <printf>
    30b5:	e8 6e 0b 00 00       	call   3c28 <exit>
    30ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    30bd:	0f b6 00             	movzbl (%eax),%eax
    30c0:	3c 63                	cmp    $0x63,%al
    30c2:	75 1a                	jne    30de <sbrktest+0x28d>
    30c4:	a1 18 5d 00 00       	mov    0x5d18,%eax
    30c9:	c7 44 24 04 5c 55 00 	movl   $0x555c,0x4(%esp)
    30d0:	00 
    30d1:	89 04 24             	mov    %eax,(%esp)
    30d4:	e8 c8 0c 00 00       	call   3da1 <printf>
    30d9:	e8 4a 0b 00 00       	call   3c28 <exit>
    30de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    30e5:	e8 c6 0b 00 00       	call   3cb0 <sbrk>
    30ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    30ed:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    30f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    30f7:	e8 b4 0b 00 00       	call   3cb0 <sbrk>
    30fc:	89 da                	mov    %ebx,%edx
    30fe:	29 c2                	sub    %eax,%edx
    3100:	89 d0                	mov    %edx,%eax
    3102:	89 04 24             	mov    %eax,(%esp)
    3105:	e8 a6 0b 00 00       	call   3cb0 <sbrk>
    310a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    310d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3110:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3113:	74 28                	je     313d <sbrktest+0x2ec>
    3115:	a1 18 5d 00 00       	mov    0x5d18,%eax
    311a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    311d:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3121:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3124:	89 54 24 08          	mov    %edx,0x8(%esp)
    3128:	c7 44 24 04 8c 55 00 	movl   $0x558c,0x4(%esp)
    312f:	00 
    3130:	89 04 24             	mov    %eax,(%esp)
    3133:	e8 69 0c 00 00       	call   3da1 <printf>
    3138:	e8 eb 0a 00 00       	call   3c28 <exit>
    313d:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    3144:	eb 7b                	jmp    31c1 <sbrktest+0x370>
    3146:	e8 5d 0b 00 00       	call   3ca8 <getpid>
    314b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    314e:	e8 cd 0a 00 00       	call   3c20 <fork>
    3153:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3156:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    315a:	79 1a                	jns    3176 <sbrktest+0x325>
    315c:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3161:	c7 44 24 04 55 45 00 	movl   $0x4555,0x4(%esp)
    3168:	00 
    3169:	89 04 24             	mov    %eax,(%esp)
    316c:	e8 30 0c 00 00       	call   3da1 <printf>
    3171:	e8 b2 0a 00 00       	call   3c28 <exit>
    3176:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    317a:	75 39                	jne    31b5 <sbrktest+0x364>
    317c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    317f:	0f b6 00             	movzbl (%eax),%eax
    3182:	0f be d0             	movsbl %al,%edx
    3185:	a1 18 5d 00 00       	mov    0x5d18,%eax
    318a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    318e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3191:	89 54 24 08          	mov    %edx,0x8(%esp)
    3195:	c7 44 24 04 ad 55 00 	movl   $0x55ad,0x4(%esp)
    319c:	00 
    319d:	89 04 24             	mov    %eax,(%esp)
    31a0:	e8 fc 0b 00 00       	call   3da1 <printf>
    31a5:	8b 45 d0             	mov    -0x30(%ebp),%eax
    31a8:	89 04 24             	mov    %eax,(%esp)
    31ab:	e8 a8 0a 00 00       	call   3c58 <kill>
    31b0:	e8 73 0a 00 00       	call   3c28 <exit>
    31b5:	e8 76 0a 00 00       	call   3c30 <wait>
    31ba:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    31c1:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    31c8:	0f 86 78 ff ff ff    	jbe    3146 <sbrktest+0x2f5>
    31ce:	8d 45 c8             	lea    -0x38(%ebp),%eax
    31d1:	89 04 24             	mov    %eax,(%esp)
    31d4:	e8 5f 0a 00 00       	call   3c38 <pipe>
    31d9:	85 c0                	test   %eax,%eax
    31db:	74 19                	je     31f6 <sbrktest+0x3a5>
    31dd:	c7 44 24 04 a9 44 00 	movl   $0x44a9,0x4(%esp)
    31e4:	00 
    31e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31ec:	e8 b0 0b 00 00       	call   3da1 <printf>
    31f1:	e8 32 0a 00 00       	call   3c28 <exit>
    31f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31fd:	e9 89 00 00 00       	jmp    328b <sbrktest+0x43a>
    3202:	e8 19 0a 00 00       	call   3c20 <fork>
    3207:	8b 55 f0             	mov    -0x10(%ebp),%edx
    320a:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    320e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3211:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3215:	85 c0                	test   %eax,%eax
    3217:	75 48                	jne    3261 <sbrktest+0x410>
    3219:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3220:	e8 8b 0a 00 00       	call   3cb0 <sbrk>
    3225:	ba 00 00 40 06       	mov    $0x6400000,%edx
    322a:	89 d1                	mov    %edx,%ecx
    322c:	29 c1                	sub    %eax,%ecx
    322e:	89 c8                	mov    %ecx,%eax
    3230:	89 04 24             	mov    %eax,(%esp)
    3233:	e8 78 0a 00 00       	call   3cb0 <sbrk>
    3238:	8b 45 cc             	mov    -0x34(%ebp),%eax
    323b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3242:	00 
    3243:	c7 44 24 04 0e 45 00 	movl   $0x450e,0x4(%esp)
    324a:	00 
    324b:	89 04 24             	mov    %eax,(%esp)
    324e:	e8 f5 09 00 00       	call   3c48 <write>
    3253:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    325a:	e8 59 0a 00 00       	call   3cb8 <sleep>
    325f:	eb f2                	jmp    3253 <sbrktest+0x402>
    3261:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3264:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3268:	83 f8 ff             	cmp    $0xffffffff,%eax
    326b:	74 1a                	je     3287 <sbrktest+0x436>
    326d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3270:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3277:	00 
    3278:	8d 55 9f             	lea    -0x61(%ebp),%edx
    327b:	89 54 24 04          	mov    %edx,0x4(%esp)
    327f:	89 04 24             	mov    %eax,(%esp)
    3282:	e8 b9 09 00 00       	call   3c40 <read>
    3287:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    328b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    328e:	83 f8 09             	cmp    $0x9,%eax
    3291:	0f 86 6b ff ff ff    	jbe    3202 <sbrktest+0x3b1>
    3297:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    329e:	e8 0d 0a 00 00       	call   3cb0 <sbrk>
    32a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    32a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    32ad:	eb 27                	jmp    32d6 <sbrktest+0x485>
    32af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32b2:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    32b6:	83 f8 ff             	cmp    $0xffffffff,%eax
    32b9:	74 16                	je     32d1 <sbrktest+0x480>
    32bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32be:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    32c2:	89 04 24             	mov    %eax,(%esp)
    32c5:	e8 8e 09 00 00       	call   3c58 <kill>
    32ca:	e8 61 09 00 00       	call   3c30 <wait>
    32cf:	eb 01                	jmp    32d2 <sbrktest+0x481>
    32d1:	90                   	nop
    32d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    32d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32d9:	83 f8 09             	cmp    $0x9,%eax
    32dc:	76 d1                	jbe    32af <sbrktest+0x45e>
    32de:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    32e2:	75 1a                	jne    32fe <sbrktest+0x4ad>
    32e4:	a1 18 5d 00 00       	mov    0x5d18,%eax
    32e9:	c7 44 24 04 c6 55 00 	movl   $0x55c6,0x4(%esp)
    32f0:	00 
    32f1:	89 04 24             	mov    %eax,(%esp)
    32f4:	e8 a8 0a 00 00       	call   3da1 <printf>
    32f9:	e8 2a 09 00 00       	call   3c28 <exit>
    32fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3305:	e8 a6 09 00 00       	call   3cb0 <sbrk>
    330a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    330d:	76 1d                	jbe    332c <sbrktest+0x4db>
    330f:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3312:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3319:	e8 92 09 00 00       	call   3cb0 <sbrk>
    331e:	89 da                	mov    %ebx,%edx
    3320:	29 c2                	sub    %eax,%edx
    3322:	89 d0                	mov    %edx,%eax
    3324:	89 04 24             	mov    %eax,(%esp)
    3327:	e8 84 09 00 00       	call   3cb0 <sbrk>
    332c:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3331:	c7 44 24 04 e1 55 00 	movl   $0x55e1,0x4(%esp)
    3338:	00 
    3339:	89 04 24             	mov    %eax,(%esp)
    333c:	e8 60 0a 00 00       	call   3da1 <printf>
    3341:	81 c4 84 00 00 00    	add    $0x84,%esp
    3347:	5b                   	pop    %ebx
    3348:	5d                   	pop    %ebp
    3349:	c3                   	ret    

0000334a <validateint>:
    334a:	55                   	push   %ebp
    334b:	89 e5                	mov    %esp,%ebp
    334d:	56                   	push   %esi
    334e:	53                   	push   %ebx
    334f:	83 ec 14             	sub    $0x14,%esp
    3352:	c7 45 e4 0d 00 00 00 	movl   $0xd,-0x1c(%ebp)
    3359:	8b 55 08             	mov    0x8(%ebp),%edx
    335c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    335f:	89 d1                	mov    %edx,%ecx
    3361:	89 e3                	mov    %esp,%ebx
    3363:	89 cc                	mov    %ecx,%esp
    3365:	cd 40                	int    $0x40
    3367:	89 dc                	mov    %ebx,%esp
    3369:	89 c6                	mov    %eax,%esi
    336b:	89 75 f4             	mov    %esi,-0xc(%ebp)
    336e:	83 c4 14             	add    $0x14,%esp
    3371:	5b                   	pop    %ebx
    3372:	5e                   	pop    %esi
    3373:	5d                   	pop    %ebp
    3374:	c3                   	ret    

00003375 <validatetest>:
    3375:	55                   	push   %ebp
    3376:	89 e5                	mov    %esp,%ebp
    3378:	83 ec 28             	sub    $0x28,%esp
    337b:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3380:	c7 44 24 04 ef 55 00 	movl   $0x55ef,0x4(%esp)
    3387:	00 
    3388:	89 04 24             	mov    %eax,(%esp)
    338b:	e8 11 0a 00 00       	call   3da1 <printf>
    3390:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)
    3397:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    339e:	eb 7f                	jmp    341f <validatetest+0xaa>
    33a0:	e8 7b 08 00 00       	call   3c20 <fork>
    33a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    33a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    33ac:	75 10                	jne    33be <validatetest+0x49>
    33ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33b1:	89 04 24             	mov    %eax,(%esp)
    33b4:	e8 91 ff ff ff       	call   334a <validateint>
    33b9:	e8 6a 08 00 00       	call   3c28 <exit>
    33be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33c5:	e8 ee 08 00 00       	call   3cb8 <sleep>
    33ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    33d1:	e8 e2 08 00 00       	call   3cb8 <sleep>
    33d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    33d9:	89 04 24             	mov    %eax,(%esp)
    33dc:	e8 77 08 00 00       	call   3c58 <kill>
    33e1:	e8 4a 08 00 00       	call   3c30 <wait>
    33e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33e9:	89 44 24 04          	mov    %eax,0x4(%esp)
    33ed:	c7 04 24 fe 55 00 00 	movl   $0x55fe,(%esp)
    33f4:	e8 8f 08 00 00       	call   3c88 <link>
    33f9:	83 f8 ff             	cmp    $0xffffffff,%eax
    33fc:	74 1a                	je     3418 <validatetest+0xa3>
    33fe:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3403:	c7 44 24 04 09 56 00 	movl   $0x5609,0x4(%esp)
    340a:	00 
    340b:	89 04 24             	mov    %eax,(%esp)
    340e:	e8 8e 09 00 00       	call   3da1 <printf>
    3413:	e8 10 08 00 00       	call   3c28 <exit>
    3418:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    341f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3422:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3425:	0f 83 75 ff ff ff    	jae    33a0 <validatetest+0x2b>
    342b:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3430:	c7 44 24 04 22 56 00 	movl   $0x5622,0x4(%esp)
    3437:	00 
    3438:	89 04 24             	mov    %eax,(%esp)
    343b:	e8 61 09 00 00       	call   3da1 <printf>
    3440:	c9                   	leave  
    3441:	c3                   	ret    

00003442 <bsstest>:
    3442:	55                   	push   %ebp
    3443:	89 e5                	mov    %esp,%ebp
    3445:	83 ec 28             	sub    $0x28,%esp
    3448:	a1 18 5d 00 00       	mov    0x5d18,%eax
    344d:	c7 44 24 04 2f 56 00 	movl   $0x562f,0x4(%esp)
    3454:	00 
    3455:	89 04 24             	mov    %eax,(%esp)
    3458:	e8 44 09 00 00       	call   3da1 <printf>
    345d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3464:	eb 2d                	jmp    3493 <bsstest+0x51>
    3466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3469:	05 e0 5d 00 00       	add    $0x5de0,%eax
    346e:	0f b6 00             	movzbl (%eax),%eax
    3471:	84 c0                	test   %al,%al
    3473:	74 1a                	je     348f <bsstest+0x4d>
    3475:	a1 18 5d 00 00       	mov    0x5d18,%eax
    347a:	c7 44 24 04 39 56 00 	movl   $0x5639,0x4(%esp)
    3481:	00 
    3482:	89 04 24             	mov    %eax,(%esp)
    3485:	e8 17 09 00 00       	call   3da1 <printf>
    348a:	e8 99 07 00 00       	call   3c28 <exit>
    348f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3496:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    349b:	76 c9                	jbe    3466 <bsstest+0x24>
    349d:	a1 18 5d 00 00       	mov    0x5d18,%eax
    34a2:	c7 44 24 04 4a 56 00 	movl   $0x564a,0x4(%esp)
    34a9:	00 
    34aa:	89 04 24             	mov    %eax,(%esp)
    34ad:	e8 ef 08 00 00       	call   3da1 <printf>
    34b2:	c9                   	leave  
    34b3:	c3                   	ret    

000034b4 <bigargtest>:
    34b4:	55                   	push   %ebp
    34b5:	89 e5                	mov    %esp,%ebp
    34b7:	83 ec 28             	sub    $0x28,%esp
    34ba:	c7 04 24 57 56 00 00 	movl   $0x5657,(%esp)
    34c1:	e8 b2 07 00 00       	call   3c78 <unlink>
    34c6:	e8 55 07 00 00       	call   3c20 <fork>
    34cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    34ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34d2:	0f 85 90 00 00 00    	jne    3568 <bigargtest+0xb4>
    34d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34df:	eb 12                	jmp    34f3 <bigargtest+0x3f>
    34e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34e4:	c7 04 85 40 5d 00 00 	movl   $0x5664,0x5d40(,%eax,4)
    34eb:	64 56 00 00 
    34ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34f3:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    34f7:	7e e8                	jle    34e1 <bigargtest+0x2d>
    34f9:	c7 05 bc 5d 00 00 00 	movl   $0x0,0x5dbc
    3500:	00 00 00 
    3503:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3508:	c7 44 24 04 41 57 00 	movl   $0x5741,0x4(%esp)
    350f:	00 
    3510:	89 04 24             	mov    %eax,(%esp)
    3513:	e8 89 08 00 00       	call   3da1 <printf>
    3518:	c7 44 24 04 40 5d 00 	movl   $0x5d40,0x4(%esp)
    351f:	00 
    3520:	c7 04 24 68 41 00 00 	movl   $0x4168,(%esp)
    3527:	e8 34 07 00 00       	call   3c60 <exec>
    352c:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3531:	c7 44 24 04 4e 57 00 	movl   $0x574e,0x4(%esp)
    3538:	00 
    3539:	89 04 24             	mov    %eax,(%esp)
    353c:	e8 60 08 00 00       	call   3da1 <printf>
    3541:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3548:	00 
    3549:	c7 04 24 57 56 00 00 	movl   $0x5657,(%esp)
    3550:	e8 13 07 00 00       	call   3c68 <open>
    3555:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3558:	8b 45 ec             	mov    -0x14(%ebp),%eax
    355b:	89 04 24             	mov    %eax,(%esp)
    355e:	e8 ed 06 00 00       	call   3c50 <close>
    3563:	e8 c0 06 00 00       	call   3c28 <exit>
    3568:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    356c:	79 1a                	jns    3588 <bigargtest+0xd4>
    356e:	a1 18 5d 00 00       	mov    0x5d18,%eax
    3573:	c7 44 24 04 5e 57 00 	movl   $0x575e,0x4(%esp)
    357a:	00 
    357b:	89 04 24             	mov    %eax,(%esp)
    357e:	e8 1e 08 00 00       	call   3da1 <printf>
    3583:	e8 a0 06 00 00       	call   3c28 <exit>
    3588:	e8 a3 06 00 00       	call   3c30 <wait>
    358d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3594:	00 
    3595:	c7 04 24 57 56 00 00 	movl   $0x5657,(%esp)
    359c:	e8 c7 06 00 00       	call   3c68 <open>
    35a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    35a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    35a8:	79 1a                	jns    35c4 <bigargtest+0x110>
    35aa:	a1 18 5d 00 00       	mov    0x5d18,%eax
    35af:	c7 44 24 04 77 57 00 	movl   $0x5777,0x4(%esp)
    35b6:	00 
    35b7:	89 04 24             	mov    %eax,(%esp)
    35ba:	e8 e2 07 00 00       	call   3da1 <printf>
    35bf:	e8 64 06 00 00       	call   3c28 <exit>
    35c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    35c7:	89 04 24             	mov    %eax,(%esp)
    35ca:	e8 81 06 00 00       	call   3c50 <close>
    35cf:	c7 04 24 57 56 00 00 	movl   $0x5657,(%esp)
    35d6:	e8 9d 06 00 00       	call   3c78 <unlink>
    35db:	c9                   	leave  
    35dc:	c3                   	ret    

000035dd <fsfull>:
    35dd:	55                   	push   %ebp
    35de:	89 e5                	mov    %esp,%ebp
    35e0:	53                   	push   %ebx
    35e1:	83 ec 74             	sub    $0x74,%esp
    35e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    35eb:	c7 44 24 04 8c 57 00 	movl   $0x578c,0x4(%esp)
    35f2:	00 
    35f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    35fa:	e8 a2 07 00 00       	call   3da1 <printf>
    35ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3606:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    360a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    360d:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3612:	89 c8                	mov    %ecx,%eax
    3614:	f7 ea                	imul   %edx
    3616:	c1 fa 06             	sar    $0x6,%edx
    3619:	89 c8                	mov    %ecx,%eax
    361b:	c1 f8 1f             	sar    $0x1f,%eax
    361e:	89 d1                	mov    %edx,%ecx
    3620:	29 c1                	sub    %eax,%ecx
    3622:	89 c8                	mov    %ecx,%eax
    3624:	83 c0 30             	add    $0x30,%eax
    3627:	88 45 a5             	mov    %al,-0x5b(%ebp)
    362a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    362d:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3632:	89 d8                	mov    %ebx,%eax
    3634:	f7 ea                	imul   %edx
    3636:	c1 fa 06             	sar    $0x6,%edx
    3639:	89 d8                	mov    %ebx,%eax
    363b:	c1 f8 1f             	sar    $0x1f,%eax
    363e:	89 d1                	mov    %edx,%ecx
    3640:	29 c1                	sub    %eax,%ecx
    3642:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3648:	89 d9                	mov    %ebx,%ecx
    364a:	29 c1                	sub    %eax,%ecx
    364c:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3651:	89 c8                	mov    %ecx,%eax
    3653:	f7 ea                	imul   %edx
    3655:	c1 fa 05             	sar    $0x5,%edx
    3658:	89 c8                	mov    %ecx,%eax
    365a:	c1 f8 1f             	sar    $0x1f,%eax
    365d:	89 d1                	mov    %edx,%ecx
    365f:	29 c1                	sub    %eax,%ecx
    3661:	89 c8                	mov    %ecx,%eax
    3663:	83 c0 30             	add    $0x30,%eax
    3666:	88 45 a6             	mov    %al,-0x5a(%ebp)
    3669:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    366c:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3671:	89 d8                	mov    %ebx,%eax
    3673:	f7 ea                	imul   %edx
    3675:	c1 fa 05             	sar    $0x5,%edx
    3678:	89 d8                	mov    %ebx,%eax
    367a:	c1 f8 1f             	sar    $0x1f,%eax
    367d:	89 d1                	mov    %edx,%ecx
    367f:	29 c1                	sub    %eax,%ecx
    3681:	6b c1 64             	imul   $0x64,%ecx,%eax
    3684:	89 d9                	mov    %ebx,%ecx
    3686:	29 c1                	sub    %eax,%ecx
    3688:	ba 67 66 66 66       	mov    $0x66666667,%edx
    368d:	89 c8                	mov    %ecx,%eax
    368f:	f7 ea                	imul   %edx
    3691:	c1 fa 02             	sar    $0x2,%edx
    3694:	89 c8                	mov    %ecx,%eax
    3696:	c1 f8 1f             	sar    $0x1f,%eax
    3699:	89 d1                	mov    %edx,%ecx
    369b:	29 c1                	sub    %eax,%ecx
    369d:	89 c8                	mov    %ecx,%eax
    369f:	83 c0 30             	add    $0x30,%eax
    36a2:	88 45 a7             	mov    %al,-0x59(%ebp)
    36a5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    36a8:	ba 67 66 66 66       	mov    $0x66666667,%edx
    36ad:	89 c8                	mov    %ecx,%eax
    36af:	f7 ea                	imul   %edx
    36b1:	c1 fa 02             	sar    $0x2,%edx
    36b4:	89 c8                	mov    %ecx,%eax
    36b6:	c1 f8 1f             	sar    $0x1f,%eax
    36b9:	29 c2                	sub    %eax,%edx
    36bb:	89 d0                	mov    %edx,%eax
    36bd:	c1 e0 02             	shl    $0x2,%eax
    36c0:	01 d0                	add    %edx,%eax
    36c2:	01 c0                	add    %eax,%eax
    36c4:	89 ca                	mov    %ecx,%edx
    36c6:	29 c2                	sub    %eax,%edx
    36c8:	89 d0                	mov    %edx,%eax
    36ca:	83 c0 30             	add    $0x30,%eax
    36cd:	88 45 a8             	mov    %al,-0x58(%ebp)
    36d0:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    36d4:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36d7:	89 44 24 08          	mov    %eax,0x8(%esp)
    36db:	c7 44 24 04 99 57 00 	movl   $0x5799,0x4(%esp)
    36e2:	00 
    36e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    36ea:	e8 b2 06 00 00       	call   3da1 <printf>
    36ef:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    36f6:	00 
    36f7:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36fa:	89 04 24             	mov    %eax,(%esp)
    36fd:	e8 66 05 00 00       	call   3c68 <open>
    3702:	89 45 e8             	mov    %eax,-0x18(%ebp)
    3705:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3709:	79 1d                	jns    3728 <fsfull+0x14b>
    370b:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    370e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3712:	c7 44 24 04 a5 57 00 	movl   $0x57a5,0x4(%esp)
    3719:	00 
    371a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3721:	e8 7b 06 00 00       	call   3da1 <printf>
    3726:	eb 71                	jmp    3799 <fsfull+0x1bc>
    3728:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    372f:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    3736:	00 
    3737:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
    373e:	00 
    373f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3742:	89 04 24             	mov    %eax,(%esp)
    3745:	e8 fe 04 00 00       	call   3c48 <write>
    374a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    374d:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3754:	7e 0c                	jle    3762 <fsfull+0x185>
    3756:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3759:	01 45 ec             	add    %eax,-0x14(%ebp)
    375c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3760:	eb cd                	jmp    372f <fsfull+0x152>
    3762:	90                   	nop
    3763:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3766:	89 44 24 08          	mov    %eax,0x8(%esp)
    376a:	c7 44 24 04 b5 57 00 	movl   $0x57b5,0x4(%esp)
    3771:	00 
    3772:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3779:	e8 23 06 00 00       	call   3da1 <printf>
    377e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3781:	89 04 24             	mov    %eax,(%esp)
    3784:	e8 c7 04 00 00       	call   3c50 <close>
    3789:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    378d:	74 09                	je     3798 <fsfull+0x1bb>
    378f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3793:	e9 6e fe ff ff       	jmp    3606 <fsfull+0x29>
    3798:	90                   	nop
    3799:	e9 dd 00 00 00       	jmp    387b <fsfull+0x29e>
    379e:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    37a2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    37a5:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    37aa:	89 c8                	mov    %ecx,%eax
    37ac:	f7 ea                	imul   %edx
    37ae:	c1 fa 06             	sar    $0x6,%edx
    37b1:	89 c8                	mov    %ecx,%eax
    37b3:	c1 f8 1f             	sar    $0x1f,%eax
    37b6:	89 d1                	mov    %edx,%ecx
    37b8:	29 c1                	sub    %eax,%ecx
    37ba:	89 c8                	mov    %ecx,%eax
    37bc:	83 c0 30             	add    $0x30,%eax
    37bf:	88 45 a5             	mov    %al,-0x5b(%ebp)
    37c2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37c5:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    37ca:	89 d8                	mov    %ebx,%eax
    37cc:	f7 ea                	imul   %edx
    37ce:	c1 fa 06             	sar    $0x6,%edx
    37d1:	89 d8                	mov    %ebx,%eax
    37d3:	c1 f8 1f             	sar    $0x1f,%eax
    37d6:	89 d1                	mov    %edx,%ecx
    37d8:	29 c1                	sub    %eax,%ecx
    37da:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    37e0:	89 d9                	mov    %ebx,%ecx
    37e2:	29 c1                	sub    %eax,%ecx
    37e4:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37e9:	89 c8                	mov    %ecx,%eax
    37eb:	f7 ea                	imul   %edx
    37ed:	c1 fa 05             	sar    $0x5,%edx
    37f0:	89 c8                	mov    %ecx,%eax
    37f2:	c1 f8 1f             	sar    $0x1f,%eax
    37f5:	89 d1                	mov    %edx,%ecx
    37f7:	29 c1                	sub    %eax,%ecx
    37f9:	89 c8                	mov    %ecx,%eax
    37fb:	83 c0 30             	add    $0x30,%eax
    37fe:	88 45 a6             	mov    %al,-0x5a(%ebp)
    3801:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3804:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3809:	89 d8                	mov    %ebx,%eax
    380b:	f7 ea                	imul   %edx
    380d:	c1 fa 05             	sar    $0x5,%edx
    3810:	89 d8                	mov    %ebx,%eax
    3812:	c1 f8 1f             	sar    $0x1f,%eax
    3815:	89 d1                	mov    %edx,%ecx
    3817:	29 c1                	sub    %eax,%ecx
    3819:	6b c1 64             	imul   $0x64,%ecx,%eax
    381c:	89 d9                	mov    %ebx,%ecx
    381e:	29 c1                	sub    %eax,%ecx
    3820:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3825:	89 c8                	mov    %ecx,%eax
    3827:	f7 ea                	imul   %edx
    3829:	c1 fa 02             	sar    $0x2,%edx
    382c:	89 c8                	mov    %ecx,%eax
    382e:	c1 f8 1f             	sar    $0x1f,%eax
    3831:	89 d1                	mov    %edx,%ecx
    3833:	29 c1                	sub    %eax,%ecx
    3835:	89 c8                	mov    %ecx,%eax
    3837:	83 c0 30             	add    $0x30,%eax
    383a:	88 45 a7             	mov    %al,-0x59(%ebp)
    383d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3840:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3845:	89 c8                	mov    %ecx,%eax
    3847:	f7 ea                	imul   %edx
    3849:	c1 fa 02             	sar    $0x2,%edx
    384c:	89 c8                	mov    %ecx,%eax
    384e:	c1 f8 1f             	sar    $0x1f,%eax
    3851:	29 c2                	sub    %eax,%edx
    3853:	89 d0                	mov    %edx,%eax
    3855:	c1 e0 02             	shl    $0x2,%eax
    3858:	01 d0                	add    %edx,%eax
    385a:	01 c0                	add    %eax,%eax
    385c:	89 ca                	mov    %ecx,%edx
    385e:	29 c2                	sub    %eax,%edx
    3860:	89 d0                	mov    %edx,%eax
    3862:	83 c0 30             	add    $0x30,%eax
    3865:	88 45 a8             	mov    %al,-0x58(%ebp)
    3868:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    386c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    386f:	89 04 24             	mov    %eax,(%esp)
    3872:	e8 01 04 00 00       	call   3c78 <unlink>
    3877:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    387b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    387f:	0f 89 19 ff ff ff    	jns    379e <fsfull+0x1c1>
    3885:	c7 44 24 04 c5 57 00 	movl   $0x57c5,0x4(%esp)
    388c:	00 
    388d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3894:	e8 08 05 00 00       	call   3da1 <printf>
    3899:	83 c4 74             	add    $0x74,%esp
    389c:	5b                   	pop    %ebx
    389d:	5d                   	pop    %ebp
    389e:	c3                   	ret    

0000389f <rand>:
    389f:	55                   	push   %ebp
    38a0:	89 e5                	mov    %esp,%ebp
    38a2:	a1 1c 5d 00 00       	mov    0x5d1c,%eax
    38a7:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    38ad:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    38b2:	a3 1c 5d 00 00       	mov    %eax,0x5d1c
    38b7:	a1 1c 5d 00 00       	mov    0x5d1c,%eax
    38bc:	5d                   	pop    %ebp
    38bd:	c3                   	ret    

000038be <main>:
    38be:	55                   	push   %ebp
    38bf:	89 e5                	mov    %esp,%ebp
    38c1:	83 e4 f0             	and    $0xfffffff0,%esp
    38c4:	83 ec 10             	sub    $0x10,%esp
    38c7:	c7 44 24 04 db 57 00 	movl   $0x57db,0x4(%esp)
    38ce:	00 
    38cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    38d6:	e8 c6 04 00 00       	call   3da1 <printf>
    38db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    38e2:	00 
    38e3:	c7 04 24 ef 57 00 00 	movl   $0x57ef,(%esp)
    38ea:	e8 79 03 00 00       	call   3c68 <open>
    38ef:	85 c0                	test   %eax,%eax
    38f1:	78 19                	js     390c <main+0x4e>
    38f3:	c7 44 24 04 00 58 00 	movl   $0x5800,0x4(%esp)
    38fa:	00 
    38fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3902:	e8 9a 04 00 00       	call   3da1 <printf>
    3907:	e8 1c 03 00 00       	call   3c28 <exit>
    390c:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    3913:	00 
    3914:	c7 04 24 ef 57 00 00 	movl   $0x57ef,(%esp)
    391b:	e8 48 03 00 00       	call   3c68 <open>
    3920:	89 04 24             	mov    %eax,(%esp)
    3923:	e8 28 03 00 00       	call   3c50 <close>
    3928:	e8 87 fb ff ff       	call   34b4 <bigargtest>
    392d:	e8 eb ea ff ff       	call   241d <bigwrite>
    3932:	e8 7d fb ff ff       	call   34b4 <bigargtest>
    3937:	e8 06 fb ff ff       	call   3442 <bsstest>
    393c:	e8 10 f5 ff ff       	call   2e51 <sbrktest>
    3941:	e8 2f fa ff ff       	call   3375 <validatetest>
    3946:	e8 b5 c6 ff ff       	call   0 <opentest>
    394b:	e8 5b c7 ff ff       	call   ab <writetest>
    3950:	e8 6b c9 ff ff       	call   2c0 <writetest1>
    3955:	e8 6f cb ff ff       	call   4c9 <createtest>
    395a:	e8 10 d1 ff ff       	call   a6f <mem>
    395f:	e8 46 cd ff ff       	call   6aa <pipe1>
    3964:	e8 2f cf ff ff       	call   898 <preempt>
    3969:	e8 83 d0 ff ff       	call   9f1 <exitwait>
    396e:	e8 2d ef ff ff       	call   28a0 <rmdot>
    3973:	e8 d2 ed ff ff       	call   274a <fourteen>
    3978:	e8 a8 eb ff ff       	call   2525 <bigfile>
    397d:	e8 55 e3 ff ff       	call   1cd7 <subdir>
    3982:	e8 fe dc ff ff       	call   1685 <concreate>
    3987:	e8 aa e0 ff ff       	call   1a36 <linkunlink>
    398c:	e8 ab da ff ff       	call   143c <linktest>
    3991:	e8 d1 d8 ff ff       	call   1267 <unlinkread>
    3996:	e8 1b d6 ff ff       	call   fb6 <createdelete>
    399b:	e8 ae d3 ff ff       	call   d4e <twofiles>
    39a0:	e8 af d1 ff ff       	call   b54 <sharedfd>
    39a5:	e8 6e f0 ff ff       	call   2a18 <dirfile>
    39aa:	e8 ab f2 ff ff       	call   2c5a <iref>
    39af:	e8 ca f3 ff ff       	call   2d7e <forktest>
    39b4:	e8 a9 e1 ff ff       	call   1b62 <bigdir>
    39b9:	e8 9d cc ff ff       	call   65b <exectest>
    39be:	e8 65 02 00 00       	call   3c28 <exit>
    39c3:	90                   	nop

000039c4 <stosb>:
    39c4:	55                   	push   %ebp
    39c5:	89 e5                	mov    %esp,%ebp
    39c7:	57                   	push   %edi
    39c8:	53                   	push   %ebx
    39c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    39cc:	8b 55 10             	mov    0x10(%ebp),%edx
    39cf:	8b 45 0c             	mov    0xc(%ebp),%eax
    39d2:	89 cb                	mov    %ecx,%ebx
    39d4:	89 df                	mov    %ebx,%edi
    39d6:	89 d1                	mov    %edx,%ecx
    39d8:	fc                   	cld    
    39d9:	f3 aa                	rep stos %al,%es:(%edi)
    39db:	89 ca                	mov    %ecx,%edx
    39dd:	89 fb                	mov    %edi,%ebx
    39df:	89 5d 08             	mov    %ebx,0x8(%ebp)
    39e2:	89 55 10             	mov    %edx,0x10(%ebp)
    39e5:	5b                   	pop    %ebx
    39e6:	5f                   	pop    %edi
    39e7:	5d                   	pop    %ebp
    39e8:	c3                   	ret    

000039e9 <strcpy>:
    39e9:	55                   	push   %ebp
    39ea:	89 e5                	mov    %esp,%ebp
    39ec:	83 ec 10             	sub    $0x10,%esp
    39ef:	8b 45 08             	mov    0x8(%ebp),%eax
    39f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    39f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    39f8:	0f b6 10             	movzbl (%eax),%edx
    39fb:	8b 45 08             	mov    0x8(%ebp),%eax
    39fe:	88 10                	mov    %dl,(%eax)
    3a00:	8b 45 08             	mov    0x8(%ebp),%eax
    3a03:	0f b6 00             	movzbl (%eax),%eax
    3a06:	84 c0                	test   %al,%al
    3a08:	0f 95 c0             	setne  %al
    3a0b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a0f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    3a13:	84 c0                	test   %al,%al
    3a15:	75 de                	jne    39f5 <strcpy+0xc>
    3a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3a1a:	c9                   	leave  
    3a1b:	c3                   	ret    

00003a1c <strcmp>:
    3a1c:	55                   	push   %ebp
    3a1d:	89 e5                	mov    %esp,%ebp
    3a1f:	eb 08                	jmp    3a29 <strcmp+0xd>
    3a21:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a25:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    3a29:	8b 45 08             	mov    0x8(%ebp),%eax
    3a2c:	0f b6 00             	movzbl (%eax),%eax
    3a2f:	84 c0                	test   %al,%al
    3a31:	74 10                	je     3a43 <strcmp+0x27>
    3a33:	8b 45 08             	mov    0x8(%ebp),%eax
    3a36:	0f b6 10             	movzbl (%eax),%edx
    3a39:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a3c:	0f b6 00             	movzbl (%eax),%eax
    3a3f:	38 c2                	cmp    %al,%dl
    3a41:	74 de                	je     3a21 <strcmp+0x5>
    3a43:	8b 45 08             	mov    0x8(%ebp),%eax
    3a46:	0f b6 00             	movzbl (%eax),%eax
    3a49:	0f b6 d0             	movzbl %al,%edx
    3a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a4f:	0f b6 00             	movzbl (%eax),%eax
    3a52:	0f b6 c0             	movzbl %al,%eax
    3a55:	89 d1                	mov    %edx,%ecx
    3a57:	29 c1                	sub    %eax,%ecx
    3a59:	89 c8                	mov    %ecx,%eax
    3a5b:	5d                   	pop    %ebp
    3a5c:	c3                   	ret    

00003a5d <strlen>:
    3a5d:	55                   	push   %ebp
    3a5e:	89 e5                	mov    %esp,%ebp
    3a60:	83 ec 10             	sub    $0x10,%esp
    3a63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3a6a:	eb 04                	jmp    3a70 <strlen+0x13>
    3a6c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3a70:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3a73:	03 45 08             	add    0x8(%ebp),%eax
    3a76:	0f b6 00             	movzbl (%eax),%eax
    3a79:	84 c0                	test   %al,%al
    3a7b:	75 ef                	jne    3a6c <strlen+0xf>
    3a7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3a80:	c9                   	leave  
    3a81:	c3                   	ret    

00003a82 <memset>:
    3a82:	55                   	push   %ebp
    3a83:	89 e5                	mov    %esp,%ebp
    3a85:	83 ec 0c             	sub    $0xc,%esp
    3a88:	8b 45 10             	mov    0x10(%ebp),%eax
    3a8b:	89 44 24 08          	mov    %eax,0x8(%esp)
    3a8f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a92:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a96:	8b 45 08             	mov    0x8(%ebp),%eax
    3a99:	89 04 24             	mov    %eax,(%esp)
    3a9c:	e8 23 ff ff ff       	call   39c4 <stosb>
    3aa1:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa4:	c9                   	leave  
    3aa5:	c3                   	ret    

00003aa6 <strchr>:
    3aa6:	55                   	push   %ebp
    3aa7:	89 e5                	mov    %esp,%ebp
    3aa9:	83 ec 04             	sub    $0x4,%esp
    3aac:	8b 45 0c             	mov    0xc(%ebp),%eax
    3aaf:	88 45 fc             	mov    %al,-0x4(%ebp)
    3ab2:	eb 14                	jmp    3ac8 <strchr+0x22>
    3ab4:	8b 45 08             	mov    0x8(%ebp),%eax
    3ab7:	0f b6 00             	movzbl (%eax),%eax
    3aba:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3abd:	75 05                	jne    3ac4 <strchr+0x1e>
    3abf:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac2:	eb 13                	jmp    3ad7 <strchr+0x31>
    3ac4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3ac8:	8b 45 08             	mov    0x8(%ebp),%eax
    3acb:	0f b6 00             	movzbl (%eax),%eax
    3ace:	84 c0                	test   %al,%al
    3ad0:	75 e2                	jne    3ab4 <strchr+0xe>
    3ad2:	b8 00 00 00 00       	mov    $0x0,%eax
    3ad7:	c9                   	leave  
    3ad8:	c3                   	ret    

00003ad9 <gets>:
    3ad9:	55                   	push   %ebp
    3ada:	89 e5                	mov    %esp,%ebp
    3adc:	83 ec 28             	sub    $0x28,%esp
    3adf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3ae6:	eb 44                	jmp    3b2c <gets+0x53>
    3ae8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3aef:	00 
    3af0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3af3:	89 44 24 04          	mov    %eax,0x4(%esp)
    3af7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3afe:	e8 3d 01 00 00       	call   3c40 <read>
    3b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3b06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b0a:	7e 2d                	jle    3b39 <gets+0x60>
    3b0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b0f:	03 45 08             	add    0x8(%ebp),%eax
    3b12:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    3b16:	88 10                	mov    %dl,(%eax)
    3b18:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3b1c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b20:	3c 0a                	cmp    $0xa,%al
    3b22:	74 16                	je     3b3a <gets+0x61>
    3b24:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b28:	3c 0d                	cmp    $0xd,%al
    3b2a:	74 0e                	je     3b3a <gets+0x61>
    3b2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b2f:	83 c0 01             	add    $0x1,%eax
    3b32:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3b35:	7c b1                	jl     3ae8 <gets+0xf>
    3b37:	eb 01                	jmp    3b3a <gets+0x61>
    3b39:	90                   	nop
    3b3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b3d:	03 45 08             	add    0x8(%ebp),%eax
    3b40:	c6 00 00             	movb   $0x0,(%eax)
    3b43:	8b 45 08             	mov    0x8(%ebp),%eax
    3b46:	c9                   	leave  
    3b47:	c3                   	ret    

00003b48 <stat>:
    3b48:	55                   	push   %ebp
    3b49:	89 e5                	mov    %esp,%ebp
    3b4b:	83 ec 28             	sub    $0x28,%esp
    3b4e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3b55:	00 
    3b56:	8b 45 08             	mov    0x8(%ebp),%eax
    3b59:	89 04 24             	mov    %eax,(%esp)
    3b5c:	e8 07 01 00 00       	call   3c68 <open>
    3b61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3b64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b68:	79 07                	jns    3b71 <stat+0x29>
    3b6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3b6f:	eb 23                	jmp    3b94 <stat+0x4c>
    3b71:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b74:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b78:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b7b:	89 04 24             	mov    %eax,(%esp)
    3b7e:	e8 fd 00 00 00       	call   3c80 <fstat>
    3b83:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b89:	89 04 24             	mov    %eax,(%esp)
    3b8c:	e8 bf 00 00 00       	call   3c50 <close>
    3b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b94:	c9                   	leave  
    3b95:	c3                   	ret    

00003b96 <atoi>:
    3b96:	55                   	push   %ebp
    3b97:	89 e5                	mov    %esp,%ebp
    3b99:	83 ec 10             	sub    $0x10,%esp
    3b9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3ba3:	eb 24                	jmp    3bc9 <atoi+0x33>
    3ba5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3ba8:	89 d0                	mov    %edx,%eax
    3baa:	c1 e0 02             	shl    $0x2,%eax
    3bad:	01 d0                	add    %edx,%eax
    3baf:	01 c0                	add    %eax,%eax
    3bb1:	89 c2                	mov    %eax,%edx
    3bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb6:	0f b6 00             	movzbl (%eax),%eax
    3bb9:	0f be c0             	movsbl %al,%eax
    3bbc:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3bbf:	83 e8 30             	sub    $0x30,%eax
    3bc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3bc5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3bc9:	8b 45 08             	mov    0x8(%ebp),%eax
    3bcc:	0f b6 00             	movzbl (%eax),%eax
    3bcf:	3c 2f                	cmp    $0x2f,%al
    3bd1:	7e 0a                	jle    3bdd <atoi+0x47>
    3bd3:	8b 45 08             	mov    0x8(%ebp),%eax
    3bd6:	0f b6 00             	movzbl (%eax),%eax
    3bd9:	3c 39                	cmp    $0x39,%al
    3bdb:	7e c8                	jle    3ba5 <atoi+0xf>
    3bdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3be0:	c9                   	leave  
    3be1:	c3                   	ret    

00003be2 <memmove>:
    3be2:	55                   	push   %ebp
    3be3:	89 e5                	mov    %esp,%ebp
    3be5:	83 ec 10             	sub    $0x10,%esp
    3be8:	8b 45 08             	mov    0x8(%ebp),%eax
    3beb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3bee:	8b 45 0c             	mov    0xc(%ebp),%eax
    3bf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3bf4:	eb 13                	jmp    3c09 <memmove+0x27>
    3bf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3bf9:	0f b6 10             	movzbl (%eax),%edx
    3bfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3bff:	88 10                	mov    %dl,(%eax)
    3c01:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    3c05:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3c09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    3c0d:	0f 9f c0             	setg   %al
    3c10:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    3c14:	84 c0                	test   %al,%al
    3c16:	75 de                	jne    3bf6 <memmove+0x14>
    3c18:	8b 45 08             	mov    0x8(%ebp),%eax
    3c1b:	c9                   	leave  
    3c1c:	c3                   	ret    
    3c1d:	90                   	nop
    3c1e:	90                   	nop
    3c1f:	90                   	nop

00003c20 <fork>:
    3c20:	b8 01 00 00 00       	mov    $0x1,%eax
    3c25:	cd 40                	int    $0x40
    3c27:	c3                   	ret    

00003c28 <exit>:
    3c28:	b8 02 00 00 00       	mov    $0x2,%eax
    3c2d:	cd 40                	int    $0x40
    3c2f:	c3                   	ret    

00003c30 <wait>:
    3c30:	b8 03 00 00 00       	mov    $0x3,%eax
    3c35:	cd 40                	int    $0x40
    3c37:	c3                   	ret    

00003c38 <pipe>:
    3c38:	b8 04 00 00 00       	mov    $0x4,%eax
    3c3d:	cd 40                	int    $0x40
    3c3f:	c3                   	ret    

00003c40 <read>:
    3c40:	b8 05 00 00 00       	mov    $0x5,%eax
    3c45:	cd 40                	int    $0x40
    3c47:	c3                   	ret    

00003c48 <write>:
    3c48:	b8 10 00 00 00       	mov    $0x10,%eax
    3c4d:	cd 40                	int    $0x40
    3c4f:	c3                   	ret    

00003c50 <close>:
    3c50:	b8 15 00 00 00       	mov    $0x15,%eax
    3c55:	cd 40                	int    $0x40
    3c57:	c3                   	ret    

00003c58 <kill>:
    3c58:	b8 06 00 00 00       	mov    $0x6,%eax
    3c5d:	cd 40                	int    $0x40
    3c5f:	c3                   	ret    

00003c60 <exec>:
    3c60:	b8 07 00 00 00       	mov    $0x7,%eax
    3c65:	cd 40                	int    $0x40
    3c67:	c3                   	ret    

00003c68 <open>:
    3c68:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c6d:	cd 40                	int    $0x40
    3c6f:	c3                   	ret    

00003c70 <mknod>:
    3c70:	b8 11 00 00 00       	mov    $0x11,%eax
    3c75:	cd 40                	int    $0x40
    3c77:	c3                   	ret    

00003c78 <unlink>:
    3c78:	b8 12 00 00 00       	mov    $0x12,%eax
    3c7d:	cd 40                	int    $0x40
    3c7f:	c3                   	ret    

00003c80 <fstat>:
    3c80:	b8 08 00 00 00       	mov    $0x8,%eax
    3c85:	cd 40                	int    $0x40
    3c87:	c3                   	ret    

00003c88 <link>:
    3c88:	b8 13 00 00 00       	mov    $0x13,%eax
    3c8d:	cd 40                	int    $0x40
    3c8f:	c3                   	ret    

00003c90 <mkdir>:
    3c90:	b8 14 00 00 00       	mov    $0x14,%eax
    3c95:	cd 40                	int    $0x40
    3c97:	c3                   	ret    

00003c98 <chdir>:
    3c98:	b8 09 00 00 00       	mov    $0x9,%eax
    3c9d:	cd 40                	int    $0x40
    3c9f:	c3                   	ret    

00003ca0 <dup>:
    3ca0:	b8 0a 00 00 00       	mov    $0xa,%eax
    3ca5:	cd 40                	int    $0x40
    3ca7:	c3                   	ret    

00003ca8 <getpid>:
    3ca8:	b8 0b 00 00 00       	mov    $0xb,%eax
    3cad:	cd 40                	int    $0x40
    3caf:	c3                   	ret    

00003cb0 <sbrk>:
    3cb0:	b8 0c 00 00 00       	mov    $0xc,%eax
    3cb5:	cd 40                	int    $0x40
    3cb7:	c3                   	ret    

00003cb8 <sleep>:
    3cb8:	b8 0d 00 00 00       	mov    $0xd,%eax
    3cbd:	cd 40                	int    $0x40
    3cbf:	c3                   	ret    

00003cc0 <uptime>:
    3cc0:	b8 0e 00 00 00       	mov    $0xe,%eax
    3cc5:	cd 40                	int    $0x40
    3cc7:	c3                   	ret    

00003cc8 <putc>:
    3cc8:	55                   	push   %ebp
    3cc9:	89 e5                	mov    %esp,%ebp
    3ccb:	83 ec 28             	sub    $0x28,%esp
    3cce:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cd1:	88 45 f4             	mov    %al,-0xc(%ebp)
    3cd4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3cdb:	00 
    3cdc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3cdf:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    3ce6:	89 04 24             	mov    %eax,(%esp)
    3ce9:	e8 5a ff ff ff       	call   3c48 <write>
    3cee:	c9                   	leave  
    3cef:	c3                   	ret    

00003cf0 <printint>:
    3cf0:	55                   	push   %ebp
    3cf1:	89 e5                	mov    %esp,%ebp
    3cf3:	53                   	push   %ebx
    3cf4:	83 ec 44             	sub    $0x44,%esp
    3cf7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3cfe:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3d02:	74 17                	je     3d1b <printint+0x2b>
    3d04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3d08:	79 11                	jns    3d1b <printint+0x2b>
    3d0a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    3d11:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d14:	f7 d8                	neg    %eax
    3d16:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3d19:	eb 06                	jmp    3d21 <printint+0x31>
    3d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3d21:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3d28:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3d2b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d31:	ba 00 00 00 00       	mov    $0x0,%edx
    3d36:	f7 f3                	div    %ebx
    3d38:	89 d0                	mov    %edx,%eax
    3d3a:	0f b6 80 20 5d 00 00 	movzbl 0x5d20(%eax),%eax
    3d41:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    3d45:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3d49:	8b 45 10             	mov    0x10(%ebp),%eax
    3d4c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d52:	ba 00 00 00 00       	mov    $0x0,%edx
    3d57:	f7 75 d4             	divl   -0x2c(%ebp)
    3d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3d5d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3d61:	75 c5                	jne    3d28 <printint+0x38>
    3d63:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d67:	74 28                	je     3d91 <printint+0xa1>
    3d69:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d6c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    3d71:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3d75:	eb 1a                	jmp    3d91 <printint+0xa1>
    3d77:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d7a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    3d7f:	0f be c0             	movsbl %al,%eax
    3d82:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d86:	8b 45 08             	mov    0x8(%ebp),%eax
    3d89:	89 04 24             	mov    %eax,(%esp)
    3d8c:	e8 37 ff ff ff       	call   3cc8 <putc>
    3d91:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    3d95:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3d99:	79 dc                	jns    3d77 <printint+0x87>
    3d9b:	83 c4 44             	add    $0x44,%esp
    3d9e:	5b                   	pop    %ebx
    3d9f:	5d                   	pop    %ebp
    3da0:	c3                   	ret    

00003da1 <printf>:
    3da1:	55                   	push   %ebp
    3da2:	89 e5                	mov    %esp,%ebp
    3da4:	83 ec 38             	sub    $0x38,%esp
    3da7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3dae:	8d 45 0c             	lea    0xc(%ebp),%eax
    3db1:	83 c0 04             	add    $0x4,%eax
    3db4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3db7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    3dbe:	e9 7e 01 00 00       	jmp    3f41 <printf+0x1a0>
    3dc3:	8b 55 0c             	mov    0xc(%ebp),%edx
    3dc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3dc9:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3dcc:	0f b6 00             	movzbl (%eax),%eax
    3dcf:	0f be c0             	movsbl %al,%eax
    3dd2:	25 ff 00 00 00       	and    $0xff,%eax
    3dd7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    3dda:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3dde:	75 2c                	jne    3e0c <printf+0x6b>
    3de0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    3de4:	75 0c                	jne    3df2 <printf+0x51>
    3de6:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    3ded:	e9 4b 01 00 00       	jmp    3f3d <printf+0x19c>
    3df2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3df5:	0f be c0             	movsbl %al,%eax
    3df8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3dfc:	8b 45 08             	mov    0x8(%ebp),%eax
    3dff:	89 04 24             	mov    %eax,(%esp)
    3e02:	e8 c1 fe ff ff       	call   3cc8 <putc>
    3e07:	e9 31 01 00 00       	jmp    3f3d <printf+0x19c>
    3e0c:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    3e10:	0f 85 27 01 00 00    	jne    3f3d <printf+0x19c>
    3e16:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    3e1a:	75 2d                	jne    3e49 <printf+0xa8>
    3e1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e1f:	8b 00                	mov    (%eax),%eax
    3e21:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    3e28:	00 
    3e29:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    3e30:	00 
    3e31:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e35:	8b 45 08             	mov    0x8(%ebp),%eax
    3e38:	89 04 24             	mov    %eax,(%esp)
    3e3b:	e8 b0 fe ff ff       	call   3cf0 <printint>
    3e40:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    3e44:	e9 ed 00 00 00       	jmp    3f36 <printf+0x195>
    3e49:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    3e4d:	74 06                	je     3e55 <printf+0xb4>
    3e4f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    3e53:	75 2d                	jne    3e82 <printf+0xe1>
    3e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e58:	8b 00                	mov    (%eax),%eax
    3e5a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    3e61:	00 
    3e62:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    3e69:	00 
    3e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e6e:	8b 45 08             	mov    0x8(%ebp),%eax
    3e71:	89 04 24             	mov    %eax,(%esp)
    3e74:	e8 77 fe ff ff       	call   3cf0 <printint>
    3e79:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    3e7d:	e9 b4 00 00 00       	jmp    3f36 <printf+0x195>
    3e82:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    3e86:	75 46                	jne    3ece <printf+0x12d>
    3e88:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e8b:	8b 00                	mov    (%eax),%eax
    3e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3e90:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    3e94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3e98:	75 27                	jne    3ec1 <printf+0x120>
    3e9a:	c7 45 e4 2a 58 00 00 	movl   $0x582a,-0x1c(%ebp)
    3ea1:	eb 1f                	jmp    3ec2 <printf+0x121>
    3ea3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ea6:	0f b6 00             	movzbl (%eax),%eax
    3ea9:	0f be c0             	movsbl %al,%eax
    3eac:	89 44 24 04          	mov    %eax,0x4(%esp)
    3eb0:	8b 45 08             	mov    0x8(%ebp),%eax
    3eb3:	89 04 24             	mov    %eax,(%esp)
    3eb6:	e8 0d fe ff ff       	call   3cc8 <putc>
    3ebb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    3ebf:	eb 01                	jmp    3ec2 <printf+0x121>
    3ec1:	90                   	nop
    3ec2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ec5:	0f b6 00             	movzbl (%eax),%eax
    3ec8:	84 c0                	test   %al,%al
    3eca:	75 d7                	jne    3ea3 <printf+0x102>
    3ecc:	eb 68                	jmp    3f36 <printf+0x195>
    3ece:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    3ed2:	75 1d                	jne    3ef1 <printf+0x150>
    3ed4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ed7:	8b 00                	mov    (%eax),%eax
    3ed9:	0f be c0             	movsbl %al,%eax
    3edc:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ee0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ee3:	89 04 24             	mov    %eax,(%esp)
    3ee6:	e8 dd fd ff ff       	call   3cc8 <putc>
    3eeb:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    3eef:	eb 45                	jmp    3f36 <printf+0x195>
    3ef1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    3ef5:	75 17                	jne    3f0e <printf+0x16d>
    3ef7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3efa:	0f be c0             	movsbl %al,%eax
    3efd:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f01:	8b 45 08             	mov    0x8(%ebp),%eax
    3f04:	89 04 24             	mov    %eax,(%esp)
    3f07:	e8 bc fd ff ff       	call   3cc8 <putc>
    3f0c:	eb 28                	jmp    3f36 <printf+0x195>
    3f0e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    3f15:	00 
    3f16:	8b 45 08             	mov    0x8(%ebp),%eax
    3f19:	89 04 24             	mov    %eax,(%esp)
    3f1c:	e8 a7 fd ff ff       	call   3cc8 <putc>
    3f21:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3f24:	0f be c0             	movsbl %al,%eax
    3f27:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f2b:	8b 45 08             	mov    0x8(%ebp),%eax
    3f2e:	89 04 24             	mov    %eax,(%esp)
    3f31:	e8 92 fd ff ff       	call   3cc8 <putc>
    3f36:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3f3d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    3f41:	8b 55 0c             	mov    0xc(%ebp),%edx
    3f44:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3f47:	8d 04 02             	lea    (%edx,%eax,1),%eax
    3f4a:	0f b6 00             	movzbl (%eax),%eax
    3f4d:	84 c0                	test   %al,%al
    3f4f:	0f 85 6e fe ff ff    	jne    3dc3 <printf+0x22>
    3f55:	c9                   	leave  
    3f56:	c3                   	ret    
    3f57:	90                   	nop

00003f58 <free>:
    3f58:	55                   	push   %ebp
    3f59:	89 e5                	mov    %esp,%ebp
    3f5b:	83 ec 10             	sub    $0x10,%esp
    3f5e:	8b 45 08             	mov    0x8(%ebp),%eax
    3f61:	83 e8 08             	sub    $0x8,%eax
    3f64:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3f67:	a1 c8 5d 00 00       	mov    0x5dc8,%eax
    3f6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f6f:	eb 24                	jmp    3f95 <free+0x3d>
    3f71:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f74:	8b 00                	mov    (%eax),%eax
    3f76:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f79:	77 12                	ja     3f8d <free+0x35>
    3f7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f7e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f81:	77 24                	ja     3fa7 <free+0x4f>
    3f83:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f86:	8b 00                	mov    (%eax),%eax
    3f88:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f8b:	77 1a                	ja     3fa7 <free+0x4f>
    3f8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f90:	8b 00                	mov    (%eax),%eax
    3f92:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f95:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f98:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f9b:	76 d4                	jbe    3f71 <free+0x19>
    3f9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fa0:	8b 00                	mov    (%eax),%eax
    3fa2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3fa5:	76 ca                	jbe    3f71 <free+0x19>
    3fa7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3faa:	8b 40 04             	mov    0x4(%eax),%eax
    3fad:	c1 e0 03             	shl    $0x3,%eax
    3fb0:	89 c2                	mov    %eax,%edx
    3fb2:	03 55 f8             	add    -0x8(%ebp),%edx
    3fb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fb8:	8b 00                	mov    (%eax),%eax
    3fba:	39 c2                	cmp    %eax,%edx
    3fbc:	75 24                	jne    3fe2 <free+0x8a>
    3fbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fc1:	8b 50 04             	mov    0x4(%eax),%edx
    3fc4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fc7:	8b 00                	mov    (%eax),%eax
    3fc9:	8b 40 04             	mov    0x4(%eax),%eax
    3fcc:	01 c2                	add    %eax,%edx
    3fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fd1:	89 50 04             	mov    %edx,0x4(%eax)
    3fd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fd7:	8b 00                	mov    (%eax),%eax
    3fd9:	8b 10                	mov    (%eax),%edx
    3fdb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fde:	89 10                	mov    %edx,(%eax)
    3fe0:	eb 0a                	jmp    3fec <free+0x94>
    3fe2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fe5:	8b 10                	mov    (%eax),%edx
    3fe7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fea:	89 10                	mov    %edx,(%eax)
    3fec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fef:	8b 40 04             	mov    0x4(%eax),%eax
    3ff2:	c1 e0 03             	shl    $0x3,%eax
    3ff5:	03 45 fc             	add    -0x4(%ebp),%eax
    3ff8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3ffb:	75 20                	jne    401d <free+0xc5>
    3ffd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4000:	8b 50 04             	mov    0x4(%eax),%edx
    4003:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4006:	8b 40 04             	mov    0x4(%eax),%eax
    4009:	01 c2                	add    %eax,%edx
    400b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    400e:	89 50 04             	mov    %edx,0x4(%eax)
    4011:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4014:	8b 10                	mov    (%eax),%edx
    4016:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4019:	89 10                	mov    %edx,(%eax)
    401b:	eb 08                	jmp    4025 <free+0xcd>
    401d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4020:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4023:	89 10                	mov    %edx,(%eax)
    4025:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4028:	a3 c8 5d 00 00       	mov    %eax,0x5dc8
    402d:	c9                   	leave  
    402e:	c3                   	ret    

0000402f <morecore>:
    402f:	55                   	push   %ebp
    4030:	89 e5                	mov    %esp,%ebp
    4032:	83 ec 28             	sub    $0x28,%esp
    4035:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    403c:	77 07                	ja     4045 <morecore+0x16>
    403e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    4045:	8b 45 08             	mov    0x8(%ebp),%eax
    4048:	c1 e0 03             	shl    $0x3,%eax
    404b:	89 04 24             	mov    %eax,(%esp)
    404e:	e8 5d fc ff ff       	call   3cb0 <sbrk>
    4053:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4056:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    405a:	75 07                	jne    4063 <morecore+0x34>
    405c:	b8 00 00 00 00       	mov    $0x0,%eax
    4061:	eb 22                	jmp    4085 <morecore+0x56>
    4063:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4066:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4069:	8b 45 f0             	mov    -0x10(%ebp),%eax
    406c:	8b 55 08             	mov    0x8(%ebp),%edx
    406f:	89 50 04             	mov    %edx,0x4(%eax)
    4072:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4075:	83 c0 08             	add    $0x8,%eax
    4078:	89 04 24             	mov    %eax,(%esp)
    407b:	e8 d8 fe ff ff       	call   3f58 <free>
    4080:	a1 c8 5d 00 00       	mov    0x5dc8,%eax
    4085:	c9                   	leave  
    4086:	c3                   	ret    

00004087 <malloc>:
    4087:	55                   	push   %ebp
    4088:	89 e5                	mov    %esp,%ebp
    408a:	83 ec 28             	sub    $0x28,%esp
    408d:	8b 45 08             	mov    0x8(%ebp),%eax
    4090:	83 c0 07             	add    $0x7,%eax
    4093:	c1 e8 03             	shr    $0x3,%eax
    4096:	83 c0 01             	add    $0x1,%eax
    4099:	89 45 ec             	mov    %eax,-0x14(%ebp)
    409c:	a1 c8 5d 00 00       	mov    0x5dc8,%eax
    40a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    40a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40a8:	75 23                	jne    40cd <malloc+0x46>
    40aa:	c7 45 f0 c0 5d 00 00 	movl   $0x5dc0,-0x10(%ebp)
    40b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40b4:	a3 c8 5d 00 00       	mov    %eax,0x5dc8
    40b9:	a1 c8 5d 00 00       	mov    0x5dc8,%eax
    40be:	a3 c0 5d 00 00       	mov    %eax,0x5dc0
    40c3:	c7 05 c4 5d 00 00 00 	movl   $0x0,0x5dc4
    40ca:	00 00 00 
    40cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40d0:	8b 00                	mov    (%eax),%eax
    40d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    40d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40d8:	8b 40 04             	mov    0x4(%eax),%eax
    40db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    40de:	72 4d                	jb     412d <malloc+0xa6>
    40e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40e3:	8b 40 04             	mov    0x4(%eax),%eax
    40e6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    40e9:	75 0c                	jne    40f7 <malloc+0x70>
    40eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ee:	8b 10                	mov    (%eax),%edx
    40f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40f3:	89 10                	mov    %edx,(%eax)
    40f5:	eb 26                	jmp    411d <malloc+0x96>
    40f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40fa:	8b 40 04             	mov    0x4(%eax),%eax
    40fd:	89 c2                	mov    %eax,%edx
    40ff:	2b 55 ec             	sub    -0x14(%ebp),%edx
    4102:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4105:	89 50 04             	mov    %edx,0x4(%eax)
    4108:	8b 45 f4             	mov    -0xc(%ebp),%eax
    410b:	8b 40 04             	mov    0x4(%eax),%eax
    410e:	c1 e0 03             	shl    $0x3,%eax
    4111:	01 45 f4             	add    %eax,-0xc(%ebp)
    4114:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4117:	8b 55 ec             	mov    -0x14(%ebp),%edx
    411a:	89 50 04             	mov    %edx,0x4(%eax)
    411d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4120:	a3 c8 5d 00 00       	mov    %eax,0x5dc8
    4125:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4128:	83 c0 08             	add    $0x8,%eax
    412b:	eb 38                	jmp    4165 <malloc+0xde>
    412d:	a1 c8 5d 00 00       	mov    0x5dc8,%eax
    4132:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4135:	75 1b                	jne    4152 <malloc+0xcb>
    4137:	8b 45 ec             	mov    -0x14(%ebp),%eax
    413a:	89 04 24             	mov    %eax,(%esp)
    413d:	e8 ed fe ff ff       	call   402f <morecore>
    4142:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4145:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4149:	75 07                	jne    4152 <malloc+0xcb>
    414b:	b8 00 00 00 00       	mov    $0x0,%eax
    4150:	eb 13                	jmp    4165 <malloc+0xde>
    4152:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4155:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4158:	8b 45 f4             	mov    -0xc(%ebp),%eax
    415b:	8b 00                	mov    (%eax),%eax
    415d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4160:	e9 70 ff ff ff       	jmp    40d5 <malloc+0x4e>
    4165:	c9                   	leave  
    4166:	c3                   	ret    
