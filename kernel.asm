
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp
8010002d:	b8 e8 33 10 80       	mov    $0x801033e8,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 58 81 10 	movl   $0x80108158,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100049:	e8 00 4b 00 00       	call   80104b4e <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 90 db 10 80 84 	movl   $0x8010db84,0x8010db90
80100055:	db 10 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 94 db 10 80 84 	movl   $0x8010db84,0x8010db94
8010005f:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 94 db 10 80    	mov    0x8010db94,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c 84 db 10 80 	movl   $0x8010db84,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 94 db 10 80       	mov    0x8010db94,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 94 db 10 80       	mov    %eax,0x8010db94

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	b8 84 db 10 80       	mov    $0x8010db84,%eax
801000aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ad:	72 bc                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801000be:	e8 ac 4a 00 00       	call   80104b6f <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c3:	a1 94 db 10 80       	mov    0x8010db94,%eax
801000c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cb:	eb 63                	jmp    80100130 <bget+0x7f>
    if(b->dev == dev && b->sector == sector){
801000cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d0:	8b 40 04             	mov    0x4(%eax),%eax
801000d3:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d6:	75 4f                	jne    80100127 <bget+0x76>
801000d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000db:	8b 40 08             	mov    0x8(%eax),%eax
801000de:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e1:	75 44                	jne    80100127 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e6:	8b 00                	mov    (%eax),%eax
801000e8:	83 e0 01             	and    $0x1,%eax
801000eb:	85 c0                	test   %eax,%eax
801000ed:	75 23                	jne    80100112 <bget+0x61>
        b->flags |= B_BUSY;
801000ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f2:	8b 00                	mov    (%eax),%eax
801000f4:	89 c2                	mov    %eax,%edx
801000f6:	83 ca 01             	or     $0x1,%edx
801000f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fc:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fe:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100105:	e8 c6 4a 00 00       	call   80104bd0 <release>
        return b;
8010010a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010d:	e9 93 00 00 00       	jmp    801001a5 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100112:	c7 44 24 04 60 c6 10 	movl   $0x8010c660,0x4(%esp)
80100119:	80 
8010011a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011d:	89 04 24             	mov    %eax,(%esp)
80100120:	e8 78 47 00 00       	call   8010489d <sleep>
      goto loop;
80100125:	eb 9c                	jmp    801000c3 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100127:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012a:	8b 40 10             	mov    0x10(%eax),%eax
8010012d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100130:	81 7d f4 84 db 10 80 	cmpl   $0x8010db84,-0xc(%ebp)
80100137:	75 94                	jne    801000cd <bget+0x1c>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100139:	a1 90 db 10 80       	mov    0x8010db90,%eax
8010013e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100141:	eb 4d                	jmp    80100190 <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100146:	8b 00                	mov    (%eax),%eax
80100148:	83 e0 01             	and    $0x1,%eax
8010014b:	85 c0                	test   %eax,%eax
8010014d:	75 38                	jne    80100187 <bget+0xd6>
8010014f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100152:	8b 00                	mov    (%eax),%eax
80100154:	83 e0 04             	and    $0x4,%eax
80100157:	85 c0                	test   %eax,%eax
80100159:	75 2c                	jne    80100187 <bget+0xd6>
      b->dev = dev;
8010015b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015e:	8b 55 08             	mov    0x8(%ebp),%edx
80100161:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100164:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100167:	8b 55 0c             	mov    0xc(%ebp),%edx
8010016a:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100170:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100176:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010017d:	e8 4e 4a 00 00       	call   80104bd0 <release>
      return b;
80100182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100185:	eb 1e                	jmp    801001a5 <bget+0xf4>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100187:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010018a:	8b 40 0c             	mov    0xc(%eax),%eax
8010018d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100190:	81 7d f4 84 db 10 80 	cmpl   $0x8010db84,-0xc(%ebp)
80100197:	75 aa                	jne    80100143 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100199:	c7 04 24 5f 81 10 80 	movl   $0x8010815f,(%esp)
801001a0:	e8 95 03 00 00       	call   8010053a <panic>
}
801001a5:	c9                   	leave  
801001a6:	c3                   	ret    

801001a7 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001a7:	55                   	push   %ebp
801001a8:	89 e5                	mov    %esp,%ebp
801001aa:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801001b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b4:	8b 45 08             	mov    0x8(%ebp),%eax
801001b7:	89 04 24             	mov    %eax,(%esp)
801001ba:	e8 f2 fe ff ff       	call   801000b1 <bget>
801001bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c5:	8b 00                	mov    (%eax),%eax
801001c7:	83 e0 02             	and    $0x2,%eax
801001ca:	85 c0                	test   %eax,%eax
801001cc:	75 0b                	jne    801001d9 <bread+0x32>
    iderw(b);
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	89 04 24             	mov    %eax,(%esp)
801001d4:	e8 dd 25 00 00       	call   801027b6 <iderw>
  return b;
801001d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001dc:	c9                   	leave  
801001dd:	c3                   	ret    

801001de <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001de:	55                   	push   %ebp
801001df:	89 e5                	mov    %esp,%ebp
801001e1:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e4:	8b 45 08             	mov    0x8(%ebp),%eax
801001e7:	8b 00                	mov    (%eax),%eax
801001e9:	83 e0 01             	and    $0x1,%eax
801001ec:	85 c0                	test   %eax,%eax
801001ee:	75 0c                	jne    801001fc <bwrite+0x1e>
    panic("bwrite");
801001f0:	c7 04 24 70 81 10 80 	movl   $0x80108170,(%esp)
801001f7:	e8 3e 03 00 00       	call   8010053a <panic>
  b->flags |= B_DIRTY;
801001fc:	8b 45 08             	mov    0x8(%ebp),%eax
801001ff:	8b 00                	mov    (%eax),%eax
80100201:	89 c2                	mov    %eax,%edx
80100203:	83 ca 04             	or     $0x4,%edx
80100206:	8b 45 08             	mov    0x8(%ebp),%eax
80100209:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020b:	8b 45 08             	mov    0x8(%ebp),%eax
8010020e:	89 04 24             	mov    %eax,(%esp)
80100211:	e8 a0 25 00 00       	call   801027b6 <iderw>
}
80100216:	c9                   	leave  
80100217:	c3                   	ret    

80100218 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100218:	55                   	push   %ebp
80100219:	89 e5                	mov    %esp,%ebp
8010021b:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021e:	8b 45 08             	mov    0x8(%ebp),%eax
80100221:	8b 00                	mov    (%eax),%eax
80100223:	83 e0 01             	and    $0x1,%eax
80100226:	85 c0                	test   %eax,%eax
80100228:	75 0c                	jne    80100236 <brelse+0x1e>
    panic("brelse");
8010022a:	c7 04 24 77 81 10 80 	movl   $0x80108177,(%esp)
80100231:	e8 04 03 00 00       	call   8010053a <panic>

  acquire(&bcache.lock);
80100236:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010023d:	e8 2d 49 00 00       	call   80104b6f <acquire>

  b->next->prev = b->prev;
80100242:	8b 45 08             	mov    0x8(%ebp),%eax
80100245:	8b 40 10             	mov    0x10(%eax),%eax
80100248:	8b 55 08             	mov    0x8(%ebp),%edx
8010024b:	8b 52 0c             	mov    0xc(%edx),%edx
8010024e:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100251:	8b 45 08             	mov    0x8(%ebp),%eax
80100254:	8b 40 0c             	mov    0xc(%eax),%eax
80100257:	8b 55 08             	mov    0x8(%ebp),%edx
8010025a:	8b 52 10             	mov    0x10(%edx),%edx
8010025d:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100260:	8b 15 94 db 10 80    	mov    0x8010db94,%edx
80100266:	8b 45 08             	mov    0x8(%ebp),%eax
80100269:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	c7 40 0c 84 db 10 80 	movl   $0x8010db84,0xc(%eax)
  bcache.head.next->prev = b;
80100276:	a1 94 db 10 80       	mov    0x8010db94,%eax
8010027b:	8b 55 08             	mov    0x8(%ebp),%edx
8010027e:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	a3 94 db 10 80       	mov    %eax,0x8010db94

  b->flags &= ~B_BUSY;
80100289:	8b 45 08             	mov    0x8(%ebp),%eax
8010028c:	8b 00                	mov    (%eax),%eax
8010028e:	89 c2                	mov    %eax,%edx
80100290:	83 e2 fe             	and    $0xfffffffe,%edx
80100293:	8b 45 08             	mov    0x8(%ebp),%eax
80100296:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100298:	8b 45 08             	mov    0x8(%ebp),%eax
8010029b:	89 04 24             	mov    %eax,(%esp)
8010029e:	e8 d4 46 00 00       	call   80104977 <wakeup>

  release(&bcache.lock);
801002a3:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801002aa:	e8 21 49 00 00       	call   80104bd0 <release>
}
801002af:	c9                   	leave  
801002b0:	c3                   	ret    
801002b1:	00 00                	add    %al,(%eax)
	...

801002b4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b4:	55                   	push   %ebp
801002b5:	89 e5                	mov    %esp,%ebp
801002b7:	83 ec 14             	sub    $0x14,%esp
801002ba:	8b 45 08             	mov    0x8(%ebp),%eax
801002bd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002c1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002c5:	89 c2                	mov    %eax,%edx
801002c7:	ec                   	in     (%dx),%al
801002c8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002cb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002cf:	c9                   	leave  
801002d0:	c3                   	ret    

801002d1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002d1:	55                   	push   %ebp
801002d2:	89 e5                	mov    %esp,%ebp
801002d4:	83 ec 08             	sub    $0x8,%esp
801002d7:	8b 55 08             	mov    0x8(%ebp),%edx
801002da:	8b 45 0c             	mov    0xc(%ebp),%eax
801002dd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002e1:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002e4:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002e8:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002ec:	ee                   	out    %al,(%dx)
}
801002ed:	c9                   	leave  
801002ee:	c3                   	ret    

801002ef <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002ef:	55                   	push   %ebp
801002f0:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002f2:	fa                   	cli    
}
801002f3:	5d                   	pop    %ebp
801002f4:	c3                   	ret    

801002f5 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002f5:	55                   	push   %ebp
801002f6:	89 e5                	mov    %esp,%ebp
801002f8:	53                   	push   %ebx
801002f9:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801002fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100300:	74 19                	je     8010031b <printint+0x26>
80100302:	8b 45 08             	mov    0x8(%ebp),%eax
80100305:	c1 e8 1f             	shr    $0x1f,%eax
80100308:	89 45 10             	mov    %eax,0x10(%ebp)
8010030b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010030f:	74 0a                	je     8010031b <printint+0x26>
    x = -xx;
80100311:	8b 45 08             	mov    0x8(%ebp),%eax
80100314:	f7 d8                	neg    %eax
80100316:	89 45 f4             	mov    %eax,-0xc(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100319:	eb 06                	jmp    80100321 <printint+0x2c>
    x = -xx;
  else
    x = xx;
8010031b:	8b 45 08             	mov    0x8(%ebp),%eax
8010031e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  i = 0;
80100321:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  do{
    buf[i++] = digits[x % base];
80100328:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010032b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100331:	ba 00 00 00 00       	mov    $0x0,%edx
80100336:	f7 f3                	div    %ebx
80100338:	89 d0                	mov    %edx,%eax
8010033a:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100341:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
80100345:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }while((x /= base) != 0);
80100349:	8b 45 0c             	mov    0xc(%ebp),%eax
8010034c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010034f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100352:	ba 00 00 00 00       	mov    $0x0,%edx
80100357:	f7 75 d4             	divl   -0x2c(%ebp)
8010035a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010035d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100361:	75 c5                	jne    80100328 <printint+0x33>

  if(sign)
80100363:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100367:	74 21                	je     8010038a <printint+0x95>
    buf[i++] = '-';
80100369:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010036c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
80100371:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

  while(--i >= 0)
80100375:	eb 13                	jmp    8010038a <printint+0x95>
    consputc(buf[i]);
80100377:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010037a:	0f b6 44 05 e0       	movzbl -0x20(%ebp,%eax,1),%eax
8010037f:	0f be c0             	movsbl %al,%eax
80100382:	89 04 24             	mov    %eax,(%esp)
80100385:	e8 c7 03 00 00       	call   80100751 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010038a:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
8010038e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100392:	79 e3                	jns    80100377 <printint+0x82>
    consputc(buf[i]);
}
80100394:	83 c4 44             	add    $0x44,%esp
80100397:	5b                   	pop    %ebx
80100398:	5d                   	pop    %ebp
80100399:	c3                   	ret    

8010039a <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
8010039a:	55                   	push   %ebp
8010039b:	89 e5                	mov    %esp,%ebp
8010039d:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a0:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(locking)
801003a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801003ac:	74 0c                	je     801003ba <cprintf+0x20>
    acquire(&cons.lock);
801003ae:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801003b5:	e8 b5 47 00 00       	call   80104b6f <acquire>

  if (fmt == 0)
801003ba:	8b 45 08             	mov    0x8(%ebp),%eax
801003bd:	85 c0                	test   %eax,%eax
801003bf:	75 0c                	jne    801003cd <cprintf+0x33>
    panic("null fmt");
801003c1:	c7 04 24 7e 81 10 80 	movl   $0x8010817e,(%esp)
801003c8:	e8 6d 01 00 00       	call   8010053a <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003cd:	8d 45 08             	lea    0x8(%ebp),%eax
801003d0:	83 c0 04             	add    $0x4,%eax
801003d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801003dd:	e9 20 01 00 00       	jmp    80100502 <cprintf+0x168>
    if(c != '%'){
801003e2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
801003e6:	74 10                	je     801003f8 <cprintf+0x5e>
      consputc(c);
801003e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801003eb:	89 04 24             	mov    %eax,(%esp)
801003ee:	e8 5e 03 00 00       	call   80100751 <consputc>
      continue;
801003f3:	e9 06 01 00 00       	jmp    801004fe <cprintf+0x164>
    }
    c = fmt[++i] & 0xff;
801003f8:	8b 55 08             	mov    0x8(%ebp),%edx
801003fb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801003ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100402:	8d 04 02             	lea    (%edx,%eax,1),%eax
80100405:	0f b6 00             	movzbl (%eax),%eax
80100408:	0f be c0             	movsbl %al,%eax
8010040b:	25 ff 00 00 00       	and    $0xff,%eax
80100410:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(c == 0)
80100413:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100417:	0f 84 08 01 00 00    	je     80100525 <cprintf+0x18b>
      break;
    switch(c){
8010041d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100420:	83 f8 70             	cmp    $0x70,%eax
80100423:	74 4d                	je     80100472 <cprintf+0xd8>
80100425:	83 f8 70             	cmp    $0x70,%eax
80100428:	7f 13                	jg     8010043d <cprintf+0xa3>
8010042a:	83 f8 25             	cmp    $0x25,%eax
8010042d:	0f 84 a6 00 00 00    	je     801004d9 <cprintf+0x13f>
80100433:	83 f8 64             	cmp    $0x64,%eax
80100436:	74 14                	je     8010044c <cprintf+0xb2>
80100438:	e9 aa 00 00 00       	jmp    801004e7 <cprintf+0x14d>
8010043d:	83 f8 73             	cmp    $0x73,%eax
80100440:	74 53                	je     80100495 <cprintf+0xfb>
80100442:	83 f8 78             	cmp    $0x78,%eax
80100445:	74 2b                	je     80100472 <cprintf+0xd8>
80100447:	e9 9b 00 00 00       	jmp    801004e7 <cprintf+0x14d>
    case 'd':
      printint(*argp++, 10, 1);
8010044c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010044f:	8b 00                	mov    (%eax),%eax
80100451:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100455:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
8010045c:	00 
8010045d:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100464:	00 
80100465:	89 04 24             	mov    %eax,(%esp)
80100468:	e8 88 fe ff ff       	call   801002f5 <printint>
      break;
8010046d:	e9 8c 00 00 00       	jmp    801004fe <cprintf+0x164>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100472:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100475:	8b 00                	mov    (%eax),%eax
80100477:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
8010047b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100482:	00 
80100483:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
8010048a:	00 
8010048b:	89 04 24             	mov    %eax,(%esp)
8010048e:	e8 62 fe ff ff       	call   801002f5 <printint>
      break;
80100493:	eb 69                	jmp    801004fe <cprintf+0x164>
    case 's':
      if((s = (char*)*argp++) == 0)
80100495:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100498:	8b 00                	mov    (%eax),%eax
8010049a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010049d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801004a1:	0f 94 c0             	sete   %al
801004a4:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
801004a8:	84 c0                	test   %al,%al
801004aa:	74 20                	je     801004cc <cprintf+0x132>
        s = "(null)";
801004ac:	c7 45 f4 87 81 10 80 	movl   $0x80108187,-0xc(%ebp)
      for(; *s; s++)
801004b3:	eb 18                	jmp    801004cd <cprintf+0x133>
        consputc(*s);
801004b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801004b8:	0f b6 00             	movzbl (%eax),%eax
801004bb:	0f be c0             	movsbl %al,%eax
801004be:	89 04 24             	mov    %eax,(%esp)
801004c1:	e8 8b 02 00 00       	call   80100751 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801004ca:	eb 01                	jmp    801004cd <cprintf+0x133>
801004cc:	90                   	nop
801004cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801004d0:	0f b6 00             	movzbl (%eax),%eax
801004d3:	84 c0                	test   %al,%al
801004d5:	75 de                	jne    801004b5 <cprintf+0x11b>
        consputc(*s);
      break;
801004d7:	eb 25                	jmp    801004fe <cprintf+0x164>
    case '%':
      consputc('%');
801004d9:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e0:	e8 6c 02 00 00       	call   80100751 <consputc>
      break;
801004e5:	eb 17                	jmp    801004fe <cprintf+0x164>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004e7:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004ee:	e8 5e 02 00 00       	call   80100751 <consputc>
      consputc(c);
801004f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801004f6:	89 04 24             	mov    %eax,(%esp)
801004f9:	e8 53 02 00 00       	call   80100751 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801004fe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100502:	8b 55 08             	mov    0x8(%ebp),%edx
80100505:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100508:	8d 04 02             	lea    (%edx,%eax,1),%eax
8010050b:	0f b6 00             	movzbl (%eax),%eax
8010050e:	0f be c0             	movsbl %al,%eax
80100511:	25 ff 00 00 00       	and    $0xff,%eax
80100516:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100519:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010051d:	0f 85 bf fe ff ff    	jne    801003e2 <cprintf+0x48>
80100523:	eb 01                	jmp    80100526 <cprintf+0x18c>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100525:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100526:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010052a:	74 0c                	je     80100538 <cprintf+0x19e>
    release(&cons.lock);
8010052c:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100533:	e8 98 46 00 00       	call   80104bd0 <release>
}
80100538:	c9                   	leave  
80100539:	c3                   	ret    

8010053a <panic>:

void
panic(char *s)
{
8010053a:	55                   	push   %ebp
8010053b:	89 e5                	mov    %esp,%ebp
8010053d:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100540:	e8 aa fd ff ff       	call   801002ef <cli>
  cons.locking = 0;
80100545:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
8010054c:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010054f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100555:	0f b6 00             	movzbl (%eax),%eax
80100558:	0f b6 c0             	movzbl %al,%eax
8010055b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010055f:	c7 04 24 8e 81 10 80 	movl   $0x8010818e,(%esp)
80100566:	e8 2f fe ff ff       	call   8010039a <cprintf>
  cprintf(s);
8010056b:	8b 45 08             	mov    0x8(%ebp),%eax
8010056e:	89 04 24             	mov    %eax,(%esp)
80100571:	e8 24 fe ff ff       	call   8010039a <cprintf>
  cprintf("\n");
80100576:	c7 04 24 9d 81 10 80 	movl   $0x8010819d,(%esp)
8010057d:	e8 18 fe ff ff       	call   8010039a <cprintf>
  getcallerpcs(&s, pcs);
80100582:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100585:	89 44 24 04          	mov    %eax,0x4(%esp)
80100589:	8d 45 08             	lea    0x8(%ebp),%eax
8010058c:	89 04 24             	mov    %eax,(%esp)
8010058f:	e8 8b 46 00 00       	call   80104c1f <getcallerpcs>
  for(i=0; i<10; i++)
80100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059b:	eb 1b                	jmp    801005b8 <panic+0x7e>
    cprintf(" %p", pcs[i]);
8010059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801005a8:	c7 04 24 9f 81 10 80 	movl   $0x8010819f,(%esp)
801005af:	e8 e6 fd ff ff       	call   8010039a <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005b8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bc:	7e df                	jle    8010059d <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005be:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005c5:	00 00 00 
  for(;;)
    ;
801005c8:	eb fe                	jmp    801005c8 <panic+0x8e>

801005ca <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005ca:	55                   	push   %ebp
801005cb:	89 e5                	mov    %esp,%ebp
801005cd:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d0:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005d7:	00 
801005d8:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005df:	e8 ed fc ff ff       	call   801002d1 <outb>
  pos = inb(CRTPORT+1) << 8;
801005e4:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005eb:	e8 c4 fc ff ff       	call   801002b4 <inb>
801005f0:	0f b6 c0             	movzbl %al,%eax
801005f3:	c1 e0 08             	shl    $0x8,%eax
801005f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005f9:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100600:	00 
80100601:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100608:	e8 c4 fc ff ff       	call   801002d1 <outb>
  pos |= inb(CRTPORT+1);
8010060d:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100614:	e8 9b fc ff ff       	call   801002b4 <inb>
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010061f:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100623:	75 30                	jne    80100655 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100625:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100628:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010062d:	89 c8                	mov    %ecx,%eax
8010062f:	f7 ea                	imul   %edx
80100631:	c1 fa 05             	sar    $0x5,%edx
80100634:	89 c8                	mov    %ecx,%eax
80100636:	c1 f8 1f             	sar    $0x1f,%eax
80100639:	29 c2                	sub    %eax,%edx
8010063b:	89 d0                	mov    %edx,%eax
8010063d:	c1 e0 02             	shl    $0x2,%eax
80100640:	01 d0                	add    %edx,%eax
80100642:	c1 e0 04             	shl    $0x4,%eax
80100645:	89 ca                	mov    %ecx,%edx
80100647:	29 c2                	sub    %eax,%edx
80100649:	b8 50 00 00 00       	mov    $0x50,%eax
8010064e:	29 d0                	sub    %edx,%eax
80100650:	01 45 f4             	add    %eax,-0xc(%ebp)
80100653:	eb 36                	jmp    8010068b <cgaputc+0xc1>
  else if(c == BACKSPACE){
80100655:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065c:	75 0c                	jne    8010066a <cgaputc+0xa0>
    if(pos > 0) --pos;
8010065e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100662:	7e 26                	jle    8010068a <cgaputc+0xc0>
80100664:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100668:	eb 21                	jmp    8010068b <cgaputc+0xc1>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010066a:	a1 00 90 10 80       	mov    0x80109000,%eax
8010066f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100672:	01 d2                	add    %edx,%edx
80100674:	8d 14 10             	lea    (%eax,%edx,1),%edx
80100677:	8b 45 08             	mov    0x8(%ebp),%eax
8010067a:	66 25 ff 00          	and    $0xff,%ax
8010067e:	80 cc 07             	or     $0x7,%ah
80100681:	66 89 02             	mov    %ax,(%edx)
80100684:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100688:	eb 01                	jmp    8010068b <cgaputc+0xc1>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010068a:	90                   	nop
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
8010068b:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100692:	7e 53                	jle    801006e7 <cgaputc+0x11d>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100694:	a1 00 90 10 80       	mov    0x80109000,%eax
80100699:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010069f:	a1 00 90 10 80       	mov    0x80109000,%eax
801006a4:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006ab:	00 
801006ac:	89 54 24 04          	mov    %edx,0x4(%esp)
801006b0:	89 04 24             	mov    %eax,(%esp)
801006b3:	e8 d9 47 00 00       	call   80104e91 <memmove>
    pos -= 80;
801006b8:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006bc:	b8 80 07 00 00       	mov    $0x780,%eax
801006c1:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006c4:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006c7:	a1 00 90 10 80       	mov    0x80109000,%eax
801006cc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006cf:	01 c9                	add    %ecx,%ecx
801006d1:	01 c8                	add    %ecx,%eax
801006d3:	89 54 24 08          	mov    %edx,0x8(%esp)
801006d7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801006de:	00 
801006df:	89 04 24             	mov    %eax,(%esp)
801006e2:	e8 d7 46 00 00       	call   80104dbe <memset>
  }
  
  outb(CRTPORT, 14);
801006e7:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801006ee:	00 
801006ef:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801006f6:	e8 d6 fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT+1, pos>>8);
801006fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006fe:	c1 f8 08             	sar    $0x8,%eax
80100701:	0f b6 c0             	movzbl %al,%eax
80100704:	89 44 24 04          	mov    %eax,0x4(%esp)
80100708:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010070f:	e8 bd fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT, 15);
80100714:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
8010071b:	00 
8010071c:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100723:	e8 a9 fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT+1, pos);
80100728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010072b:	0f b6 c0             	movzbl %al,%eax
8010072e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100732:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100739:	e8 93 fb ff ff       	call   801002d1 <outb>
  crt[pos] = ' ' | 0x0700;
8010073e:	a1 00 90 10 80       	mov    0x80109000,%eax
80100743:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100746:	01 d2                	add    %edx,%edx
80100748:	01 d0                	add    %edx,%eax
8010074a:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010074f:	c9                   	leave  
80100750:	c3                   	ret    

80100751 <consputc>:

void
consputc(int c)
{
80100751:	55                   	push   %ebp
80100752:	89 e5                	mov    %esp,%ebp
80100754:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100757:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010075c:	85 c0                	test   %eax,%eax
8010075e:	74 07                	je     80100767 <consputc+0x16>
    cli();
80100760:	e8 8a fb ff ff       	call   801002ef <cli>
    for(;;)
      ;
80100765:	eb fe                	jmp    80100765 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100767:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010076e:	75 26                	jne    80100796 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100770:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100777:	e8 3c 60 00 00       	call   801067b8 <uartputc>
8010077c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100783:	e8 30 60 00 00       	call   801067b8 <uartputc>
80100788:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078f:	e8 24 60 00 00       	call   801067b8 <uartputc>
80100794:	eb 0b                	jmp    801007a1 <consputc+0x50>
  } else
    uartputc(c);
80100796:	8b 45 08             	mov    0x8(%ebp),%eax
80100799:	89 04 24             	mov    %eax,(%esp)
8010079c:	e8 17 60 00 00       	call   801067b8 <uartputc>
  cgaputc(c);
801007a1:	8b 45 08             	mov    0x8(%ebp),%eax
801007a4:	89 04 24             	mov    %eax,(%esp)
801007a7:	e8 1e fe ff ff       	call   801005ca <cgaputc>
}
801007ac:	c9                   	leave  
801007ad:	c3                   	ret    

801007ae <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007ae:	55                   	push   %ebp
801007af:	89 e5                	mov    %esp,%ebp
801007b1:	83 ec 28             	sub    $0x28,%esp
  int c;

  acquire(&input.lock);
801007b4:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
801007bb:	e8 af 43 00 00       	call   80104b6f <acquire>
  while((c = getc()) >= 0){
801007c0:	e9 3e 01 00 00       	jmp    80100903 <consoleintr+0x155>
    switch(c){
801007c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007c8:	83 f8 10             	cmp    $0x10,%eax
801007cb:	74 1e                	je     801007eb <consoleintr+0x3d>
801007cd:	83 f8 10             	cmp    $0x10,%eax
801007d0:	7f 0a                	jg     801007dc <consoleintr+0x2e>
801007d2:	83 f8 08             	cmp    $0x8,%eax
801007d5:	74 68                	je     8010083f <consoleintr+0x91>
801007d7:	e9 94 00 00 00       	jmp    80100870 <consoleintr+0xc2>
801007dc:	83 f8 15             	cmp    $0x15,%eax
801007df:	74 2f                	je     80100810 <consoleintr+0x62>
801007e1:	83 f8 7f             	cmp    $0x7f,%eax
801007e4:	74 59                	je     8010083f <consoleintr+0x91>
801007e6:	e9 85 00 00 00       	jmp    80100870 <consoleintr+0xc2>
    case C('P'):  // Process listing.
      procdump();
801007eb:	e8 2b 42 00 00       	call   80104a1b <procdump>
      break;
801007f0:	e9 0e 01 00 00       	jmp    80100903 <consoleintr+0x155>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801007f5:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801007fa:	83 e8 01             	sub    $0x1,%eax
801007fd:	a3 5c de 10 80       	mov    %eax,0x8010de5c
        consputc(BACKSPACE);
80100802:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100809:	e8 43 ff ff ff       	call   80100751 <consputc>
8010080e:	eb 01                	jmp    80100811 <consoleintr+0x63>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100810:	90                   	nop
80100811:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
80100817:	a1 58 de 10 80       	mov    0x8010de58,%eax
8010081c:	39 c2                	cmp    %eax,%edx
8010081e:	0f 84 db 00 00 00    	je     801008ff <consoleintr+0x151>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100824:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100829:	83 e8 01             	sub    $0x1,%eax
8010082c:	83 e0 7f             	and    $0x7f,%eax
8010082f:	0f b6 80 d4 dd 10 80 	movzbl -0x7fef222c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100836:	3c 0a                	cmp    $0xa,%al
80100838:	75 bb                	jne    801007f5 <consoleintr+0x47>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010083a:	e9 c4 00 00 00       	jmp    80100903 <consoleintr+0x155>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010083f:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
80100845:	a1 58 de 10 80       	mov    0x8010de58,%eax
8010084a:	39 c2                	cmp    %eax,%edx
8010084c:	0f 84 b0 00 00 00    	je     80100902 <consoleintr+0x154>
        input.e--;
80100852:	a1 5c de 10 80       	mov    0x8010de5c,%eax
80100857:	83 e8 01             	sub    $0x1,%eax
8010085a:	a3 5c de 10 80       	mov    %eax,0x8010de5c
        consputc(BACKSPACE);
8010085f:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100866:	e8 e6 fe ff ff       	call   80100751 <consputc>
      }
      break;
8010086b:	e9 93 00 00 00       	jmp    80100903 <consoleintr+0x155>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100870:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100874:	0f 84 89 00 00 00    	je     80100903 <consoleintr+0x155>
8010087a:	8b 15 5c de 10 80    	mov    0x8010de5c,%edx
80100880:	a1 54 de 10 80       	mov    0x8010de54,%eax
80100885:	89 d1                	mov    %edx,%ecx
80100887:	29 c1                	sub    %eax,%ecx
80100889:	89 c8                	mov    %ecx,%eax
8010088b:	83 f8 7f             	cmp    $0x7f,%eax
8010088e:	77 73                	ja     80100903 <consoleintr+0x155>
        c = (c == '\r') ? '\n' : c;
80100890:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
80100894:	74 05                	je     8010089b <consoleintr+0xed>
80100896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100899:	eb 05                	jmp    801008a0 <consoleintr+0xf2>
8010089b:	b8 0a 00 00 00       	mov    $0xa,%eax
801008a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008a3:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801008a8:	89 c1                	mov    %eax,%ecx
801008aa:	83 e1 7f             	and    $0x7f,%ecx
801008ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008b0:	88 91 d4 dd 10 80    	mov    %dl,-0x7fef222c(%ecx)
801008b6:	83 c0 01             	add    $0x1,%eax
801008b9:	a3 5c de 10 80       	mov    %eax,0x8010de5c
        consputc(c);
801008be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008c1:	89 04 24             	mov    %eax,(%esp)
801008c4:	e8 88 fe ff ff       	call   80100751 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c9:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008cd:	74 18                	je     801008e7 <consoleintr+0x139>
801008cf:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801008d3:	74 12                	je     801008e7 <consoleintr+0x139>
801008d5:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801008da:	8b 15 54 de 10 80    	mov    0x8010de54,%edx
801008e0:	83 ea 80             	sub    $0xffffff80,%edx
801008e3:	39 d0                	cmp    %edx,%eax
801008e5:	75 1c                	jne    80100903 <consoleintr+0x155>
          input.w = input.e;
801008e7:	a1 5c de 10 80       	mov    0x8010de5c,%eax
801008ec:	a3 58 de 10 80       	mov    %eax,0x8010de58
          wakeup(&input.r);
801008f1:	c7 04 24 54 de 10 80 	movl   $0x8010de54,(%esp)
801008f8:	e8 7a 40 00 00       	call   80104977 <wakeup>
801008fd:	eb 04                	jmp    80100903 <consoleintr+0x155>
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008ff:	90                   	nop
80100900:	eb 01                	jmp    80100903 <consoleintr+0x155>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100902:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
80100903:	8b 45 08             	mov    0x8(%ebp),%eax
80100906:	ff d0                	call   *%eax
80100908:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010090b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010090f:	0f 89 b0 fe ff ff    	jns    801007c5 <consoleintr+0x17>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100915:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
8010091c:	e8 af 42 00 00       	call   80104bd0 <release>
}
80100921:	c9                   	leave  
80100922:	c3                   	ret    

80100923 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100923:	55                   	push   %ebp
80100924:	89 e5                	mov    %esp,%ebp
80100926:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100929:	8b 45 08             	mov    0x8(%ebp),%eax
8010092c:	89 04 24             	mov    %eax,(%esp)
8010092f:	e8 a0 10 00 00       	call   801019d4 <iunlock>
  target = n;
80100934:	8b 45 10             	mov    0x10(%ebp),%eax
80100937:	89 45 f0             	mov    %eax,-0x10(%ebp)
  acquire(&input.lock);
8010093a:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
80100941:	e8 29 42 00 00       	call   80104b6f <acquire>
  while(n > 0){
80100946:	e9 a8 00 00 00       	jmp    801009f3 <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
8010094b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100951:	8b 40 24             	mov    0x24(%eax),%eax
80100954:	85 c0                	test   %eax,%eax
80100956:	74 21                	je     80100979 <consoleread+0x56>
        release(&input.lock);
80100958:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
8010095f:	e8 6c 42 00 00       	call   80104bd0 <release>
        ilock(ip);
80100964:	8b 45 08             	mov    0x8(%ebp),%eax
80100967:	89 04 24             	mov    %eax,(%esp)
8010096a:	e8 14 0f 00 00       	call   80101883 <ilock>
        return -1;
8010096f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100974:	e9 a9 00 00 00       	jmp    80100a22 <consoleread+0xff>
      }
      sleep(&input.r, &input.lock);
80100979:	c7 44 24 04 a0 dd 10 	movl   $0x8010dda0,0x4(%esp)
80100980:	80 
80100981:	c7 04 24 54 de 10 80 	movl   $0x8010de54,(%esp)
80100988:	e8 10 3f 00 00       	call   8010489d <sleep>
8010098d:	eb 01                	jmp    80100990 <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
8010098f:	90                   	nop
80100990:	8b 15 54 de 10 80    	mov    0x8010de54,%edx
80100996:	a1 58 de 10 80       	mov    0x8010de58,%eax
8010099b:	39 c2                	cmp    %eax,%edx
8010099d:	74 ac                	je     8010094b <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
8010099f:	a1 54 de 10 80       	mov    0x8010de54,%eax
801009a4:	89 c2                	mov    %eax,%edx
801009a6:	83 e2 7f             	and    $0x7f,%edx
801009a9:	0f b6 92 d4 dd 10 80 	movzbl -0x7fef222c(%edx),%edx
801009b0:	0f be d2             	movsbl %dl,%edx
801009b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
801009b6:	83 c0 01             	add    $0x1,%eax
801009b9:	a3 54 de 10 80       	mov    %eax,0x8010de54
    if(c == C('D')){  // EOF
801009be:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801009c2:	75 17                	jne    801009db <consoleread+0xb8>
      if(n < target){
801009c4:	8b 45 10             	mov    0x10(%ebp),%eax
801009c7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801009ca:	73 2f                	jae    801009fb <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801009cc:	a1 54 de 10 80       	mov    0x8010de54,%eax
801009d1:	83 e8 01             	sub    $0x1,%eax
801009d4:	a3 54 de 10 80       	mov    %eax,0x8010de54
      }
      break;
801009d9:	eb 24                	jmp    801009ff <consoleread+0xdc>
    }
    *dst++ = c;
801009db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009de:	89 c2                	mov    %eax,%edx
801009e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801009e3:	88 10                	mov    %dl,(%eax)
801009e5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
801009e9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
801009ed:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801009f1:	74 0b                	je     801009fe <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
801009f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801009f7:	7f 96                	jg     8010098f <consoleread+0x6c>
801009f9:	eb 04                	jmp    801009ff <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
801009fb:	90                   	nop
801009fc:	eb 01                	jmp    801009ff <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
801009fe:	90                   	nop
  }
  release(&input.lock);
801009ff:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
80100a06:	e8 c5 41 00 00       	call   80104bd0 <release>
  ilock(ip);
80100a0b:	8b 45 08             	mov    0x8(%ebp),%eax
80100a0e:	89 04 24             	mov    %eax,(%esp)
80100a11:	e8 6d 0e 00 00       	call   80101883 <ilock>

  return target - n;
80100a16:	8b 45 10             	mov    0x10(%ebp),%eax
80100a19:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a1c:	89 d1                	mov    %edx,%ecx
80100a1e:	29 c1                	sub    %eax,%ecx
80100a20:	89 c8                	mov    %ecx,%eax
}
80100a22:	c9                   	leave  
80100a23:	c3                   	ret    

80100a24 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a24:	55                   	push   %ebp
80100a25:	89 e5                	mov    %esp,%ebp
80100a27:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a2a:	8b 45 08             	mov    0x8(%ebp),%eax
80100a2d:	89 04 24             	mov    %eax,(%esp)
80100a30:	e8 9f 0f 00 00       	call   801019d4 <iunlock>
  acquire(&cons.lock);
80100a35:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a3c:	e8 2e 41 00 00       	call   80104b6f <acquire>
  for(i = 0; i < n; i++)
80100a41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a48:	eb 1d                	jmp    80100a67 <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a4d:	03 45 0c             	add    0xc(%ebp),%eax
80100a50:	0f b6 00             	movzbl (%eax),%eax
80100a53:	0f be c0             	movsbl %al,%eax
80100a56:	25 ff 00 00 00       	and    $0xff,%eax
80100a5b:	89 04 24             	mov    %eax,(%esp)
80100a5e:	e8 ee fc ff ff       	call   80100751 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a6a:	3b 45 10             	cmp    0x10(%ebp),%eax
80100a6d:	7c db                	jl     80100a4a <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100a6f:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a76:	e8 55 41 00 00       	call   80104bd0 <release>
  ilock(ip);
80100a7b:	8b 45 08             	mov    0x8(%ebp),%eax
80100a7e:	89 04 24             	mov    %eax,(%esp)
80100a81:	e8 fd 0d 00 00       	call   80101883 <ilock>

  return n;
80100a86:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100a89:	c9                   	leave  
80100a8a:	c3                   	ret    

80100a8b <consoleinit>:

void
consoleinit(void)
{
80100a8b:	55                   	push   %ebp
80100a8c:	89 e5                	mov    %esp,%ebp
80100a8e:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a91:	c7 44 24 04 a3 81 10 	movl   $0x801081a3,0x4(%esp)
80100a98:	80 
80100a99:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100aa0:	e8 a9 40 00 00       	call   80104b4e <initlock>
  initlock(&input.lock, "input");
80100aa5:	c7 44 24 04 ab 81 10 	movl   $0x801081ab,0x4(%esp)
80100aac:	80 
80100aad:	c7 04 24 a0 dd 10 80 	movl   $0x8010dda0,(%esp)
80100ab4:	e8 95 40 00 00       	call   80104b4e <initlock>

  devsw[CONSOLE].write = consolewrite;
80100ab9:	c7 05 0c e8 10 80 24 	movl   $0x80100a24,0x8010e80c
80100ac0:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100ac3:	c7 05 08 e8 10 80 23 	movl   $0x80100923,0x8010e808
80100aca:	09 10 80 
  cons.locking = 1;
80100acd:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100ad4:	00 00 00 

  picenable(IRQ_KBD);
80100ad7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100ade:	e8 b6 2f 00 00       	call   80103a99 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100ae3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100aea:	00 
80100aeb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100af2:	e8 7f 1e 00 00       	call   80102976 <ioapicenable>
}
80100af7:	c9                   	leave  
80100af8:	c3                   	ret    
80100af9:	00 00                	add    %al,(%eax)
	...

80100afc <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100afc:	55                   	push   %ebp
80100afd:	89 e5                	mov    %esp,%ebp
80100aff:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100b05:	8b 45 08             	mov    0x8(%ebp),%eax
80100b08:	89 04 24             	mov    %eax,(%esp)
80100b0b:	e8 0b 19 00 00       	call   8010241b <namei>
80100b10:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100b13:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100b17:	75 0a                	jne    80100b23 <exec+0x27>
    return -1;
80100b19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b1e:	e9 df 03 00 00       	jmp    80100f02 <exec+0x406>
  ilock(ip);
80100b23:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 55 0d 00 00       	call   80101883 <ilock>
  pgdir = 0;
80100b2e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b35:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b3b:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b42:	00 
80100b43:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b4a:	00 
80100b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b52:	89 04 24             	mov    %eax,(%esp)
80100b55:	e8 22 12 00 00       	call   80101d7c <readi>
80100b5a:	83 f8 33             	cmp    $0x33,%eax
80100b5d:	0f 86 59 03 00 00    	jbe    80100ebc <exec+0x3c0>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b63:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b69:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100b6e:	0f 85 4b 03 00 00    	jne    80100ebf <exec+0x3c3>
    goto bad;

  if((pgdir = setupkvm(kalloc)) == 0)
80100b74:	c7 04 24 02 2b 10 80 	movl   $0x80102b02,(%esp)
80100b7b:	e8 7e 6d 00 00       	call   801078fe <setupkvm>
80100b80:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100b83:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100b87:	0f 84 35 03 00 00    	je     80100ec2 <exec+0x3c6>
    goto bad;

  // Load program into memory.
  sz = 0;
80100b8d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b94:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
80100b9b:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100ba1:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ba4:	e9 ca 00 00 00       	jmp    80100c73 <exec+0x177>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100ba9:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100bac:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bb2:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100bb9:	00 
80100bba:	89 54 24 08          	mov    %edx,0x8(%esp)
80100bbe:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100bc5:	89 04 24             	mov    %eax,(%esp)
80100bc8:	e8 af 11 00 00       	call   80101d7c <readi>
80100bcd:	83 f8 20             	cmp    $0x20,%eax
80100bd0:	0f 85 ef 02 00 00    	jne    80100ec5 <exec+0x3c9>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100bd6:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bdc:	83 f8 01             	cmp    $0x1,%eax
80100bdf:	0f 85 80 00 00 00    	jne    80100c65 <exec+0x169>
      continue;
    if(ph.memsz < ph.filesz)
80100be5:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100beb:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100bf1:	39 c2                	cmp    %eax,%edx
80100bf3:	0f 82 cf 02 00 00    	jb     80100ec8 <exec+0x3cc>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bf9:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100bff:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c05:	8d 04 02             	lea    (%edx,%eax,1),%eax
80100c08:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c16:	89 04 24             	mov    %eax,(%esp)
80100c19:	e8 b4 70 00 00       	call   80107cd2 <allocuvm>
80100c1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100c21:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100c25:	0f 84 a0 02 00 00    	je     80100ecb <exec+0x3cf>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c2b:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c31:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c37:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c3d:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100c41:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c45:	8b 55 ec             	mov    -0x14(%ebp),%edx
80100c48:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c53:	89 04 24             	mov    %eax,(%esp)
80100c56:	e8 87 6f 00 00       	call   80107be2 <loaduvm>
80100c5b:	85 c0                	test   %eax,%eax
80100c5d:	0f 88 6b 02 00 00    	js     80100ece <exec+0x3d2>
80100c63:	eb 01                	jmp    80100c66 <exec+0x16a>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c65:	90                   	nop
  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c66:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
80100c6a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100c6d:	83 c0 20             	add    $0x20,%eax
80100c70:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100c73:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100c7a:	0f b7 c0             	movzwl %ax,%eax
80100c7d:	3b 45 d8             	cmp    -0x28(%ebp),%eax
80100c80:	0f 8f 23 ff ff ff    	jg     80100ba9 <exec+0xad>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100c89:	89 04 24             	mov    %eax,(%esp)
80100c8c:	e8 79 0e 00 00       	call   80101b0a <iunlockput>
  ip = 0;
80100c91:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c9b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100ca0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100ca5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ca8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cab:	05 00 20 00 00       	add    $0x2000,%eax
80100cb0:	89 44 24 08          	mov    %eax,0x8(%esp)
80100cb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100cbe:	89 04 24             	mov    %eax,(%esp)
80100cc1:	e8 0c 70 00 00       	call   80107cd2 <allocuvm>
80100cc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100cc9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100ccd:	0f 84 fe 01 00 00    	je     80100ed1 <exec+0x3d5>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cd6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cdb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ce2:	89 04 24             	mov    %eax,(%esp)
80100ce5:	e8 0c 72 00 00       	call   80107ef6 <clearpteu>
  sp = sz;
80100cea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ced:	89 45 e8             	mov    %eax,-0x18(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cf0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80100cf7:	e9 81 00 00 00       	jmp    80100d7d <exec+0x281>
    if(argc >= MAXARG)
80100cfc:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
80100d00:	0f 87 ce 01 00 00    	ja     80100ed4 <exec+0x3d8>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d06:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d09:	c1 e0 02             	shl    $0x2,%eax
80100d0c:	03 45 0c             	add    0xc(%ebp),%eax
80100d0f:	8b 00                	mov    (%eax),%eax
80100d11:	89 04 24             	mov    %eax,(%esp)
80100d14:	e8 26 43 00 00       	call   8010503f <strlen>
80100d19:	f7 d0                	not    %eax
80100d1b:	03 45 e8             	add    -0x18(%ebp),%eax
80100d1e:	83 e0 fc             	and    $0xfffffffc,%eax
80100d21:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d24:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d27:	c1 e0 02             	shl    $0x2,%eax
80100d2a:	03 45 0c             	add    0xc(%ebp),%eax
80100d2d:	8b 00                	mov    (%eax),%eax
80100d2f:	89 04 24             	mov    %eax,(%esp)
80100d32:	e8 08 43 00 00       	call   8010503f <strlen>
80100d37:	83 c0 01             	add    $0x1,%eax
80100d3a:	89 c2                	mov    %eax,%edx
80100d3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d3f:	c1 e0 02             	shl    $0x2,%eax
80100d42:	03 45 0c             	add    0xc(%ebp),%eax
80100d45:	8b 00                	mov    (%eax),%eax
80100d47:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100d4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d52:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d59:	89 04 24             	mov    %eax,(%esp)
80100d5c:	e8 49 73 00 00       	call   801080aa <copyout>
80100d61:	85 c0                	test   %eax,%eax
80100d63:	0f 88 6e 01 00 00    	js     80100ed7 <exec+0x3db>
      goto bad;
    ustack[3+argc] = sp;
80100d69:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d6c:	8d 50 03             	lea    0x3(%eax),%edx
80100d6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d72:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d79:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80100d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d80:	c1 e0 02             	shl    $0x2,%eax
80100d83:	03 45 0c             	add    0xc(%ebp),%eax
80100d86:	8b 00                	mov    (%eax),%eax
80100d88:	85 c0                	test   %eax,%eax
80100d8a:	0f 85 6c ff ff ff    	jne    80100cfc <exec+0x200>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100d90:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d93:	83 c0 03             	add    $0x3,%eax
80100d96:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100d9d:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100da1:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100da8:	ff ff ff 
  ustack[1] = argc;
80100dab:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dae:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100db4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100db7:	83 c0 01             	add    $0x1,%eax
80100dba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc1:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100dc4:	29 d0                	sub    %edx,%eax
80100dc6:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100dcc:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dcf:	83 c0 04             	add    $0x4,%eax
80100dd2:	c1 e0 02             	shl    $0x2,%eax
80100dd5:	29 45 e8             	sub    %eax,-0x18(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100dd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ddb:	83 c0 04             	add    $0x4,%eax
80100dde:	c1 e0 02             	shl    $0x2,%eax
80100de1:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100de5:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100deb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100def:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100df2:	89 44 24 04          	mov    %eax,0x4(%esp)
80100df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100df9:	89 04 24             	mov    %eax,(%esp)
80100dfc:	e8 a9 72 00 00       	call   801080aa <copyout>
80100e01:	85 c0                	test   %eax,%eax
80100e03:	0f 88 d1 00 00 00    	js     80100eda <exec+0x3de>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e09:	8b 45 08             	mov    0x8(%ebp),%eax
80100e0c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80100e0f:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e12:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100e15:	eb 17                	jmp    80100e2e <exec+0x332>
    if(*s == '/')
80100e17:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e1a:	0f b6 00             	movzbl (%eax),%eax
80100e1d:	3c 2f                	cmp    $0x2f,%al
80100e1f:	75 09                	jne    80100e2a <exec+0x32e>
      last = s+1;
80100e21:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e24:	83 c0 01             	add    $0x1,%eax
80100e27:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e2a:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80100e2e:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e31:	0f b6 00             	movzbl (%eax),%eax
80100e34:	84 c0                	test   %al,%al
80100e36:	75 df                	jne    80100e17 <exec+0x31b>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e3e:	8d 50 6c             	lea    0x6c(%eax),%edx
80100e41:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e48:	00 
80100e49:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e50:	89 14 24             	mov    %edx,(%esp)
80100e53:	e8 99 41 00 00       	call   80104ff1 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e5e:	8b 40 04             	mov    0x4(%eax),%eax
80100e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
  proc->pgdir = pgdir;
80100e64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e6a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100e6d:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100e70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e76:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100e79:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100e7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e81:	8b 40 18             	mov    0x18(%eax),%eax
80100e84:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100e8a:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100e8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e93:	8b 40 18             	mov    0x18(%eax),%eax
80100e96:	8b 55 e8             	mov    -0x18(%ebp),%edx
80100e99:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100e9c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea2:	89 04 24             	mov    %eax,(%esp)
80100ea5:	e8 46 6b 00 00       	call   801079f0 <switchuvm>
  freevm(oldpgdir);
80100eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ead:	89 04 24             	mov    %eax,(%esp)
80100eb0:	e8 b3 6f 00 00       	call   80107e68 <freevm>
  return 0;
80100eb5:	b8 00 00 00 00       	mov    $0x0,%eax
80100eba:	eb 46                	jmp    80100f02 <exec+0x406>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100ebc:	90                   	nop
80100ebd:	eb 1c                	jmp    80100edb <exec+0x3df>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100ebf:	90                   	nop
80100ec0:	eb 19                	jmp    80100edb <exec+0x3df>

  if((pgdir = setupkvm(kalloc)) == 0)
    goto bad;
80100ec2:	90                   	nop
80100ec3:	eb 16                	jmp    80100edb <exec+0x3df>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100ec5:	90                   	nop
80100ec6:	eb 13                	jmp    80100edb <exec+0x3df>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100ec8:	90                   	nop
80100ec9:	eb 10                	jmp    80100edb <exec+0x3df>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100ecb:	90                   	nop
80100ecc:	eb 0d                	jmp    80100edb <exec+0x3df>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100ece:	90                   	nop
80100ecf:	eb 0a                	jmp    80100edb <exec+0x3df>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100ed1:	90                   	nop
80100ed2:	eb 07                	jmp    80100edb <exec+0x3df>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100ed4:	90                   	nop
80100ed5:	eb 04                	jmp    80100edb <exec+0x3df>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100ed7:	90                   	nop
80100ed8:	eb 01                	jmp    80100edb <exec+0x3df>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100eda:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100edb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100edf:	74 0b                	je     80100eec <exec+0x3f0>
    freevm(pgdir);
80100ee1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ee4:	89 04 24             	mov    %eax,(%esp)
80100ee7:	e8 7c 6f 00 00       	call   80107e68 <freevm>
  if(ip)
80100eec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100ef0:	74 0b                	je     80100efd <exec+0x401>
    iunlockput(ip);
80100ef2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100ef5:	89 04 24             	mov    %eax,(%esp)
80100ef8:	e8 0d 0c 00 00       	call   80101b0a <iunlockput>
  return -1;
80100efd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f02:	c9                   	leave  
80100f03:	c3                   	ret    

80100f04 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f04:	55                   	push   %ebp
80100f05:	89 e5                	mov    %esp,%ebp
80100f07:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f0a:	c7 44 24 04 b1 81 10 	movl   $0x801081b1,0x4(%esp)
80100f11:	80 
80100f12:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100f19:	e8 30 3c 00 00       	call   80104b4e <initlock>
}
80100f1e:	c9                   	leave  
80100f1f:	c3                   	ret    

80100f20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f26:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100f2d:	e8 3d 3c 00 00       	call   80104b6f <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f32:	c7 45 f4 94 de 10 80 	movl   $0x8010de94,-0xc(%ebp)
80100f39:	eb 29                	jmp    80100f64 <filealloc+0x44>
    if(f->ref == 0){
80100f3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f3e:	8b 40 04             	mov    0x4(%eax),%eax
80100f41:	85 c0                	test   %eax,%eax
80100f43:	75 1b                	jne    80100f60 <filealloc+0x40>
      f->ref = 1;
80100f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f48:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f4f:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100f56:	e8 75 3c 00 00       	call   80104bd0 <release>
      return f;
80100f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f5e:	eb 1f                	jmp    80100f7f <filealloc+0x5f>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f60:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f64:	b8 f4 e7 10 80       	mov    $0x8010e7f4,%eax
80100f69:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100f6c:	72 cd                	jb     80100f3b <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f6e:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100f75:	e8 56 3c 00 00       	call   80104bd0 <release>
  return 0;
80100f7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100f7f:	c9                   	leave  
80100f80:	c3                   	ret    

80100f81 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f81:	55                   	push   %ebp
80100f82:	89 e5                	mov    %esp,%ebp
80100f84:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80100f87:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100f8e:	e8 dc 3b 00 00       	call   80104b6f <acquire>
  if(f->ref < 1)
80100f93:	8b 45 08             	mov    0x8(%ebp),%eax
80100f96:	8b 40 04             	mov    0x4(%eax),%eax
80100f99:	85 c0                	test   %eax,%eax
80100f9b:	7f 0c                	jg     80100fa9 <filedup+0x28>
    panic("filedup");
80100f9d:	c7 04 24 b8 81 10 80 	movl   $0x801081b8,(%esp)
80100fa4:	e8 91 f5 ff ff       	call   8010053a <panic>
  f->ref++;
80100fa9:	8b 45 08             	mov    0x8(%ebp),%eax
80100fac:	8b 40 04             	mov    0x4(%eax),%eax
80100faf:	8d 50 01             	lea    0x1(%eax),%edx
80100fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb5:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fb8:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100fbf:	e8 0c 3c 00 00       	call   80104bd0 <release>
  return f;
80100fc4:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100fc7:	c9                   	leave  
80100fc8:	c3                   	ret    

80100fc9 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fc9:	55                   	push   %ebp
80100fca:	89 e5                	mov    %esp,%ebp
80100fcc:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
80100fcf:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80100fd6:	e8 94 3b 00 00       	call   80104b6f <acquire>
  if(f->ref < 1)
80100fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80100fde:	8b 40 04             	mov    0x4(%eax),%eax
80100fe1:	85 c0                	test   %eax,%eax
80100fe3:	7f 0c                	jg     80100ff1 <fileclose+0x28>
    panic("fileclose");
80100fe5:	c7 04 24 c0 81 10 80 	movl   $0x801081c0,(%esp)
80100fec:	e8 49 f5 ff ff       	call   8010053a <panic>
  if(--f->ref > 0){
80100ff1:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff4:	8b 40 04             	mov    0x4(%eax),%eax
80100ff7:	8d 50 ff             	lea    -0x1(%eax),%edx
80100ffa:	8b 45 08             	mov    0x8(%ebp),%eax
80100ffd:	89 50 04             	mov    %edx,0x4(%eax)
80101000:	8b 45 08             	mov    0x8(%ebp),%eax
80101003:	8b 40 04             	mov    0x4(%eax),%eax
80101006:	85 c0                	test   %eax,%eax
80101008:	7e 11                	jle    8010101b <fileclose+0x52>
    release(&ftable.lock);
8010100a:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
80101011:	e8 ba 3b 00 00       	call   80104bd0 <release>
    return;
80101016:	e9 82 00 00 00       	jmp    8010109d <fileclose+0xd4>
  }
  ff = *f;
8010101b:	8b 45 08             	mov    0x8(%ebp),%eax
8010101e:	8b 10                	mov    (%eax),%edx
80101020:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101023:	8b 50 04             	mov    0x4(%eax),%edx
80101026:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101029:	8b 50 08             	mov    0x8(%eax),%edx
8010102c:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010102f:	8b 50 0c             	mov    0xc(%eax),%edx
80101032:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101035:	8b 50 10             	mov    0x10(%eax),%edx
80101038:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010103b:	8b 40 14             	mov    0x14(%eax),%eax
8010103e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101041:	8b 45 08             	mov    0x8(%ebp),%eax
80101044:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010104b:	8b 45 08             	mov    0x8(%ebp),%eax
8010104e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101054:	c7 04 24 60 de 10 80 	movl   $0x8010de60,(%esp)
8010105b:	e8 70 3b 00 00       	call   80104bd0 <release>
  
  if(ff.type == FD_PIPE)
80101060:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101063:	83 f8 01             	cmp    $0x1,%eax
80101066:	75 18                	jne    80101080 <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
80101068:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010106c:	0f be d0             	movsbl %al,%edx
8010106f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101072:	89 54 24 04          	mov    %edx,0x4(%esp)
80101076:	89 04 24             	mov    %eax,(%esp)
80101079:	e8 d5 2c 00 00       	call   80103d53 <pipeclose>
8010107e:	eb 1d                	jmp    8010109d <fileclose+0xd4>
  else if(ff.type == FD_INODE){
80101080:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101083:	83 f8 02             	cmp    $0x2,%eax
80101086:	75 15                	jne    8010109d <fileclose+0xd4>
    begin_trans();
80101088:	e8 7c 21 00 00       	call   80103209 <begin_trans>
    iput(ff.ip);
8010108d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101090:	89 04 24             	mov    %eax,(%esp)
80101093:	e8 a1 09 00 00       	call   80101a39 <iput>
    commit_trans();
80101098:	e8 b5 21 00 00       	call   80103252 <commit_trans>
  }
}
8010109d:	c9                   	leave  
8010109e:	c3                   	ret    

8010109f <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010109f:	55                   	push   %ebp
801010a0:	89 e5                	mov    %esp,%ebp
801010a2:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801010a5:	8b 45 08             	mov    0x8(%ebp),%eax
801010a8:	8b 00                	mov    (%eax),%eax
801010aa:	83 f8 02             	cmp    $0x2,%eax
801010ad:	75 38                	jne    801010e7 <filestat+0x48>
    ilock(f->ip);
801010af:	8b 45 08             	mov    0x8(%ebp),%eax
801010b2:	8b 40 10             	mov    0x10(%eax),%eax
801010b5:	89 04 24             	mov    %eax,(%esp)
801010b8:	e8 c6 07 00 00       	call   80101883 <ilock>
    stati(f->ip, st);
801010bd:	8b 45 08             	mov    0x8(%ebp),%eax
801010c0:	8b 40 10             	mov    0x10(%eax),%eax
801010c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801010c6:	89 54 24 04          	mov    %edx,0x4(%esp)
801010ca:	89 04 24             	mov    %eax,(%esp)
801010cd:	e8 65 0c 00 00       	call   80101d37 <stati>
    iunlock(f->ip);
801010d2:	8b 45 08             	mov    0x8(%ebp),%eax
801010d5:	8b 40 10             	mov    0x10(%eax),%eax
801010d8:	89 04 24             	mov    %eax,(%esp)
801010db:	e8 f4 08 00 00       	call   801019d4 <iunlock>
    return 0;
801010e0:	b8 00 00 00 00       	mov    $0x0,%eax
801010e5:	eb 05                	jmp    801010ec <filestat+0x4d>
  }
  return -1;
801010e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010ec:	c9                   	leave  
801010ed:	c3                   	ret    

801010ee <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010ee:	55                   	push   %ebp
801010ef:	89 e5                	mov    %esp,%ebp
801010f1:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
801010f4:	8b 45 08             	mov    0x8(%ebp),%eax
801010f7:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801010fb:	84 c0                	test   %al,%al
801010fd:	75 0a                	jne    80101109 <fileread+0x1b>
    return -1;
801010ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101104:	e9 9f 00 00 00       	jmp    801011a8 <fileread+0xba>
  if(f->type == FD_PIPE)
80101109:	8b 45 08             	mov    0x8(%ebp),%eax
8010110c:	8b 00                	mov    (%eax),%eax
8010110e:	83 f8 01             	cmp    $0x1,%eax
80101111:	75 1e                	jne    80101131 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101113:	8b 45 08             	mov    0x8(%ebp),%eax
80101116:	8b 40 0c             	mov    0xc(%eax),%eax
80101119:	8b 55 10             	mov    0x10(%ebp),%edx
8010111c:	89 54 24 08          	mov    %edx,0x8(%esp)
80101120:	8b 55 0c             	mov    0xc(%ebp),%edx
80101123:	89 54 24 04          	mov    %edx,0x4(%esp)
80101127:	89 04 24             	mov    %eax,(%esp)
8010112a:	e8 a6 2d 00 00       	call   80103ed5 <piperead>
8010112f:	eb 77                	jmp    801011a8 <fileread+0xba>
  if(f->type == FD_INODE){
80101131:	8b 45 08             	mov    0x8(%ebp),%eax
80101134:	8b 00                	mov    (%eax),%eax
80101136:	83 f8 02             	cmp    $0x2,%eax
80101139:	75 61                	jne    8010119c <fileread+0xae>
    ilock(f->ip);
8010113b:	8b 45 08             	mov    0x8(%ebp),%eax
8010113e:	8b 40 10             	mov    0x10(%eax),%eax
80101141:	89 04 24             	mov    %eax,(%esp)
80101144:	e8 3a 07 00 00       	call   80101883 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101149:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010114c:	8b 45 08             	mov    0x8(%ebp),%eax
8010114f:	8b 50 14             	mov    0x14(%eax),%edx
80101152:	8b 45 08             	mov    0x8(%ebp),%eax
80101155:	8b 40 10             	mov    0x10(%eax),%eax
80101158:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010115c:	89 54 24 08          	mov    %edx,0x8(%esp)
80101160:	8b 55 0c             	mov    0xc(%ebp),%edx
80101163:	89 54 24 04          	mov    %edx,0x4(%esp)
80101167:	89 04 24             	mov    %eax,(%esp)
8010116a:	e8 0d 0c 00 00       	call   80101d7c <readi>
8010116f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101172:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101176:	7e 11                	jle    80101189 <fileread+0x9b>
      f->off += r;
80101178:	8b 45 08             	mov    0x8(%ebp),%eax
8010117b:	8b 50 14             	mov    0x14(%eax),%edx
8010117e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101181:	01 c2                	add    %eax,%edx
80101183:	8b 45 08             	mov    0x8(%ebp),%eax
80101186:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101189:	8b 45 08             	mov    0x8(%ebp),%eax
8010118c:	8b 40 10             	mov    0x10(%eax),%eax
8010118f:	89 04 24             	mov    %eax,(%esp)
80101192:	e8 3d 08 00 00       	call   801019d4 <iunlock>
    return r;
80101197:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010119a:	eb 0c                	jmp    801011a8 <fileread+0xba>
  }
  panic("fileread");
8010119c:	c7 04 24 ca 81 10 80 	movl   $0x801081ca,(%esp)
801011a3:	e8 92 f3 ff ff       	call   8010053a <panic>
}
801011a8:	c9                   	leave  
801011a9:	c3                   	ret    

801011aa <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011aa:	55                   	push   %ebp
801011ab:	89 e5                	mov    %esp,%ebp
801011ad:	53                   	push   %ebx
801011ae:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801011b1:	8b 45 08             	mov    0x8(%ebp),%eax
801011b4:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801011b8:	84 c0                	test   %al,%al
801011ba:	75 0a                	jne    801011c6 <filewrite+0x1c>
    return -1;
801011bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011c1:	e9 23 01 00 00       	jmp    801012e9 <filewrite+0x13f>
  if(f->type == FD_PIPE)
801011c6:	8b 45 08             	mov    0x8(%ebp),%eax
801011c9:	8b 00                	mov    (%eax),%eax
801011cb:	83 f8 01             	cmp    $0x1,%eax
801011ce:	75 21                	jne    801011f1 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801011d0:	8b 45 08             	mov    0x8(%ebp),%eax
801011d3:	8b 40 0c             	mov    0xc(%eax),%eax
801011d6:	8b 55 10             	mov    0x10(%ebp),%edx
801011d9:	89 54 24 08          	mov    %edx,0x8(%esp)
801011dd:	8b 55 0c             	mov    0xc(%ebp),%edx
801011e0:	89 54 24 04          	mov    %edx,0x4(%esp)
801011e4:	89 04 24             	mov    %eax,(%esp)
801011e7:	e8 f9 2b 00 00       	call   80103de5 <pipewrite>
801011ec:	e9 f8 00 00 00       	jmp    801012e9 <filewrite+0x13f>
  if(f->type == FD_INODE){
801011f1:	8b 45 08             	mov    0x8(%ebp),%eax
801011f4:	8b 00                	mov    (%eax),%eax
801011f6:	83 f8 02             	cmp    $0x2,%eax
801011f9:	0f 85 de 00 00 00    	jne    801012dd <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
801011ff:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101206:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while(i < n){
8010120d:	e9 a8 00 00 00       	jmp    801012ba <filewrite+0x110>
      int n1 = n - i;
80101212:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101215:	8b 55 10             	mov    0x10(%ebp),%edx
80101218:	89 d1                	mov    %edx,%ecx
8010121a:	29 c1                	sub    %eax,%ecx
8010121c:	89 c8                	mov    %ecx,%eax
8010121e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(n1 > max)
80101221:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101224:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101227:	7e 06                	jle    8010122f <filewrite+0x85>
        n1 = max;
80101229:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010122c:	89 45 f4             	mov    %eax,-0xc(%ebp)

      begin_trans();
8010122f:	e8 d5 1f 00 00       	call   80103209 <begin_trans>
      ilock(f->ip);
80101234:	8b 45 08             	mov    0x8(%ebp),%eax
80101237:	8b 40 10             	mov    0x10(%eax),%eax
8010123a:	89 04 24             	mov    %eax,(%esp)
8010123d:	e8 41 06 00 00       	call   80101883 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101242:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101245:	8b 45 08             	mov    0x8(%ebp),%eax
80101248:	8b 48 14             	mov    0x14(%eax),%ecx
8010124b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010124e:	89 c2                	mov    %eax,%edx
80101250:	03 55 0c             	add    0xc(%ebp),%edx
80101253:	8b 45 08             	mov    0x8(%ebp),%eax
80101256:	8b 40 10             	mov    0x10(%eax),%eax
80101259:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010125d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101261:	89 54 24 04          	mov    %edx,0x4(%esp)
80101265:	89 04 24             	mov    %eax,(%esp)
80101268:	e8 73 0c 00 00       	call   80101ee0 <writei>
8010126d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101270:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101274:	7e 11                	jle    80101287 <filewrite+0xdd>
        f->off += r;
80101276:	8b 45 08             	mov    0x8(%ebp),%eax
80101279:	8b 50 14             	mov    0x14(%eax),%edx
8010127c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010127f:	01 c2                	add    %eax,%edx
80101281:	8b 45 08             	mov    0x8(%ebp),%eax
80101284:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101287:	8b 45 08             	mov    0x8(%ebp),%eax
8010128a:	8b 40 10             	mov    0x10(%eax),%eax
8010128d:	89 04 24             	mov    %eax,(%esp)
80101290:	e8 3f 07 00 00       	call   801019d4 <iunlock>
      commit_trans();
80101295:	e8 b8 1f 00 00       	call   80103252 <commit_trans>

      if(r < 0)
8010129a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010129e:	78 28                	js     801012c8 <filewrite+0x11e>
        break;
      if(r != n1)
801012a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801012a6:	74 0c                	je     801012b4 <filewrite+0x10a>
        panic("short filewrite");
801012a8:	c7 04 24 d3 81 10 80 	movl   $0x801081d3,(%esp)
801012af:	e8 86 f2 ff ff       	call   8010053a <panic>
      i += r;
801012b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012b7:	01 45 f0             	add    %eax,-0x10(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012bd:	3b 45 10             	cmp    0x10(%ebp),%eax
801012c0:	0f 8c 4c ff ff ff    	jl     80101212 <filewrite+0x68>
801012c6:	eb 01                	jmp    801012c9 <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
801012c8:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012cc:	3b 45 10             	cmp    0x10(%ebp),%eax
801012cf:	75 05                	jne    801012d6 <filewrite+0x12c>
801012d1:	8b 45 10             	mov    0x10(%ebp),%eax
801012d4:	eb 05                	jmp    801012db <filewrite+0x131>
801012d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012db:	eb 0c                	jmp    801012e9 <filewrite+0x13f>
  }
  panic("filewrite");
801012dd:	c7 04 24 e3 81 10 80 	movl   $0x801081e3,(%esp)
801012e4:	e8 51 f2 ff ff       	call   8010053a <panic>
}
801012e9:	83 c4 24             	add    $0x24,%esp
801012ec:	5b                   	pop    %ebx
801012ed:	5d                   	pop    %ebp
801012ee:	c3                   	ret    
	...

801012f0 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801012f6:	8b 45 08             	mov    0x8(%ebp),%eax
801012f9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101300:	00 
80101301:	89 04 24             	mov    %eax,(%esp)
80101304:	e8 9e ee ff ff       	call   801001a7 <bread>
80101309:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010130f:	83 c0 18             	add    $0x18,%eax
80101312:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80101319:	00 
8010131a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010131e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101321:	89 04 24             	mov    %eax,(%esp)
80101324:	e8 68 3b 00 00       	call   80104e91 <memmove>
  brelse(bp);
80101329:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010132c:	89 04 24             	mov    %eax,(%esp)
8010132f:	e8 e4 ee ff ff       	call   80100218 <brelse>
}
80101334:	c9                   	leave  
80101335:	c3                   	ret    

80101336 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101336:	55                   	push   %ebp
80101337:	89 e5                	mov    %esp,%ebp
80101339:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
8010133c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010133f:	8b 45 08             	mov    0x8(%ebp),%eax
80101342:	89 54 24 04          	mov    %edx,0x4(%esp)
80101346:	89 04 24             	mov    %eax,(%esp)
80101349:	e8 59 ee ff ff       	call   801001a7 <bread>
8010134e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101351:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101354:	83 c0 18             	add    $0x18,%eax
80101357:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010135e:	00 
8010135f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101366:	00 
80101367:	89 04 24             	mov    %eax,(%esp)
8010136a:	e8 4f 3a 00 00       	call   80104dbe <memset>
  log_write(bp);
8010136f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101372:	89 04 24             	mov    %eax,(%esp)
80101375:	e8 30 1f 00 00       	call   801032aa <log_write>
  brelse(bp);
8010137a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010137d:	89 04 24             	mov    %eax,(%esp)
80101380:	e8 93 ee ff ff       	call   80100218 <brelse>
}
80101385:	c9                   	leave  
80101386:	c3                   	ret    

80101387 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101387:	55                   	push   %ebp
80101388:	89 e5                	mov    %esp,%ebp
8010138a:	53                   	push   %ebx
8010138b:	83 ec 34             	sub    $0x34,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
8010138e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  readsb(dev, &sb);
80101395:	8b 45 08             	mov    0x8(%ebp),%eax
80101398:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010139b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010139f:	89 04 24             	mov    %eax,(%esp)
801013a2:	e8 49 ff ff ff       	call   801012f0 <readsb>
  for(b = 0; b < sb.size; b += BPB){
801013a7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
801013ae:	e9 1b 01 00 00       	jmp    801014ce <balloc+0x147>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801013b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013b6:	89 c2                	mov    %eax,%edx
801013b8:	c1 fa 1f             	sar    $0x1f,%edx
801013bb:	c1 ea 14             	shr    $0x14,%edx
801013be:	8d 04 02             	lea    (%edx,%eax,1),%eax
801013c1:	c1 f8 0c             	sar    $0xc,%eax
801013c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801013c7:	c1 ea 03             	shr    $0x3,%edx
801013ca:	01 d0                	add    %edx,%eax
801013cc:	83 c0 03             	add    $0x3,%eax
801013cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801013d3:	8b 45 08             	mov    0x8(%ebp),%eax
801013d6:	89 04 24             	mov    %eax,(%esp)
801013d9:	e8 c9 ed ff ff       	call   801001a7 <bread>
801013de:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801013e8:	e9 b0 00 00 00       	jmp    8010149d <balloc+0x116>
      m = 1 << (bi % 8);
801013ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801013f0:	89 c2                	mov    %eax,%edx
801013f2:	c1 fa 1f             	sar    $0x1f,%edx
801013f5:	c1 ea 1d             	shr    $0x1d,%edx
801013f8:	01 d0                	add    %edx,%eax
801013fa:	83 e0 07             	and    $0x7,%eax
801013fd:	29 d0                	sub    %edx,%eax
801013ff:	ba 01 00 00 00       	mov    $0x1,%edx
80101404:	89 d3                	mov    %edx,%ebx
80101406:	89 c1                	mov    %eax,%ecx
80101408:	d3 e3                	shl    %cl,%ebx
8010140a:	89 d8                	mov    %ebx,%eax
8010140c:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010140f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101412:	89 c2                	mov    %eax,%edx
80101414:	c1 fa 1f             	sar    $0x1f,%edx
80101417:	c1 ea 1d             	shr    $0x1d,%edx
8010141a:	8d 04 02             	lea    (%edx,%eax,1),%eax
8010141d:	c1 f8 03             	sar    $0x3,%eax
80101420:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101423:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101428:	0f b6 c0             	movzbl %al,%eax
8010142b:	23 45 f0             	and    -0x10(%ebp),%eax
8010142e:	85 c0                	test   %eax,%eax
80101430:	75 67                	jne    80101499 <balloc+0x112>
        bp->data[bi/8] |= m;  // Mark block in use.
80101432:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101435:	89 c2                	mov    %eax,%edx
80101437:	c1 fa 1f             	sar    $0x1f,%edx
8010143a:	c1 ea 1d             	shr    $0x1d,%edx
8010143d:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101440:	c1 f8 03             	sar    $0x3,%eax
80101443:	89 c2                	mov    %eax,%edx
80101445:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80101448:	0f b6 44 01 18       	movzbl 0x18(%ecx,%eax,1),%eax
8010144d:	89 c1                	mov    %eax,%ecx
8010144f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101452:	09 c8                	or     %ecx,%eax
80101454:	89 c1                	mov    %eax,%ecx
80101456:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101459:	88 4c 10 18          	mov    %cl,0x18(%eax,%edx,1)
        log_write(bp);
8010145d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101460:	89 04 24             	mov    %eax,(%esp)
80101463:	e8 42 1e 00 00       	call   801032aa <log_write>
        brelse(bp);
80101468:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010146b:	89 04 24             	mov    %eax,(%esp)
8010146e:	e8 a5 ed ff ff       	call   80100218 <brelse>
        bzero(dev, b + bi);
80101473:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101476:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101479:	01 c2                	add    %eax,%edx
8010147b:	8b 45 08             	mov    0x8(%ebp),%eax
8010147e:	89 54 24 04          	mov    %edx,0x4(%esp)
80101482:	89 04 24             	mov    %eax,(%esp)
80101485:	e8 ac fe ff ff       	call   80101336 <bzero>
        return b + bi;
8010148a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010148d:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101490:	8d 04 02             	lea    (%edx,%eax,1),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101493:	83 c4 34             	add    $0x34,%esp
80101496:	5b                   	pop    %ebx
80101497:	5d                   	pop    %ebp
80101498:	c3                   	ret    

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101499:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010149d:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%ebp)
801014a4:	7f 16                	jg     801014bc <balloc+0x135>
801014a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014ac:	8d 04 02             	lea    (%edx,%eax,1),%eax
801014af:	89 c2                	mov    %eax,%edx
801014b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014b4:	39 c2                	cmp    %eax,%edx
801014b6:	0f 82 31 ff ff ff    	jb     801013ed <balloc+0x66>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014bf:	89 04 24             	mov    %eax,(%esp)
801014c2:	e8 51 ed ff ff       	call   80100218 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801014c7:	81 45 e8 00 10 00 00 	addl   $0x1000,-0x18(%ebp)
801014ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014d1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014d4:	39 c2                	cmp    %eax,%edx
801014d6:	0f 82 d7 fe ff ff    	jb     801013b3 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014dc:	c7 04 24 ed 81 10 80 	movl   $0x801081ed,(%esp)
801014e3:	e8 52 f0 ff ff       	call   8010053a <panic>

801014e8 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014e8:	55                   	push   %ebp
801014e9:	89 e5                	mov    %esp,%ebp
801014eb:	53                   	push   %ebx
801014ec:	83 ec 34             	sub    $0x34,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801014ef:	8d 45 dc             	lea    -0x24(%ebp),%eax
801014f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801014f6:	8b 45 08             	mov    0x8(%ebp),%eax
801014f9:	89 04 24             	mov    %eax,(%esp)
801014fc:	e8 ef fd ff ff       	call   801012f0 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101501:	8b 45 0c             	mov    0xc(%ebp),%eax
80101504:	89 c2                	mov    %eax,%edx
80101506:	c1 ea 0c             	shr    $0xc,%edx
80101509:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010150c:	c1 e8 03             	shr    $0x3,%eax
8010150f:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101512:	8d 50 03             	lea    0x3(%eax),%edx
80101515:	8b 45 08             	mov    0x8(%ebp),%eax
80101518:	89 54 24 04          	mov    %edx,0x4(%esp)
8010151c:	89 04 24             	mov    %eax,(%esp)
8010151f:	e8 83 ec ff ff       	call   801001a7 <bread>
80101524:	89 45 ec             	mov    %eax,-0x14(%ebp)
  bi = b % BPB;
80101527:	8b 45 0c             	mov    0xc(%ebp),%eax
8010152a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010152f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101532:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101535:	89 c2                	mov    %eax,%edx
80101537:	c1 fa 1f             	sar    $0x1f,%edx
8010153a:	c1 ea 1d             	shr    $0x1d,%edx
8010153d:	01 d0                	add    %edx,%eax
8010153f:	83 e0 07             	and    $0x7,%eax
80101542:	29 d0                	sub    %edx,%eax
80101544:	ba 01 00 00 00       	mov    $0x1,%edx
80101549:	89 d3                	mov    %edx,%ebx
8010154b:	89 c1                	mov    %eax,%ecx
8010154d:	d3 e3                	shl    %cl,%ebx
8010154f:	89 d8                	mov    %ebx,%eax
80101551:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101554:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101557:	89 c2                	mov    %eax,%edx
80101559:	c1 fa 1f             	sar    $0x1f,%edx
8010155c:	c1 ea 1d             	shr    $0x1d,%edx
8010155f:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101562:	c1 f8 03             	sar    $0x3,%eax
80101565:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101568:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
8010156d:	0f b6 c0             	movzbl %al,%eax
80101570:	23 45 f4             	and    -0xc(%ebp),%eax
80101573:	85 c0                	test   %eax,%eax
80101575:	75 0c                	jne    80101583 <bfree+0x9b>
    panic("freeing free block");
80101577:	c7 04 24 03 82 10 80 	movl   $0x80108203,(%esp)
8010157e:	e8 b7 ef ff ff       	call   8010053a <panic>
  bp->data[bi/8] &= ~m;
80101583:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101586:	89 c2                	mov    %eax,%edx
80101588:	c1 fa 1f             	sar    $0x1f,%edx
8010158b:	c1 ea 1d             	shr    $0x1d,%edx
8010158e:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101591:	c1 f8 03             	sar    $0x3,%eax
80101594:	89 c2                	mov    %eax,%edx
80101596:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101599:	0f b6 44 01 18       	movzbl 0x18(%ecx,%eax,1),%eax
8010159e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801015a1:	f7 d1                	not    %ecx
801015a3:	21 c8                	and    %ecx,%eax
801015a5:	89 c1                	mov    %eax,%ecx
801015a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015aa:	88 4c 10 18          	mov    %cl,0x18(%eax,%edx,1)
  log_write(bp);
801015ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015b1:	89 04 24             	mov    %eax,(%esp)
801015b4:	e8 f1 1c 00 00       	call   801032aa <log_write>
  brelse(bp);
801015b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015bc:	89 04 24             	mov    %eax,(%esp)
801015bf:	e8 54 ec ff ff       	call   80100218 <brelse>
}
801015c4:	83 c4 34             	add    $0x34,%esp
801015c7:	5b                   	pop    %ebx
801015c8:	5d                   	pop    %ebp
801015c9:	c3                   	ret    

801015ca <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
801015ca:	55                   	push   %ebp
801015cb:	89 e5                	mov    %esp,%ebp
801015cd:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
801015d0:	c7 44 24 04 16 82 10 	movl   $0x80108216,0x4(%esp)
801015d7:	80 
801015d8:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
801015df:	e8 6a 35 00 00       	call   80104b4e <initlock>
}
801015e4:	c9                   	leave  
801015e5:	c3                   	ret    

801015e6 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801015e6:	55                   	push   %ebp
801015e7:	89 e5                	mov    %esp,%ebp
801015e9:	83 ec 48             	sub    $0x48,%esp
801015ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801015ef:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
801015f3:	8b 45 08             	mov    0x8(%ebp),%eax
801015f6:	8d 55 dc             	lea    -0x24(%ebp),%edx
801015f9:	89 54 24 04          	mov    %edx,0x4(%esp)
801015fd:	89 04 24             	mov    %eax,(%esp)
80101600:	e8 eb fc ff ff       	call   801012f0 <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
80101605:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
8010160c:	e9 98 00 00 00       	jmp    801016a9 <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
80101611:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101614:	c1 e8 03             	shr    $0x3,%eax
80101617:	83 c0 02             	add    $0x2,%eax
8010161a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010161e:	8b 45 08             	mov    0x8(%ebp),%eax
80101621:	89 04 24             	mov    %eax,(%esp)
80101624:	e8 7e eb ff ff       	call   801001a7 <bread>
80101629:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
8010162c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010162f:	83 c0 18             	add    $0x18,%eax
80101632:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101635:	83 e2 07             	and    $0x7,%edx
80101638:	c1 e2 06             	shl    $0x6,%edx
8010163b:	01 d0                	add    %edx,%eax
8010163d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(dip->type == 0){  // a free inode
80101640:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101643:	0f b7 00             	movzwl (%eax),%eax
80101646:	66 85 c0             	test   %ax,%ax
80101649:	75 4f                	jne    8010169a <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
8010164b:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
80101652:	00 
80101653:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010165a:	00 
8010165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010165e:	89 04 24             	mov    %eax,(%esp)
80101661:	e8 58 37 00 00       	call   80104dbe <memset>
      dip->type = type;
80101666:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101669:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
8010166d:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101670:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101673:	89 04 24             	mov    %eax,(%esp)
80101676:	e8 2f 1c 00 00       	call   801032aa <log_write>
      brelse(bp);
8010167b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010167e:	89 04 24             	mov    %eax,(%esp)
80101681:	e8 92 eb ff ff       	call   80100218 <brelse>
      return iget(dev, inum);
80101686:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101689:	89 44 24 04          	mov    %eax,0x4(%esp)
8010168d:	8b 45 08             	mov    0x8(%ebp),%eax
80101690:	89 04 24             	mov    %eax,(%esp)
80101693:	e8 e6 00 00 00       	call   8010177e <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101698:	c9                   	leave  
80101699:	c3                   	ret    
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
8010169a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010169d:	89 04 24             	mov    %eax,(%esp)
801016a0:	e8 73 eb ff ff       	call   80100218 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
801016a5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801016a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
801016ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016af:	39 c2                	cmp    %eax,%edx
801016b1:	0f 82 5a ff ff ff    	jb     80101611 <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016b7:	c7 04 24 1d 82 10 80 	movl   $0x8010821d,(%esp)
801016be:	e8 77 ee ff ff       	call   8010053a <panic>

801016c3 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801016c3:	55                   	push   %ebp
801016c4:	89 e5                	mov    %esp,%ebp
801016c6:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801016c9:	8b 45 08             	mov    0x8(%ebp),%eax
801016cc:	8b 40 04             	mov    0x4(%eax),%eax
801016cf:	c1 e8 03             	shr    $0x3,%eax
801016d2:	8d 50 02             	lea    0x2(%eax),%edx
801016d5:	8b 45 08             	mov    0x8(%ebp),%eax
801016d8:	8b 00                	mov    (%eax),%eax
801016da:	89 54 24 04          	mov    %edx,0x4(%esp)
801016de:	89 04 24             	mov    %eax,(%esp)
801016e1:	e8 c1 ea ff ff       	call   801001a7 <bread>
801016e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016ec:	83 c0 18             	add    $0x18,%eax
801016ef:	89 c2                	mov    %eax,%edx
801016f1:	8b 45 08             	mov    0x8(%ebp),%eax
801016f4:	8b 40 04             	mov    0x4(%eax),%eax
801016f7:	83 e0 07             	and    $0x7,%eax
801016fa:	c1 e0 06             	shl    $0x6,%eax
801016fd:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101700:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip->type = ip->type;
80101703:	8b 45 08             	mov    0x8(%ebp),%eax
80101706:	0f b7 50 10          	movzwl 0x10(%eax),%edx
8010170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010170d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101710:	8b 45 08             	mov    0x8(%ebp),%eax
80101713:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010171a:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010171e:	8b 45 08             	mov    0x8(%ebp),%eax
80101721:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101725:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101728:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010172c:	8b 45 08             	mov    0x8(%ebp),%eax
8010172f:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101733:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101736:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010173a:	8b 45 08             	mov    0x8(%ebp),%eax
8010173d:	8b 50 18             	mov    0x18(%eax),%edx
80101740:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101743:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101746:	8b 45 08             	mov    0x8(%ebp),%eax
80101749:	8d 50 1c             	lea    0x1c(%eax),%edx
8010174c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010174f:	83 c0 0c             	add    $0xc,%eax
80101752:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101759:	00 
8010175a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010175e:	89 04 24             	mov    %eax,(%esp)
80101761:	e8 2b 37 00 00       	call   80104e91 <memmove>
  log_write(bp);
80101766:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101769:	89 04 24             	mov    %eax,(%esp)
8010176c:	e8 39 1b 00 00       	call   801032aa <log_write>
  brelse(bp);
80101771:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101774:	89 04 24             	mov    %eax,(%esp)
80101777:	e8 9c ea ff ff       	call   80100218 <brelse>
}
8010177c:	c9                   	leave  
8010177d:	c3                   	ret    

8010177e <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010177e:	55                   	push   %ebp
8010177f:	89 e5                	mov    %esp,%ebp
80101781:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101784:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
8010178b:	e8 df 33 00 00       	call   80104b6f <acquire>

  // Is the inode already cached?
  empty = 0;
80101790:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101797:	c7 45 f0 94 e8 10 80 	movl   $0x8010e894,-0x10(%ebp)
8010179e:	eb 59                	jmp    801017f9 <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a3:	8b 40 08             	mov    0x8(%eax),%eax
801017a6:	85 c0                	test   %eax,%eax
801017a8:	7e 35                	jle    801017df <iget+0x61>
801017aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ad:	8b 00                	mov    (%eax),%eax
801017af:	3b 45 08             	cmp    0x8(%ebp),%eax
801017b2:	75 2b                	jne    801017df <iget+0x61>
801017b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017b7:	8b 40 04             	mov    0x4(%eax),%eax
801017ba:	3b 45 0c             	cmp    0xc(%ebp),%eax
801017bd:	75 20                	jne    801017df <iget+0x61>
      ip->ref++;
801017bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c2:	8b 40 08             	mov    0x8(%eax),%eax
801017c5:	8d 50 01             	lea    0x1(%eax),%edx
801017c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017cb:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801017ce:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
801017d5:	e8 f6 33 00 00       	call   80104bd0 <release>
      return ip;
801017da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017dd:	eb 70                	jmp    8010184f <iget+0xd1>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801017df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801017e3:	75 10                	jne    801017f5 <iget+0x77>
801017e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e8:	8b 40 08             	mov    0x8(%eax),%eax
801017eb:	85 c0                	test   %eax,%eax
801017ed:	75 06                	jne    801017f5 <iget+0x77>
      empty = ip;
801017ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017f2:	89 45 f4             	mov    %eax,-0xc(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017f5:	83 45 f0 50          	addl   $0x50,-0x10(%ebp)
801017f9:	b8 34 f8 10 80       	mov    $0x8010f834,%eax
801017fe:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80101801:	72 9d                	jb     801017a0 <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101803:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101807:	75 0c                	jne    80101815 <iget+0x97>
    panic("iget: no inodes");
80101809:	c7 04 24 2f 82 10 80 	movl   $0x8010822f,(%esp)
80101810:	e8 25 ed ff ff       	call   8010053a <panic>

  ip = empty;
80101815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101818:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ip->dev = dev;
8010181b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010181e:	8b 55 08             	mov    0x8(%ebp),%edx
80101821:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101823:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101826:	8b 55 0c             	mov    0xc(%ebp),%edx
80101829:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010182c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010182f:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101836:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101839:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101840:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101847:	e8 84 33 00 00       	call   80104bd0 <release>

  return ip;
8010184c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
8010184f:	c9                   	leave  
80101850:	c3                   	ret    

80101851 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101851:	55                   	push   %ebp
80101852:	89 e5                	mov    %esp,%ebp
80101854:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101857:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
8010185e:	e8 0c 33 00 00       	call   80104b6f <acquire>
  ip->ref++;
80101863:	8b 45 08             	mov    0x8(%ebp),%eax
80101866:	8b 40 08             	mov    0x8(%eax),%eax
80101869:	8d 50 01             	lea    0x1(%eax),%edx
8010186c:	8b 45 08             	mov    0x8(%ebp),%eax
8010186f:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101872:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101879:	e8 52 33 00 00       	call   80104bd0 <release>
  return ip;
8010187e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101881:	c9                   	leave  
80101882:	c3                   	ret    

80101883 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101883:	55                   	push   %ebp
80101884:	89 e5                	mov    %esp,%ebp
80101886:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101889:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010188d:	74 0a                	je     80101899 <ilock+0x16>
8010188f:	8b 45 08             	mov    0x8(%ebp),%eax
80101892:	8b 40 08             	mov    0x8(%eax),%eax
80101895:	85 c0                	test   %eax,%eax
80101897:	7f 0c                	jg     801018a5 <ilock+0x22>
    panic("ilock");
80101899:	c7 04 24 3f 82 10 80 	movl   $0x8010823f,(%esp)
801018a0:	e8 95 ec ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
801018a5:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
801018ac:	e8 be 32 00 00       	call   80104b6f <acquire>
  while(ip->flags & I_BUSY)
801018b1:	eb 13                	jmp    801018c6 <ilock+0x43>
    sleep(ip, &icache.lock);
801018b3:	c7 44 24 04 60 e8 10 	movl   $0x8010e860,0x4(%esp)
801018ba:	80 
801018bb:	8b 45 08             	mov    0x8(%ebp),%eax
801018be:	89 04 24             	mov    %eax,(%esp)
801018c1:	e8 d7 2f 00 00       	call   8010489d <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801018c6:	8b 45 08             	mov    0x8(%ebp),%eax
801018c9:	8b 40 0c             	mov    0xc(%eax),%eax
801018cc:	83 e0 01             	and    $0x1,%eax
801018cf:	84 c0                	test   %al,%al
801018d1:	75 e0                	jne    801018b3 <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801018d3:	8b 45 08             	mov    0x8(%ebp),%eax
801018d6:	8b 40 0c             	mov    0xc(%eax),%eax
801018d9:	89 c2                	mov    %eax,%edx
801018db:	83 ca 01             	or     $0x1,%edx
801018de:	8b 45 08             	mov    0x8(%ebp),%eax
801018e1:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801018e4:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
801018eb:	e8 e0 32 00 00       	call   80104bd0 <release>

  if(!(ip->flags & I_VALID)){
801018f0:	8b 45 08             	mov    0x8(%ebp),%eax
801018f3:	8b 40 0c             	mov    0xc(%eax),%eax
801018f6:	83 e0 02             	and    $0x2,%eax
801018f9:	85 c0                	test   %eax,%eax
801018fb:	0f 85 d1 00 00 00    	jne    801019d2 <ilock+0x14f>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101901:	8b 45 08             	mov    0x8(%ebp),%eax
80101904:	8b 40 04             	mov    0x4(%eax),%eax
80101907:	c1 e8 03             	shr    $0x3,%eax
8010190a:	8d 50 02             	lea    0x2(%eax),%edx
8010190d:	8b 45 08             	mov    0x8(%ebp),%eax
80101910:	8b 00                	mov    (%eax),%eax
80101912:	89 54 24 04          	mov    %edx,0x4(%esp)
80101916:	89 04 24             	mov    %eax,(%esp)
80101919:	e8 89 e8 ff ff       	call   801001a7 <bread>
8010191e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101921:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101924:	83 c0 18             	add    $0x18,%eax
80101927:	89 c2                	mov    %eax,%edx
80101929:	8b 45 08             	mov    0x8(%ebp),%eax
8010192c:	8b 40 04             	mov    0x4(%eax),%eax
8010192f:	83 e0 07             	and    $0x7,%eax
80101932:	c1 e0 06             	shl    $0x6,%eax
80101935:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101938:	89 45 f4             	mov    %eax,-0xc(%ebp)
    ip->type = dip->type;
8010193b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010193e:	0f b7 10             	movzwl (%eax),%edx
80101941:	8b 45 08             	mov    0x8(%ebp),%eax
80101944:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101948:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194b:	0f b7 50 02          	movzwl 0x2(%eax),%edx
8010194f:	8b 45 08             	mov    0x8(%ebp),%eax
80101952:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101956:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101959:	0f b7 50 04          	movzwl 0x4(%eax),%edx
8010195d:	8b 45 08             	mov    0x8(%ebp),%eax
80101960:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101964:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101967:	0f b7 50 06          	movzwl 0x6(%eax),%edx
8010196b:	8b 45 08             	mov    0x8(%ebp),%eax
8010196e:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
80101972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101975:	8b 50 08             	mov    0x8(%eax),%edx
80101978:	8b 45 08             	mov    0x8(%ebp),%eax
8010197b:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101981:	8d 50 0c             	lea    0xc(%eax),%edx
80101984:	8b 45 08             	mov    0x8(%ebp),%eax
80101987:	83 c0 1c             	add    $0x1c,%eax
8010198a:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101991:	00 
80101992:	89 54 24 04          	mov    %edx,0x4(%esp)
80101996:	89 04 24             	mov    %eax,(%esp)
80101999:	e8 f3 34 00 00       	call   80104e91 <memmove>
    brelse(bp);
8010199e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019a1:	89 04 24             	mov    %eax,(%esp)
801019a4:	e8 6f e8 ff ff       	call   80100218 <brelse>
    ip->flags |= I_VALID;
801019a9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ac:	8b 40 0c             	mov    0xc(%eax),%eax
801019af:	89 c2                	mov    %eax,%edx
801019b1:	83 ca 02             	or     $0x2,%edx
801019b4:	8b 45 08             	mov    0x8(%ebp),%eax
801019b7:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
801019ba:	8b 45 08             	mov    0x8(%ebp),%eax
801019bd:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801019c1:	66 85 c0             	test   %ax,%ax
801019c4:	75 0c                	jne    801019d2 <ilock+0x14f>
      panic("ilock: no type");
801019c6:	c7 04 24 45 82 10 80 	movl   $0x80108245,(%esp)
801019cd:	e8 68 eb ff ff       	call   8010053a <panic>
  }
}
801019d2:	c9                   	leave  
801019d3:	c3                   	ret    

801019d4 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801019d4:	55                   	push   %ebp
801019d5:	89 e5                	mov    %esp,%ebp
801019d7:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
801019da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019de:	74 17                	je     801019f7 <iunlock+0x23>
801019e0:	8b 45 08             	mov    0x8(%ebp),%eax
801019e3:	8b 40 0c             	mov    0xc(%eax),%eax
801019e6:	83 e0 01             	and    $0x1,%eax
801019e9:	85 c0                	test   %eax,%eax
801019eb:	74 0a                	je     801019f7 <iunlock+0x23>
801019ed:	8b 45 08             	mov    0x8(%ebp),%eax
801019f0:	8b 40 08             	mov    0x8(%eax),%eax
801019f3:	85 c0                	test   %eax,%eax
801019f5:	7f 0c                	jg     80101a03 <iunlock+0x2f>
    panic("iunlock");
801019f7:	c7 04 24 54 82 10 80 	movl   $0x80108254,(%esp)
801019fe:	e8 37 eb ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
80101a03:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101a0a:	e8 60 31 00 00       	call   80104b6f <acquire>
  ip->flags &= ~I_BUSY;
80101a0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a12:	8b 40 0c             	mov    0xc(%eax),%eax
80101a15:	89 c2                	mov    %eax,%edx
80101a17:	83 e2 fe             	and    $0xfffffffe,%edx
80101a1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1d:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101a20:	8b 45 08             	mov    0x8(%ebp),%eax
80101a23:	89 04 24             	mov    %eax,(%esp)
80101a26:	e8 4c 2f 00 00       	call   80104977 <wakeup>
  release(&icache.lock);
80101a2b:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101a32:	e8 99 31 00 00       	call   80104bd0 <release>
}
80101a37:	c9                   	leave  
80101a38:	c3                   	ret    

80101a39 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101a39:	55                   	push   %ebp
80101a3a:	89 e5                	mov    %esp,%ebp
80101a3c:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101a3f:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101a46:	e8 24 31 00 00       	call   80104b6f <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101a4b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4e:	8b 40 08             	mov    0x8(%eax),%eax
80101a51:	83 f8 01             	cmp    $0x1,%eax
80101a54:	0f 85 93 00 00 00    	jne    80101aed <iput+0xb4>
80101a5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5d:	8b 40 0c             	mov    0xc(%eax),%eax
80101a60:	83 e0 02             	and    $0x2,%eax
80101a63:	85 c0                	test   %eax,%eax
80101a65:	0f 84 82 00 00 00    	je     80101aed <iput+0xb4>
80101a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6e:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101a72:	66 85 c0             	test   %ax,%ax
80101a75:	75 76                	jne    80101aed <iput+0xb4>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101a77:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7a:	8b 40 0c             	mov    0xc(%eax),%eax
80101a7d:	83 e0 01             	and    $0x1,%eax
80101a80:	84 c0                	test   %al,%al
80101a82:	74 0c                	je     80101a90 <iput+0x57>
      panic("iput busy");
80101a84:	c7 04 24 5c 82 10 80 	movl   $0x8010825c,(%esp)
80101a8b:	e8 aa ea ff ff       	call   8010053a <panic>
    ip->flags |= I_BUSY;
80101a90:	8b 45 08             	mov    0x8(%ebp),%eax
80101a93:	8b 40 0c             	mov    0xc(%eax),%eax
80101a96:	89 c2                	mov    %eax,%edx
80101a98:	83 ca 01             	or     $0x1,%edx
80101a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9e:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101aa1:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101aa8:	e8 23 31 00 00       	call   80104bd0 <release>
    itrunc(ip);
80101aad:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab0:	89 04 24             	mov    %eax,(%esp)
80101ab3:	e8 72 01 00 00       	call   80101c2a <itrunc>
    ip->type = 0;
80101ab8:	8b 45 08             	mov    0x8(%ebp),%eax
80101abb:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101ac1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac4:	89 04 24             	mov    %eax,(%esp)
80101ac7:	e8 f7 fb ff ff       	call   801016c3 <iupdate>
    acquire(&icache.lock);
80101acc:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101ad3:	e8 97 30 00 00       	call   80104b6f <acquire>
    ip->flags = 0;
80101ad8:	8b 45 08             	mov    0x8(%ebp),%eax
80101adb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101ae2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae5:	89 04 24             	mov    %eax,(%esp)
80101ae8:	e8 8a 2e 00 00       	call   80104977 <wakeup>
  }
  ip->ref--;
80101aed:	8b 45 08             	mov    0x8(%ebp),%eax
80101af0:	8b 40 08             	mov    0x8(%eax),%eax
80101af3:	8d 50 ff             	lea    -0x1(%eax),%edx
80101af6:	8b 45 08             	mov    0x8(%ebp),%eax
80101af9:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101afc:	c7 04 24 60 e8 10 80 	movl   $0x8010e860,(%esp)
80101b03:	e8 c8 30 00 00       	call   80104bd0 <release>
}
80101b08:	c9                   	leave  
80101b09:	c3                   	ret    

80101b0a <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b0a:	55                   	push   %ebp
80101b0b:	89 e5                	mov    %esp,%ebp
80101b0d:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101b10:	8b 45 08             	mov    0x8(%ebp),%eax
80101b13:	89 04 24             	mov    %eax,(%esp)
80101b16:	e8 b9 fe ff ff       	call   801019d4 <iunlock>
  iput(ip);
80101b1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1e:	89 04 24             	mov    %eax,(%esp)
80101b21:	e8 13 ff ff ff       	call   80101a39 <iput>
}
80101b26:	c9                   	leave  
80101b27:	c3                   	ret    

80101b28 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101b28:	55                   	push   %ebp
80101b29:	89 e5                	mov    %esp,%ebp
80101b2b:	53                   	push   %ebx
80101b2c:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101b2f:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101b33:	77 3e                	ja     80101b73 <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101b35:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b38:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3b:	83 c2 04             	add    $0x4,%edx
80101b3e:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101b42:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b45:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101b49:	75 20                	jne    80101b6b <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101b4b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80101b4e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b51:	8b 00                	mov    (%eax),%eax
80101b53:	89 04 24             	mov    %eax,(%esp)
80101b56:	e8 2c f8 ff ff       	call   80101387 <balloc>
80101b5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b61:	8d 4b 04             	lea    0x4(%ebx),%ecx
80101b64:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b67:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101b6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b6e:	e9 b1 00 00 00       	jmp    80101c24 <bmap+0xfc>
  }
  bn -= NDIRECT;
80101b73:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101b77:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101b7b:	0f 87 97 00 00 00    	ja     80101c18 <bmap+0xf0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101b81:	8b 45 08             	mov    0x8(%ebp),%eax
80101b84:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b87:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b8a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101b8e:	75 19                	jne    80101ba9 <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101b90:	8b 45 08             	mov    0x8(%ebp),%eax
80101b93:	8b 00                	mov    (%eax),%eax
80101b95:	89 04 24             	mov    %eax,(%esp)
80101b98:	e8 ea f7 ff ff       	call   80101387 <balloc>
80101b9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101ba0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba3:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101ba6:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bac:	8b 00                	mov    (%eax),%eax
80101bae:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101bb1:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bb5:	89 04 24             	mov    %eax,(%esp)
80101bb8:	e8 ea e5 ff ff       	call   801001a7 <bread>
80101bbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    a = (uint*)bp->data;
80101bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bc3:	83 c0 18             	add    $0x18,%eax
80101bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((addr = a[bn]) == 0){
80101bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bcc:	c1 e0 02             	shl    $0x2,%eax
80101bcf:	03 45 f0             	add    -0x10(%ebp),%eax
80101bd2:	8b 00                	mov    (%eax),%eax
80101bd4:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101bd7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101bdb:	75 2b                	jne    80101c08 <bmap+0xe0>
      a[bn] = addr = balloc(ip->dev);
80101bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101be0:	c1 e0 02             	shl    $0x2,%eax
80101be3:	89 c3                	mov    %eax,%ebx
80101be5:	03 5d f0             	add    -0x10(%ebp),%ebx
80101be8:	8b 45 08             	mov    0x8(%ebp),%eax
80101beb:	8b 00                	mov    (%eax),%eax
80101bed:	89 04 24             	mov    %eax,(%esp)
80101bf0:	e8 92 f7 ff ff       	call   80101387 <balloc>
80101bf5:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101bf8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101bfb:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c00:	89 04 24             	mov    %eax,(%esp)
80101c03:	e8 a2 16 00 00       	call   801032aa <log_write>
    }
    brelse(bp);
80101c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c0b:	89 04 24             	mov    %eax,(%esp)
80101c0e:	e8 05 e6 ff ff       	call   80100218 <brelse>
    return addr;
80101c13:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c16:	eb 0c                	jmp    80101c24 <bmap+0xfc>
  }

  panic("bmap: out of range");
80101c18:	c7 04 24 66 82 10 80 	movl   $0x80108266,(%esp)
80101c1f:	e8 16 e9 ff ff       	call   8010053a <panic>
}
80101c24:	83 c4 24             	add    $0x24,%esp
80101c27:	5b                   	pop    %ebx
80101c28:	5d                   	pop    %ebp
80101c29:	c3                   	ret    

80101c2a <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101c2a:	55                   	push   %ebp
80101c2b:	89 e5                	mov    %esp,%ebp
80101c2d:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c30:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80101c37:	eb 44                	jmp    80101c7d <itrunc+0x53>
    if(ip->addrs[i]){
80101c39:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c3c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3f:	83 c2 04             	add    $0x4,%edx
80101c42:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c46:	85 c0                	test   %eax,%eax
80101c48:	74 2f                	je     80101c79 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101c4a:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c50:	83 c2 04             	add    $0x4,%edx
80101c53:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101c57:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5a:	8b 00                	mov    (%eax),%eax
80101c5c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c60:	89 04 24             	mov    %eax,(%esp)
80101c63:	e8 80 f8 ff ff       	call   801014e8 <bfree>
      ip->addrs[i] = 0;
80101c68:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6e:	83 c2 04             	add    $0x4,%edx
80101c71:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101c78:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c79:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
80101c7d:	83 7d e8 0b          	cmpl   $0xb,-0x18(%ebp)
80101c81:	7e b6                	jle    80101c39 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101c83:	8b 45 08             	mov    0x8(%ebp),%eax
80101c86:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c89:	85 c0                	test   %eax,%eax
80101c8b:	0f 84 8f 00 00 00    	je     80101d20 <itrunc+0xf6>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c91:	8b 45 08             	mov    0x8(%ebp),%eax
80101c94:	8b 50 4c             	mov    0x4c(%eax),%edx
80101c97:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9a:	8b 00                	mov    (%eax),%eax
80101c9c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ca0:	89 04 24             	mov    %eax,(%esp)
80101ca3:	e8 ff e4 ff ff       	call   801001a7 <bread>
80101ca8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101cab:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cae:	83 c0 18             	add    $0x18,%eax
80101cb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101cb4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101cbb:	eb 2f                	jmp    80101cec <itrunc+0xc2>
      if(a[j])
80101cbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cc0:	c1 e0 02             	shl    $0x2,%eax
80101cc3:	03 45 f4             	add    -0xc(%ebp),%eax
80101cc6:	8b 00                	mov    (%eax),%eax
80101cc8:	85 c0                	test   %eax,%eax
80101cca:	74 1c                	je     80101ce8 <itrunc+0xbe>
        bfree(ip->dev, a[j]);
80101ccc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ccf:	c1 e0 02             	shl    $0x2,%eax
80101cd2:	03 45 f4             	add    -0xc(%ebp),%eax
80101cd5:	8b 10                	mov    (%eax),%edx
80101cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cda:	8b 00                	mov    (%eax),%eax
80101cdc:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ce0:	89 04 24             	mov    %eax,(%esp)
80101ce3:	e8 00 f8 ff ff       	call   801014e8 <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101ce8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80101cec:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cef:	83 f8 7f             	cmp    $0x7f,%eax
80101cf2:	76 c9                	jbe    80101cbd <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cf7:	89 04 24             	mov    %eax,(%esp)
80101cfa:	e8 19 e5 ff ff       	call   80100218 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101cff:	8b 45 08             	mov    0x8(%ebp),%eax
80101d02:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d05:	8b 45 08             	mov    0x8(%ebp),%eax
80101d08:	8b 00                	mov    (%eax),%eax
80101d0a:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d0e:	89 04 24             	mov    %eax,(%esp)
80101d11:	e8 d2 f7 ff ff       	call   801014e8 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d16:	8b 45 08             	mov    0x8(%ebp),%eax
80101d19:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101d20:	8b 45 08             	mov    0x8(%ebp),%eax
80101d23:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101d2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d2d:	89 04 24             	mov    %eax,(%esp)
80101d30:	e8 8e f9 ff ff       	call   801016c3 <iupdate>
}
80101d35:	c9                   	leave  
80101d36:	c3                   	ret    

80101d37 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101d37:	55                   	push   %ebp
80101d38:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101d3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3d:	8b 00                	mov    (%eax),%eax
80101d3f:	89 c2                	mov    %eax,%edx
80101d41:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d44:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101d47:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4a:	8b 50 04             	mov    0x4(%eax),%edx
80101d4d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d50:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101d53:	8b 45 08             	mov    0x8(%ebp),%eax
80101d56:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101d5a:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d5d:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101d60:	8b 45 08             	mov    0x8(%ebp),%eax
80101d63:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101d67:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d6a:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101d6e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d71:	8b 50 18             	mov    0x18(%eax),%edx
80101d74:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d77:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d7a:	5d                   	pop    %ebp
80101d7b:	c3                   	ret    

80101d7c <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d7c:	55                   	push   %ebp
80101d7d:	89 e5                	mov    %esp,%ebp
80101d7f:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d82:	8b 45 08             	mov    0x8(%ebp),%eax
80101d85:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101d89:	66 83 f8 03          	cmp    $0x3,%ax
80101d8d:	75 60                	jne    80101def <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d92:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d96:	66 85 c0             	test   %ax,%ax
80101d99:	78 20                	js     80101dbb <readi+0x3f>
80101d9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d9e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101da2:	66 83 f8 09          	cmp    $0x9,%ax
80101da6:	7f 13                	jg     80101dbb <readi+0x3f>
80101da8:	8b 45 08             	mov    0x8(%ebp),%eax
80101dab:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101daf:	98                   	cwtl   
80101db0:	8b 04 c5 00 e8 10 80 	mov    -0x7fef1800(,%eax,8),%eax
80101db7:	85 c0                	test   %eax,%eax
80101db9:	75 0a                	jne    80101dc5 <readi+0x49>
      return -1;
80101dbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dc0:	e9 19 01 00 00       	jmp    80101ede <readi+0x162>
    return devsw[ip->major].read(ip, dst, n);
80101dc5:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101dcc:	98                   	cwtl   
80101dcd:	8b 14 c5 00 e8 10 80 	mov    -0x7fef1800(,%eax,8),%edx
80101dd4:	8b 45 14             	mov    0x14(%ebp),%eax
80101dd7:	89 44 24 08          	mov    %eax,0x8(%esp)
80101ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dde:	89 44 24 04          	mov    %eax,0x4(%esp)
80101de2:	8b 45 08             	mov    0x8(%ebp),%eax
80101de5:	89 04 24             	mov    %eax,(%esp)
80101de8:	ff d2                	call   *%edx
80101dea:	e9 ef 00 00 00       	jmp    80101ede <readi+0x162>
  }

  if(off > ip->size || off + n < off)
80101def:	8b 45 08             	mov    0x8(%ebp),%eax
80101df2:	8b 40 18             	mov    0x18(%eax),%eax
80101df5:	3b 45 10             	cmp    0x10(%ebp),%eax
80101df8:	72 0e                	jb     80101e08 <readi+0x8c>
80101dfa:	8b 45 14             	mov    0x14(%ebp),%eax
80101dfd:	8b 55 10             	mov    0x10(%ebp),%edx
80101e00:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101e03:	3b 45 10             	cmp    0x10(%ebp),%eax
80101e06:	73 0a                	jae    80101e12 <readi+0x96>
    return -1;
80101e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e0d:	e9 cc 00 00 00       	jmp    80101ede <readi+0x162>
  if(off + n > ip->size)
80101e12:	8b 45 14             	mov    0x14(%ebp),%eax
80101e15:	8b 55 10             	mov    0x10(%ebp),%edx
80101e18:	01 c2                	add    %eax,%edx
80101e1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1d:	8b 40 18             	mov    0x18(%eax),%eax
80101e20:	39 c2                	cmp    %eax,%edx
80101e22:	76 0c                	jbe    80101e30 <readi+0xb4>
    n = ip->size - off;
80101e24:	8b 45 08             	mov    0x8(%ebp),%eax
80101e27:	8b 40 18             	mov    0x18(%eax),%eax
80101e2a:	2b 45 10             	sub    0x10(%ebp),%eax
80101e2d:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e30:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101e37:	e9 93 00 00 00       	jmp    80101ecf <readi+0x153>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e3c:	8b 45 10             	mov    0x10(%ebp),%eax
80101e3f:	c1 e8 09             	shr    $0x9,%eax
80101e42:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e46:	8b 45 08             	mov    0x8(%ebp),%eax
80101e49:	89 04 24             	mov    %eax,(%esp)
80101e4c:	e8 d7 fc ff ff       	call   80101b28 <bmap>
80101e51:	8b 55 08             	mov    0x8(%ebp),%edx
80101e54:	8b 12                	mov    (%edx),%edx
80101e56:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e5a:	89 14 24             	mov    %edx,(%esp)
80101e5d:	e8 45 e3 ff ff       	call   801001a7 <bread>
80101e62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101e65:	8b 45 10             	mov    0x10(%ebp),%eax
80101e68:	89 c2                	mov    %eax,%edx
80101e6a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101e70:	b8 00 02 00 00       	mov    $0x200,%eax
80101e75:	89 c1                	mov    %eax,%ecx
80101e77:	29 d1                	sub    %edx,%ecx
80101e79:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e7c:	8b 55 14             	mov    0x14(%ebp),%edx
80101e7f:	29 c2                	sub    %eax,%edx
80101e81:	89 c8                	mov    %ecx,%eax
80101e83:	39 d0                	cmp    %edx,%eax
80101e85:	76 02                	jbe    80101e89 <readi+0x10d>
80101e87:	89 d0                	mov    %edx,%eax
80101e89:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e8f:	8d 50 18             	lea    0x18(%eax),%edx
80101e92:	8b 45 10             	mov    0x10(%ebp),%eax
80101e95:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e9a:	01 c2                	add    %eax,%edx
80101e9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e9f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101ea3:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eaa:	89 04 24             	mov    %eax,(%esp)
80101ead:	e8 df 2f 00 00       	call   80104e91 <memmove>
    brelse(bp);
80101eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101eb5:	89 04 24             	mov    %eax,(%esp)
80101eb8:	e8 5b e3 ff ff       	call   80100218 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ebd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ec0:	01 45 ec             	add    %eax,-0x14(%ebp)
80101ec3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ec6:	01 45 10             	add    %eax,0x10(%ebp)
80101ec9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ecc:	01 45 0c             	add    %eax,0xc(%ebp)
80101ecf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ed2:	3b 45 14             	cmp    0x14(%ebp),%eax
80101ed5:	0f 82 61 ff ff ff    	jb     80101e3c <readi+0xc0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101edb:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101ede:	c9                   	leave  
80101edf:	c3                   	ret    

80101ee0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	83 ec 28             	sub    $0x28,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ee6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101eed:	66 83 f8 03          	cmp    $0x3,%ax
80101ef1:	75 60                	jne    80101f53 <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ef3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef6:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101efa:	66 85 c0             	test   %ax,%ax
80101efd:	78 20                	js     80101f1f <writei+0x3f>
80101eff:	8b 45 08             	mov    0x8(%ebp),%eax
80101f02:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f06:	66 83 f8 09          	cmp    $0x9,%ax
80101f0a:	7f 13                	jg     80101f1f <writei+0x3f>
80101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f13:	98                   	cwtl   
80101f14:	8b 04 c5 04 e8 10 80 	mov    -0x7fef17fc(,%eax,8),%eax
80101f1b:	85 c0                	test   %eax,%eax
80101f1d:	75 0a                	jne    80101f29 <writei+0x49>
      return -1;
80101f1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f24:	e9 45 01 00 00       	jmp    8010206e <writei+0x18e>
    return devsw[ip->major].write(ip, src, n);
80101f29:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2c:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f30:	98                   	cwtl   
80101f31:	8b 14 c5 04 e8 10 80 	mov    -0x7fef17fc(,%eax,8),%edx
80101f38:	8b 45 14             	mov    0x14(%ebp),%eax
80101f3b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f42:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f46:	8b 45 08             	mov    0x8(%ebp),%eax
80101f49:	89 04 24             	mov    %eax,(%esp)
80101f4c:	ff d2                	call   *%edx
80101f4e:	e9 1b 01 00 00       	jmp    8010206e <writei+0x18e>
  }

  if(off > ip->size || off + n < off)
80101f53:	8b 45 08             	mov    0x8(%ebp),%eax
80101f56:	8b 40 18             	mov    0x18(%eax),%eax
80101f59:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f5c:	72 0e                	jb     80101f6c <writei+0x8c>
80101f5e:	8b 45 14             	mov    0x14(%ebp),%eax
80101f61:	8b 55 10             	mov    0x10(%ebp),%edx
80101f64:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101f67:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f6a:	73 0a                	jae    80101f76 <writei+0x96>
    return -1;
80101f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f71:	e9 f8 00 00 00       	jmp    8010206e <writei+0x18e>
  if(off + n > MAXFILE*BSIZE)
80101f76:	8b 45 14             	mov    0x14(%ebp),%eax
80101f79:	8b 55 10             	mov    0x10(%ebp),%edx
80101f7c:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101f7f:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f84:	76 0a                	jbe    80101f90 <writei+0xb0>
    return -1;
80101f86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f8b:	e9 de 00 00 00       	jmp    8010206e <writei+0x18e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101f97:	e9 9e 00 00 00       	jmp    8010203a <writei+0x15a>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f9c:	8b 45 10             	mov    0x10(%ebp),%eax
80101f9f:	c1 e8 09             	shr    $0x9,%eax
80101fa2:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa9:	89 04 24             	mov    %eax,(%esp)
80101fac:	e8 77 fb ff ff       	call   80101b28 <bmap>
80101fb1:	8b 55 08             	mov    0x8(%ebp),%edx
80101fb4:	8b 12                	mov    (%edx),%edx
80101fb6:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fba:	89 14 24             	mov    %edx,(%esp)
80101fbd:	e8 e5 e1 ff ff       	call   801001a7 <bread>
80101fc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fc5:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc8:	89 c2                	mov    %eax,%edx
80101fca:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101fd0:	b8 00 02 00 00       	mov    $0x200,%eax
80101fd5:	89 c1                	mov    %eax,%ecx
80101fd7:	29 d1                	sub    %edx,%ecx
80101fd9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fdc:	8b 55 14             	mov    0x14(%ebp),%edx
80101fdf:	29 c2                	sub    %eax,%edx
80101fe1:	89 c8                	mov    %ecx,%eax
80101fe3:	39 d0                	cmp    %edx,%eax
80101fe5:	76 02                	jbe    80101fe9 <writei+0x109>
80101fe7:	89 d0                	mov    %edx,%eax
80101fe9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80101fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fef:	8d 50 18             	lea    0x18(%eax),%edx
80101ff2:	8b 45 10             	mov    0x10(%ebp),%eax
80101ff5:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ffa:	01 c2                	add    %eax,%edx
80101ffc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101fff:	89 44 24 08          	mov    %eax,0x8(%esp)
80102003:	8b 45 0c             	mov    0xc(%ebp),%eax
80102006:	89 44 24 04          	mov    %eax,0x4(%esp)
8010200a:	89 14 24             	mov    %edx,(%esp)
8010200d:	e8 7f 2e 00 00       	call   80104e91 <memmove>
    log_write(bp);
80102012:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102015:	89 04 24             	mov    %eax,(%esp)
80102018:	e8 8d 12 00 00       	call   801032aa <log_write>
    brelse(bp);
8010201d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102020:	89 04 24             	mov    %eax,(%esp)
80102023:	e8 f0 e1 ff ff       	call   80100218 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102028:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010202b:	01 45 ec             	add    %eax,-0x14(%ebp)
8010202e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102031:	01 45 10             	add    %eax,0x10(%ebp)
80102034:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102037:	01 45 0c             	add    %eax,0xc(%ebp)
8010203a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010203d:	3b 45 14             	cmp    0x14(%ebp),%eax
80102040:	0f 82 56 ff ff ff    	jb     80101f9c <writei+0xbc>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102046:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010204a:	74 1f                	je     8010206b <writei+0x18b>
8010204c:	8b 45 08             	mov    0x8(%ebp),%eax
8010204f:	8b 40 18             	mov    0x18(%eax),%eax
80102052:	3b 45 10             	cmp    0x10(%ebp),%eax
80102055:	73 14                	jae    8010206b <writei+0x18b>
    ip->size = off;
80102057:	8b 45 08             	mov    0x8(%ebp),%eax
8010205a:	8b 55 10             	mov    0x10(%ebp),%edx
8010205d:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102060:	8b 45 08             	mov    0x8(%ebp),%eax
80102063:	89 04 24             	mov    %eax,(%esp)
80102066:	e8 58 f6 ff ff       	call   801016c3 <iupdate>
  }
  return n;
8010206b:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010206e:	c9                   	leave  
8010206f:	c3                   	ret    

80102070 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80102076:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
8010207d:	00 
8010207e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102081:	89 44 24 04          	mov    %eax,0x4(%esp)
80102085:	8b 45 08             	mov    0x8(%ebp),%eax
80102088:	89 04 24             	mov    %eax,(%esp)
8010208b:	e8 a9 2e 00 00       	call   80104f39 <strncmp>
}
80102090:	c9                   	leave  
80102091:	c3                   	ret    

80102092 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102092:	55                   	push   %ebp
80102093:	89 e5                	mov    %esp,%ebp
80102095:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102098:	8b 45 08             	mov    0x8(%ebp),%eax
8010209b:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010209f:	66 83 f8 01          	cmp    $0x1,%ax
801020a3:	74 0c                	je     801020b1 <dirlookup+0x1f>
    panic("dirlookup not DIR");
801020a5:	c7 04 24 79 82 10 80 	movl   $0x80108279,(%esp)
801020ac:	e8 89 e4 ff ff       	call   8010053a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801020b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801020b8:	e9 87 00 00 00       	jmp    80102144 <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020bd:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020c0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801020c7:	00 
801020c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801020cb:	89 54 24 08          	mov    %edx,0x8(%esp)
801020cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801020d3:	8b 45 08             	mov    0x8(%ebp),%eax
801020d6:	89 04 24             	mov    %eax,(%esp)
801020d9:	e8 9e fc ff ff       	call   80101d7c <readi>
801020de:	83 f8 10             	cmp    $0x10,%eax
801020e1:	74 0c                	je     801020ef <dirlookup+0x5d>
      panic("dirlink read");
801020e3:	c7 04 24 8b 82 10 80 	movl   $0x8010828b,(%esp)
801020ea:	e8 4b e4 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801020ef:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801020f3:	66 85 c0             	test   %ax,%ax
801020f6:	74 47                	je     8010213f <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
801020f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020fb:	83 c0 02             	add    $0x2,%eax
801020fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80102102:	8b 45 0c             	mov    0xc(%ebp),%eax
80102105:	89 04 24             	mov    %eax,(%esp)
80102108:	e8 63 ff ff ff       	call   80102070 <namecmp>
8010210d:	85 c0                	test   %eax,%eax
8010210f:	75 2f                	jne    80102140 <dirlookup+0xae>
      // entry matches path element
      if(poff)
80102111:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102115:	74 08                	je     8010211f <dirlookup+0x8d>
        *poff = off;
80102117:	8b 45 10             	mov    0x10(%ebp),%eax
8010211a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010211d:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010211f:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102123:	0f b7 c0             	movzwl %ax,%eax
80102126:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return iget(dp->dev, inum);
80102129:	8b 45 08             	mov    0x8(%ebp),%eax
8010212c:	8b 00                	mov    (%eax),%eax
8010212e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102131:	89 54 24 04          	mov    %edx,0x4(%esp)
80102135:	89 04 24             	mov    %eax,(%esp)
80102138:	e8 41 f6 ff ff       	call   8010177e <iget>
8010213d:	eb 19                	jmp    80102158 <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
8010213f:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102140:	83 45 f0 10          	addl   $0x10,-0x10(%ebp)
80102144:	8b 45 08             	mov    0x8(%ebp),%eax
80102147:	8b 40 18             	mov    0x18(%eax),%eax
8010214a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010214d:	0f 87 6a ff ff ff    	ja     801020bd <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102153:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102158:	c9                   	leave  
80102159:	c3                   	ret    

8010215a <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010215a:	55                   	push   %ebp
8010215b:	89 e5                	mov    %esp,%ebp
8010215d:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102160:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80102167:	00 
80102168:	8b 45 0c             	mov    0xc(%ebp),%eax
8010216b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010216f:	8b 45 08             	mov    0x8(%ebp),%eax
80102172:	89 04 24             	mov    %eax,(%esp)
80102175:	e8 18 ff ff ff       	call   80102092 <dirlookup>
8010217a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010217d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102181:	74 15                	je     80102198 <dirlink+0x3e>
    iput(ip);
80102183:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102186:	89 04 24             	mov    %eax,(%esp)
80102189:	e8 ab f8 ff ff       	call   80101a39 <iput>
    return -1;
8010218e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102193:	e9 b8 00 00 00       	jmp    80102250 <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102198:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010219f:	eb 44                	jmp    801021e5 <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021a7:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801021ae:	00 
801021af:	89 54 24 08          	mov    %edx,0x8(%esp)
801021b3:	89 44 24 04          	mov    %eax,0x4(%esp)
801021b7:	8b 45 08             	mov    0x8(%ebp),%eax
801021ba:	89 04 24             	mov    %eax,(%esp)
801021bd:	e8 ba fb ff ff       	call   80101d7c <readi>
801021c2:	83 f8 10             	cmp    $0x10,%eax
801021c5:	74 0c                	je     801021d3 <dirlink+0x79>
      panic("dirlink read");
801021c7:	c7 04 24 8b 82 10 80 	movl   $0x8010828b,(%esp)
801021ce:	e8 67 e3 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801021d3:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021d7:	66 85 c0             	test   %ax,%ax
801021da:	74 18                	je     801021f4 <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021df:	83 c0 10             	add    $0x10,%eax
801021e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801021e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021e8:	8b 45 08             	mov    0x8(%ebp),%eax
801021eb:	8b 40 18             	mov    0x18(%eax),%eax
801021ee:	39 c2                	cmp    %eax,%edx
801021f0:	72 af                	jb     801021a1 <dirlink+0x47>
801021f2:	eb 01                	jmp    801021f5 <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801021f4:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801021f5:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801021fc:	00 
801021fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102200:	89 44 24 04          	mov    %eax,0x4(%esp)
80102204:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102207:	83 c0 02             	add    $0x2,%eax
8010220a:	89 04 24             	mov    %eax,(%esp)
8010220d:	e8 7f 2d 00 00       	call   80104f91 <strncpy>
  de.inum = inum;
80102212:	8b 45 10             	mov    0x10(%ebp),%eax
80102215:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102219:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010221c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010221f:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80102226:	00 
80102227:	89 54 24 08          	mov    %edx,0x8(%esp)
8010222b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010222f:	8b 45 08             	mov    0x8(%ebp),%eax
80102232:	89 04 24             	mov    %eax,(%esp)
80102235:	e8 a6 fc ff ff       	call   80101ee0 <writei>
8010223a:	83 f8 10             	cmp    $0x10,%eax
8010223d:	74 0c                	je     8010224b <dirlink+0xf1>
    panic("dirlink");
8010223f:	c7 04 24 98 82 10 80 	movl   $0x80108298,(%esp)
80102246:	e8 ef e2 ff ff       	call   8010053a <panic>
  
  return 0;
8010224b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102250:	c9                   	leave  
80102251:	c3                   	ret    

80102252 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102252:	55                   	push   %ebp
80102253:	89 e5                	mov    %esp,%ebp
80102255:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
80102258:	eb 04                	jmp    8010225e <skipelem+0xc>
    path++;
8010225a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
8010225e:	8b 45 08             	mov    0x8(%ebp),%eax
80102261:	0f b6 00             	movzbl (%eax),%eax
80102264:	3c 2f                	cmp    $0x2f,%al
80102266:	74 f2                	je     8010225a <skipelem+0x8>
    path++;
  if(*path == 0)
80102268:	8b 45 08             	mov    0x8(%ebp),%eax
8010226b:	0f b6 00             	movzbl (%eax),%eax
8010226e:	84 c0                	test   %al,%al
80102270:	75 0a                	jne    8010227c <skipelem+0x2a>
    return 0;
80102272:	b8 00 00 00 00       	mov    $0x0,%eax
80102277:	e9 86 00 00 00       	jmp    80102302 <skipelem+0xb0>
  s = path;
8010227c:	8b 45 08             	mov    0x8(%ebp),%eax
8010227f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(*path != '/' && *path != 0)
80102282:	eb 04                	jmp    80102288 <skipelem+0x36>
    path++;
80102284:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102288:	8b 45 08             	mov    0x8(%ebp),%eax
8010228b:	0f b6 00             	movzbl (%eax),%eax
8010228e:	3c 2f                	cmp    $0x2f,%al
80102290:	74 0a                	je     8010229c <skipelem+0x4a>
80102292:	8b 45 08             	mov    0x8(%ebp),%eax
80102295:	0f b6 00             	movzbl (%eax),%eax
80102298:	84 c0                	test   %al,%al
8010229a:	75 e8                	jne    80102284 <skipelem+0x32>
    path++;
  len = path - s;
8010229c:	8b 55 08             	mov    0x8(%ebp),%edx
8010229f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022a2:	89 d1                	mov    %edx,%ecx
801022a4:	29 c1                	sub    %eax,%ecx
801022a6:	89 c8                	mov    %ecx,%eax
801022a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(len >= DIRSIZ)
801022ab:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801022af:	7e 1c                	jle    801022cd <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
801022b1:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801022b8:	00 
801022b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801022c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801022c3:	89 04 24             	mov    %eax,(%esp)
801022c6:	e8 c6 2b 00 00       	call   80104e91 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022cb:	eb 28                	jmp    801022f5 <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801022cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d0:	89 44 24 08          	mov    %eax,0x8(%esp)
801022d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801022db:	8b 45 0c             	mov    0xc(%ebp),%eax
801022de:	89 04 24             	mov    %eax,(%esp)
801022e1:	e8 ab 2b 00 00       	call   80104e91 <memmove>
    name[len] = 0;
801022e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022e9:	03 45 0c             	add    0xc(%ebp),%eax
801022ec:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801022ef:	eb 04                	jmp    801022f5 <skipelem+0xa3>
    path++;
801022f1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022f5:	8b 45 08             	mov    0x8(%ebp),%eax
801022f8:	0f b6 00             	movzbl (%eax),%eax
801022fb:	3c 2f                	cmp    $0x2f,%al
801022fd:	74 f2                	je     801022f1 <skipelem+0x9f>
    path++;
  return path;
801022ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102302:	c9                   	leave  
80102303:	c3                   	ret    

80102304 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102304:	55                   	push   %ebp
80102305:	89 e5                	mov    %esp,%ebp
80102307:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010230a:	8b 45 08             	mov    0x8(%ebp),%eax
8010230d:	0f b6 00             	movzbl (%eax),%eax
80102310:	3c 2f                	cmp    $0x2f,%al
80102312:	75 1c                	jne    80102330 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
80102314:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010231b:	00 
8010231c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102323:	e8 56 f4 ff ff       	call   8010177e <iget>
80102328:	89 45 f0             	mov    %eax,-0x10(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010232b:	e9 af 00 00 00       	jmp    801023df <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80102330:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102336:	8b 40 68             	mov    0x68(%eax),%eax
80102339:	89 04 24             	mov    %eax,(%esp)
8010233c:	e8 10 f5 ff ff       	call   80101851 <idup>
80102341:	89 45 f0             	mov    %eax,-0x10(%ebp)

  while((path = skipelem(path, name)) != 0){
80102344:	e9 96 00 00 00       	jmp    801023df <namex+0xdb>
    ilock(ip);
80102349:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010234c:	89 04 24             	mov    %eax,(%esp)
8010234f:	e8 2f f5 ff ff       	call   80101883 <ilock>
    if(ip->type != T_DIR){
80102354:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102357:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010235b:	66 83 f8 01          	cmp    $0x1,%ax
8010235f:	74 15                	je     80102376 <namex+0x72>
      iunlockput(ip);
80102361:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102364:	89 04 24             	mov    %eax,(%esp)
80102367:	e8 9e f7 ff ff       	call   80101b0a <iunlockput>
      return 0;
8010236c:	b8 00 00 00 00       	mov    $0x0,%eax
80102371:	e9 a3 00 00 00       	jmp    80102419 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
80102376:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010237a:	74 1d                	je     80102399 <namex+0x95>
8010237c:	8b 45 08             	mov    0x8(%ebp),%eax
8010237f:	0f b6 00             	movzbl (%eax),%eax
80102382:	84 c0                	test   %al,%al
80102384:	75 13                	jne    80102399 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
80102386:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102389:	89 04 24             	mov    %eax,(%esp)
8010238c:	e8 43 f6 ff ff       	call   801019d4 <iunlock>
      return ip;
80102391:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102394:	e9 80 00 00 00       	jmp    80102419 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102399:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801023a0:	00 
801023a1:	8b 45 10             	mov    0x10(%ebp),%eax
801023a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801023a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023ab:	89 04 24             	mov    %eax,(%esp)
801023ae:	e8 df fc ff ff       	call   80102092 <dirlookup>
801023b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801023ba:	75 12                	jne    801023ce <namex+0xca>
      iunlockput(ip);
801023bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023bf:	89 04 24             	mov    %eax,(%esp)
801023c2:	e8 43 f7 ff ff       	call   80101b0a <iunlockput>
      return 0;
801023c7:	b8 00 00 00 00       	mov    $0x0,%eax
801023cc:	eb 4b                	jmp    80102419 <namex+0x115>
    }
    iunlockput(ip);
801023ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d1:	89 04 24             	mov    %eax,(%esp)
801023d4:	e8 31 f7 ff ff       	call   80101b0a <iunlockput>
    ip = next;
801023d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023df:	8b 45 10             	mov    0x10(%ebp),%eax
801023e2:	89 44 24 04          	mov    %eax,0x4(%esp)
801023e6:	8b 45 08             	mov    0x8(%ebp),%eax
801023e9:	89 04 24             	mov    %eax,(%esp)
801023ec:	e8 61 fe ff ff       	call   80102252 <skipelem>
801023f1:	89 45 08             	mov    %eax,0x8(%ebp)
801023f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801023f8:	0f 85 4b ff ff ff    	jne    80102349 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801023fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102402:	74 12                	je     80102416 <namex+0x112>
    iput(ip);
80102404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102407:	89 04 24             	mov    %eax,(%esp)
8010240a:	e8 2a f6 ff ff       	call   80101a39 <iput>
    return 0;
8010240f:	b8 00 00 00 00       	mov    $0x0,%eax
80102414:	eb 03                	jmp    80102419 <namex+0x115>
  }
  return ip;
80102416:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80102419:	c9                   	leave  
8010241a:	c3                   	ret    

8010241b <namei>:

struct inode*
namei(char *path)
{
8010241b:	55                   	push   %ebp
8010241c:	89 e5                	mov    %esp,%ebp
8010241e:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102421:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102424:	89 44 24 08          	mov    %eax,0x8(%esp)
80102428:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010242f:	00 
80102430:	8b 45 08             	mov    0x8(%ebp),%eax
80102433:	89 04 24             	mov    %eax,(%esp)
80102436:	e8 c9 fe ff ff       	call   80102304 <namex>
}
8010243b:	c9                   	leave  
8010243c:	c3                   	ret    

8010243d <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
8010243d:	55                   	push   %ebp
8010243e:	89 e5                	mov    %esp,%ebp
80102440:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
80102443:	8b 45 0c             	mov    0xc(%ebp),%eax
80102446:	89 44 24 08          	mov    %eax,0x8(%esp)
8010244a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102451:	00 
80102452:	8b 45 08             	mov    0x8(%ebp),%eax
80102455:	89 04 24             	mov    %eax,(%esp)
80102458:	e8 a7 fe ff ff       	call   80102304 <namex>
}
8010245d:	c9                   	leave  
8010245e:	c3                   	ret    
	...

80102460 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	83 ec 14             	sub    $0x14,%esp
80102466:	8b 45 08             	mov    0x8(%ebp),%eax
80102469:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010246d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102471:	89 c2                	mov    %eax,%edx
80102473:	ec                   	in     (%dx),%al
80102474:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102477:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010247b:	c9                   	leave  
8010247c:	c3                   	ret    

8010247d <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010247d:	55                   	push   %ebp
8010247e:	89 e5                	mov    %esp,%ebp
80102480:	57                   	push   %edi
80102481:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102482:	8b 55 08             	mov    0x8(%ebp),%edx
80102485:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102488:	8b 45 10             	mov    0x10(%ebp),%eax
8010248b:	89 cb                	mov    %ecx,%ebx
8010248d:	89 df                	mov    %ebx,%edi
8010248f:	89 c1                	mov    %eax,%ecx
80102491:	fc                   	cld    
80102492:	f3 6d                	rep insl (%dx),%es:(%edi)
80102494:	89 c8                	mov    %ecx,%eax
80102496:	89 fb                	mov    %edi,%ebx
80102498:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010249b:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
8010249e:	5b                   	pop    %ebx
8010249f:	5f                   	pop    %edi
801024a0:	5d                   	pop    %ebp
801024a1:	c3                   	ret    

801024a2 <outb>:

static inline void
outb(ushort port, uchar data)
{
801024a2:	55                   	push   %ebp
801024a3:	89 e5                	mov    %esp,%ebp
801024a5:	83 ec 08             	sub    $0x8,%esp
801024a8:	8b 55 08             	mov    0x8(%ebp),%edx
801024ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801024ae:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801024b2:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024b5:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801024b9:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801024bd:	ee                   	out    %al,(%dx)
}
801024be:	c9                   	leave  
801024bf:	c3                   	ret    

801024c0 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	56                   	push   %esi
801024c4:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801024c5:	8b 55 08             	mov    0x8(%ebp),%edx
801024c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024cb:	8b 45 10             	mov    0x10(%ebp),%eax
801024ce:	89 cb                	mov    %ecx,%ebx
801024d0:	89 de                	mov    %ebx,%esi
801024d2:	89 c1                	mov    %eax,%ecx
801024d4:	fc                   	cld    
801024d5:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801024d7:	89 c8                	mov    %ecx,%eax
801024d9:	89 f3                	mov    %esi,%ebx
801024db:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024de:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    

801024e5 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801024e5:	55                   	push   %ebp
801024e6:	89 e5                	mov    %esp,%ebp
801024e8:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801024eb:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801024f2:	e8 69 ff ff ff       	call   80102460 <inb>
801024f7:	0f b6 c0             	movzbl %al,%eax
801024fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
801024fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102500:	25 c0 00 00 00       	and    $0xc0,%eax
80102505:	83 f8 40             	cmp    $0x40,%eax
80102508:	75 e1                	jne    801024eb <idewait+0x6>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010250a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010250e:	74 11                	je     80102521 <idewait+0x3c>
80102510:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102513:	83 e0 21             	and    $0x21,%eax
80102516:	85 c0                	test   %eax,%eax
80102518:	74 07                	je     80102521 <idewait+0x3c>
    return -1;
8010251a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010251f:	eb 05                	jmp    80102526 <idewait+0x41>
  return 0;
80102521:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102526:	c9                   	leave  
80102527:	c3                   	ret    

80102528 <ideinit>:

void
ideinit(void)
{
80102528:	55                   	push   %ebp
80102529:	89 e5                	mov    %esp,%ebp
8010252b:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
8010252e:	c7 44 24 04 a0 82 10 	movl   $0x801082a0,0x4(%esp)
80102535:	80 
80102536:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010253d:	e8 0c 26 00 00       	call   80104b4e <initlock>
  picenable(IRQ_IDE);
80102542:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102549:	e8 4b 15 00 00       	call   80103a99 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010254e:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80102553:	83 e8 01             	sub    $0x1,%eax
80102556:	89 44 24 04          	mov    %eax,0x4(%esp)
8010255a:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102561:	e8 10 04 00 00       	call   80102976 <ioapicenable>
  idewait(0);
80102566:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010256d:	e8 73 ff ff ff       	call   801024e5 <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102572:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102579:	00 
8010257a:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102581:	e8 1c ff ff ff       	call   801024a2 <outb>
  for(i=0; i<1000; i++){
80102586:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010258d:	eb 20                	jmp    801025af <ideinit+0x87>
    if(inb(0x1f7) != 0){
8010258f:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
80102596:	e8 c5 fe ff ff       	call   80102460 <inb>
8010259b:	84 c0                	test   %al,%al
8010259d:	74 0c                	je     801025ab <ideinit+0x83>
      havedisk1 = 1;
8010259f:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
801025a6:	00 00 00 
      break;
801025a9:	eb 0d                	jmp    801025b8 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801025ab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801025af:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801025b6:	7e d7                	jle    8010258f <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801025b8:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
801025bf:	00 
801025c0:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801025c7:	e8 d6 fe ff ff       	call   801024a2 <outb>
}
801025cc:	c9                   	leave  
801025cd:	c3                   	ret    

801025ce <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025ce:	55                   	push   %ebp
801025cf:	89 e5                	mov    %esp,%ebp
801025d1:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801025d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025d8:	75 0c                	jne    801025e6 <idestart+0x18>
    panic("idestart");
801025da:	c7 04 24 a4 82 10 80 	movl   $0x801082a4,(%esp)
801025e1:	e8 54 df ff ff       	call   8010053a <panic>

  idewait(0);
801025e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801025ed:	e8 f3 fe ff ff       	call   801024e5 <idewait>
  outb(0x3f6, 0);  // generate interrupt
801025f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801025f9:	00 
801025fa:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
80102601:	e8 9c fe ff ff       	call   801024a2 <outb>
  outb(0x1f2, 1);  // number of sectors
80102606:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010260d:	00 
8010260e:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
80102615:	e8 88 fe ff ff       	call   801024a2 <outb>
  outb(0x1f3, b->sector & 0xff);
8010261a:	8b 45 08             	mov    0x8(%ebp),%eax
8010261d:	8b 40 08             	mov    0x8(%eax),%eax
80102620:	0f b6 c0             	movzbl %al,%eax
80102623:	89 44 24 04          	mov    %eax,0x4(%esp)
80102627:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
8010262e:	e8 6f fe ff ff       	call   801024a2 <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
80102633:	8b 45 08             	mov    0x8(%ebp),%eax
80102636:	8b 40 08             	mov    0x8(%eax),%eax
80102639:	c1 e8 08             	shr    $0x8,%eax
8010263c:	0f b6 c0             	movzbl %al,%eax
8010263f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102643:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
8010264a:	e8 53 fe ff ff       	call   801024a2 <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
8010264f:	8b 45 08             	mov    0x8(%ebp),%eax
80102652:	8b 40 08             	mov    0x8(%eax),%eax
80102655:	c1 e8 10             	shr    $0x10,%eax
80102658:	0f b6 c0             	movzbl %al,%eax
8010265b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010265f:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
80102666:	e8 37 fe ff ff       	call   801024a2 <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
8010266b:	8b 45 08             	mov    0x8(%ebp),%eax
8010266e:	8b 40 04             	mov    0x4(%eax),%eax
80102671:	83 e0 01             	and    $0x1,%eax
80102674:	89 c2                	mov    %eax,%edx
80102676:	c1 e2 04             	shl    $0x4,%edx
80102679:	8b 45 08             	mov    0x8(%ebp),%eax
8010267c:	8b 40 08             	mov    0x8(%eax),%eax
8010267f:	c1 e8 18             	shr    $0x18,%eax
80102682:	83 e0 0f             	and    $0xf,%eax
80102685:	09 d0                	or     %edx,%eax
80102687:	83 c8 e0             	or     $0xffffffe0,%eax
8010268a:	0f b6 c0             	movzbl %al,%eax
8010268d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102691:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102698:	e8 05 fe ff ff       	call   801024a2 <outb>
  if(b->flags & B_DIRTY){
8010269d:	8b 45 08             	mov    0x8(%ebp),%eax
801026a0:	8b 00                	mov    (%eax),%eax
801026a2:	83 e0 04             	and    $0x4,%eax
801026a5:	85 c0                	test   %eax,%eax
801026a7:	74 34                	je     801026dd <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
801026a9:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
801026b0:	00 
801026b1:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026b8:	e8 e5 fd ff ff       	call   801024a2 <outb>
    outsl(0x1f0, b->data, 512/4);
801026bd:	8b 45 08             	mov    0x8(%ebp),%eax
801026c0:	83 c0 18             	add    $0x18,%eax
801026c3:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801026ca:	00 
801026cb:	89 44 24 04          	mov    %eax,0x4(%esp)
801026cf:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801026d6:	e8 e5 fd ff ff       	call   801024c0 <outsl>
801026db:	eb 14                	jmp    801026f1 <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801026dd:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
801026e4:	00 
801026e5:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026ec:	e8 b1 fd ff ff       	call   801024a2 <outb>
  }
}
801026f1:	c9                   	leave  
801026f2:	c3                   	ret    

801026f3 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026f3:	55                   	push   %ebp
801026f4:	89 e5                	mov    %esp,%ebp
801026f6:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026f9:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102700:	e8 6a 24 00 00       	call   80104b6f <acquire>
  if((b = idequeue) == 0){
80102705:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010270a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010270d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102711:	75 11                	jne    80102724 <ideintr+0x31>
    release(&idelock);
80102713:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
8010271a:	e8 b1 24 00 00       	call   80104bd0 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
8010271f:	e9 90 00 00 00       	jmp    801027b4 <ideintr+0xc1>
  }
  idequeue = b->qnext;
80102724:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102727:	8b 40 14             	mov    0x14(%eax),%eax
8010272a:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010272f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102732:	8b 00                	mov    (%eax),%eax
80102734:	83 e0 04             	and    $0x4,%eax
80102737:	85 c0                	test   %eax,%eax
80102739:	75 2e                	jne    80102769 <ideintr+0x76>
8010273b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80102742:	e8 9e fd ff ff       	call   801024e5 <idewait>
80102747:	85 c0                	test   %eax,%eax
80102749:	78 1e                	js     80102769 <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
8010274b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010274e:	83 c0 18             	add    $0x18,%eax
80102751:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102758:	00 
80102759:	89 44 24 04          	mov    %eax,0x4(%esp)
8010275d:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
80102764:	e8 14 fd ff ff       	call   8010247d <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102769:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010276c:	8b 00                	mov    (%eax),%eax
8010276e:	89 c2                	mov    %eax,%edx
80102770:	83 ca 02             	or     $0x2,%edx
80102773:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102776:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102778:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010277b:	8b 00                	mov    (%eax),%eax
8010277d:	89 c2                	mov    %eax,%edx
8010277f:	83 e2 fb             	and    $0xfffffffb,%edx
80102782:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102785:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102787:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010278a:	89 04 24             	mov    %eax,(%esp)
8010278d:	e8 e5 21 00 00       	call   80104977 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102792:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102797:	85 c0                	test   %eax,%eax
80102799:	74 0d                	je     801027a8 <ideintr+0xb5>
    idestart(idequeue);
8010279b:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027a0:	89 04 24             	mov    %eax,(%esp)
801027a3:	e8 26 fe ff ff       	call   801025ce <idestart>

  release(&idelock);
801027a8:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
801027af:	e8 1c 24 00 00       	call   80104bd0 <release>
}
801027b4:	c9                   	leave  
801027b5:	c3                   	ret    

801027b6 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801027b6:	55                   	push   %ebp
801027b7:	89 e5                	mov    %esp,%ebp
801027b9:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801027bc:	8b 45 08             	mov    0x8(%ebp),%eax
801027bf:	8b 00                	mov    (%eax),%eax
801027c1:	83 e0 01             	and    $0x1,%eax
801027c4:	85 c0                	test   %eax,%eax
801027c6:	75 0c                	jne    801027d4 <iderw+0x1e>
    panic("iderw: buf not busy");
801027c8:	c7 04 24 ad 82 10 80 	movl   $0x801082ad,(%esp)
801027cf:	e8 66 dd ff ff       	call   8010053a <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027d4:	8b 45 08             	mov    0x8(%ebp),%eax
801027d7:	8b 00                	mov    (%eax),%eax
801027d9:	83 e0 06             	and    $0x6,%eax
801027dc:	83 f8 02             	cmp    $0x2,%eax
801027df:	75 0c                	jne    801027ed <iderw+0x37>
    panic("iderw: nothing to do");
801027e1:	c7 04 24 c1 82 10 80 	movl   $0x801082c1,(%esp)
801027e8:	e8 4d dd ff ff       	call   8010053a <panic>
  if(b->dev != 0 && !havedisk1)
801027ed:	8b 45 08             	mov    0x8(%ebp),%eax
801027f0:	8b 40 04             	mov    0x4(%eax),%eax
801027f3:	85 c0                	test   %eax,%eax
801027f5:	74 15                	je     8010280c <iderw+0x56>
801027f7:	a1 38 b6 10 80       	mov    0x8010b638,%eax
801027fc:	85 c0                	test   %eax,%eax
801027fe:	75 0c                	jne    8010280c <iderw+0x56>
    panic("iderw: ide disk 1 not present");
80102800:	c7 04 24 d6 82 10 80 	movl   $0x801082d6,(%esp)
80102807:	e8 2e dd ff ff       	call   8010053a <panic>

  acquire(&idelock);  //DOC: acquire-lock
8010280c:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102813:	e8 57 23 00 00       	call   80104b6f <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102818:	8b 45 08             	mov    0x8(%ebp),%eax
8010281b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC: insert-queue
80102822:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
80102829:	eb 0b                	jmp    80102836 <iderw+0x80>
8010282b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010282e:	8b 00                	mov    (%eax),%eax
80102830:	83 c0 14             	add    $0x14,%eax
80102833:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102836:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102839:	8b 00                	mov    (%eax),%eax
8010283b:	85 c0                	test   %eax,%eax
8010283d:	75 ec                	jne    8010282b <iderw+0x75>
    ;
  *pp = b;
8010283f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102842:	8b 55 08             	mov    0x8(%ebp),%edx
80102845:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102847:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010284c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010284f:	75 22                	jne    80102873 <iderw+0xbd>
    idestart(b);
80102851:	8b 45 08             	mov    0x8(%ebp),%eax
80102854:	89 04 24             	mov    %eax,(%esp)
80102857:	e8 72 fd ff ff       	call   801025ce <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010285c:	eb 16                	jmp    80102874 <iderw+0xbe>
    sleep(b, &idelock);
8010285e:	c7 44 24 04 00 b6 10 	movl   $0x8010b600,0x4(%esp)
80102865:	80 
80102866:	8b 45 08             	mov    0x8(%ebp),%eax
80102869:	89 04 24             	mov    %eax,(%esp)
8010286c:	e8 2c 20 00 00       	call   8010489d <sleep>
80102871:	eb 01                	jmp    80102874 <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102873:	90                   	nop
80102874:	8b 45 08             	mov    0x8(%ebp),%eax
80102877:	8b 00                	mov    (%eax),%eax
80102879:	83 e0 06             	and    $0x6,%eax
8010287c:	83 f8 02             	cmp    $0x2,%eax
8010287f:	75 dd                	jne    8010285e <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
80102881:	c7 04 24 00 b6 10 80 	movl   $0x8010b600,(%esp)
80102888:	e8 43 23 00 00       	call   80104bd0 <release>
}
8010288d:	c9                   	leave  
8010288e:	c3                   	ret    
	...

80102890 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102890:	55                   	push   %ebp
80102891:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102893:	a1 34 f8 10 80       	mov    0x8010f834,%eax
80102898:	8b 55 08             	mov    0x8(%ebp),%edx
8010289b:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
8010289d:	a1 34 f8 10 80       	mov    0x8010f834,%eax
801028a2:	8b 40 10             	mov    0x10(%eax),%eax
}
801028a5:	5d                   	pop    %ebp
801028a6:	c3                   	ret    

801028a7 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
801028a7:	55                   	push   %ebp
801028a8:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801028aa:	a1 34 f8 10 80       	mov    0x8010f834,%eax
801028af:	8b 55 08             	mov    0x8(%ebp),%edx
801028b2:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
801028b4:	a1 34 f8 10 80       	mov    0x8010f834,%eax
801028b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801028bc:	89 50 10             	mov    %edx,0x10(%eax)
}
801028bf:	5d                   	pop    %ebp
801028c0:	c3                   	ret    

801028c1 <ioapicinit>:

void
ioapicinit(void)
{
801028c1:	55                   	push   %ebp
801028c2:	89 e5                	mov    %esp,%ebp
801028c4:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801028c7:	a1 04 f9 10 80       	mov    0x8010f904,%eax
801028cc:	85 c0                	test   %eax,%eax
801028ce:	0f 84 9f 00 00 00    	je     80102973 <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801028d4:	c7 05 34 f8 10 80 00 	movl   $0xfec00000,0x8010f834
801028db:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801028e5:	e8 a6 ff ff ff       	call   80102890 <ioapicread>
801028ea:	c1 e8 10             	shr    $0x10,%eax
801028ed:	25 ff 00 00 00       	and    $0xff,%eax
801028f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  id = ioapicread(REG_ID) >> 24;
801028f5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801028fc:	e8 8f ff ff ff       	call   80102890 <ioapicread>
80102901:	c1 e8 18             	shr    $0x18,%eax
80102904:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(id != ioapicid)
80102907:	0f b6 05 00 f9 10 80 	movzbl 0x8010f900,%eax
8010290e:	0f b6 c0             	movzbl %al,%eax
80102911:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102914:	74 0c                	je     80102922 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102916:	c7 04 24 f4 82 10 80 	movl   $0x801082f4,(%esp)
8010291d:	e8 78 da ff ff       	call   8010039a <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102922:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80102929:	eb 3e                	jmp    80102969 <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010292b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010292e:	83 c0 20             	add    $0x20,%eax
80102931:	0d 00 00 01 00       	or     $0x10000,%eax
80102936:	8b 55 ec             	mov    -0x14(%ebp),%edx
80102939:	83 c2 08             	add    $0x8,%edx
8010293c:	01 d2                	add    %edx,%edx
8010293e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102942:	89 14 24             	mov    %edx,(%esp)
80102945:	e8 5d ff ff ff       	call   801028a7 <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
8010294a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010294d:	83 c0 08             	add    $0x8,%eax
80102950:	01 c0                	add    %eax,%eax
80102952:	83 c0 01             	add    $0x1,%eax
80102955:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010295c:	00 
8010295d:	89 04 24             	mov    %eax,(%esp)
80102960:	e8 42 ff ff ff       	call   801028a7 <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102965:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80102969:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010296c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010296f:	7e ba                	jle    8010292b <ioapicinit+0x6a>
80102971:	eb 01                	jmp    80102974 <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102973:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102974:	c9                   	leave  
80102975:	c3                   	ret    

80102976 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102976:	55                   	push   %ebp
80102977:	89 e5                	mov    %esp,%ebp
80102979:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
8010297c:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80102981:	85 c0                	test   %eax,%eax
80102983:	74 39                	je     801029be <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102985:	8b 45 08             	mov    0x8(%ebp),%eax
80102988:	83 c0 20             	add    $0x20,%eax
8010298b:	8b 55 08             	mov    0x8(%ebp),%edx
8010298e:	83 c2 08             	add    $0x8,%edx
80102991:	01 d2                	add    %edx,%edx
80102993:	89 44 24 04          	mov    %eax,0x4(%esp)
80102997:	89 14 24             	mov    %edx,(%esp)
8010299a:	e8 08 ff ff ff       	call   801028a7 <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010299f:	8b 45 0c             	mov    0xc(%ebp),%eax
801029a2:	c1 e0 18             	shl    $0x18,%eax
801029a5:	8b 55 08             	mov    0x8(%ebp),%edx
801029a8:	83 c2 08             	add    $0x8,%edx
801029ab:	01 d2                	add    %edx,%edx
801029ad:	83 c2 01             	add    $0x1,%edx
801029b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801029b4:	89 14 24             	mov    %edx,(%esp)
801029b7:	e8 eb fe ff ff       	call   801028a7 <ioapicwrite>
801029bc:	eb 01                	jmp    801029bf <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
801029be:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801029bf:	c9                   	leave  
801029c0:	c3                   	ret    
801029c1:	00 00                	add    %al,(%eax)
	...

801029c4 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801029c4:	55                   	push   %ebp
801029c5:	89 e5                	mov    %esp,%ebp
801029c7:	8b 45 08             	mov    0x8(%ebp),%eax
801029ca:	2d 00 00 00 80       	sub    $0x80000000,%eax
801029cf:	5d                   	pop    %ebp
801029d0:	c3                   	ret    

801029d1 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801029d1:	55                   	push   %ebp
801029d2:	89 e5                	mov    %esp,%ebp
801029d4:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
801029d7:	c7 44 24 04 26 83 10 	movl   $0x80108326,0x4(%esp)
801029de:	80 
801029df:	c7 04 24 40 f8 10 80 	movl   $0x8010f840,(%esp)
801029e6:	e8 63 21 00 00       	call   80104b4e <initlock>
  kmem.use_lock = 0;
801029eb:	c7 05 74 f8 10 80 00 	movl   $0x0,0x8010f874
801029f2:	00 00 00 
  freerange(vstart, vend);
801029f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801029f8:	89 44 24 04          	mov    %eax,0x4(%esp)
801029fc:	8b 45 08             	mov    0x8(%ebp),%eax
801029ff:	89 04 24             	mov    %eax,(%esp)
80102a02:	e8 26 00 00 00       	call   80102a2d <freerange>
}
80102a07:	c9                   	leave  
80102a08:	c3                   	ret    

80102a09 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102a09:	55                   	push   %ebp
80102a0a:	89 e5                	mov    %esp,%ebp
80102a0c:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a12:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a16:	8b 45 08             	mov    0x8(%ebp),%eax
80102a19:	89 04 24             	mov    %eax,(%esp)
80102a1c:	e8 0c 00 00 00       	call   80102a2d <freerange>
  kmem.use_lock = 1;
80102a21:	c7 05 74 f8 10 80 01 	movl   $0x1,0x8010f874
80102a28:	00 00 00 
}
80102a2b:	c9                   	leave  
80102a2c:	c3                   	ret    

80102a2d <freerange>:

void
freerange(void *vstart, void *vend)
{
80102a2d:	55                   	push   %ebp
80102a2e:	89 e5                	mov    %esp,%ebp
80102a30:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102a33:	8b 45 08             	mov    0x8(%ebp),%eax
80102a36:	05 ff 0f 00 00       	add    $0xfff,%eax
80102a3b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a43:	eb 12                	jmp    80102a57 <freerange+0x2a>
    kfree(p);
80102a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a48:	89 04 24             	mov    %eax,(%esp)
80102a4b:	e8 19 00 00 00       	call   80102a69 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a50:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a5a:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
80102a60:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a63:	39 c2                	cmp    %eax,%edx
80102a65:	76 de                	jbe    80102a45 <freerange+0x18>
    kfree(p);
}
80102a67:	c9                   	leave  
80102a68:	c3                   	ret    

80102a69 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102a69:	55                   	push   %ebp
80102a6a:	89 e5                	mov    %esp,%ebp
80102a6c:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a72:	25 ff 0f 00 00       	and    $0xfff,%eax
80102a77:	85 c0                	test   %eax,%eax
80102a79:	75 1b                	jne    80102a96 <kfree+0x2d>
80102a7b:	81 7d 08 fc 26 11 80 	cmpl   $0x801126fc,0x8(%ebp)
80102a82:	72 12                	jb     80102a96 <kfree+0x2d>
80102a84:	8b 45 08             	mov    0x8(%ebp),%eax
80102a87:	89 04 24             	mov    %eax,(%esp)
80102a8a:	e8 35 ff ff ff       	call   801029c4 <v2p>
80102a8f:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a94:	76 0c                	jbe    80102aa2 <kfree+0x39>
    panic("kfree");
80102a96:	c7 04 24 2b 83 10 80 	movl   $0x8010832b,(%esp)
80102a9d:	e8 98 da ff ff       	call   8010053a <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102aa2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102aa9:	00 
80102aaa:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102ab1:	00 
80102ab2:	8b 45 08             	mov    0x8(%ebp),%eax
80102ab5:	89 04 24             	mov    %eax,(%esp)
80102ab8:	e8 01 23 00 00       	call   80104dbe <memset>

  if(kmem.use_lock)
80102abd:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102ac2:	85 c0                	test   %eax,%eax
80102ac4:	74 0c                	je     80102ad2 <kfree+0x69>
    acquire(&kmem.lock);
80102ac6:	c7 04 24 40 f8 10 80 	movl   $0x8010f840,(%esp)
80102acd:	e8 9d 20 00 00       	call   80104b6f <acquire>
  r = (struct run*)v;
80102ad2:	8b 45 08             	mov    0x8(%ebp),%eax
80102ad5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102ad8:	8b 15 78 f8 10 80    	mov    0x8010f878,%edx
80102ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ae1:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ae6:	a3 78 f8 10 80       	mov    %eax,0x8010f878
  if(kmem.use_lock)
80102aeb:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102af0:	85 c0                	test   %eax,%eax
80102af2:	74 0c                	je     80102b00 <kfree+0x97>
    release(&kmem.lock);
80102af4:	c7 04 24 40 f8 10 80 	movl   $0x8010f840,(%esp)
80102afb:	e8 d0 20 00 00       	call   80104bd0 <release>
}
80102b00:	c9                   	leave  
80102b01:	c3                   	ret    

80102b02 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b02:	55                   	push   %ebp
80102b03:	89 e5                	mov    %esp,%ebp
80102b05:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102b08:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102b0d:	85 c0                	test   %eax,%eax
80102b0f:	74 0c                	je     80102b1d <kalloc+0x1b>
    acquire(&kmem.lock);
80102b11:	c7 04 24 40 f8 10 80 	movl   $0x8010f840,(%esp)
80102b18:	e8 52 20 00 00       	call   80104b6f <acquire>
  r = kmem.freelist;
80102b1d:	a1 78 f8 10 80       	mov    0x8010f878,%eax
80102b22:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102b25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102b29:	74 0a                	je     80102b35 <kalloc+0x33>
    kmem.freelist = r->next;
80102b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b2e:	8b 00                	mov    (%eax),%eax
80102b30:	a3 78 f8 10 80       	mov    %eax,0x8010f878
  if(kmem.use_lock)
80102b35:	a1 74 f8 10 80       	mov    0x8010f874,%eax
80102b3a:	85 c0                	test   %eax,%eax
80102b3c:	74 0c                	je     80102b4a <kalloc+0x48>
    release(&kmem.lock);
80102b3e:	c7 04 24 40 f8 10 80 	movl   $0x8010f840,(%esp)
80102b45:	e8 86 20 00 00       	call   80104bd0 <release>
  return (char*)r;
80102b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102b4d:	c9                   	leave  
80102b4e:	c3                   	ret    
	...

80102b50 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	83 ec 14             	sub    $0x14,%esp
80102b56:	8b 45 08             	mov    0x8(%ebp),%eax
80102b59:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102b61:	89 c2                	mov    %eax,%edx
80102b63:	ec                   	in     (%dx),%al
80102b64:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102b67:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102b6b:	c9                   	leave  
80102b6c:	c3                   	ret    

80102b6d <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b6d:	55                   	push   %ebp
80102b6e:	89 e5                	mov    %esp,%ebp
80102b70:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102b73:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102b7a:	e8 d1 ff ff ff       	call   80102b50 <inb>
80102b7f:	0f b6 c0             	movzbl %al,%eax
80102b82:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b88:	83 e0 01             	and    $0x1,%eax
80102b8b:	85 c0                	test   %eax,%eax
80102b8d:	75 0a                	jne    80102b99 <kbdgetc+0x2c>
    return -1;
80102b8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b94:	e9 20 01 00 00       	jmp    80102cb9 <kbdgetc+0x14c>
  data = inb(KBDATAP);
80102b99:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102ba0:	e8 ab ff ff ff       	call   80102b50 <inb>
80102ba5:	0f b6 c0             	movzbl %al,%eax
80102ba8:	89 45 f8             	mov    %eax,-0x8(%ebp)

  if(data == 0xE0){
80102bab:	81 7d f8 e0 00 00 00 	cmpl   $0xe0,-0x8(%ebp)
80102bb2:	75 17                	jne    80102bcb <kbdgetc+0x5e>
    shift |= E0ESC;
80102bb4:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102bb9:	83 c8 40             	or     $0x40,%eax
80102bbc:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102bc1:	b8 00 00 00 00       	mov    $0x0,%eax
80102bc6:	e9 ee 00 00 00       	jmp    80102cb9 <kbdgetc+0x14c>
  } else if(data & 0x80){
80102bcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bce:	25 80 00 00 00       	and    $0x80,%eax
80102bd3:	85 c0                	test   %eax,%eax
80102bd5:	74 44                	je     80102c1b <kbdgetc+0xae>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102bd7:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102bdc:	83 e0 40             	and    $0x40,%eax
80102bdf:	85 c0                	test   %eax,%eax
80102be1:	75 08                	jne    80102beb <kbdgetc+0x7e>
80102be3:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102be6:	83 e0 7f             	and    $0x7f,%eax
80102be9:	eb 03                	jmp    80102bee <kbdgetc+0x81>
80102beb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bee:	89 45 f8             	mov    %eax,-0x8(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102bf1:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bf4:	0f b6 80 20 90 10 80 	movzbl -0x7fef6fe0(%eax),%eax
80102bfb:	83 c8 40             	or     $0x40,%eax
80102bfe:	0f b6 c0             	movzbl %al,%eax
80102c01:	f7 d0                	not    %eax
80102c03:	89 c2                	mov    %eax,%edx
80102c05:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c0a:	21 d0                	and    %edx,%eax
80102c0c:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102c11:	b8 00 00 00 00       	mov    $0x0,%eax
80102c16:	e9 9e 00 00 00       	jmp    80102cb9 <kbdgetc+0x14c>
  } else if(shift & E0ESC){
80102c1b:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c20:	83 e0 40             	and    $0x40,%eax
80102c23:	85 c0                	test   %eax,%eax
80102c25:	74 14                	je     80102c3b <kbdgetc+0xce>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c27:	81 4d f8 80 00 00 00 	orl    $0x80,-0x8(%ebp)
    shift &= ~E0ESC;
80102c2e:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c33:	83 e0 bf             	and    $0xffffffbf,%eax
80102c36:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102c3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102c3e:	0f b6 80 20 90 10 80 	movzbl -0x7fef6fe0(%eax),%eax
80102c45:	0f b6 d0             	movzbl %al,%edx
80102c48:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c4d:	09 d0                	or     %edx,%eax
80102c4f:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102c54:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102c57:	0f b6 80 20 91 10 80 	movzbl -0x7fef6ee0(%eax),%eax
80102c5e:	0f b6 d0             	movzbl %al,%edx
80102c61:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c66:	31 d0                	xor    %edx,%eax
80102c68:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c6d:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c72:	83 e0 03             	and    $0x3,%eax
80102c75:	8b 04 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%eax
80102c7c:	03 45 f8             	add    -0x8(%ebp),%eax
80102c7f:	0f b6 00             	movzbl (%eax),%eax
80102c82:	0f b6 c0             	movzbl %al,%eax
80102c85:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(shift & CAPSLOCK){
80102c88:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c8d:	83 e0 08             	and    $0x8,%eax
80102c90:	85 c0                	test   %eax,%eax
80102c92:	74 22                	je     80102cb6 <kbdgetc+0x149>
    if('a' <= c && c <= 'z')
80102c94:	83 7d fc 60          	cmpl   $0x60,-0x4(%ebp)
80102c98:	76 0c                	jbe    80102ca6 <kbdgetc+0x139>
80102c9a:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%ebp)
80102c9e:	77 06                	ja     80102ca6 <kbdgetc+0x139>
      c += 'A' - 'a';
80102ca0:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
80102ca4:	eb 10                	jmp    80102cb6 <kbdgetc+0x149>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102ca6:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
80102caa:	76 0a                	jbe    80102cb6 <kbdgetc+0x149>
80102cac:	83 7d fc 5a          	cmpl   $0x5a,-0x4(%ebp)
80102cb0:	77 04                	ja     80102cb6 <kbdgetc+0x149>
      c += 'a' - 'A';
80102cb2:	83 45 fc 20          	addl   $0x20,-0x4(%ebp)
  }
  return c;
80102cb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    

80102cbb <kbdintr>:

void
kbdintr(void)
{
80102cbb:	55                   	push   %ebp
80102cbc:	89 e5                	mov    %esp,%ebp
80102cbe:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102cc1:	c7 04 24 6d 2b 10 80 	movl   $0x80102b6d,(%esp)
80102cc8:	e8 e1 da ff ff       	call   801007ae <consoleintr>
}
80102ccd:	c9                   	leave  
80102cce:	c3                   	ret    
	...

80102cd0 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	83 ec 08             	sub    $0x8,%esp
80102cd6:	8b 55 08             	mov    0x8(%ebp),%edx
80102cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80102cdc:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102ce0:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce3:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ce7:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102ceb:	ee                   	out    %al,(%dx)
}
80102cec:	c9                   	leave  
80102ced:	c3                   	ret    

80102cee <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102cee:	55                   	push   %ebp
80102cef:	89 e5                	mov    %esp,%ebp
80102cf1:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102cf4:	9c                   	pushf  
80102cf5:	58                   	pop    %eax
80102cf6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102cf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102cfc:	c9                   	leave  
80102cfd:	c3                   	ret    

80102cfe <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102cfe:	55                   	push   %ebp
80102cff:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102d01:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102d06:	8b 55 08             	mov    0x8(%ebp),%edx
80102d09:	c1 e2 02             	shl    $0x2,%edx
80102d0c:	8d 14 10             	lea    (%eax,%edx,1),%edx
80102d0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d12:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102d14:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102d19:	83 c0 20             	add    $0x20,%eax
80102d1c:	8b 00                	mov    (%eax),%eax
}
80102d1e:	5d                   	pop    %ebp
80102d1f:	c3                   	ret    

80102d20 <lapicinit>:
//PAGEBREAK!

void
lapicinit(int c)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
80102d26:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102d2b:	85 c0                	test   %eax,%eax
80102d2d:	0f 84 46 01 00 00    	je     80102e79 <lapicinit+0x159>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102d33:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102d3a:	00 
80102d3b:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102d42:	e8 b7 ff ff ff       	call   80102cfe <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102d47:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102d4e:	00 
80102d4f:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102d56:	e8 a3 ff ff ff       	call   80102cfe <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102d5b:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102d62:	00 
80102d63:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102d6a:	e8 8f ff ff ff       	call   80102cfe <lapicw>
  lapicw(TICR, 10000000); 
80102d6f:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102d76:	00 
80102d77:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102d7e:	e8 7b ff ff ff       	call   80102cfe <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102d83:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102d8a:	00 
80102d8b:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102d92:	e8 67 ff ff ff       	call   80102cfe <lapicw>
  lapicw(LINT1, MASKED);
80102d97:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102d9e:	00 
80102d9f:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102da6:	e8 53 ff ff ff       	call   80102cfe <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102dab:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102db0:	83 c0 30             	add    $0x30,%eax
80102db3:	8b 00                	mov    (%eax),%eax
80102db5:	c1 e8 10             	shr    $0x10,%eax
80102db8:	25 ff 00 00 00       	and    $0xff,%eax
80102dbd:	83 f8 03             	cmp    $0x3,%eax
80102dc0:	76 14                	jbe    80102dd6 <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
80102dc2:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102dc9:	00 
80102dca:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102dd1:	e8 28 ff ff ff       	call   80102cfe <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102dd6:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102ddd:	00 
80102dde:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102de5:	e8 14 ff ff ff       	call   80102cfe <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102dea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102df1:	00 
80102df2:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102df9:	e8 00 ff ff ff       	call   80102cfe <lapicw>
  lapicw(ESR, 0);
80102dfe:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e05:	00 
80102e06:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102e0d:	e8 ec fe ff ff       	call   80102cfe <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102e12:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e19:	00 
80102e1a:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102e21:	e8 d8 fe ff ff       	call   80102cfe <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102e26:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e2d:	00 
80102e2e:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102e35:	e8 c4 fe ff ff       	call   80102cfe <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102e3a:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102e41:	00 
80102e42:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102e49:	e8 b0 fe ff ff       	call   80102cfe <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102e4e:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102e53:	05 00 03 00 00       	add    $0x300,%eax
80102e58:	8b 00                	mov    (%eax),%eax
80102e5a:	25 00 10 00 00       	and    $0x1000,%eax
80102e5f:	85 c0                	test   %eax,%eax
80102e61:	75 eb                	jne    80102e4e <lapicinit+0x12e>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102e63:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e6a:	00 
80102e6b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102e72:	e8 87 fe ff ff       	call   80102cfe <lapicw>
80102e77:	eb 01                	jmp    80102e7a <lapicinit+0x15a>

void
lapicinit(int c)
{
  if(!lapic) 
    return;
80102e79:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102e7a:	c9                   	leave  
80102e7b:	c3                   	ret    

80102e7c <cpunum>:

int
cpunum(void)
{
80102e7c:	55                   	push   %ebp
80102e7d:	89 e5                	mov    %esp,%ebp
80102e7f:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102e82:	e8 67 fe ff ff       	call   80102cee <readeflags>
80102e87:	25 00 02 00 00       	and    $0x200,%eax
80102e8c:	85 c0                	test   %eax,%eax
80102e8e:	74 29                	je     80102eb9 <cpunum+0x3d>
    static int n;
    if(n++ == 0)
80102e90:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102e95:	85 c0                	test   %eax,%eax
80102e97:	0f 94 c2             	sete   %dl
80102e9a:	83 c0 01             	add    $0x1,%eax
80102e9d:	a3 40 b6 10 80       	mov    %eax,0x8010b640
80102ea2:	84 d2                	test   %dl,%dl
80102ea4:	74 13                	je     80102eb9 <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
80102ea6:	8b 45 04             	mov    0x4(%ebp),%eax
80102ea9:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ead:	c7 04 24 34 83 10 80 	movl   $0x80108334,(%esp)
80102eb4:	e8 e1 d4 ff ff       	call   8010039a <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102eb9:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ebe:	85 c0                	test   %eax,%eax
80102ec0:	74 0f                	je     80102ed1 <cpunum+0x55>
    return lapic[ID]>>24;
80102ec2:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ec7:	83 c0 20             	add    $0x20,%eax
80102eca:	8b 00                	mov    (%eax),%eax
80102ecc:	c1 e8 18             	shr    $0x18,%eax
80102ecf:	eb 05                	jmp    80102ed6 <cpunum+0x5a>
  return 0;
80102ed1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102ed6:	c9                   	leave  
80102ed7:	c3                   	ret    

80102ed8 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102ed8:	55                   	push   %ebp
80102ed9:	89 e5                	mov    %esp,%ebp
80102edb:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80102ede:	a1 7c f8 10 80       	mov    0x8010f87c,%eax
80102ee3:	85 c0                	test   %eax,%eax
80102ee5:	74 14                	je     80102efb <lapiceoi+0x23>
    lapicw(EOI, 0);
80102ee7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102eee:	00 
80102eef:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102ef6:	e8 03 fe ff ff       	call   80102cfe <lapicw>
}
80102efb:	c9                   	leave  
80102efc:	c3                   	ret    

80102efd <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102efd:	55                   	push   %ebp
80102efe:	89 e5                	mov    %esp,%ebp
}
80102f00:	5d                   	pop    %ebp
80102f01:	c3                   	ret    

80102f02 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f02:	55                   	push   %ebp
80102f03:	89 e5                	mov    %esp,%ebp
80102f05:	83 ec 1c             	sub    $0x1c,%esp
80102f08:	8b 45 08             	mov    0x8(%ebp),%eax
80102f0b:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102f0e:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80102f15:	00 
80102f16:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80102f1d:	e8 ae fd ff ff       	call   80102cd0 <outb>
  outb(IO_RTC+1, 0x0A);
80102f22:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80102f29:	00 
80102f2a:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80102f31:	e8 9a fd ff ff       	call   80102cd0 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f36:	c7 45 fc 67 04 00 80 	movl   $0x80000467,-0x4(%ebp)
  wrv[0] = 0;
80102f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f40:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f48:	8d 50 02             	lea    0x2(%eax),%edx
80102f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f4e:	c1 e8 04             	shr    $0x4,%eax
80102f51:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f54:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f58:	c1 e0 18             	shl    $0x18,%eax
80102f5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f5f:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f66:	e8 93 fd ff ff       	call   80102cfe <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102f6b:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
80102f72:	00 
80102f73:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f7a:	e8 7f fd ff ff       	call   80102cfe <lapicw>
  microdelay(200);
80102f7f:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102f86:	e8 72 ff ff ff       	call   80102efd <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
80102f8b:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
80102f92:	00 
80102f93:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f9a:	e8 5f fd ff ff       	call   80102cfe <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102f9f:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102fa6:	e8 52 ff ff ff       	call   80102efd <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102fab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80102fb2:	eb 40                	jmp    80102ff4 <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80102fb4:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fb8:	c1 e0 18             	shl    $0x18,%eax
80102fbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fbf:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102fc6:	e8 33 fd ff ff       	call   80102cfe <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80102fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fce:	c1 e8 0c             	shr    $0xc,%eax
80102fd1:	80 cc 06             	or     $0x6,%ah
80102fd4:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fd8:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fdf:	e8 1a fd ff ff       	call   80102cfe <lapicw>
    microdelay(200);
80102fe4:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102feb:	e8 0d ff ff ff       	call   80102efd <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102ff0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80102ff4:	83 7d f8 01          	cmpl   $0x1,-0x8(%ebp)
80102ff8:	7e ba                	jle    80102fb4 <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102ffa:	c9                   	leave  
80102ffb:	c3                   	ret    

80102ffc <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80102ffc:	55                   	push   %ebp
80102ffd:	89 e5                	mov    %esp,%ebp
80102fff:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103002:	c7 44 24 04 60 83 10 	movl   $0x80108360,0x4(%esp)
80103009:	80 
8010300a:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
80103011:	e8 38 1b 00 00       	call   80104b4e <initlock>
  readsb(ROOTDEV, &sb);
80103016:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103019:	89 44 24 04          	mov    %eax,0x4(%esp)
8010301d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103024:	e8 c7 e2 ff ff       	call   801012f0 <readsb>
  log.start = sb.size - sb.nlog;
80103029:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010302c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010302f:	89 d1                	mov    %edx,%ecx
80103031:	29 c1                	sub    %eax,%ecx
80103033:	89 c8                	mov    %ecx,%eax
80103035:	a3 b4 f8 10 80       	mov    %eax,0x8010f8b4
  log.size = sb.nlog;
8010303a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010303d:	a3 b8 f8 10 80       	mov    %eax,0x8010f8b8
  log.dev = ROOTDEV;
80103042:	c7 05 c0 f8 10 80 01 	movl   $0x1,0x8010f8c0
80103049:	00 00 00 
  recover_from_log();
8010304c:	e8 97 01 00 00       	call   801031e8 <recover_from_log>
}
80103051:	c9                   	leave  
80103052:	c3                   	ret    

80103053 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103053:	55                   	push   %ebp
80103054:	89 e5                	mov    %esp,%ebp
80103056:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103059:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80103060:	e9 89 00 00 00       	jmp    801030ee <install_trans+0x9b>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103065:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
8010306a:	03 45 ec             	add    -0x14(%ebp),%eax
8010306d:	83 c0 01             	add    $0x1,%eax
80103070:	89 c2                	mov    %eax,%edx
80103072:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
80103077:	89 54 24 04          	mov    %edx,0x4(%esp)
8010307b:	89 04 24             	mov    %eax,(%esp)
8010307e:	e8 24 d1 ff ff       	call   801001a7 <bread>
80103083:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
80103086:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103089:	83 c0 10             	add    $0x10,%eax
8010308c:	8b 04 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%eax
80103093:	89 c2                	mov    %eax,%edx
80103095:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
8010309a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010309e:	89 04 24             	mov    %eax,(%esp)
801030a1:	e8 01 d1 ff ff       	call   801001a7 <bread>
801030a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030ac:	8d 50 18             	lea    0x18(%eax),%edx
801030af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030b2:	83 c0 18             	add    $0x18,%eax
801030b5:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801030bc:	00 
801030bd:	89 54 24 04          	mov    %edx,0x4(%esp)
801030c1:	89 04 24             	mov    %eax,(%esp)
801030c4:	e8 c8 1d 00 00       	call   80104e91 <memmove>
    bwrite(dbuf);  // write dst to disk
801030c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030cc:	89 04 24             	mov    %eax,(%esp)
801030cf:	e8 0a d1 ff ff       	call   801001de <bwrite>
    brelse(lbuf); 
801030d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030d7:	89 04 24             	mov    %eax,(%esp)
801030da:	e8 39 d1 ff ff       	call   80100218 <brelse>
    brelse(dbuf);
801030df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030e2:	89 04 24             	mov    %eax,(%esp)
801030e5:	e8 2e d1 ff ff       	call   80100218 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030ea:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801030ee:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801030f3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801030f6:	0f 8f 69 ff ff ff    	jg     80103065 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
801030fc:	c9                   	leave  
801030fd:	c3                   	ret    

801030fe <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801030fe:	55                   	push   %ebp
801030ff:	89 e5                	mov    %esp,%ebp
80103101:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103104:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
80103109:	89 c2                	mov    %eax,%edx
8010310b:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
80103110:	89 54 24 04          	mov    %edx,0x4(%esp)
80103114:	89 04 24             	mov    %eax,(%esp)
80103117:	e8 8b d0 ff ff       	call   801001a7 <bread>
8010311c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010311f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103122:	83 c0 18             	add    $0x18,%eax
80103125:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int i;
  log.lh.n = lh->n;
80103128:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010312b:	8b 00                	mov    (%eax),%eax
8010312d:	a3 c4 f8 10 80       	mov    %eax,0x8010f8c4
  for (i = 0; i < log.lh.n; i++) {
80103132:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103139:	eb 1b                	jmp    80103156 <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
8010313b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010313e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103141:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103144:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103148:	8d 51 10             	lea    0x10(%ecx),%edx
8010314b:	89 04 95 88 f8 10 80 	mov    %eax,-0x7fef0778(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103152:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103156:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010315b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010315e:	7f db                	jg     8010313b <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103160:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103163:	89 04 24             	mov    %eax,(%esp)
80103166:	e8 ad d0 ff ff       	call   80100218 <brelse>
}
8010316b:	c9                   	leave  
8010316c:	c3                   	ret    

8010316d <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010316d:	55                   	push   %ebp
8010316e:	89 e5                	mov    %esp,%ebp
80103170:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
80103173:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
80103178:	89 c2                	mov    %eax,%edx
8010317a:	a1 c0 f8 10 80       	mov    0x8010f8c0,%eax
8010317f:	89 54 24 04          	mov    %edx,0x4(%esp)
80103183:	89 04 24             	mov    %eax,(%esp)
80103186:	e8 1c d0 ff ff       	call   801001a7 <bread>
8010318b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010318e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103191:	83 c0 18             	add    $0x18,%eax
80103194:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int i;
  hb->n = log.lh.n;
80103197:	8b 15 c4 f8 10 80    	mov    0x8010f8c4,%edx
8010319d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031a0:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801031a9:	eb 1b                	jmp    801031c6 <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
801031ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031b1:	83 c0 10             	add    $0x10,%eax
801031b4:	8b 0c 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%ecx
801031bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031be:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031c6:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801031cb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031ce:	7f db                	jg     801031ab <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801031d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031d3:	89 04 24             	mov    %eax,(%esp)
801031d6:	e8 03 d0 ff ff       	call   801001de <bwrite>
  brelse(buf);
801031db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031de:	89 04 24             	mov    %eax,(%esp)
801031e1:	e8 32 d0 ff ff       	call   80100218 <brelse>
}
801031e6:	c9                   	leave  
801031e7:	c3                   	ret    

801031e8 <recover_from_log>:

static void
recover_from_log(void)
{
801031e8:	55                   	push   %ebp
801031e9:	89 e5                	mov    %esp,%ebp
801031eb:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801031ee:	e8 0b ff ff ff       	call   801030fe <read_head>
  install_trans(); // if committed, copy from log to disk
801031f3:	e8 5b fe ff ff       	call   80103053 <install_trans>
  log.lh.n = 0;
801031f8:	c7 05 c4 f8 10 80 00 	movl   $0x0,0x8010f8c4
801031ff:	00 00 00 
  write_head(); // clear the log
80103202:	e8 66 ff ff ff       	call   8010316d <write_head>
}
80103207:	c9                   	leave  
80103208:	c3                   	ret    

80103209 <begin_trans>:

void
begin_trans(void)
{
80103209:	55                   	push   %ebp
8010320a:	89 e5                	mov    %esp,%ebp
8010320c:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
8010320f:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
80103216:	e8 54 19 00 00       	call   80104b6f <acquire>
  while (log.busy) {
8010321b:	eb 14                	jmp    80103231 <begin_trans+0x28>
    sleep(&log, &log.lock);
8010321d:	c7 44 24 04 80 f8 10 	movl   $0x8010f880,0x4(%esp)
80103224:	80 
80103225:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
8010322c:	e8 6c 16 00 00       	call   8010489d <sleep>

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
80103231:	a1 bc f8 10 80       	mov    0x8010f8bc,%eax
80103236:	85 c0                	test   %eax,%eax
80103238:	75 e3                	jne    8010321d <begin_trans+0x14>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
8010323a:	c7 05 bc f8 10 80 01 	movl   $0x1,0x8010f8bc
80103241:	00 00 00 
  release(&log.lock);
80103244:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
8010324b:	e8 80 19 00 00       	call   80104bd0 <release>
}
80103250:	c9                   	leave  
80103251:	c3                   	ret    

80103252 <commit_trans>:

void
commit_trans(void)
{
80103252:	55                   	push   %ebp
80103253:	89 e5                	mov    %esp,%ebp
80103255:	83 ec 18             	sub    $0x18,%esp
  if (log.lh.n > 0) {
80103258:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010325d:	85 c0                	test   %eax,%eax
8010325f:	7e 19                	jle    8010327a <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
80103261:	e8 07 ff ff ff       	call   8010316d <write_head>
    install_trans(); // Now install writes to home locations
80103266:	e8 e8 fd ff ff       	call   80103053 <install_trans>
    log.lh.n = 0; 
8010326b:	c7 05 c4 f8 10 80 00 	movl   $0x0,0x8010f8c4
80103272:	00 00 00 
    write_head();    // Erase the transaction from the log
80103275:	e8 f3 fe ff ff       	call   8010316d <write_head>
  }
  
  acquire(&log.lock);
8010327a:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
80103281:	e8 e9 18 00 00       	call   80104b6f <acquire>
  log.busy = 0;
80103286:	c7 05 bc f8 10 80 00 	movl   $0x0,0x8010f8bc
8010328d:	00 00 00 
  wakeup(&log);
80103290:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
80103297:	e8 db 16 00 00       	call   80104977 <wakeup>
  release(&log.lock);
8010329c:	c7 04 24 80 f8 10 80 	movl   $0x8010f880,(%esp)
801032a3:	e8 28 19 00 00       	call   80104bd0 <release>
}
801032a8:	c9                   	leave  
801032a9:	c3                   	ret    

801032aa <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801032aa:	55                   	push   %ebp
801032ab:	89 e5                	mov    %esp,%ebp
801032ad:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801032b0:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801032b5:	83 f8 09             	cmp    $0x9,%eax
801032b8:	7f 12                	jg     801032cc <log_write+0x22>
801032ba:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
801032bf:	8b 15 b8 f8 10 80    	mov    0x8010f8b8,%edx
801032c5:	83 ea 01             	sub    $0x1,%edx
801032c8:	39 d0                	cmp    %edx,%eax
801032ca:	7c 0c                	jl     801032d8 <log_write+0x2e>
    panic("too big a transaction");
801032cc:	c7 04 24 64 83 10 80 	movl   $0x80108364,(%esp)
801032d3:	e8 62 d2 ff ff       	call   8010053a <panic>
  if (!log.busy)
801032d8:	a1 bc f8 10 80       	mov    0x8010f8bc,%eax
801032dd:	85 c0                	test   %eax,%eax
801032df:	75 0c                	jne    801032ed <log_write+0x43>
    panic("write outside of trans");
801032e1:	c7 04 24 7a 83 10 80 	movl   $0x8010837a,(%esp)
801032e8:	e8 4d d2 ff ff       	call   8010053a <panic>

  for (i = 0; i < log.lh.n; i++) {
801032ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801032f4:	eb 1d                	jmp    80103313 <log_write+0x69>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
801032f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801032f9:	83 c0 10             	add    $0x10,%eax
801032fc:	8b 04 85 88 f8 10 80 	mov    -0x7fef0778(,%eax,4),%eax
80103303:	89 c2                	mov    %eax,%edx
80103305:	8b 45 08             	mov    0x8(%ebp),%eax
80103308:	8b 40 08             	mov    0x8(%eax),%eax
8010330b:	39 c2                	cmp    %eax,%edx
8010330d:	74 10                	je     8010331f <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
8010330f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80103313:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103318:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010331b:	7f d9                	jg     801032f6 <log_write+0x4c>
8010331d:	eb 01                	jmp    80103320 <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
8010331f:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103320:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103323:	8b 45 08             	mov    0x8(%ebp),%eax
80103326:	8b 40 08             	mov    0x8(%eax),%eax
80103329:	83 c2 10             	add    $0x10,%edx
8010332c:	89 04 95 88 f8 10 80 	mov    %eax,-0x7fef0778(,%edx,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
80103333:	a1 b4 f8 10 80       	mov    0x8010f8b4,%eax
80103338:	03 45 f0             	add    -0x10(%ebp),%eax
8010333b:	83 c0 01             	add    $0x1,%eax
8010333e:	89 c2                	mov    %eax,%edx
80103340:	8b 45 08             	mov    0x8(%ebp),%eax
80103343:	8b 40 04             	mov    0x4(%eax),%eax
80103346:	89 54 24 04          	mov    %edx,0x4(%esp)
8010334a:	89 04 24             	mov    %eax,(%esp)
8010334d:	e8 55 ce ff ff       	call   801001a7 <bread>
80103352:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
80103355:	8b 45 08             	mov    0x8(%ebp),%eax
80103358:	8d 50 18             	lea    0x18(%eax),%edx
8010335b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010335e:	83 c0 18             	add    $0x18,%eax
80103361:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103368:	00 
80103369:	89 54 24 04          	mov    %edx,0x4(%esp)
8010336d:	89 04 24             	mov    %eax,(%esp)
80103370:	e8 1c 1b 00 00       	call   80104e91 <memmove>
  bwrite(lbuf);
80103375:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103378:	89 04 24             	mov    %eax,(%esp)
8010337b:	e8 5e ce ff ff       	call   801001de <bwrite>
  brelse(lbuf);
80103380:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103383:	89 04 24             	mov    %eax,(%esp)
80103386:	e8 8d ce ff ff       	call   80100218 <brelse>
  if (i == log.lh.n)
8010338b:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
80103390:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80103393:	75 0d                	jne    801033a2 <log_write+0xf8>
    log.lh.n++;
80103395:	a1 c4 f8 10 80       	mov    0x8010f8c4,%eax
8010339a:	83 c0 01             	add    $0x1,%eax
8010339d:	a3 c4 f8 10 80       	mov    %eax,0x8010f8c4
  b->flags |= B_DIRTY; // XXX prevent eviction
801033a2:	8b 45 08             	mov    0x8(%ebp),%eax
801033a5:	8b 00                	mov    (%eax),%eax
801033a7:	89 c2                	mov    %eax,%edx
801033a9:	83 ca 04             	or     $0x4,%edx
801033ac:	8b 45 08             	mov    0x8(%ebp),%eax
801033af:	89 10                	mov    %edx,(%eax)
}
801033b1:	c9                   	leave  
801033b2:	c3                   	ret    
	...

801033b4 <v2p>:
801033b4:	55                   	push   %ebp
801033b5:	89 e5                	mov    %esp,%ebp
801033b7:	8b 45 08             	mov    0x8(%ebp),%eax
801033ba:	2d 00 00 00 80       	sub    $0x80000000,%eax
801033bf:	5d                   	pop    %ebp
801033c0:	c3                   	ret    

801033c1 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801033c1:	55                   	push   %ebp
801033c2:	89 e5                	mov    %esp,%ebp
801033c4:	8b 45 08             	mov    0x8(%ebp),%eax
801033c7:	2d 00 00 00 80       	sub    $0x80000000,%eax
801033cc:	5d                   	pop    %ebp
801033cd:	c3                   	ret    

801033ce <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801033ce:	55                   	push   %ebp
801033cf:	89 e5                	mov    %esp,%ebp
801033d1:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801033d4:	8b 55 08             	mov    0x8(%ebp),%edx
801033d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801033da:	8b 4d 08             	mov    0x8(%ebp),%ecx
801033dd:	f0 87 02             	lock xchg %eax,(%edx)
801033e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801033e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801033e6:	c9                   	leave  
801033e7:	c3                   	ret    

801033e8 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801033e8:	55                   	push   %ebp
801033e9:	89 e5                	mov    %esp,%ebp
801033eb:	83 e4 f0             	and    $0xfffffff0,%esp
801033ee:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801033f1:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
801033f8:	80 
801033f9:	c7 04 24 fc 26 11 80 	movl   $0x801126fc,(%esp)
80103400:	e8 cc f5 ff ff       	call   801029d1 <kinit1>
  kvmalloc();      // kernel page table
80103405:	e8 b2 45 00 00       	call   801079bc <kvmalloc>
  mpinit();        // collect info about this machine
8010340a:	e8 56 04 00 00       	call   80103865 <mpinit>
  lapicinit(mpbcpu());
8010340f:	e8 20 02 00 00       	call   80103634 <mpbcpu>
80103414:	89 04 24             	mov    %eax,(%esp)
80103417:	e8 04 f9 ff ff       	call   80102d20 <lapicinit>
  seginit();       // set up segments
8010341c:	e8 3c 3f 00 00       	call   8010735d <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103421:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103427:	0f b6 00             	movzbl (%eax),%eax
8010342a:	0f b6 c0             	movzbl %al,%eax
8010342d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103431:	c7 04 24 91 83 10 80 	movl   $0x80108391,(%esp)
80103438:	e8 5d cf ff ff       	call   8010039a <cprintf>
  picinit();       // interrupt controller
8010343d:	e8 8c 06 00 00       	call   80103ace <picinit>
  ioapicinit();    // another interrupt controller
80103442:	e8 7a f4 ff ff       	call   801028c1 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103447:	e8 3f d6 ff ff       	call   80100a8b <consoleinit>
  uartinit();      // serial port
8010344c:	e8 56 32 00 00       	call   801066a7 <uartinit>
  pinit();         // process table
80103451:	e8 88 0b 00 00       	call   80103fde <pinit>
  tvinit();        // trap vectors
80103456:	e8 ff 2d 00 00       	call   8010625a <tvinit>
  binit();         // buffer cache
8010345b:	e8 d4 cb ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103460:	e8 9f da ff ff       	call   80100f04 <fileinit>
  iinit();         // inode cache
80103465:	e8 60 e1 ff ff       	call   801015ca <iinit>
  ideinit();       // disk
8010346a:	e8 b9 f0 ff ff       	call   80102528 <ideinit>
  if(!ismp)
8010346f:	a1 04 f9 10 80       	mov    0x8010f904,%eax
80103474:	85 c0                	test   %eax,%eax
80103476:	75 05                	jne    8010347d <main+0x95>
    timerinit();   // uniprocessor timer
80103478:	e8 25 2d 00 00       	call   801061a2 <timerinit>
  startothers();   // start other processors
8010347d:	e8 87 00 00 00       	call   80103509 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103482:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80103489:	8e 
8010348a:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103491:	e8 73 f5 ff ff       	call   80102a09 <kinit2>
  userinit();      // first user process
80103496:	e8 5f 0c 00 00       	call   801040fa <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010349b:	e8 22 00 00 00       	call   801034c2 <mpmain>

801034a0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	83 ec 18             	sub    $0x18,%esp
  switchkvm(); 
801034a6:	e8 28 45 00 00       	call   801079d3 <switchkvm>
  seginit();
801034ab:	e8 ad 3e 00 00       	call   8010735d <seginit>
  lapicinit(cpunum());
801034b0:	e8 c7 f9 ff ff       	call   80102e7c <cpunum>
801034b5:	89 04 24             	mov    %eax,(%esp)
801034b8:	e8 63 f8 ff ff       	call   80102d20 <lapicinit>
  mpmain();
801034bd:	e8 00 00 00 00       	call   801034c2 <mpmain>

801034c2 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801034c2:	55                   	push   %ebp
801034c3:	89 e5                	mov    %esp,%ebp
801034c5:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801034c8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034ce:	0f b6 00             	movzbl (%eax),%eax
801034d1:	0f b6 c0             	movzbl %al,%eax
801034d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801034d8:	c7 04 24 a8 83 10 80 	movl   $0x801083a8,(%esp)
801034df:	e8 b6 ce ff ff       	call   8010039a <cprintf>
  idtinit();       // load idt register
801034e4:	e8 e1 2e 00 00       	call   801063ca <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801034e9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034ef:	05 a8 00 00 00       	add    $0xa8,%eax
801034f4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801034fb:	00 
801034fc:	89 04 24             	mov    %eax,(%esp)
801034ff:	e8 ca fe ff ff       	call   801033ce <xchg>
  scheduler();     // start running processes
80103504:	e8 ea 11 00 00       	call   801046f3 <scheduler>

80103509 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103509:	55                   	push   %ebp
8010350a:	89 e5                	mov    %esp,%ebp
8010350c:	53                   	push   %ebx
8010350d:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103510:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
80103517:	e8 a5 fe ff ff       	call   801033c1 <p2v>
8010351c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010351f:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103524:	89 44 24 08          	mov    %eax,0x8(%esp)
80103528:	c7 44 24 04 0c b5 10 	movl   $0x8010b50c,0x4(%esp)
8010352f:	80 
80103530:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103533:	89 04 24             	mov    %eax,(%esp)
80103536:	e8 56 19 00 00       	call   80104e91 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010353b:	c7 45 f0 20 f9 10 80 	movl   $0x8010f920,-0x10(%ebp)
80103542:	e9 85 00 00 00       	jmp    801035cc <startothers+0xc3>
    if(c == cpus+cpunum())  // We've started already.
80103547:	e8 30 f9 ff ff       	call   80102e7c <cpunum>
8010354c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103552:	05 20 f9 10 80       	add    $0x8010f920,%eax
80103557:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010355a:	74 68                	je     801035c4 <startothers+0xbb>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
8010355c:	e8 a1 f5 ff ff       	call   80102b02 <kalloc>
80103561:	89 45 f4             	mov    %eax,-0xc(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103564:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103567:	83 e8 04             	sub    $0x4,%eax
8010356a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010356d:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103573:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103575:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103578:	83 e8 08             	sub    $0x8,%eax
8010357b:	c7 00 a0 34 10 80    	movl   $0x801034a0,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103581:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103584:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103587:	c7 04 24 00 a0 10 80 	movl   $0x8010a000,(%esp)
8010358e:	e8 21 fe ff ff       	call   801033b4 <v2p>
80103593:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103595:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103598:	89 04 24             	mov    %eax,(%esp)
8010359b:	e8 14 fe ff ff       	call   801033b4 <v2p>
801035a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801035a3:	0f b6 12             	movzbl (%edx),%edx
801035a6:	0f b6 d2             	movzbl %dl,%edx
801035a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801035ad:	89 14 24             	mov    %edx,(%esp)
801035b0:	e8 4d f9 ff ff       	call   80102f02 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801035b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035b8:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801035be:	85 c0                	test   %eax,%eax
801035c0:	74 f3                	je     801035b5 <startothers+0xac>
801035c2:	eb 01                	jmp    801035c5 <startothers+0xbc>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
801035c4:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801035c5:	81 45 f0 bc 00 00 00 	addl   $0xbc,-0x10(%ebp)
801035cc:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801035d1:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801035d7:	05 20 f9 10 80       	add    $0x8010f920,%eax
801035dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801035df:	0f 87 62 ff ff ff    	ja     80103547 <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
801035e5:	83 c4 24             	add    $0x24,%esp
801035e8:	5b                   	pop    %ebx
801035e9:	5d                   	pop    %ebp
801035ea:	c3                   	ret    
	...

801035ec <p2v>:
801035ec:	55                   	push   %ebp
801035ed:	89 e5                	mov    %esp,%ebp
801035ef:	8b 45 08             	mov    0x8(%ebp),%eax
801035f2:	2d 00 00 00 80       	sub    $0x80000000,%eax
801035f7:	5d                   	pop    %ebp
801035f8:	c3                   	ret    

801035f9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801035f9:	55                   	push   %ebp
801035fa:	89 e5                	mov    %esp,%ebp
801035fc:	83 ec 14             	sub    $0x14,%esp
801035ff:	8b 45 08             	mov    0x8(%ebp),%eax
80103602:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103606:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010360a:	89 c2                	mov    %eax,%edx
8010360c:	ec                   	in     (%dx),%al
8010360d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103610:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103614:	c9                   	leave  
80103615:	c3                   	ret    

80103616 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103616:	55                   	push   %ebp
80103617:	89 e5                	mov    %esp,%ebp
80103619:	83 ec 08             	sub    $0x8,%esp
8010361c:	8b 55 08             	mov    0x8(%ebp),%edx
8010361f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103622:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103626:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103629:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010362d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103631:	ee                   	out    %al,(%dx)
}
80103632:	c9                   	leave  
80103633:	c3                   	ret    

80103634 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103634:	55                   	push   %ebp
80103635:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103637:	a1 44 b6 10 80       	mov    0x8010b644,%eax
8010363c:	89 c2                	mov    %eax,%edx
8010363e:	b8 20 f9 10 80       	mov    $0x8010f920,%eax
80103643:	89 d1                	mov    %edx,%ecx
80103645:	29 c1                	sub    %eax,%ecx
80103647:	89 c8                	mov    %ecx,%eax
80103649:	c1 f8 02             	sar    $0x2,%eax
8010364c:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103652:	5d                   	pop    %ebp
80103653:	c3                   	ret    

80103654 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103654:	55                   	push   %ebp
80103655:	89 e5                	mov    %esp,%ebp
80103657:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
8010365a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  for(i=0; i<len; i++)
80103661:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80103668:	eb 13                	jmp    8010367d <sum+0x29>
    sum += addr[i];
8010366a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010366d:	03 45 08             	add    0x8(%ebp),%eax
80103670:	0f b6 00             	movzbl (%eax),%eax
80103673:	0f b6 c0             	movzbl %al,%eax
80103676:	01 45 fc             	add    %eax,-0x4(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103679:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010367d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103680:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103683:	7c e5                	jl     8010366a <sum+0x16>
    sum += addr[i];
  return sum;
80103685:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103688:	c9                   	leave  
80103689:	c3                   	ret    

8010368a <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010368a:	55                   	push   %ebp
8010368b:	89 e5                	mov    %esp,%ebp
8010368d:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103690:	8b 45 08             	mov    0x8(%ebp),%eax
80103693:	89 04 24             	mov    %eax,(%esp)
80103696:	e8 51 ff ff ff       	call   801035ec <p2v>
8010369b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  e = addr+len;
8010369e:	8b 45 0c             	mov    0xc(%ebp),%eax
801036a1:	03 45 f4             	add    -0xc(%ebp),%eax
801036a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
801036a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
801036ad:	eb 3f                	jmp    801036ee <mpsearch1+0x64>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036af:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801036b6:	00 
801036b7:	c7 44 24 04 bc 83 10 	movl   $0x801083bc,0x4(%esp)
801036be:	80 
801036bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036c2:	89 04 24             	mov    %eax,(%esp)
801036c5:	e8 6b 17 00 00       	call   80104e35 <memcmp>
801036ca:	85 c0                	test   %eax,%eax
801036cc:	75 1c                	jne    801036ea <mpsearch1+0x60>
801036ce:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
801036d5:	00 
801036d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036d9:	89 04 24             	mov    %eax,(%esp)
801036dc:	e8 73 ff ff ff       	call   80103654 <sum>
801036e1:	84 c0                	test   %al,%al
801036e3:	75 05                	jne    801036ea <mpsearch1+0x60>
      return (struct mp*)p;
801036e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e8:	eb 11                	jmp    801036fb <mpsearch1+0x71>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801036ea:	83 45 f0 10          	addl   $0x10,-0x10(%ebp)
801036ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036f1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801036f4:	72 b9                	jb     801036af <mpsearch1+0x25>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801036f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801036fb:	c9                   	leave  
801036fc:	c3                   	ret    

801036fd <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
801036fd:	55                   	push   %ebp
801036fe:	89 e5                	mov    %esp,%ebp
80103700:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103703:	c7 45 ec 00 04 00 80 	movl   $0x80000400,-0x14(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010370a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010370d:	83 c0 0f             	add    $0xf,%eax
80103710:	0f b6 00             	movzbl (%eax),%eax
80103713:	0f b6 c0             	movzbl %al,%eax
80103716:	89 c2                	mov    %eax,%edx
80103718:	c1 e2 08             	shl    $0x8,%edx
8010371b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010371e:	83 c0 0e             	add    $0xe,%eax
80103721:	0f b6 00             	movzbl (%eax),%eax
80103724:	0f b6 c0             	movzbl %al,%eax
80103727:	09 d0                	or     %edx,%eax
80103729:	c1 e0 04             	shl    $0x4,%eax
8010372c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010372f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103733:	74 21                	je     80103756 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103735:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
8010373c:	00 
8010373d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103740:	89 04 24             	mov    %eax,(%esp)
80103743:	e8 42 ff ff ff       	call   8010368a <mpsearch1>
80103748:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010374b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010374f:	74 50                	je     801037a1 <mpsearch+0xa4>
      return mp;
80103751:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103754:	eb 60                	jmp    801037b6 <mpsearch+0xb9>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103756:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103759:	83 c0 14             	add    $0x14,%eax
8010375c:	0f b6 00             	movzbl (%eax),%eax
8010375f:	0f b6 c0             	movzbl %al,%eax
80103762:	89 c2                	mov    %eax,%edx
80103764:	c1 e2 08             	shl    $0x8,%edx
80103767:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010376a:	83 c0 13             	add    $0x13,%eax
8010376d:	0f b6 00             	movzbl (%eax),%eax
80103770:	0f b6 c0             	movzbl %al,%eax
80103773:	09 d0                	or     %edx,%eax
80103775:	c1 e0 0a             	shl    $0xa,%eax
80103778:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
8010377b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010377e:	2d 00 04 00 00       	sub    $0x400,%eax
80103783:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
8010378a:	00 
8010378b:	89 04 24             	mov    %eax,(%esp)
8010378e:	e8 f7 fe ff ff       	call   8010368a <mpsearch1>
80103793:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103796:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010379a:	74 06                	je     801037a2 <mpsearch+0xa5>
      return mp;
8010379c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010379f:	eb 15                	jmp    801037b6 <mpsearch+0xb9>
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
      return mp;
801037a1:	90                   	nop
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801037a2:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801037a9:	00 
801037aa:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
801037b1:	e8 d4 fe ff ff       	call   8010368a <mpsearch1>
}
801037b6:	c9                   	leave  
801037b7:	c3                   	ret    

801037b8 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
801037b8:	55                   	push   %ebp
801037b9:	89 e5                	mov    %esp,%ebp
801037bb:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037be:	e8 3a ff ff ff       	call   801036fd <mpsearch>
801037c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801037c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801037ca:	74 0a                	je     801037d6 <mpconfig+0x1e>
801037cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037cf:	8b 40 04             	mov    0x4(%eax),%eax
801037d2:	85 c0                	test   %eax,%eax
801037d4:	75 0a                	jne    801037e0 <mpconfig+0x28>
    return 0;
801037d6:	b8 00 00 00 00       	mov    $0x0,%eax
801037db:	e9 83 00 00 00       	jmp    80103863 <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
801037e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037e3:	8b 40 04             	mov    0x4(%eax),%eax
801037e6:	89 04 24             	mov    %eax,(%esp)
801037e9:	e8 fe fd ff ff       	call   801035ec <p2v>
801037ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801037f1:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801037f8:	00 
801037f9:	c7 44 24 04 c1 83 10 	movl   $0x801083c1,0x4(%esp)
80103800:	80 
80103801:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103804:	89 04 24             	mov    %eax,(%esp)
80103807:	e8 29 16 00 00       	call   80104e35 <memcmp>
8010380c:	85 c0                	test   %eax,%eax
8010380e:	74 07                	je     80103817 <mpconfig+0x5f>
    return 0;
80103810:	b8 00 00 00 00       	mov    $0x0,%eax
80103815:	eb 4c                	jmp    80103863 <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
80103817:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010381a:	0f b6 40 06          	movzbl 0x6(%eax),%eax
8010381e:	3c 01                	cmp    $0x1,%al
80103820:	74 12                	je     80103834 <mpconfig+0x7c>
80103822:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103825:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103829:	3c 04                	cmp    $0x4,%al
8010382b:	74 07                	je     80103834 <mpconfig+0x7c>
    return 0;
8010382d:	b8 00 00 00 00       	mov    $0x0,%eax
80103832:	eb 2f                	jmp    80103863 <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
80103834:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103837:	0f b7 40 04          	movzwl 0x4(%eax),%eax
8010383b:	0f b7 d0             	movzwl %ax,%edx
8010383e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103841:	89 54 24 04          	mov    %edx,0x4(%esp)
80103845:	89 04 24             	mov    %eax,(%esp)
80103848:	e8 07 fe ff ff       	call   80103654 <sum>
8010384d:	84 c0                	test   %al,%al
8010384f:	74 07                	je     80103858 <mpconfig+0xa0>
    return 0;
80103851:	b8 00 00 00 00       	mov    $0x0,%eax
80103856:	eb 0b                	jmp    80103863 <mpconfig+0xab>
  *pmp = mp;
80103858:	8b 45 08             	mov    0x8(%ebp),%eax
8010385b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010385e:	89 10                	mov    %edx,(%eax)
  return conf;
80103860:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103863:	c9                   	leave  
80103864:	c3                   	ret    

80103865 <mpinit>:

void
mpinit(void)
{
80103865:	55                   	push   %ebp
80103866:	89 e5                	mov    %esp,%ebp
80103868:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
8010386b:	c7 05 44 b6 10 80 20 	movl   $0x8010f920,0x8010b644
80103872:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
80103875:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103878:	89 04 24             	mov    %eax,(%esp)
8010387b:	e8 38 ff ff ff       	call   801037b8 <mpconfig>
80103880:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103883:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103887:	0f 84 9d 01 00 00    	je     80103a2a <mpinit+0x1c5>
    return;
  ismp = 1;
8010388d:	c7 05 04 f9 10 80 01 	movl   $0x1,0x8010f904
80103894:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103897:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010389a:	8b 40 24             	mov    0x24(%eax),%eax
8010389d:	a3 7c f8 10 80       	mov    %eax,0x8010f87c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801038a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801038a5:	83 c0 2c             	add    $0x2c,%eax
801038a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
801038ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
801038b1:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801038b5:	0f b7 c0             	movzwl %ax,%eax
801038b8:	8d 04 02             	lea    (%edx,%eax,1),%eax
801038bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
801038be:	e9 f2 00 00 00       	jmp    801039b5 <mpinit+0x150>
    switch(*p){
801038c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801038c6:	0f b6 00             	movzbl (%eax),%eax
801038c9:	0f b6 c0             	movzbl %al,%eax
801038cc:	83 f8 04             	cmp    $0x4,%eax
801038cf:	0f 87 bd 00 00 00    	ja     80103992 <mpinit+0x12d>
801038d5:	8b 04 85 04 84 10 80 	mov    -0x7fef7bfc(,%eax,4),%eax
801038dc:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
801038de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801038e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(ncpu != proc->apicid){
801038e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038e7:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038eb:	0f b6 d0             	movzbl %al,%edx
801038ee:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801038f3:	39 c2                	cmp    %eax,%edx
801038f5:	74 2d                	je     80103924 <mpinit+0xbf>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
801038f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038fa:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038fe:	0f b6 d0             	movzbl %al,%edx
80103901:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103906:	89 54 24 08          	mov    %edx,0x8(%esp)
8010390a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010390e:	c7 04 24 c6 83 10 80 	movl   $0x801083c6,(%esp)
80103915:	e8 80 ca ff ff       	call   8010039a <cprintf>
        ismp = 0;
8010391a:	c7 05 04 f9 10 80 00 	movl   $0x0,0x8010f904
80103921:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103924:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103927:	0f b6 40 03          	movzbl 0x3(%eax),%eax
8010392b:	0f b6 c0             	movzbl %al,%eax
8010392e:	83 e0 02             	and    $0x2,%eax
80103931:	85 c0                	test   %eax,%eax
80103933:	74 15                	je     8010394a <mpinit+0xe5>
        bcpu = &cpus[ncpu];
80103935:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010393a:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103940:	05 20 f9 10 80       	add    $0x8010f920,%eax
80103945:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
8010394a:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010394f:	8b 15 00 ff 10 80    	mov    0x8010ff00,%edx
80103955:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010395b:	88 90 20 f9 10 80    	mov    %dl,-0x7fef06e0(%eax)
      ncpu++;
80103961:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80103966:	83 c0 01             	add    $0x1,%eax
80103969:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
      p += sizeof(struct mpproc);
8010396e:	83 45 e4 14          	addl   $0x14,-0x1c(%ebp)
      continue;
80103972:	eb 41                	jmp    801039b5 <mpinit+0x150>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103974:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103977:	89 45 f4             	mov    %eax,-0xc(%ebp)
      ioapicid = ioapic->apicno;
8010397a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010397d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103981:	a2 00 f9 10 80       	mov    %al,0x8010f900
      p += sizeof(struct mpioapic);
80103986:	83 45 e4 08          	addl   $0x8,-0x1c(%ebp)
      continue;
8010398a:	eb 29                	jmp    801039b5 <mpinit+0x150>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010398c:	83 45 e4 08          	addl   $0x8,-0x1c(%ebp)
      continue;
80103990:	eb 23                	jmp    801039b5 <mpinit+0x150>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103992:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103995:	0f b6 00             	movzbl (%eax),%eax
80103998:	0f b6 c0             	movzbl %al,%eax
8010399b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010399f:	c7 04 24 e4 83 10 80 	movl   $0x801083e4,(%esp)
801039a6:	e8 ef c9 ff ff       	call   8010039a <cprintf>
      ismp = 0;
801039ab:	c7 05 04 f9 10 80 00 	movl   $0x0,0x8010f904
801039b2:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801039b8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
801039bb:	0f 82 02 ff ff ff    	jb     801038c3 <mpinit+0x5e>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
801039c1:	a1 04 f9 10 80       	mov    0x8010f904,%eax
801039c6:	85 c0                	test   %eax,%eax
801039c8:	75 1d                	jne    801039e7 <mpinit+0x182>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
801039ca:	c7 05 00 ff 10 80 01 	movl   $0x1,0x8010ff00
801039d1:	00 00 00 
    lapic = 0;
801039d4:	c7 05 7c f8 10 80 00 	movl   $0x0,0x8010f87c
801039db:	00 00 00 
    ioapicid = 0;
801039de:	c6 05 00 f9 10 80 00 	movb   $0x0,0x8010f900
    return;
801039e5:	eb 44                	jmp    80103a2b <mpinit+0x1c6>
  }

  if(mp->imcrp){
801039e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801039ea:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
801039ee:	84 c0                	test   %al,%al
801039f0:	74 39                	je     80103a2b <mpinit+0x1c6>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
801039f2:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
801039f9:	00 
801039fa:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
80103a01:	e8 10 fc ff ff       	call   80103616 <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103a06:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103a0d:	e8 e7 fb ff ff       	call   801035f9 <inb>
80103a12:	83 c8 01             	or     $0x1,%eax
80103a15:	0f b6 c0             	movzbl %al,%eax
80103a18:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a1c:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103a23:	e8 ee fb ff ff       	call   80103616 <outb>
80103a28:	eb 01                	jmp    80103a2b <mpinit+0x1c6>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103a2a:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103a2b:	c9                   	leave  
80103a2c:	c3                   	ret    
80103a2d:	00 00                	add    %al,(%eax)
	...

80103a30 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	83 ec 08             	sub    $0x8,%esp
80103a36:	8b 55 08             	mov    0x8(%ebp),%edx
80103a39:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a3c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a40:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a43:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a47:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a4b:	ee                   	out    %al,(%dx)
}
80103a4c:	c9                   	leave  
80103a4d:	c3                   	ret    

80103a4e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103a4e:	55                   	push   %ebp
80103a4f:	89 e5                	mov    %esp,%ebp
80103a51:	83 ec 0c             	sub    $0xc,%esp
80103a54:	8b 45 08             	mov    0x8(%ebp),%eax
80103a57:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103a5b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a5f:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103a65:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a69:	0f b6 c0             	movzbl %al,%eax
80103a6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a70:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103a77:	e8 b4 ff ff ff       	call   80103a30 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103a7c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a80:	66 c1 e8 08          	shr    $0x8,%ax
80103a84:	0f b6 c0             	movzbl %al,%eax
80103a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a8b:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103a92:	e8 99 ff ff ff       	call   80103a30 <outb>
}
80103a97:	c9                   	leave  
80103a98:	c3                   	ret    

80103a99 <picenable>:

void
picenable(int irq)
{
80103a99:	55                   	push   %ebp
80103a9a:	89 e5                	mov    %esp,%ebp
80103a9c:	53                   	push   %ebx
80103a9d:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103aa0:	8b 45 08             	mov    0x8(%ebp),%eax
80103aa3:	ba 01 00 00 00       	mov    $0x1,%edx
80103aa8:	89 d3                	mov    %edx,%ebx
80103aaa:	89 c1                	mov    %eax,%ecx
80103aac:	d3 e3                	shl    %cl,%ebx
80103aae:	89 d8                	mov    %ebx,%eax
80103ab0:	89 c2                	mov    %eax,%edx
80103ab2:	f7 d2                	not    %edx
80103ab4:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103abb:	21 d0                	and    %edx,%eax
80103abd:	0f b7 c0             	movzwl %ax,%eax
80103ac0:	89 04 24             	mov    %eax,(%esp)
80103ac3:	e8 86 ff ff ff       	call   80103a4e <picsetmask>
}
80103ac8:	83 c4 04             	add    $0x4,%esp
80103acb:	5b                   	pop    %ebx
80103acc:	5d                   	pop    %ebp
80103acd:	c3                   	ret    

80103ace <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103ace:	55                   	push   %ebp
80103acf:	89 e5                	mov    %esp,%ebp
80103ad1:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103ad4:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103adb:	00 
80103adc:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103ae3:	e8 48 ff ff ff       	call   80103a30 <outb>
  outb(IO_PIC2+1, 0xFF);
80103ae8:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103aef:	00 
80103af0:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103af7:	e8 34 ff ff ff       	call   80103a30 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103afc:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103b03:	00 
80103b04:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103b0b:	e8 20 ff ff ff       	call   80103a30 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103b10:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103b17:	00 
80103b18:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b1f:	e8 0c ff ff ff       	call   80103a30 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103b24:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103b2b:	00 
80103b2c:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b33:	e8 f8 fe ff ff       	call   80103a30 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103b38:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b3f:	00 
80103b40:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b47:	e8 e4 fe ff ff       	call   80103a30 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103b4c:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103b53:	00 
80103b54:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103b5b:	e8 d0 fe ff ff       	call   80103a30 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103b60:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103b67:	00 
80103b68:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b6f:	e8 bc fe ff ff       	call   80103a30 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103b74:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103b7b:	00 
80103b7c:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b83:	e8 a8 fe ff ff       	call   80103a30 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103b88:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b8f:	00 
80103b90:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b97:	e8 94 fe ff ff       	call   80103a30 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103b9c:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103ba3:	00 
80103ba4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103bab:	e8 80 fe ff ff       	call   80103a30 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103bb0:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103bb7:	00 
80103bb8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103bbf:	e8 6c fe ff ff       	call   80103a30 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80103bc4:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103bcb:	00 
80103bcc:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103bd3:	e8 58 fe ff ff       	call   80103a30 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80103bd8:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103bdf:	00 
80103be0:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103be7:	e8 44 fe ff ff       	call   80103a30 <outb>

  if(irqmask != 0xFFFF)
80103bec:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bf3:	66 83 f8 ff          	cmp    $0xffffffff,%ax
80103bf7:	74 12                	je     80103c0b <picinit+0x13d>
    picsetmask(irqmask);
80103bf9:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103c00:	0f b7 c0             	movzwl %ax,%eax
80103c03:	89 04 24             	mov    %eax,(%esp)
80103c06:	e8 43 fe ff ff       	call   80103a4e <picsetmask>
}
80103c0b:	c9                   	leave  
80103c0c:	c3                   	ret    
80103c0d:	00 00                	add    %al,(%eax)
	...

80103c10 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80103c16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103c26:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c29:	8b 10                	mov    (%eax),%edx
80103c2b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c2e:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103c30:	e8 eb d2 ff ff       	call   80100f20 <filealloc>
80103c35:	8b 55 08             	mov    0x8(%ebp),%edx
80103c38:	89 02                	mov    %eax,(%edx)
80103c3a:	8b 45 08             	mov    0x8(%ebp),%eax
80103c3d:	8b 00                	mov    (%eax),%eax
80103c3f:	85 c0                	test   %eax,%eax
80103c41:	0f 84 c8 00 00 00    	je     80103d0f <pipealloc+0xff>
80103c47:	e8 d4 d2 ff ff       	call   80100f20 <filealloc>
80103c4c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c4f:	89 02                	mov    %eax,(%edx)
80103c51:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c54:	8b 00                	mov    (%eax),%eax
80103c56:	85 c0                	test   %eax,%eax
80103c58:	0f 84 b1 00 00 00    	je     80103d0f <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103c5e:	e8 9f ee ff ff       	call   80102b02 <kalloc>
80103c63:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c6a:	0f 84 9e 00 00 00    	je     80103d0e <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
80103c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c73:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c7a:	00 00 00 
  p->writeopen = 1;
80103c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c80:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c87:	00 00 00 
  p->nwrite = 0;
80103c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c8d:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c94:	00 00 00 
  p->nread = 0;
80103c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c9a:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103ca1:	00 00 00 
  initlock(&p->lock, "pipe");
80103ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca7:	c7 44 24 04 18 84 10 	movl   $0x80108418,0x4(%esp)
80103cae:	80 
80103caf:	89 04 24             	mov    %eax,(%esp)
80103cb2:	e8 97 0e 00 00       	call   80104b4e <initlock>
  (*f0)->type = FD_PIPE;
80103cb7:	8b 45 08             	mov    0x8(%ebp),%eax
80103cba:	8b 00                	mov    (%eax),%eax
80103cbc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103cc2:	8b 45 08             	mov    0x8(%ebp),%eax
80103cc5:	8b 00                	mov    (%eax),%eax
80103cc7:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80103cce:	8b 00                	mov    (%eax),%eax
80103cd0:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103cd4:	8b 45 08             	mov    0x8(%ebp),%eax
80103cd7:	8b 00                	mov    (%eax),%eax
80103cd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cdc:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ce2:	8b 00                	mov    (%eax),%eax
80103ce4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103cea:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ced:	8b 00                	mov    (%eax),%eax
80103cef:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103cf3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cf6:	8b 00                	mov    (%eax),%eax
80103cf8:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cff:	8b 00                	mov    (%eax),%eax
80103d01:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d04:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103d07:	b8 00 00 00 00       	mov    $0x0,%eax
80103d0c:	eb 43                	jmp    80103d51 <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103d0e:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103d0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103d13:	74 0b                	je     80103d20 <pipealloc+0x110>
    kfree((char*)p);
80103d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d18:	89 04 24             	mov    %eax,(%esp)
80103d1b:	e8 49 ed ff ff       	call   80102a69 <kfree>
  if(*f0)
80103d20:	8b 45 08             	mov    0x8(%ebp),%eax
80103d23:	8b 00                	mov    (%eax),%eax
80103d25:	85 c0                	test   %eax,%eax
80103d27:	74 0d                	je     80103d36 <pipealloc+0x126>
    fileclose(*f0);
80103d29:	8b 45 08             	mov    0x8(%ebp),%eax
80103d2c:	8b 00                	mov    (%eax),%eax
80103d2e:	89 04 24             	mov    %eax,(%esp)
80103d31:	e8 93 d2 ff ff       	call   80100fc9 <fileclose>
  if(*f1)
80103d36:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d39:	8b 00                	mov    (%eax),%eax
80103d3b:	85 c0                	test   %eax,%eax
80103d3d:	74 0d                	je     80103d4c <pipealloc+0x13c>
    fileclose(*f1);
80103d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d42:	8b 00                	mov    (%eax),%eax
80103d44:	89 04 24             	mov    %eax,(%esp)
80103d47:	e8 7d d2 ff ff       	call   80100fc9 <fileclose>
  return -1;
80103d4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d51:	c9                   	leave  
80103d52:	c3                   	ret    

80103d53 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103d53:	55                   	push   %ebp
80103d54:	89 e5                	mov    %esp,%ebp
80103d56:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
80103d59:	8b 45 08             	mov    0x8(%ebp),%eax
80103d5c:	89 04 24             	mov    %eax,(%esp)
80103d5f:	e8 0b 0e 00 00       	call   80104b6f <acquire>
  if(writable){
80103d64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103d68:	74 1f                	je     80103d89 <pipeclose+0x36>
    p->writeopen = 0;
80103d6a:	8b 45 08             	mov    0x8(%ebp),%eax
80103d6d:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103d74:	00 00 00 
    wakeup(&p->nread);
80103d77:	8b 45 08             	mov    0x8(%ebp),%eax
80103d7a:	05 34 02 00 00       	add    $0x234,%eax
80103d7f:	89 04 24             	mov    %eax,(%esp)
80103d82:	e8 f0 0b 00 00       	call   80104977 <wakeup>
80103d87:	eb 1d                	jmp    80103da6 <pipeclose+0x53>
  } else {
    p->readopen = 0;
80103d89:	8b 45 08             	mov    0x8(%ebp),%eax
80103d8c:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103d93:	00 00 00 
    wakeup(&p->nwrite);
80103d96:	8b 45 08             	mov    0x8(%ebp),%eax
80103d99:	05 38 02 00 00       	add    $0x238,%eax
80103d9e:	89 04 24             	mov    %eax,(%esp)
80103da1:	e8 d1 0b 00 00       	call   80104977 <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103da6:	8b 45 08             	mov    0x8(%ebp),%eax
80103da9:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103daf:	85 c0                	test   %eax,%eax
80103db1:	75 25                	jne    80103dd8 <pipeclose+0x85>
80103db3:	8b 45 08             	mov    0x8(%ebp),%eax
80103db6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103dbc:	85 c0                	test   %eax,%eax
80103dbe:	75 18                	jne    80103dd8 <pipeclose+0x85>
    release(&p->lock);
80103dc0:	8b 45 08             	mov    0x8(%ebp),%eax
80103dc3:	89 04 24             	mov    %eax,(%esp)
80103dc6:	e8 05 0e 00 00       	call   80104bd0 <release>
    kfree((char*)p);
80103dcb:	8b 45 08             	mov    0x8(%ebp),%eax
80103dce:	89 04 24             	mov    %eax,(%esp)
80103dd1:	e8 93 ec ff ff       	call   80102a69 <kfree>
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103dd6:	eb 0b                	jmp    80103de3 <pipeclose+0x90>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103dd8:	8b 45 08             	mov    0x8(%ebp),%eax
80103ddb:	89 04 24             	mov    %eax,(%esp)
80103dde:	e8 ed 0d 00 00       	call   80104bd0 <release>
}
80103de3:	c9                   	leave  
80103de4:	c3                   	ret    

80103de5 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103de5:	55                   	push   %ebp
80103de6:	89 e5                	mov    %esp,%ebp
80103de8:	53                   	push   %ebx
80103de9:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103dec:	8b 45 08             	mov    0x8(%ebp),%eax
80103def:	89 04 24             	mov    %eax,(%esp)
80103df2:	e8 78 0d 00 00       	call   80104b6f <acquire>
  for(i = 0; i < n; i++){
80103df7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103dfe:	e9 a6 00 00 00       	jmp    80103ea9 <pipewrite+0xc4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80103e03:	8b 45 08             	mov    0x8(%ebp),%eax
80103e06:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103e0c:	85 c0                	test   %eax,%eax
80103e0e:	74 0d                	je     80103e1d <pipewrite+0x38>
80103e10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e16:	8b 40 24             	mov    0x24(%eax),%eax
80103e19:	85 c0                	test   %eax,%eax
80103e1b:	74 15                	je     80103e32 <pipewrite+0x4d>
        release(&p->lock);
80103e1d:	8b 45 08             	mov    0x8(%ebp),%eax
80103e20:	89 04 24             	mov    %eax,(%esp)
80103e23:	e8 a8 0d 00 00       	call   80104bd0 <release>
        return -1;
80103e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e2d:	e9 9d 00 00 00       	jmp    80103ecf <pipewrite+0xea>
      }
      wakeup(&p->nread);
80103e32:	8b 45 08             	mov    0x8(%ebp),%eax
80103e35:	05 34 02 00 00       	add    $0x234,%eax
80103e3a:	89 04 24             	mov    %eax,(%esp)
80103e3d:	e8 35 0b 00 00       	call   80104977 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e42:	8b 45 08             	mov    0x8(%ebp),%eax
80103e45:	8b 55 08             	mov    0x8(%ebp),%edx
80103e48:	81 c2 38 02 00 00    	add    $0x238,%edx
80103e4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e52:	89 14 24             	mov    %edx,(%esp)
80103e55:	e8 43 0a 00 00       	call   8010489d <sleep>
80103e5a:	eb 01                	jmp    80103e5d <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103e5c:	90                   	nop
80103e5d:	8b 45 08             	mov    0x8(%ebp),%eax
80103e60:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103e66:	8b 45 08             	mov    0x8(%ebp),%eax
80103e69:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103e6f:	05 00 02 00 00       	add    $0x200,%eax
80103e74:	39 c2                	cmp    %eax,%edx
80103e76:	74 8b                	je     80103e03 <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103e78:	8b 45 08             	mov    0x8(%ebp),%eax
80103e7b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103e81:	89 c3                	mov    %eax,%ebx
80103e83:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80103e89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e8c:	03 55 0c             	add    0xc(%ebp),%edx
80103e8f:	0f b6 0a             	movzbl (%edx),%ecx
80103e92:	8b 55 08             	mov    0x8(%ebp),%edx
80103e95:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
80103e99:	8d 50 01             	lea    0x1(%eax),%edx
80103e9c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e9f:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103ea5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103eac:	3b 45 10             	cmp    0x10(%ebp),%eax
80103eaf:	7c ab                	jl     80103e5c <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103eb1:	8b 45 08             	mov    0x8(%ebp),%eax
80103eb4:	05 34 02 00 00       	add    $0x234,%eax
80103eb9:	89 04 24             	mov    %eax,(%esp)
80103ebc:	e8 b6 0a 00 00       	call   80104977 <wakeup>
  release(&p->lock);
80103ec1:	8b 45 08             	mov    0x8(%ebp),%eax
80103ec4:	89 04 24             	mov    %eax,(%esp)
80103ec7:	e8 04 0d 00 00       	call   80104bd0 <release>
  return n;
80103ecc:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103ecf:	83 c4 24             	add    $0x24,%esp
80103ed2:	5b                   	pop    %ebx
80103ed3:	5d                   	pop    %ebp
80103ed4:	c3                   	ret    

80103ed5 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103ed5:	55                   	push   %ebp
80103ed6:	89 e5                	mov    %esp,%ebp
80103ed8:	53                   	push   %ebx
80103ed9:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103edc:	8b 45 08             	mov    0x8(%ebp),%eax
80103edf:	89 04 24             	mov    %eax,(%esp)
80103ee2:	e8 88 0c 00 00       	call   80104b6f <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103ee7:	eb 3a                	jmp    80103f23 <piperead+0x4e>
    if(proc->killed){
80103ee9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103eef:	8b 40 24             	mov    0x24(%eax),%eax
80103ef2:	85 c0                	test   %eax,%eax
80103ef4:	74 15                	je     80103f0b <piperead+0x36>
      release(&p->lock);
80103ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef9:	89 04 24             	mov    %eax,(%esp)
80103efc:	e8 cf 0c 00 00       	call   80104bd0 <release>
      return -1;
80103f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f06:	e9 b6 00 00 00       	jmp    80103fc1 <piperead+0xec>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103f0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0e:	8b 55 08             	mov    0x8(%ebp),%edx
80103f11:	81 c2 34 02 00 00    	add    $0x234,%edx
80103f17:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f1b:	89 14 24             	mov    %edx,(%esp)
80103f1e:	e8 7a 09 00 00       	call   8010489d <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103f23:	8b 45 08             	mov    0x8(%ebp),%eax
80103f26:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f2c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f2f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f35:	39 c2                	cmp    %eax,%edx
80103f37:	75 0d                	jne    80103f46 <piperead+0x71>
80103f39:	8b 45 08             	mov    0x8(%ebp),%eax
80103f3c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103f42:	85 c0                	test   %eax,%eax
80103f44:	75 a3                	jne    80103ee9 <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f4d:	eb 49                	jmp    80103f98 <piperead+0xc3>
    if(p->nread == p->nwrite)
80103f4f:	8b 45 08             	mov    0x8(%ebp),%eax
80103f52:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f58:	8b 45 08             	mov    0x8(%ebp),%eax
80103f5b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f61:	39 c2                	cmp    %eax,%edx
80103f63:	74 3d                	je     80103fa2 <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f68:	89 c2                	mov    %eax,%edx
80103f6a:	03 55 0c             	add    0xc(%ebp),%edx
80103f6d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f70:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103f76:	89 c3                	mov    %eax,%ebx
80103f78:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80103f7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103f81:	0f b6 4c 19 34       	movzbl 0x34(%ecx,%ebx,1),%ecx
80103f86:	88 0a                	mov    %cl,(%edx)
80103f88:	8d 50 01             	lea    0x1(%eax),%edx
80103f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80103f8e:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f94:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f9b:	3b 45 10             	cmp    0x10(%ebp),%eax
80103f9e:	7c af                	jl     80103f4f <piperead+0x7a>
80103fa0:	eb 01                	jmp    80103fa3 <piperead+0xce>
    if(p->nread == p->nwrite)
      break;
80103fa2:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa6:	05 38 02 00 00       	add    $0x238,%eax
80103fab:	89 04 24             	mov    %eax,(%esp)
80103fae:	e8 c4 09 00 00       	call   80104977 <wakeup>
  release(&p->lock);
80103fb3:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb6:	89 04 24             	mov    %eax,(%esp)
80103fb9:	e8 12 0c 00 00       	call   80104bd0 <release>
  return i;
80103fbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103fc1:	83 c4 24             	add    $0x24,%esp
80103fc4:	5b                   	pop    %ebx
80103fc5:	5d                   	pop    %ebp
80103fc6:	c3                   	ret    
	...

80103fc8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103fc8:	55                   	push   %ebp
80103fc9:	89 e5                	mov    %esp,%ebp
80103fcb:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fce:	9c                   	pushf  
80103fcf:	58                   	pop    %eax
80103fd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103fd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103fd6:	c9                   	leave  
80103fd7:	c3                   	ret    

80103fd8 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80103fd8:	55                   	push   %ebp
80103fd9:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80103fdb:	fb                   	sti    
}
80103fdc:	5d                   	pop    %ebp
80103fdd:	c3                   	ret    

80103fde <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103fde:	55                   	push   %ebp
80103fdf:	89 e5                	mov    %esp,%ebp
80103fe1:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103fe4:	c7 44 24 04 1d 84 10 	movl   $0x8010841d,0x4(%esp)
80103feb:	80 
80103fec:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80103ff3:	e8 56 0b 00 00       	call   80104b4e <initlock>
}
80103ff8:	c9                   	leave  
80103ff9:	c3                   	ret    

80103ffa <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103ffa:	55                   	push   %ebp
80103ffb:	89 e5                	mov    %esp,%ebp
80103ffd:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104000:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104007:	e8 63 0b 00 00       	call   80104b6f <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010400c:	c7 45 f0 54 ff 10 80 	movl   $0x8010ff54,-0x10(%ebp)
80104013:	eb 0e                	jmp    80104023 <allocproc+0x29>
    if(p->state == UNUSED)
80104015:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104018:	8b 40 0c             	mov    0xc(%eax),%eax
8010401b:	85 c0                	test   %eax,%eax
8010401d:	74 24                	je     80104043 <allocproc+0x49>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010401f:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104023:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104028:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010402b:	72 e8                	jb     80104015 <allocproc+0x1b>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
8010402d:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104034:	e8 97 0b 00 00       	call   80104bd0 <release>
  return 0;
80104039:	b8 00 00 00 00       	mov    $0x0,%eax
8010403e:	e9 b5 00 00 00       	jmp    801040f8 <allocproc+0xfe>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
80104043:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104044:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104047:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010404e:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104053:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104056:	89 42 10             	mov    %eax,0x10(%edx)
80104059:	83 c0 01             	add    $0x1,%eax
8010405c:	a3 04 b0 10 80       	mov    %eax,0x8010b004
  release(&ptable.lock);
80104061:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104068:	e8 63 0b 00 00       	call   80104bd0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010406d:	e8 90 ea ff ff       	call   80102b02 <kalloc>
80104072:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104075:	89 42 08             	mov    %eax,0x8(%edx)
80104078:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010407b:	8b 40 08             	mov    0x8(%eax),%eax
8010407e:	85 c0                	test   %eax,%eax
80104080:	75 11                	jne    80104093 <allocproc+0x99>
    p->state = UNUSED;
80104082:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104085:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
8010408c:	b8 00 00 00 00       	mov    $0x0,%eax
80104091:	eb 65                	jmp    801040f8 <allocproc+0xfe>
  }
  sp = p->kstack + KSTACKSIZE;
80104093:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104096:	8b 40 08             	mov    0x8(%eax),%eax
80104099:	05 00 10 00 00       	add    $0x1000,%eax
8010409e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801040a1:	83 6d f4 4c          	subl   $0x4c,-0xc(%ebp)
  p->tf = (struct trapframe*)sp;
801040a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040ab:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801040ae:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
  *(uint*)sp = (uint)trapret;
801040b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040b5:	ba 14 62 10 80       	mov    $0x80106214,%edx
801040ba:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801040bc:	83 6d f4 14          	subl   $0x14,-0xc(%ebp)
  p->context = (struct context*)sp;
801040c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040c6:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801040c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040cc:	8b 40 1c             	mov    0x1c(%eax),%eax
801040cf:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801040d6:	00 
801040d7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801040de:	00 
801040df:	89 04 24             	mov    %eax,(%esp)
801040e2:	e8 d7 0c 00 00       	call   80104dbe <memset>
  p->context->eip = (uint)forkret;
801040e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040ea:	8b 40 1c             	mov    0x1c(%eax),%eax
801040ed:	ba 71 48 10 80       	mov    $0x80104871,%edx
801040f2:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801040f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801040f8:	c9                   	leave  
801040f9:	c3                   	ret    

801040fa <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801040fa:	55                   	push   %ebp
801040fb:	89 e5                	mov    %esp,%ebp
801040fd:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
80104100:	e8 f5 fe ff ff       	call   80103ffa <allocproc>
80104105:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80104108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010410b:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm(kalloc)) == 0)
80104110:	c7 04 24 02 2b 10 80 	movl   $0x80102b02,(%esp)
80104117:	e8 e2 37 00 00       	call   801078fe <setupkvm>
8010411c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010411f:	89 42 04             	mov    %eax,0x4(%edx)
80104122:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104125:	8b 40 04             	mov    0x4(%eax),%eax
80104128:	85 c0                	test   %eax,%eax
8010412a:	75 0c                	jne    80104138 <userinit+0x3e>
    panic("userinit: out of memory?");
8010412c:	c7 04 24 24 84 10 80 	movl   $0x80108424,(%esp)
80104133:	e8 02 c4 ff ff       	call   8010053a <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104138:	ba 2c 00 00 00       	mov    $0x2c,%edx
8010413d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104140:	8b 40 04             	mov    0x4(%eax),%eax
80104143:	89 54 24 08          	mov    %edx,0x8(%esp)
80104147:	c7 44 24 04 e0 b4 10 	movl   $0x8010b4e0,0x4(%esp)
8010414e:	80 
8010414f:	89 04 24             	mov    %eax,(%esp)
80104152:	e8 00 3a 00 00       	call   80107b57 <inituvm>
  p->sz = PGSIZE;
80104157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010415a:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104160:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104163:	8b 40 18             	mov    0x18(%eax),%eax
80104166:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
8010416d:	00 
8010416e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104175:	00 
80104176:	89 04 24             	mov    %eax,(%esp)
80104179:	e8 40 0c 00 00       	call   80104dbe <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010417e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104181:	8b 40 18             	mov    0x18(%eax),%eax
80104184:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010418a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010418d:	8b 40 18             	mov    0x18(%eax),%eax
80104190:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104199:	8b 40 18             	mov    0x18(%eax),%eax
8010419c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010419f:	8b 52 18             	mov    0x18(%edx),%edx
801041a2:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041a6:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801041aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ad:	8b 40 18             	mov    0x18(%eax),%eax
801041b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801041b3:	8b 52 18             	mov    0x18(%edx),%edx
801041b6:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801041ba:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801041be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c1:	8b 40 18             	mov    0x18(%eax),%eax
801041c4:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801041cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ce:	8b 40 18             	mov    0x18(%eax),%eax
801041d1:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801041d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041db:	8b 40 18             	mov    0x18(%eax),%eax
801041de:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801041e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041e8:	83 c0 6c             	add    $0x6c,%eax
801041eb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801041f2:	00 
801041f3:	c7 44 24 04 3d 84 10 	movl   $0x8010843d,0x4(%esp)
801041fa:	80 
801041fb:	89 04 24             	mov    %eax,(%esp)
801041fe:	e8 ee 0d 00 00       	call   80104ff1 <safestrcpy>
  p->cwd = namei("/");
80104203:	c7 04 24 46 84 10 80 	movl   $0x80108446,(%esp)
8010420a:	e8 0c e2 ff ff       	call   8010241b <namei>
8010420f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104212:	89 42 68             	mov    %eax,0x68(%edx)

  p->state = RUNNABLE;
80104215:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104218:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
8010421f:	c9                   	leave  
80104220:	c3                   	ret    

80104221 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104221:	55                   	push   %ebp
80104222:	89 e5                	mov    %esp,%ebp
80104224:	83 ec 28             	sub    $0x28,%esp
  uint sz;
  
  sz = proc->sz;
80104227:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010422d:	8b 00                	mov    (%eax),%eax
8010422f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104232:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104236:	7e 34                	jle    8010426c <growproc+0x4b>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104238:	8b 45 08             	mov    0x8(%ebp),%eax
8010423b:	89 c2                	mov    %eax,%edx
8010423d:	03 55 f4             	add    -0xc(%ebp),%edx
80104240:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104246:	8b 40 04             	mov    0x4(%eax),%eax
80104249:	89 54 24 08          	mov    %edx,0x8(%esp)
8010424d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104250:	89 54 24 04          	mov    %edx,0x4(%esp)
80104254:	89 04 24             	mov    %eax,(%esp)
80104257:	e8 76 3a 00 00       	call   80107cd2 <allocuvm>
8010425c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010425f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104263:	75 41                	jne    801042a6 <growproc+0x85>
      return -1;
80104265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010426a:	eb 59                	jmp    801042c5 <growproc+0xa4>
  } else if(n < 0){
8010426c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104270:	79 35                	jns    801042a7 <growproc+0x86>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104272:	8b 45 08             	mov    0x8(%ebp),%eax
80104275:	89 c2                	mov    %eax,%edx
80104277:	03 55 f4             	add    -0xc(%ebp),%edx
8010427a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104280:	8b 40 04             	mov    0x4(%eax),%eax
80104283:	89 54 24 08          	mov    %edx,0x8(%esp)
80104287:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010428a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010428e:	89 04 24             	mov    %eax,(%esp)
80104291:	e8 16 3b 00 00       	call   80107dac <deallocuvm>
80104296:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010429d:	75 08                	jne    801042a7 <growproc+0x86>
      return -1;
8010429f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042a4:	eb 1f                	jmp    801042c5 <growproc+0xa4>
  uint sz;
  
  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
801042a6:	90                   	nop
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
801042a7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042b0:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801042b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042b8:	89 04 24             	mov    %eax,(%esp)
801042bb:	e8 30 37 00 00       	call   801079f0 <switchuvm>
  return 0;
801042c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801042c5:	c9                   	leave  
801042c6:	c3                   	ret    

801042c7 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801042c7:	55                   	push   %ebp
801042c8:	89 e5                	mov    %esp,%ebp
801042ca:	57                   	push   %edi
801042cb:	56                   	push   %esi
801042cc:	53                   	push   %ebx
801042cd:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
801042d0:	e8 25 fd ff ff       	call   80103ffa <allocproc>
801042d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
801042dc:	75 0a                	jne    801042e8 <fork+0x21>
    return -1;
801042de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042e3:	e9 3a 01 00 00       	jmp    80104422 <fork+0x15b>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801042e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042ee:	8b 10                	mov    (%eax),%edx
801042f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f6:	8b 40 04             	mov    0x4(%eax),%eax
801042f9:	89 54 24 04          	mov    %edx,0x4(%esp)
801042fd:	89 04 24             	mov    %eax,(%esp)
80104300:	e8 37 3c 00 00       	call   80107f3c <copyuvm>
80104305:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104308:	89 42 04             	mov    %eax,0x4(%edx)
8010430b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010430e:	8b 40 04             	mov    0x4(%eax),%eax
80104311:	85 c0                	test   %eax,%eax
80104313:	75 2c                	jne    80104341 <fork+0x7a>
    kfree(np->kstack);
80104315:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104318:	8b 40 08             	mov    0x8(%eax),%eax
8010431b:	89 04 24             	mov    %eax,(%esp)
8010431e:	e8 46 e7 ff ff       	call   80102a69 <kfree>
    np->kstack = 0;
80104323:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104326:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
8010432d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104330:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104337:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010433c:	e9 e1 00 00 00       	jmp    80104422 <fork+0x15b>
  }
  np->sz = proc->sz;
80104341:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104347:	8b 10                	mov    (%eax),%edx
80104349:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010434c:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
8010434e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104355:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104358:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
8010435b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010435e:	8b 50 18             	mov    0x18(%eax),%edx
80104361:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104367:	8b 40 18             	mov    0x18(%eax),%eax
8010436a:	89 c3                	mov    %eax,%ebx
8010436c:	b8 13 00 00 00       	mov    $0x13,%eax
80104371:	89 d7                	mov    %edx,%edi
80104373:	89 de                	mov    %ebx,%esi
80104375:	89 c1                	mov    %eax,%ecx
80104377:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104379:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010437c:	8b 40 18             	mov    0x18(%eax),%eax
8010437f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104386:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
8010438d:	eb 3d                	jmp    801043cc <fork+0x105>
    if(proc->ofile[i])
8010438f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104395:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104398:	83 c2 08             	add    $0x8,%edx
8010439b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010439f:	85 c0                	test   %eax,%eax
801043a1:	74 25                	je     801043c8 <fork+0x101>
      np->ofile[i] = filedup(proc->ofile[i]);
801043a3:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801043a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043ac:	8b 55 dc             	mov    -0x24(%ebp),%edx
801043af:	83 c2 08             	add    $0x8,%edx
801043b2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801043b6:	89 04 24             	mov    %eax,(%esp)
801043b9:	e8 c3 cb ff ff       	call   80100f81 <filedup>
801043be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043c1:	8d 4b 08             	lea    0x8(%ebx),%ecx
801043c4:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801043c8:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
801043cc:	83 7d dc 0f          	cmpl   $0xf,-0x24(%ebp)
801043d0:	7e bd                	jle    8010438f <fork+0xc8>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801043d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043d8:	8b 40 68             	mov    0x68(%eax),%eax
801043db:	89 04 24             	mov    %eax,(%esp)
801043de:	e8 6e d4 ff ff       	call   80101851 <idup>
801043e3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043e6:	89 42 68             	mov    %eax,0x68(%edx)
 
  pid = np->pid;
801043e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043ec:	8b 40 10             	mov    0x10(%eax),%eax
801043ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
  np->state = RUNNABLE;
801043f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
801043fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104402:	8d 50 6c             	lea    0x6c(%eax),%edx
80104405:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104408:	83 c0 6c             	add    $0x6c,%eax
8010440b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104412:	00 
80104413:	89 54 24 04          	mov    %edx,0x4(%esp)
80104417:	89 04 24             	mov    %eax,(%esp)
8010441a:	e8 d2 0b 00 00       	call   80104ff1 <safestrcpy>
  return pid;
8010441f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80104422:	83 c4 2c             	add    $0x2c,%esp
80104425:	5b                   	pop    %ebx
80104426:	5e                   	pop    %esi
80104427:	5f                   	pop    %edi
80104428:	5d                   	pop    %ebp
80104429:	c3                   	ret    

8010442a <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010442a:	55                   	push   %ebp
8010442b:	89 e5                	mov    %esp,%ebp
8010442d:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104430:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104437:	a1 48 b6 10 80       	mov    0x8010b648,%eax
8010443c:	39 c2                	cmp    %eax,%edx
8010443e:	75 0c                	jne    8010444c <exit+0x22>
    panic("init exiting");
80104440:	c7 04 24 48 84 10 80 	movl   $0x80108448,(%esp)
80104447:	e8 ee c0 ff ff       	call   8010053a <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010444c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104453:	eb 44                	jmp    80104499 <exit+0x6f>
    if(proc->ofile[fd]){
80104455:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010445b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010445e:	83 c2 08             	add    $0x8,%edx
80104461:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104465:	85 c0                	test   %eax,%eax
80104467:	74 2c                	je     80104495 <exit+0x6b>
      fileclose(proc->ofile[fd]);
80104469:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010446f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104472:	83 c2 08             	add    $0x8,%edx
80104475:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104479:	89 04 24             	mov    %eax,(%esp)
8010447c:	e8 48 cb ff ff       	call   80100fc9 <fileclose>
      proc->ofile[fd] = 0;
80104481:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104487:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010448a:	83 c2 08             	add    $0x8,%edx
8010448d:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104494:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104495:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104499:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010449d:	7e b6                	jle    80104455 <exit+0x2b>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
8010449f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044a5:	8b 40 68             	mov    0x68(%eax),%eax
801044a8:	89 04 24             	mov    %eax,(%esp)
801044ab:	e8 89 d5 ff ff       	call   80101a39 <iput>
  proc->cwd = 0;
801044b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044b6:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801044bd:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801044c4:	e8 a6 06 00 00       	call   80104b6f <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801044c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044cf:	8b 40 14             	mov    0x14(%eax),%eax
801044d2:	89 04 24             	mov    %eax,(%esp)
801044d5:	e8 5e 04 00 00       	call   80104938 <wakeup1>

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044da:	c7 45 f0 54 ff 10 80 	movl   $0x8010ff54,-0x10(%ebp)
801044e1:	eb 38                	jmp    8010451b <exit+0xf1>
    if(p->parent == proc){
801044e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044e6:	8b 50 14             	mov    0x14(%eax),%edx
801044e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044ef:	39 c2                	cmp    %eax,%edx
801044f1:	75 24                	jne    80104517 <exit+0xed>
      p->parent = initproc;
801044f3:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
801044f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044fc:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
801044ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104502:	8b 40 0c             	mov    0xc(%eax),%eax
80104505:	83 f8 05             	cmp    $0x5,%eax
80104508:	75 0d                	jne    80104517 <exit+0xed>
        wakeup1(initproc);
8010450a:	a1 48 b6 10 80       	mov    0x8010b648,%eax
8010450f:	89 04 24             	mov    %eax,(%esp)
80104512:	e8 21 04 00 00       	call   80104938 <wakeup1>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104517:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
8010451b:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104520:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104523:	72 be                	jb     801044e3 <exit+0xb9>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104525:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010452b:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104532:	e8 56 02 00 00       	call   8010478d <sched>
  panic("zombie exit");
80104537:	c7 04 24 55 84 10 80 	movl   $0x80108455,(%esp)
8010453e:	e8 f7 bf ff ff       	call   8010053a <panic>

80104543 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104543:	55                   	push   %ebp
80104544:	89 e5                	mov    %esp,%ebp
80104546:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104549:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104550:	e8 1a 06 00 00       	call   80104b6f <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104555:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010455c:	c7 45 ec 54 ff 10 80 	movl   $0x8010ff54,-0x14(%ebp)
80104563:	e9 9a 00 00 00       	jmp    80104602 <wait+0xbf>
      if(p->parent != proc)
80104568:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010456b:	8b 50 14             	mov    0x14(%eax),%edx
8010456e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104574:	39 c2                	cmp    %eax,%edx
80104576:	0f 85 81 00 00 00    	jne    801045fd <wait+0xba>
        continue;
      havekids = 1;
8010457c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104583:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104586:	8b 40 0c             	mov    0xc(%eax),%eax
80104589:	83 f8 05             	cmp    $0x5,%eax
8010458c:	75 70                	jne    801045fe <wait+0xbb>
        // Found one.
        pid = p->pid;
8010458e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104591:	8b 40 10             	mov    0x10(%eax),%eax
80104594:	89 45 f4             	mov    %eax,-0xc(%ebp)
        kfree(p->kstack);
80104597:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010459a:	8b 40 08             	mov    0x8(%eax),%eax
8010459d:	89 04 24             	mov    %eax,(%esp)
801045a0:	e8 c4 e4 ff ff       	call   80102a69 <kfree>
        p->kstack = 0;
801045a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045a8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801045af:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045b2:	8b 40 04             	mov    0x4(%eax),%eax
801045b5:	89 04 24             	mov    %eax,(%esp)
801045b8:	e8 ab 38 00 00       	call   80107e68 <freevm>
        p->state = UNUSED;
801045bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045c0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
801045c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045ca:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
801045d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045d4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
801045db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045de:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
801045e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801045e5:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
801045ec:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801045f3:	e8 d8 05 00 00       	call   80104bd0 <release>
        return pid;
801045f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045fb:	eb 54                	jmp    80104651 <wait+0x10e>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
801045fd:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045fe:	83 45 ec 7c          	addl   $0x7c,-0x14(%ebp)
80104602:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104607:	39 45 ec             	cmp    %eax,-0x14(%ebp)
8010460a:	0f 82 58 ff ff ff    	jb     80104568 <wait+0x25>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104610:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104614:	74 0d                	je     80104623 <wait+0xe0>
80104616:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010461c:	8b 40 24             	mov    0x24(%eax),%eax
8010461f:	85 c0                	test   %eax,%eax
80104621:	74 13                	je     80104636 <wait+0xf3>
      release(&ptable.lock);
80104623:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010462a:	e8 a1 05 00 00       	call   80104bd0 <release>
      return -1;
8010462f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104634:	eb 1b                	jmp    80104651 <wait+0x10e>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104636:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010463c:	c7 44 24 04 20 ff 10 	movl   $0x8010ff20,0x4(%esp)
80104643:	80 
80104644:	89 04 24             	mov    %eax,(%esp)
80104647:	e8 51 02 00 00       	call   8010489d <sleep>
  }
8010464c:	e9 04 ff ff ff       	jmp    80104555 <wait+0x12>
}
80104651:	c9                   	leave  
80104652:	c3                   	ret    

80104653 <register_handler>:

void
register_handler(sighandler_t sighandler)
{
80104653:	55                   	push   %ebp
80104654:	89 e5                	mov    %esp,%ebp
80104656:	83 ec 28             	sub    $0x28,%esp
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
80104659:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465f:	8b 40 18             	mov    0x18(%eax),%eax
80104662:	8b 40 44             	mov    0x44(%eax),%eax
80104665:	89 c2                	mov    %eax,%edx
80104667:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010466d:	8b 40 04             	mov    0x4(%eax),%eax
80104670:	89 54 24 04          	mov    %edx,0x4(%esp)
80104674:	89 04 24             	mov    %eax,(%esp)
80104677:	e8 d1 39 00 00       	call   8010804d <uva2ka>
8010467c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if ((proc->tf->esp & 0xFFF) == 0)
8010467f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104685:	8b 40 18             	mov    0x18(%eax),%eax
80104688:	8b 40 44             	mov    0x44(%eax),%eax
8010468b:	25 ff 0f 00 00       	and    $0xfff,%eax
80104690:	85 c0                	test   %eax,%eax
80104692:	75 0c                	jne    801046a0 <register_handler+0x4d>
    panic("esp_offset == 0");
80104694:	c7 04 24 61 84 10 80 	movl   $0x80108461,(%esp)
8010469b:	e8 9a be ff ff       	call   8010053a <panic>

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
801046a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046a6:	8b 40 18             	mov    0x18(%eax),%eax
801046a9:	8b 40 44             	mov    0x44(%eax),%eax
801046ac:	83 e8 04             	sub    $0x4,%eax
801046af:	25 ff 0f 00 00       	and    $0xfff,%eax
801046b4:	03 45 f4             	add    -0xc(%ebp),%eax
          = proc->tf->eip;
801046b7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046be:	8b 52 18             	mov    0x18(%edx),%edx
801046c1:	8b 52 38             	mov    0x38(%edx),%edx
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
  if ((proc->tf->esp & 0xFFF) == 0)
    panic("esp_offset == 0");

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
801046c4:	89 10                	mov    %edx,(%eax)
          = proc->tf->eip;
  proc->tf->esp -= 4;
801046c6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046cc:	8b 40 18             	mov    0x18(%eax),%eax
801046cf:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046d6:	8b 52 18             	mov    0x18(%edx),%edx
801046d9:	8b 52 44             	mov    0x44(%edx),%edx
801046dc:	83 ea 04             	sub    $0x4,%edx
801046df:	89 50 44             	mov    %edx,0x44(%eax)

    /* update eip */
  proc->tf->eip = (uint)sighandler;
801046e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e8:	8b 40 18             	mov    0x18(%eax),%eax
801046eb:	8b 55 08             	mov    0x8(%ebp),%edx
801046ee:	89 50 38             	mov    %edx,0x38(%eax)
}
801046f1:	c9                   	leave  
801046f2:	c3                   	ret    

801046f3 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801046f3:	55                   	push   %ebp
801046f4:	89 e5                	mov    %esp,%ebp
801046f6:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801046f9:	e8 da f8 ff ff       	call   80103fd8 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801046fe:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104705:	e8 65 04 00 00       	call   80104b6f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010470a:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
80104711:	eb 5f                	jmp    80104772 <scheduler+0x7f>
      if(p->state != RUNNABLE)
80104713:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104716:	8b 40 0c             	mov    0xc(%eax),%eax
80104719:	83 f8 03             	cmp    $0x3,%eax
8010471c:	75 4f                	jne    8010476d <scheduler+0x7a>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
8010471e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104721:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104727:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010472a:	89 04 24             	mov    %eax,(%esp)
8010472d:	e8 be 32 00 00       	call   801079f0 <switchuvm>
      p->state = RUNNING;
80104732:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104735:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
8010473c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104742:	8b 40 1c             	mov    0x1c(%eax),%eax
80104745:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010474c:	83 c2 04             	add    $0x4,%edx
8010474f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104753:	89 14 24             	mov    %edx,(%esp)
80104756:	e8 09 09 00 00       	call   80105064 <swtch>
      switchkvm();
8010475b:	e8 73 32 00 00       	call   801079d3 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104760:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104767:	00 00 00 00 
8010476b:	eb 01                	jmp    8010476e <scheduler+0x7b>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
8010476d:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010476e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104772:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104777:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010477a:	72 97                	jb     80104713 <scheduler+0x20>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
8010477c:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104783:	e8 48 04 00 00       	call   80104bd0 <release>

  }
80104788:	e9 6c ff ff ff       	jmp    801046f9 <scheduler+0x6>

8010478d <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
8010478d:	55                   	push   %ebp
8010478e:	89 e5                	mov    %esp,%ebp
80104790:	83 ec 28             	sub    $0x28,%esp
  int intena;

  if(!holding(&ptable.lock))
80104793:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010479a:	e8 ef 04 00 00       	call   80104c8e <holding>
8010479f:	85 c0                	test   %eax,%eax
801047a1:	75 0c                	jne    801047af <sched+0x22>
    panic("sched ptable.lock");
801047a3:	c7 04 24 71 84 10 80 	movl   $0x80108471,(%esp)
801047aa:	e8 8b bd ff ff       	call   8010053a <panic>
  if(cpu->ncli != 1)
801047af:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047b5:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801047bb:	83 f8 01             	cmp    $0x1,%eax
801047be:	74 0c                	je     801047cc <sched+0x3f>
    panic("sched locks");
801047c0:	c7 04 24 83 84 10 80 	movl   $0x80108483,(%esp)
801047c7:	e8 6e bd ff ff       	call   8010053a <panic>
  if(proc->state == RUNNING)
801047cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d2:	8b 40 0c             	mov    0xc(%eax),%eax
801047d5:	83 f8 04             	cmp    $0x4,%eax
801047d8:	75 0c                	jne    801047e6 <sched+0x59>
    panic("sched running");
801047da:	c7 04 24 8f 84 10 80 	movl   $0x8010848f,(%esp)
801047e1:	e8 54 bd ff ff       	call   8010053a <panic>
  if(readeflags()&FL_IF)
801047e6:	e8 dd f7 ff ff       	call   80103fc8 <readeflags>
801047eb:	25 00 02 00 00       	and    $0x200,%eax
801047f0:	85 c0                	test   %eax,%eax
801047f2:	74 0c                	je     80104800 <sched+0x73>
    panic("sched interruptible");
801047f4:	c7 04 24 9d 84 10 80 	movl   $0x8010849d,(%esp)
801047fb:	e8 3a bd ff ff       	call   8010053a <panic>
  intena = cpu->intena;
80104800:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104806:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010480c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
8010480f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104815:	8b 40 04             	mov    0x4(%eax),%eax
80104818:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010481f:	83 c2 1c             	add    $0x1c,%edx
80104822:	89 44 24 04          	mov    %eax,0x4(%esp)
80104826:	89 14 24             	mov    %edx,(%esp)
80104829:	e8 36 08 00 00       	call   80105064 <swtch>
  cpu->intena = intena;
8010482e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104834:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104837:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
8010483d:	c9                   	leave  
8010483e:	c3                   	ret    

8010483f <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
8010483f:	55                   	push   %ebp
80104840:	89 e5                	mov    %esp,%ebp
80104842:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104845:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010484c:	e8 1e 03 00 00       	call   80104b6f <acquire>
  proc->state = RUNNABLE;
80104851:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104857:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
8010485e:	e8 2a ff ff ff       	call   8010478d <sched>
  release(&ptable.lock);
80104863:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010486a:	e8 61 03 00 00       	call   80104bd0 <release>
}
8010486f:	c9                   	leave  
80104870:	c3                   	ret    

80104871 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104871:	55                   	push   %ebp
80104872:	89 e5                	mov    %esp,%ebp
80104874:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104877:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010487e:	e8 4d 03 00 00       	call   80104bd0 <release>

  if (first) {
80104883:	a1 20 b0 10 80       	mov    0x8010b020,%eax
80104888:	85 c0                	test   %eax,%eax
8010488a:	74 0f                	je     8010489b <forkret+0x2a>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
8010488c:	c7 05 20 b0 10 80 00 	movl   $0x0,0x8010b020
80104893:	00 00 00 
    initlog();
80104896:	e8 61 e7 ff ff       	call   80102ffc <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
8010489b:	c9                   	leave  
8010489c:	c3                   	ret    

8010489d <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
8010489d:	55                   	push   %ebp
8010489e:	89 e5                	mov    %esp,%ebp
801048a0:	83 ec 18             	sub    $0x18,%esp
  if(proc == 0)
801048a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a9:	85 c0                	test   %eax,%eax
801048ab:	75 0c                	jne    801048b9 <sleep+0x1c>
    panic("sleep");
801048ad:	c7 04 24 b1 84 10 80 	movl   $0x801084b1,(%esp)
801048b4:	e8 81 bc ff ff       	call   8010053a <panic>

  if(lk == 0)
801048b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801048bd:	75 0c                	jne    801048cb <sleep+0x2e>
    panic("sleep without lk");
801048bf:	c7 04 24 b7 84 10 80 	movl   $0x801084b7,(%esp)
801048c6:	e8 6f bc ff ff       	call   8010053a <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801048cb:	81 7d 0c 20 ff 10 80 	cmpl   $0x8010ff20,0xc(%ebp)
801048d2:	74 17                	je     801048eb <sleep+0x4e>
    acquire(&ptable.lock);  //DOC: sleeplock1
801048d4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801048db:	e8 8f 02 00 00       	call   80104b6f <acquire>
    release(lk);
801048e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801048e3:	89 04 24             	mov    %eax,(%esp)
801048e6:	e8 e5 02 00 00       	call   80104bd0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
801048eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048f1:	8b 55 08             	mov    0x8(%ebp),%edx
801048f4:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
801048f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048fd:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104904:	e8 84 fe ff ff       	call   8010478d <sched>

  // Tidy up.
  proc->chan = 0;
80104909:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010490f:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104916:	81 7d 0c 20 ff 10 80 	cmpl   $0x8010ff20,0xc(%ebp)
8010491d:	74 17                	je     80104936 <sleep+0x99>
    release(&ptable.lock);
8010491f:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104926:	e8 a5 02 00 00       	call   80104bd0 <release>
    acquire(lk);
8010492b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492e:	89 04 24             	mov    %eax,(%esp)
80104931:	e8 39 02 00 00       	call   80104b6f <acquire>
  }
}
80104936:	c9                   	leave  
80104937:	c3                   	ret    

80104938 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104938:	55                   	push   %ebp
80104939:	89 e5                	mov    %esp,%ebp
8010493b:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010493e:	c7 45 fc 54 ff 10 80 	movl   $0x8010ff54,-0x4(%ebp)
80104945:	eb 24                	jmp    8010496b <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104947:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010494a:	8b 40 0c             	mov    0xc(%eax),%eax
8010494d:	83 f8 02             	cmp    $0x2,%eax
80104950:	75 15                	jne    80104967 <wakeup1+0x2f>
80104952:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104955:	8b 40 20             	mov    0x20(%eax),%eax
80104958:	3b 45 08             	cmp    0x8(%ebp),%eax
8010495b:	75 0a                	jne    80104967 <wakeup1+0x2f>
      p->state = RUNNABLE;
8010495d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104960:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104967:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
8010496b:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104970:	39 45 fc             	cmp    %eax,-0x4(%ebp)
80104973:	72 d2                	jb     80104947 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104975:	c9                   	leave  
80104976:	c3                   	ret    

80104977 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104977:	55                   	push   %ebp
80104978:	89 e5                	mov    %esp,%ebp
8010497a:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
8010497d:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104984:	e8 e6 01 00 00       	call   80104b6f <acquire>
  wakeup1(chan);
80104989:	8b 45 08             	mov    0x8(%ebp),%eax
8010498c:	89 04 24             	mov    %eax,(%esp)
8010498f:	e8 a4 ff ff ff       	call   80104938 <wakeup1>
  release(&ptable.lock);
80104994:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010499b:	e8 30 02 00 00       	call   80104bd0 <release>
}
801049a0:	c9                   	leave  
801049a1:	c3                   	ret    

801049a2 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801049a2:	55                   	push   %ebp
801049a3:	89 e5                	mov    %esp,%ebp
801049a5:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;

  acquire(&ptable.lock);
801049a8:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801049af:	e8 bb 01 00 00       	call   80104b6f <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049b4:	c7 45 f4 54 ff 10 80 	movl   $0x8010ff54,-0xc(%ebp)
801049bb:	eb 41                	jmp    801049fe <kill+0x5c>
    if(p->pid == pid){
801049bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c0:	8b 40 10             	mov    0x10(%eax),%eax
801049c3:	3b 45 08             	cmp    0x8(%ebp),%eax
801049c6:	75 32                	jne    801049fa <kill+0x58>
      p->killed = 1;
801049c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049cb:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801049d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d5:	8b 40 0c             	mov    0xc(%eax),%eax
801049d8:	83 f8 02             	cmp    $0x2,%eax
801049db:	75 0a                	jne    801049e7 <kill+0x45>
        p->state = RUNNABLE;
801049dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801049e7:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801049ee:	e8 dd 01 00 00       	call   80104bd0 <release>
      return 0;
801049f3:	b8 00 00 00 00       	mov    $0x0,%eax
801049f8:	eb 1f                	jmp    80104a19 <kill+0x77>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049fa:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801049fe:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104a03:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104a06:	72 b5                	jb     801049bd <kill+0x1b>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104a08:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
80104a0f:	e8 bc 01 00 00       	call   80104bd0 <release>
  return -1;
80104a14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a19:	c9                   	leave  
80104a1a:	c3                   	ret    

80104a1b <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a1b:	55                   	push   %ebp
80104a1c:	89 e5                	mov    %esp,%ebp
80104a1e:	83 ec 58             	sub    $0x58,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a21:	c7 45 f0 54 ff 10 80 	movl   $0x8010ff54,-0x10(%ebp)
80104a28:	e9 d8 00 00 00       	jmp    80104b05 <procdump+0xea>
    if(p->state == UNUSED)
80104a2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a30:	8b 40 0c             	mov    0xc(%eax),%eax
80104a33:	85 c0                	test   %eax,%eax
80104a35:	0f 84 c5 00 00 00    	je     80104b00 <procdump+0xe5>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a3e:	8b 40 0c             	mov    0xc(%eax),%eax
80104a41:	83 f8 05             	cmp    $0x5,%eax
80104a44:	77 23                	ja     80104a69 <procdump+0x4e>
80104a46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a49:	8b 40 0c             	mov    0xc(%eax),%eax
80104a4c:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104a53:	85 c0                	test   %eax,%eax
80104a55:	74 12                	je     80104a69 <procdump+0x4e>
      state = states[p->state];
80104a57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a5a:	8b 40 0c             	mov    0xc(%eax),%eax
80104a5d:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104a64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a67:	eb 07                	jmp    80104a70 <procdump+0x55>
      state = states[p->state];
    else
      state = "???";
80104a69:	c7 45 f4 c8 84 10 80 	movl   $0x801084c8,-0xc(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104a70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a73:	8d 50 6c             	lea    0x6c(%eax),%edx
80104a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a79:	8b 40 10             	mov    0x10(%eax),%eax
80104a7c:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104a80:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104a83:	89 54 24 08          	mov    %edx,0x8(%esp)
80104a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a8b:	c7 04 24 cc 84 10 80 	movl   $0x801084cc,(%esp)
80104a92:	e8 03 b9 ff ff       	call   8010039a <cprintf>
    if(p->state == SLEEPING){
80104a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a9a:	8b 40 0c             	mov    0xc(%eax),%eax
80104a9d:	83 f8 02             	cmp    $0x2,%eax
80104aa0:	75 50                	jne    80104af2 <procdump+0xd7>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104aa5:	8b 40 1c             	mov    0x1c(%eax),%eax
80104aa8:	8b 40 0c             	mov    0xc(%eax),%eax
80104aab:	83 c0 08             	add    $0x8,%eax
80104aae:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104ab1:	89 54 24 04          	mov    %edx,0x4(%esp)
80104ab5:	89 04 24             	mov    %eax,(%esp)
80104ab8:	e8 62 01 00 00       	call   80104c1f <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104abd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104ac4:	eb 1b                	jmp    80104ae1 <procdump+0xc6>
        cprintf(" %p", pc[i]);
80104ac6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104ac9:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104acd:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ad1:	c7 04 24 d5 84 10 80 	movl   $0x801084d5,(%esp)
80104ad8:	e8 bd b8 ff ff       	call   8010039a <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104add:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80104ae1:	83 7d ec 09          	cmpl   $0x9,-0x14(%ebp)
80104ae5:	7f 0b                	jg     80104af2 <procdump+0xd7>
80104ae7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104aea:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104aee:	85 c0                	test   %eax,%eax
80104af0:	75 d4                	jne    80104ac6 <procdump+0xab>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104af2:	c7 04 24 d9 84 10 80 	movl   $0x801084d9,(%esp)
80104af9:	e8 9c b8 ff ff       	call   8010039a <cprintf>
80104afe:	eb 01                	jmp    80104b01 <procdump+0xe6>
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104b00:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b01:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104b05:	b8 54 1e 11 80       	mov    $0x80111e54,%eax
80104b0a:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104b0d:	0f 82 1a ff ff ff    	jb     80104a2d <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104b13:	c9                   	leave  
80104b14:	c3                   	ret    
80104b15:	00 00                	add    %al,(%eax)
	...

80104b18 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104b18:	55                   	push   %ebp
80104b19:	89 e5                	mov    %esp,%ebp
80104b1b:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b1e:	9c                   	pushf  
80104b1f:	58                   	pop    %eax
80104b20:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104b23:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b26:	c9                   	leave  
80104b27:	c3                   	ret    

80104b28 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104b28:	55                   	push   %ebp
80104b29:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104b2b:	fa                   	cli    
}
80104b2c:	5d                   	pop    %ebp
80104b2d:	c3                   	ret    

80104b2e <sti>:

static inline void
sti(void)
{
80104b2e:	55                   	push   %ebp
80104b2f:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104b31:	fb                   	sti    
}
80104b32:	5d                   	pop    %ebp
80104b33:	c3                   	ret    

80104b34 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104b34:	55                   	push   %ebp
80104b35:	89 e5                	mov    %esp,%ebp
80104b37:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104b3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b40:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b43:	f0 87 02             	lock xchg %eax,(%edx)
80104b46:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104b49:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b4c:	c9                   	leave  
80104b4d:	c3                   	ret    

80104b4e <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b4e:	55                   	push   %ebp
80104b4f:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104b51:	8b 45 08             	mov    0x8(%ebp),%eax
80104b54:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b57:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104b5a:	8b 45 08             	mov    0x8(%ebp),%eax
80104b5d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104b63:	8b 45 08             	mov    0x8(%ebp),%eax
80104b66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b6d:	5d                   	pop    %ebp
80104b6e:	c3                   	ret    

80104b6f <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104b6f:	55                   	push   %ebp
80104b70:	89 e5                	mov    %esp,%ebp
80104b72:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104b75:	e8 3e 01 00 00       	call   80104cb8 <pushcli>
  if(holding(lk))
80104b7a:	8b 45 08             	mov    0x8(%ebp),%eax
80104b7d:	89 04 24             	mov    %eax,(%esp)
80104b80:	e8 09 01 00 00       	call   80104c8e <holding>
80104b85:	85 c0                	test   %eax,%eax
80104b87:	74 0c                	je     80104b95 <acquire+0x26>
    panic("acquire");
80104b89:	c7 04 24 05 85 10 80 	movl   $0x80108505,(%esp)
80104b90:	e8 a5 b9 ff ff       	call   8010053a <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104b95:	8b 45 08             	mov    0x8(%ebp),%eax
80104b98:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80104b9f:	00 
80104ba0:	89 04 24             	mov    %eax,(%esp)
80104ba3:	e8 8c ff ff ff       	call   80104b34 <xchg>
80104ba8:	85 c0                	test   %eax,%eax
80104baa:	75 e9                	jne    80104b95 <acquire+0x26>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104bac:	8b 45 08             	mov    0x8(%ebp),%eax
80104baf:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104bb6:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80104bbc:	83 c0 0c             	add    $0xc,%eax
80104bbf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bc3:	8d 45 08             	lea    0x8(%ebp),%eax
80104bc6:	89 04 24             	mov    %eax,(%esp)
80104bc9:	e8 51 00 00 00       	call   80104c1f <getcallerpcs>
}
80104bce:	c9                   	leave  
80104bcf:	c3                   	ret    

80104bd0 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80104bd6:	8b 45 08             	mov    0x8(%ebp),%eax
80104bd9:	89 04 24             	mov    %eax,(%esp)
80104bdc:	e8 ad 00 00 00       	call   80104c8e <holding>
80104be1:	85 c0                	test   %eax,%eax
80104be3:	75 0c                	jne    80104bf1 <release+0x21>
    panic("release");
80104be5:	c7 04 24 0d 85 10 80 	movl   $0x8010850d,(%esp)
80104bec:	e8 49 b9 ff ff       	call   8010053a <panic>

  lk->pcs[0] = 0;
80104bf1:	8b 45 08             	mov    0x8(%ebp),%eax
80104bf4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104bfb:	8b 45 08             	mov    0x8(%ebp),%eax
80104bfe:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104c05:	8b 45 08             	mov    0x8(%ebp),%eax
80104c08:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104c0f:	00 
80104c10:	89 04 24             	mov    %eax,(%esp)
80104c13:	e8 1c ff ff ff       	call   80104b34 <xchg>

  popcli();
80104c18:	e8 e3 00 00 00       	call   80104d00 <popcli>
}
80104c1d:	c9                   	leave  
80104c1e:	c3                   	ret    

80104c1f <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104c1f:	55                   	push   %ebp
80104c20:	89 e5                	mov    %esp,%ebp
80104c22:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104c25:	8b 45 08             	mov    0x8(%ebp),%eax
80104c28:	83 e8 08             	sub    $0x8,%eax
80104c2b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(i = 0; i < 10; i++){
80104c2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80104c35:	eb 34                	jmp    80104c6b <getcallerpcs+0x4c>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c37:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
80104c3b:	74 49                	je     80104c86 <getcallerpcs+0x67>
80104c3d:	81 7d f8 ff ff ff 7f 	cmpl   $0x7fffffff,-0x8(%ebp)
80104c44:	76 40                	jbe    80104c86 <getcallerpcs+0x67>
80104c46:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%ebp)
80104c4a:	74 3a                	je     80104c86 <getcallerpcs+0x67>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104c4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c4f:	c1 e0 02             	shl    $0x2,%eax
80104c52:	03 45 0c             	add    0xc(%ebp),%eax
80104c55:	8b 55 f8             	mov    -0x8(%ebp),%edx
80104c58:	83 c2 04             	add    $0x4,%edx
80104c5b:	8b 12                	mov    (%edx),%edx
80104c5d:	89 10                	mov    %edx,(%eax)
    ebp = (uint*)ebp[0]; // saved %ebp
80104c5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104c62:	8b 00                	mov    (%eax),%eax
80104c64:	89 45 f8             	mov    %eax,-0x8(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104c67:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104c6b:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
80104c6f:	7e c6                	jle    80104c37 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c71:	eb 13                	jmp    80104c86 <getcallerpcs+0x67>
    pcs[i] = 0;
80104c73:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c76:	c1 e0 02             	shl    $0x2,%eax
80104c79:	03 45 0c             	add    0xc(%ebp),%eax
80104c7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c82:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104c86:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
80104c8a:	7e e7                	jle    80104c73 <getcallerpcs+0x54>
    pcs[i] = 0;
}
80104c8c:	c9                   	leave  
80104c8d:	c3                   	ret    

80104c8e <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104c8e:	55                   	push   %ebp
80104c8f:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104c91:	8b 45 08             	mov    0x8(%ebp),%eax
80104c94:	8b 00                	mov    (%eax),%eax
80104c96:	85 c0                	test   %eax,%eax
80104c98:	74 17                	je     80104cb1 <holding+0x23>
80104c9a:	8b 45 08             	mov    0x8(%ebp),%eax
80104c9d:	8b 50 08             	mov    0x8(%eax),%edx
80104ca0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ca6:	39 c2                	cmp    %eax,%edx
80104ca8:	75 07                	jne    80104cb1 <holding+0x23>
80104caa:	b8 01 00 00 00       	mov    $0x1,%eax
80104caf:	eb 05                	jmp    80104cb6 <holding+0x28>
80104cb1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104cb6:	5d                   	pop    %ebp
80104cb7:	c3                   	ret    

80104cb8 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104cb8:	55                   	push   %ebp
80104cb9:	89 e5                	mov    %esp,%ebp
80104cbb:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104cbe:	e8 55 fe ff ff       	call   80104b18 <readeflags>
80104cc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104cc6:	e8 5d fe ff ff       	call   80104b28 <cli>
  if(cpu->ncli++ == 0)
80104ccb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104cd1:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104cd7:	85 d2                	test   %edx,%edx
80104cd9:	0f 94 c1             	sete   %cl
80104cdc:	83 c2 01             	add    $0x1,%edx
80104cdf:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104ce5:	84 c9                	test   %cl,%cl
80104ce7:	74 15                	je     80104cfe <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80104ce9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104cef:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104cf2:	81 e2 00 02 00 00    	and    $0x200,%edx
80104cf8:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104cfe:	c9                   	leave  
80104cff:	c3                   	ret    

80104d00 <popcli>:

void
popcli(void)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
80104d06:	e8 0d fe ff ff       	call   80104b18 <readeflags>
80104d0b:	25 00 02 00 00       	and    $0x200,%eax
80104d10:	85 c0                	test   %eax,%eax
80104d12:	74 0c                	je     80104d20 <popcli+0x20>
    panic("popcli - interruptible");
80104d14:	c7 04 24 15 85 10 80 	movl   $0x80108515,(%esp)
80104d1b:	e8 1a b8 ff ff       	call   8010053a <panic>
  if(--cpu->ncli < 0)
80104d20:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d26:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104d2c:	83 ea 01             	sub    $0x1,%edx
80104d2f:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104d35:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d3b:	85 c0                	test   %eax,%eax
80104d3d:	79 0c                	jns    80104d4b <popcli+0x4b>
    panic("popcli");
80104d3f:	c7 04 24 2c 85 10 80 	movl   $0x8010852c,(%esp)
80104d46:	e8 ef b7 ff ff       	call   8010053a <panic>
  if(cpu->ncli == 0 && cpu->intena)
80104d4b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d51:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104d57:	85 c0                	test   %eax,%eax
80104d59:	75 15                	jne    80104d70 <popcli+0x70>
80104d5b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d61:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104d67:	85 c0                	test   %eax,%eax
80104d69:	74 05                	je     80104d70 <popcli+0x70>
    sti();
80104d6b:	e8 be fd ff ff       	call   80104b2e <sti>
}
80104d70:	c9                   	leave  
80104d71:	c3                   	ret    
	...

80104d74 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80104d74:	55                   	push   %ebp
80104d75:	89 e5                	mov    %esp,%ebp
80104d77:	57                   	push   %edi
80104d78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80104d79:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d7c:	8b 55 10             	mov    0x10(%ebp),%edx
80104d7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d82:	89 cb                	mov    %ecx,%ebx
80104d84:	89 df                	mov    %ebx,%edi
80104d86:	89 d1                	mov    %edx,%ecx
80104d88:	fc                   	cld    
80104d89:	f3 aa                	rep stos %al,%es:(%edi)
80104d8b:	89 ca                	mov    %ecx,%edx
80104d8d:	89 fb                	mov    %edi,%ebx
80104d8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104d92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104d95:	5b                   	pop    %ebx
80104d96:	5f                   	pop    %edi
80104d97:	5d                   	pop    %ebp
80104d98:	c3                   	ret    

80104d99 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80104d99:	55                   	push   %ebp
80104d9a:	89 e5                	mov    %esp,%ebp
80104d9c:	57                   	push   %edi
80104d9d:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80104d9e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104da1:	8b 55 10             	mov    0x10(%ebp),%edx
80104da4:	8b 45 0c             	mov    0xc(%ebp),%eax
80104da7:	89 cb                	mov    %ecx,%ebx
80104da9:	89 df                	mov    %ebx,%edi
80104dab:	89 d1                	mov    %edx,%ecx
80104dad:	fc                   	cld    
80104dae:	f3 ab                	rep stos %eax,%es:(%edi)
80104db0:	89 ca                	mov    %ecx,%edx
80104db2:	89 fb                	mov    %edi,%ebx
80104db4:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104db7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104dba:	5b                   	pop    %ebx
80104dbb:	5f                   	pop    %edi
80104dbc:	5d                   	pop    %ebp
80104dbd:	c3                   	ret    

80104dbe <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104dbe:	55                   	push   %ebp
80104dbf:	89 e5                	mov    %esp,%ebp
80104dc1:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
80104dc4:	8b 45 08             	mov    0x8(%ebp),%eax
80104dc7:	83 e0 03             	and    $0x3,%eax
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	75 49                	jne    80104e17 <memset+0x59>
80104dce:	8b 45 10             	mov    0x10(%ebp),%eax
80104dd1:	83 e0 03             	and    $0x3,%eax
80104dd4:	85 c0                	test   %eax,%eax
80104dd6:	75 3f                	jne    80104e17 <memset+0x59>
    c &= 0xFF;
80104dd8:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104ddf:	8b 45 10             	mov    0x10(%ebp),%eax
80104de2:	c1 e8 02             	shr    $0x2,%eax
80104de5:	89 c2                	mov    %eax,%edx
80104de7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dea:	89 c1                	mov    %eax,%ecx
80104dec:	c1 e1 18             	shl    $0x18,%ecx
80104def:	8b 45 0c             	mov    0xc(%ebp),%eax
80104df2:	c1 e0 10             	shl    $0x10,%eax
80104df5:	09 c1                	or     %eax,%ecx
80104df7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dfa:	c1 e0 08             	shl    $0x8,%eax
80104dfd:	09 c8                	or     %ecx,%eax
80104dff:	0b 45 0c             	or     0xc(%ebp),%eax
80104e02:	89 54 24 08          	mov    %edx,0x8(%esp)
80104e06:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e0a:	8b 45 08             	mov    0x8(%ebp),%eax
80104e0d:	89 04 24             	mov    %eax,(%esp)
80104e10:	e8 84 ff ff ff       	call   80104d99 <stosl>
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
80104e15:	eb 19                	jmp    80104e30 <memset+0x72>
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
80104e17:	8b 45 10             	mov    0x10(%ebp),%eax
80104e1a:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e21:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e25:	8b 45 08             	mov    0x8(%ebp),%eax
80104e28:	89 04 24             	mov    %eax,(%esp)
80104e2b:	e8 44 ff ff ff       	call   80104d74 <stosb>
  return dst;
80104e30:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104e33:	c9                   	leave  
80104e34:	c3                   	ret    

80104e35 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104e35:	55                   	push   %ebp
80104e36:	89 e5                	mov    %esp,%ebp
80104e38:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80104e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80104e3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  s2 = v2;
80104e41:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e44:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0){
80104e47:	eb 32                	jmp    80104e7b <memcmp+0x46>
    if(*s1 != *s2)
80104e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e4c:	0f b6 10             	movzbl (%eax),%edx
80104e4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e52:	0f b6 00             	movzbl (%eax),%eax
80104e55:	38 c2                	cmp    %al,%dl
80104e57:	74 1a                	je     80104e73 <memcmp+0x3e>
      return *s1 - *s2;
80104e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104e5c:	0f b6 00             	movzbl (%eax),%eax
80104e5f:	0f b6 d0             	movzbl %al,%edx
80104e62:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104e65:	0f b6 00             	movzbl (%eax),%eax
80104e68:	0f b6 c0             	movzbl %al,%eax
80104e6b:	89 d1                	mov    %edx,%ecx
80104e6d:	29 c1                	sub    %eax,%ecx
80104e6f:	89 c8                	mov    %ecx,%eax
80104e71:	eb 1c                	jmp    80104e8f <memcmp+0x5a>
    s1++, s2++;
80104e73:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104e77:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104e7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104e7f:	0f 95 c0             	setne  %al
80104e82:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104e86:	84 c0                	test   %al,%al
80104e88:	75 bf                	jne    80104e49 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104e8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104e8f:	c9                   	leave  
80104e90:	c3                   	ret    

80104e91 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e91:	55                   	push   %ebp
80104e92:	89 e5                	mov    %esp,%ebp
80104e94:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80104e97:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  d = dst;
80104e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80104ea0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(s < d && s + n > d){
80104ea3:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ea6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80104ea9:	73 55                	jae    80104f00 <memmove+0x6f>
80104eab:	8b 45 10             	mov    0x10(%ebp),%eax
80104eae:	8b 55 f8             	mov    -0x8(%ebp),%edx
80104eb1:	8d 04 02             	lea    (%edx,%eax,1),%eax
80104eb4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80104eb7:	76 4a                	jbe    80104f03 <memmove+0x72>
    s += n;
80104eb9:	8b 45 10             	mov    0x10(%ebp),%eax
80104ebc:	01 45 f8             	add    %eax,-0x8(%ebp)
    d += n;
80104ebf:	8b 45 10             	mov    0x10(%ebp),%eax
80104ec2:	01 45 fc             	add    %eax,-0x4(%ebp)
    while(n-- > 0)
80104ec5:	eb 13                	jmp    80104eda <memmove+0x49>
      *--d = *--s;
80104ec7:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80104ecb:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80104ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ed2:	0f b6 10             	movzbl (%eax),%edx
80104ed5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ed8:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104eda:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104ede:	0f 95 c0             	setne  %al
80104ee1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104ee5:	84 c0                	test   %al,%al
80104ee7:	75 de                	jne    80104ec7 <memmove+0x36>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ee9:	eb 28                	jmp    80104f13 <memmove+0x82>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
80104eeb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104eee:	0f b6 10             	movzbl (%eax),%edx
80104ef1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ef4:	88 10                	mov    %dl,(%eax)
80104ef6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104efa:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104efe:	eb 04                	jmp    80104f04 <memmove+0x73>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104f00:	90                   	nop
80104f01:	eb 01                	jmp    80104f04 <memmove+0x73>
80104f03:	90                   	nop
80104f04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104f08:	0f 95 c0             	setne  %al
80104f0b:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104f0f:	84 c0                	test   %al,%al
80104f11:	75 d8                	jne    80104eeb <memmove+0x5a>
      *d++ = *s++;

  return dst;
80104f13:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104f16:	c9                   	leave  
80104f17:	c3                   	ret    

80104f18 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104f18:	55                   	push   %ebp
80104f19:	89 e5                	mov    %esp,%ebp
80104f1b:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
80104f1e:	8b 45 10             	mov    0x10(%ebp),%eax
80104f21:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f25:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f28:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f2c:	8b 45 08             	mov    0x8(%ebp),%eax
80104f2f:	89 04 24             	mov    %eax,(%esp)
80104f32:	e8 5a ff ff ff       	call   80104e91 <memmove>
}
80104f37:	c9                   	leave  
80104f38:	c3                   	ret    

80104f39 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104f39:	55                   	push   %ebp
80104f3a:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80104f3c:	eb 0c                	jmp    80104f4a <strncmp+0x11>
    n--, p++, q++;
80104f3e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104f42:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80104f46:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104f4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104f4e:	74 1a                	je     80104f6a <strncmp+0x31>
80104f50:	8b 45 08             	mov    0x8(%ebp),%eax
80104f53:	0f b6 00             	movzbl (%eax),%eax
80104f56:	84 c0                	test   %al,%al
80104f58:	74 10                	je     80104f6a <strncmp+0x31>
80104f5a:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5d:	0f b6 10             	movzbl (%eax),%edx
80104f60:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f63:	0f b6 00             	movzbl (%eax),%eax
80104f66:	38 c2                	cmp    %al,%dl
80104f68:	74 d4                	je     80104f3e <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80104f6a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104f6e:	75 07                	jne    80104f77 <strncmp+0x3e>
    return 0;
80104f70:	b8 00 00 00 00       	mov    $0x0,%eax
80104f75:	eb 18                	jmp    80104f8f <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
80104f77:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7a:	0f b6 00             	movzbl (%eax),%eax
80104f7d:	0f b6 d0             	movzbl %al,%edx
80104f80:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f83:	0f b6 00             	movzbl (%eax),%eax
80104f86:	0f b6 c0             	movzbl %al,%eax
80104f89:	89 d1                	mov    %edx,%ecx
80104f8b:	29 c1                	sub    %eax,%ecx
80104f8d:	89 c8                	mov    %ecx,%eax
}
80104f8f:	5d                   	pop    %ebp
80104f90:	c3                   	ret    

80104f91 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f91:	55                   	push   %ebp
80104f92:	89 e5                	mov    %esp,%ebp
80104f94:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80104f97:	8b 45 08             	mov    0x8(%ebp),%eax
80104f9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fa1:	0f 9f c0             	setg   %al
80104fa4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104fa8:	84 c0                	test   %al,%al
80104faa:	74 30                	je     80104fdc <strncpy+0x4b>
80104fac:	8b 45 0c             	mov    0xc(%ebp),%eax
80104faf:	0f b6 10             	movzbl (%eax),%edx
80104fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb5:	88 10                	mov    %dl,(%eax)
80104fb7:	8b 45 08             	mov    0x8(%ebp),%eax
80104fba:	0f b6 00             	movzbl (%eax),%eax
80104fbd:	84 c0                	test   %al,%al
80104fbf:	0f 95 c0             	setne  %al
80104fc2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80104fc6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104fca:	84 c0                	test   %al,%al
80104fcc:	75 cf                	jne    80104f9d <strncpy+0xc>
    ;
  while(n-- > 0)
80104fce:	eb 0d                	jmp    80104fdd <strncpy+0x4c>
    *s++ = 0;
80104fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd3:	c6 00 00             	movb   $0x0,(%eax)
80104fd6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80104fda:	eb 01                	jmp    80104fdd <strncpy+0x4c>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104fdc:	90                   	nop
80104fdd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fe1:	0f 9f c0             	setg   %al
80104fe4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104fe8:	84 c0                	test   %al,%al
80104fea:	75 e4                	jne    80104fd0 <strncpy+0x3f>
    *s++ = 0;
  return os;
80104fec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104fef:	c9                   	leave  
80104ff0:	c3                   	ret    

80104ff1 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ff1:	55                   	push   %ebp
80104ff2:	89 e5                	mov    %esp,%ebp
80104ff4:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80104ff7:	8b 45 08             	mov    0x8(%ebp),%eax
80104ffa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80104ffd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105001:	7f 05                	jg     80105008 <safestrcpy+0x17>
    return os;
80105003:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105006:	eb 35                	jmp    8010503d <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
80105008:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010500c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105010:	7e 22                	jle    80105034 <safestrcpy+0x43>
80105012:	8b 45 0c             	mov    0xc(%ebp),%eax
80105015:	0f b6 10             	movzbl (%eax),%edx
80105018:	8b 45 08             	mov    0x8(%ebp),%eax
8010501b:	88 10                	mov    %dl,(%eax)
8010501d:	8b 45 08             	mov    0x8(%ebp),%eax
80105020:	0f b6 00             	movzbl (%eax),%eax
80105023:	84 c0                	test   %al,%al
80105025:	0f 95 c0             	setne  %al
80105028:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010502c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105030:	84 c0                	test   %al,%al
80105032:	75 d4                	jne    80105008 <safestrcpy+0x17>
    ;
  *s = 0;
80105034:	8b 45 08             	mov    0x8(%ebp),%eax
80105037:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010503a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010503d:	c9                   	leave  
8010503e:	c3                   	ret    

8010503f <strlen>:

int
strlen(const char *s)
{
8010503f:	55                   	push   %ebp
80105040:	89 e5                	mov    %esp,%ebp
80105042:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105045:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010504c:	eb 04                	jmp    80105052 <strlen+0x13>
8010504e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105052:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105055:	03 45 08             	add    0x8(%ebp),%eax
80105058:	0f b6 00             	movzbl (%eax),%eax
8010505b:	84 c0                	test   %al,%al
8010505d:	75 ef                	jne    8010504e <strlen+0xf>
    ;
  return n;
8010505f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105062:	c9                   	leave  
80105063:	c3                   	ret    

80105064 <swtch>:
80105064:	8b 44 24 04          	mov    0x4(%esp),%eax
80105068:	8b 54 24 08          	mov    0x8(%esp),%edx
8010506c:	55                   	push   %ebp
8010506d:	53                   	push   %ebx
8010506e:	56                   	push   %esi
8010506f:	57                   	push   %edi
80105070:	89 20                	mov    %esp,(%eax)
80105072:	89 d4                	mov    %edx,%esp
80105074:	5f                   	pop    %edi
80105075:	5e                   	pop    %esi
80105076:	5b                   	pop    %ebx
80105077:	5d                   	pop    %ebp
80105078:	c3                   	ret    
80105079:	00 00                	add    %al,(%eax)
	...

8010507c <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
8010507c:	55                   	push   %ebp
8010507d:	89 e5                	mov    %esp,%ebp
  if(addr >= p->sz || addr+4 > p->sz)
8010507f:	8b 45 08             	mov    0x8(%ebp),%eax
80105082:	8b 00                	mov    (%eax),%eax
80105084:	3b 45 0c             	cmp    0xc(%ebp),%eax
80105087:	76 0f                	jbe    80105098 <fetchint+0x1c>
80105089:	8b 45 0c             	mov    0xc(%ebp),%eax
8010508c:	8d 50 04             	lea    0x4(%eax),%edx
8010508f:	8b 45 08             	mov    0x8(%ebp),%eax
80105092:	8b 00                	mov    (%eax),%eax
80105094:	39 c2                	cmp    %eax,%edx
80105096:	76 07                	jbe    8010509f <fetchint+0x23>
    return -1;
80105098:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010509d:	eb 0f                	jmp    801050ae <fetchint+0x32>
  *ip = *(int*)(addr);
8010509f:	8b 45 0c             	mov    0xc(%ebp),%eax
801050a2:	8b 10                	mov    (%eax),%edx
801050a4:	8b 45 10             	mov    0x10(%ebp),%eax
801050a7:	89 10                	mov    %edx,(%eax)
  return 0;
801050a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801050ae:	5d                   	pop    %ebp
801050af:	c3                   	ret    

801050b0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= p->sz)
801050b6:	8b 45 08             	mov    0x8(%ebp),%eax
801050b9:	8b 00                	mov    (%eax),%eax
801050bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
801050be:	77 07                	ja     801050c7 <fetchstr+0x17>
    return -1;
801050c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050c5:	eb 45                	jmp    8010510c <fetchstr+0x5c>
  *pp = (char*)addr;
801050c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801050ca:	8b 45 10             	mov    0x10(%ebp),%eax
801050cd:	89 10                	mov    %edx,(%eax)
  ep = (char*)p->sz;
801050cf:	8b 45 08             	mov    0x8(%ebp),%eax
801050d2:	8b 00                	mov    (%eax),%eax
801050d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(s = *pp; s < ep; s++)
801050d7:	8b 45 10             	mov    0x10(%ebp),%eax
801050da:	8b 00                	mov    (%eax),%eax
801050dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
801050df:	eb 1e                	jmp    801050ff <fetchstr+0x4f>
    if(*s == 0)
801050e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050e4:	0f b6 00             	movzbl (%eax),%eax
801050e7:	84 c0                	test   %al,%al
801050e9:	75 10                	jne    801050fb <fetchstr+0x4b>
      return s - *pp;
801050eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
801050ee:	8b 45 10             	mov    0x10(%ebp),%eax
801050f1:	8b 00                	mov    (%eax),%eax
801050f3:	89 d1                	mov    %edx,%ecx
801050f5:	29 c1                	sub    %eax,%ecx
801050f7:	89 c8                	mov    %ecx,%eax
801050f9:	eb 11                	jmp    8010510c <fetchstr+0x5c>

  if(addr >= p->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)p->sz;
  for(s = *pp; s < ep; s++)
801050fb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801050ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105102:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80105105:	72 da                	jb     801050e1 <fetchstr+0x31>
    if(*s == 0)
      return s - *pp;
  return -1;
80105107:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010510c:	c9                   	leave  
8010510d:	c3                   	ret    

8010510e <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010510e:	55                   	push   %ebp
8010510f:	89 e5                	mov    %esp,%ebp
80105111:	83 ec 0c             	sub    $0xc,%esp
  return fetchint(proc, proc->tf->esp + 4 + 4*n, ip);
80105114:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010511a:	8b 40 18             	mov    0x18(%eax),%eax
8010511d:	8b 50 44             	mov    0x44(%eax),%edx
80105120:	8b 45 08             	mov    0x8(%ebp),%eax
80105123:	c1 e0 02             	shl    $0x2,%eax
80105126:	8d 04 02             	lea    (%edx,%eax,1),%eax
80105129:	8d 48 04             	lea    0x4(%eax),%ecx
8010512c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105132:	8b 55 0c             	mov    0xc(%ebp),%edx
80105135:	89 54 24 08          	mov    %edx,0x8(%esp)
80105139:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010513d:	89 04 24             	mov    %eax,(%esp)
80105140:	e8 37 ff ff ff       	call   8010507c <fetchint>
}
80105145:	c9                   	leave  
80105146:	c3                   	ret    

80105147 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105147:	55                   	push   %ebp
80105148:	89 e5                	mov    %esp,%ebp
8010514a:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
8010514d:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105150:	89 44 24 04          	mov    %eax,0x4(%esp)
80105154:	8b 45 08             	mov    0x8(%ebp),%eax
80105157:	89 04 24             	mov    %eax,(%esp)
8010515a:	e8 af ff ff ff       	call   8010510e <argint>
8010515f:	85 c0                	test   %eax,%eax
80105161:	79 07                	jns    8010516a <argptr+0x23>
    return -1;
80105163:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105168:	eb 3d                	jmp    801051a7 <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010516a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010516d:	89 c2                	mov    %eax,%edx
8010516f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105175:	8b 00                	mov    (%eax),%eax
80105177:	39 c2                	cmp    %eax,%edx
80105179:	73 16                	jae    80105191 <argptr+0x4a>
8010517b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010517e:	89 c2                	mov    %eax,%edx
80105180:	8b 45 10             	mov    0x10(%ebp),%eax
80105183:	01 c2                	add    %eax,%edx
80105185:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010518b:	8b 00                	mov    (%eax),%eax
8010518d:	39 c2                	cmp    %eax,%edx
8010518f:	76 07                	jbe    80105198 <argptr+0x51>
    return -1;
80105191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105196:	eb 0f                	jmp    801051a7 <argptr+0x60>
  *pp = (char*)i;
80105198:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010519b:	89 c2                	mov    %eax,%edx
8010519d:	8b 45 0c             	mov    0xc(%ebp),%eax
801051a0:	89 10                	mov    %edx,(%eax)
  return 0;
801051a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801051a7:	c9                   	leave  
801051a8:	c3                   	ret    

801051a9 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801051a9:	55                   	push   %ebp
801051aa:	89 e5                	mov    %esp,%ebp
801051ac:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  if(argint(n, &addr) < 0)
801051af:	8d 45 fc             	lea    -0x4(%ebp),%eax
801051b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801051b6:	8b 45 08             	mov    0x8(%ebp),%eax
801051b9:	89 04 24             	mov    %eax,(%esp)
801051bc:	e8 4d ff ff ff       	call   8010510e <argint>
801051c1:	85 c0                	test   %eax,%eax
801051c3:	79 07                	jns    801051cc <argstr+0x23>
    return -1;
801051c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051ca:	eb 1e                	jmp    801051ea <argstr+0x41>
  return fetchstr(proc, addr, pp);
801051cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051cf:	89 c2                	mov    %eax,%edx
801051d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801051da:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801051de:	89 54 24 04          	mov    %edx,0x4(%esp)
801051e2:	89 04 24             	mov    %eax,(%esp)
801051e5:	e8 c6 fe ff ff       	call   801050b0 <fetchstr>
}
801051ea:	c9                   	leave  
801051eb:	c3                   	ret    

801051ec <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
801051ec:	55                   	push   %ebp
801051ed:	89 e5                	mov    %esp,%ebp
801051ef:	53                   	push   %ebx
801051f0:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
801051f3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051f9:	8b 40 18             	mov    0x18(%eax),%eax
801051fc:	8b 40 1c             	mov    0x1c(%eax),%eax
801051ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num >= 0 && num < SYS_open && syscalls[num]) {
80105202:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105206:	78 2e                	js     80105236 <syscall+0x4a>
80105208:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
8010520c:	7f 28                	jg     80105236 <syscall+0x4a>
8010520e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105211:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105218:	85 c0                	test   %eax,%eax
8010521a:	74 1a                	je     80105236 <syscall+0x4a>
    proc->tf->eax = syscalls[num]();
8010521c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105222:	8b 58 18             	mov    0x18(%eax),%ebx
80105225:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105228:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010522f:	ff d0                	call   *%eax
80105231:	89 43 1c             	mov    %eax,0x1c(%ebx)
syscall(void)
{
  int num;

  num = proc->tf->eax;
  if(num >= 0 && num < SYS_open && syscalls[num]) {
80105234:	eb 73                	jmp    801052a9 <syscall+0xbd>
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
80105236:	83 7d f4 0e          	cmpl   $0xe,-0xc(%ebp)
8010523a:	7e 30                	jle    8010526c <syscall+0x80>
8010523c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010523f:	83 f8 15             	cmp    $0x15,%eax
80105242:	77 28                	ja     8010526c <syscall+0x80>
80105244:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105247:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010524e:	85 c0                	test   %eax,%eax
80105250:	74 1a                	je     8010526c <syscall+0x80>
    proc->tf->eax = syscalls[num]();
80105252:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105258:	8b 58 18             	mov    0x18(%eax),%ebx
8010525b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010525e:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105265:	ff d0                	call   *%eax
80105267:	89 43 1c             	mov    %eax,0x1c(%ebx)
  int num;

  num = proc->tf->eax;
  if(num >= 0 && num < SYS_open && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
8010526a:	eb 3d                	jmp    801052a9 <syscall+0xbd>
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010526c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(num >= 0 && num < SYS_open && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105272:	8d 48 6c             	lea    0x6c(%eax),%ecx
            proc->pid, proc->name, num);
80105275:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(num >= 0 && num < SYS_open && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else if (num >= SYS_open && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010527b:	8b 40 10             	mov    0x10(%eax),%eax
8010527e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105281:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105285:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105289:	89 44 24 04          	mov    %eax,0x4(%esp)
8010528d:	c7 04 24 33 85 10 80 	movl   $0x80108533,(%esp)
80105294:	e8 01 b1 ff ff       	call   8010039a <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105299:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010529f:	8b 40 18             	mov    0x18(%eax),%eax
801052a2:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801052a9:	83 c4 24             	add    $0x24,%esp
801052ac:	5b                   	pop    %ebx
801052ad:	5d                   	pop    %ebp
801052ae:	c3                   	ret    
	...

801052b0 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801052b6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b9:	89 44 24 04          	mov    %eax,0x4(%esp)
801052bd:	8b 45 08             	mov    0x8(%ebp),%eax
801052c0:	89 04 24             	mov    %eax,(%esp)
801052c3:	e8 46 fe ff ff       	call   8010510e <argint>
801052c8:	85 c0                	test   %eax,%eax
801052ca:	79 07                	jns    801052d3 <argfd+0x23>
    return -1;
801052cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052d1:	eb 50                	jmp    80105323 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801052d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052d6:	85 c0                	test   %eax,%eax
801052d8:	78 21                	js     801052fb <argfd+0x4b>
801052da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052dd:	83 f8 0f             	cmp    $0xf,%eax
801052e0:	7f 19                	jg     801052fb <argfd+0x4b>
801052e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801052eb:	83 c2 08             	add    $0x8,%edx
801052ee:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801052f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801052f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801052f9:	75 07                	jne    80105302 <argfd+0x52>
    return -1;
801052fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105300:	eb 21                	jmp    80105323 <argfd+0x73>
  if(pfd)
80105302:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105306:	74 08                	je     80105310 <argfd+0x60>
    *pfd = fd;
80105308:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010530b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010530e:	89 10                	mov    %edx,(%eax)
  if(pf)
80105310:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105314:	74 08                	je     8010531e <argfd+0x6e>
    *pf = f;
80105316:	8b 45 10             	mov    0x10(%ebp),%eax
80105319:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010531c:	89 10                	mov    %edx,(%eax)
  return 0;
8010531e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105323:	c9                   	leave  
80105324:	c3                   	ret    

80105325 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105325:	55                   	push   %ebp
80105326:	89 e5                	mov    %esp,%ebp
80105328:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010532b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105332:	eb 30                	jmp    80105364 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105334:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010533a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010533d:	83 c2 08             	add    $0x8,%edx
80105340:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105344:	85 c0                	test   %eax,%eax
80105346:	75 18                	jne    80105360 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105348:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010534e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105351:	8d 4a 08             	lea    0x8(%edx),%ecx
80105354:	8b 55 08             	mov    0x8(%ebp),%edx
80105357:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
8010535b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010535e:	eb 0f                	jmp    8010536f <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105360:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105364:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105368:	7e ca                	jle    80105334 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010536a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010536f:	c9                   	leave  
80105370:	c3                   	ret    

80105371 <sys_dup>:

int
sys_dup(void)
{
80105371:	55                   	push   %ebp
80105372:	89 e5                	mov    %esp,%ebp
80105374:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105377:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010537a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010537e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105385:	00 
80105386:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010538d:	e8 1e ff ff ff       	call   801052b0 <argfd>
80105392:	85 c0                	test   %eax,%eax
80105394:	79 07                	jns    8010539d <sys_dup+0x2c>
    return -1;
80105396:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539b:	eb 29                	jmp    801053c6 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
8010539d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053a0:	89 04 24             	mov    %eax,(%esp)
801053a3:	e8 7d ff ff ff       	call   80105325 <fdalloc>
801053a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801053ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801053af:	79 07                	jns    801053b8 <sys_dup+0x47>
    return -1;
801053b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053b6:	eb 0e                	jmp    801053c6 <sys_dup+0x55>
  filedup(f);
801053b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053bb:	89 04 24             	mov    %eax,(%esp)
801053be:	e8 be bb ff ff       	call   80100f81 <filedup>
  return fd;
801053c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801053c6:	c9                   	leave  
801053c7:	c3                   	ret    

801053c8 <sys_read>:

int
sys_read(void)
{
801053c8:	55                   	push   %ebp
801053c9:	89 e5                	mov    %esp,%ebp
801053cb:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d1:	89 44 24 08          	mov    %eax,0x8(%esp)
801053d5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801053dc:	00 
801053dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053e4:	e8 c7 fe ff ff       	call   801052b0 <argfd>
801053e9:	85 c0                	test   %eax,%eax
801053eb:	78 35                	js     80105422 <sys_read+0x5a>
801053ed:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801053f4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801053fb:	e8 0e fd ff ff       	call   8010510e <argint>
80105400:	85 c0                	test   %eax,%eax
80105402:	78 1e                	js     80105422 <sys_read+0x5a>
80105404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105407:	89 44 24 08          	mov    %eax,0x8(%esp)
8010540b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010540e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105412:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105419:	e8 29 fd ff ff       	call   80105147 <argptr>
8010541e:	85 c0                	test   %eax,%eax
80105420:	79 07                	jns    80105429 <sys_read+0x61>
    return -1;
80105422:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105427:	eb 19                	jmp    80105442 <sys_read+0x7a>
  return fileread(f, p, n);
80105429:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010542c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010542f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105432:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105436:	89 54 24 04          	mov    %edx,0x4(%esp)
8010543a:	89 04 24             	mov    %eax,(%esp)
8010543d:	e8 ac bc ff ff       	call   801010ee <fileread>
}
80105442:	c9                   	leave  
80105443:	c3                   	ret    

80105444 <sys_write>:

int
sys_write(void)
{
80105444:	55                   	push   %ebp
80105445:	89 e5                	mov    %esp,%ebp
80105447:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010544a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010544d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105451:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105458:	00 
80105459:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105460:	e8 4b fe ff ff       	call   801052b0 <argfd>
80105465:	85 c0                	test   %eax,%eax
80105467:	78 35                	js     8010549e <sys_write+0x5a>
80105469:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010546c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105470:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105477:	e8 92 fc ff ff       	call   8010510e <argint>
8010547c:	85 c0                	test   %eax,%eax
8010547e:	78 1e                	js     8010549e <sys_write+0x5a>
80105480:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105483:	89 44 24 08          	mov    %eax,0x8(%esp)
80105487:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010548a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010548e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105495:	e8 ad fc ff ff       	call   80105147 <argptr>
8010549a:	85 c0                	test   %eax,%eax
8010549c:	79 07                	jns    801054a5 <sys_write+0x61>
    return -1;
8010549e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a3:	eb 19                	jmp    801054be <sys_write+0x7a>
  return filewrite(f, p, n);
801054a5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801054a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801054ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054ae:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801054b2:	89 54 24 04          	mov    %edx,0x4(%esp)
801054b6:	89 04 24             	mov    %eax,(%esp)
801054b9:	e8 ec bc ff ff       	call   801011aa <filewrite>
}
801054be:	c9                   	leave  
801054bf:	c3                   	ret    

801054c0 <sys_close>:

int
sys_close(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801054c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054c9:	89 44 24 08          	mov    %eax,0x8(%esp)
801054cd:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801054d4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054db:	e8 d0 fd ff ff       	call   801052b0 <argfd>
801054e0:	85 c0                	test   %eax,%eax
801054e2:	79 07                	jns    801054eb <sys_close+0x2b>
    return -1;
801054e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e9:	eb 24                	jmp    8010550f <sys_close+0x4f>
  proc->ofile[fd] = 0;
801054eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054f4:	83 c2 08             	add    $0x8,%edx
801054f7:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801054fe:	00 
  fileclose(f);
801054ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105502:	89 04 24             	mov    %eax,(%esp)
80105505:	e8 bf ba ff ff       	call   80100fc9 <fileclose>
  return 0;
8010550a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010550f:	c9                   	leave  
80105510:	c3                   	ret    

80105511 <sys_fstat>:

int
sys_fstat(void)
{
80105511:	55                   	push   %ebp
80105512:	89 e5                	mov    %esp,%ebp
80105514:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105517:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010551a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010551e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105525:	00 
80105526:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010552d:	e8 7e fd ff ff       	call   801052b0 <argfd>
80105532:	85 c0                	test   %eax,%eax
80105534:	78 1f                	js     80105555 <sys_fstat+0x44>
80105536:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105539:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80105540:	00 
80105541:	89 44 24 04          	mov    %eax,0x4(%esp)
80105545:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010554c:	e8 f6 fb ff ff       	call   80105147 <argptr>
80105551:	85 c0                	test   %eax,%eax
80105553:	79 07                	jns    8010555c <sys_fstat+0x4b>
    return -1;
80105555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010555a:	eb 12                	jmp    8010556e <sys_fstat+0x5d>
  return filestat(f, st);
8010555c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010555f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105562:	89 54 24 04          	mov    %edx,0x4(%esp)
80105566:	89 04 24             	mov    %eax,(%esp)
80105569:	e8 31 bb ff ff       	call   8010109f <filestat>
}
8010556e:	c9                   	leave  
8010556f:	c3                   	ret    

80105570 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105576:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105579:	89 44 24 04          	mov    %eax,0x4(%esp)
8010557d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105584:	e8 20 fc ff ff       	call   801051a9 <argstr>
80105589:	85 c0                	test   %eax,%eax
8010558b:	78 17                	js     801055a4 <sys_link+0x34>
8010558d:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105590:	89 44 24 04          	mov    %eax,0x4(%esp)
80105594:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010559b:	e8 09 fc ff ff       	call   801051a9 <argstr>
801055a0:	85 c0                	test   %eax,%eax
801055a2:	79 0a                	jns    801055ae <sys_link+0x3e>
    return -1;
801055a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055a9:	e9 3c 01 00 00       	jmp    801056ea <sys_link+0x17a>
  if((ip = namei(old)) == 0)
801055ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
801055b1:	89 04 24             	mov    %eax,(%esp)
801055b4:	e8 62 ce ff ff       	call   8010241b <namei>
801055b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055c0:	75 0a                	jne    801055cc <sys_link+0x5c>
    return -1;
801055c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c7:	e9 1e 01 00 00       	jmp    801056ea <sys_link+0x17a>

  begin_trans();
801055cc:	e8 38 dc ff ff       	call   80103209 <begin_trans>

  ilock(ip);
801055d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055d4:	89 04 24             	mov    %eax,(%esp)
801055d7:	e8 a7 c2 ff ff       	call   80101883 <ilock>
  if(ip->type == T_DIR){
801055dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055df:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801055e3:	66 83 f8 01          	cmp    $0x1,%ax
801055e7:	75 1a                	jne    80105603 <sys_link+0x93>
    iunlockput(ip);
801055e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055ec:	89 04 24             	mov    %eax,(%esp)
801055ef:	e8 16 c5 ff ff       	call   80101b0a <iunlockput>
    commit_trans();
801055f4:	e8 59 dc ff ff       	call   80103252 <commit_trans>
    return -1;
801055f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055fe:	e9 e7 00 00 00       	jmp    801056ea <sys_link+0x17a>
  }

  ip->nlink++;
80105603:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105606:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010560a:	8d 50 01             	lea    0x1(%eax),%edx
8010560d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105610:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105614:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105617:	89 04 24             	mov    %eax,(%esp)
8010561a:	e8 a4 c0 ff ff       	call   801016c3 <iupdate>
  iunlock(ip);
8010561f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105622:	89 04 24             	mov    %eax,(%esp)
80105625:	e8 aa c3 ff ff       	call   801019d4 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
8010562a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010562d:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105630:	89 54 24 04          	mov    %edx,0x4(%esp)
80105634:	89 04 24             	mov    %eax,(%esp)
80105637:	e8 01 ce ff ff       	call   8010243d <nameiparent>
8010563c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010563f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105643:	74 68                	je     801056ad <sys_link+0x13d>
    goto bad;
  ilock(dp);
80105645:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105648:	89 04 24             	mov    %eax,(%esp)
8010564b:	e8 33 c2 ff ff       	call   80101883 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105650:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105653:	8b 10                	mov    (%eax),%edx
80105655:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105658:	8b 00                	mov    (%eax),%eax
8010565a:	39 c2                	cmp    %eax,%edx
8010565c:	75 20                	jne    8010567e <sys_link+0x10e>
8010565e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105661:	8b 40 04             	mov    0x4(%eax),%eax
80105664:	89 44 24 08          	mov    %eax,0x8(%esp)
80105668:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010566b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010566f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105672:	89 04 24             	mov    %eax,(%esp)
80105675:	e8 e0 ca ff ff       	call   8010215a <dirlink>
8010567a:	85 c0                	test   %eax,%eax
8010567c:	79 0d                	jns    8010568b <sys_link+0x11b>
    iunlockput(dp);
8010567e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105681:	89 04 24             	mov    %eax,(%esp)
80105684:	e8 81 c4 ff ff       	call   80101b0a <iunlockput>
    goto bad;
80105689:	eb 23                	jmp    801056ae <sys_link+0x13e>
  }
  iunlockput(dp);
8010568b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010568e:	89 04 24             	mov    %eax,(%esp)
80105691:	e8 74 c4 ff ff       	call   80101b0a <iunlockput>
  iput(ip);
80105696:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105699:	89 04 24             	mov    %eax,(%esp)
8010569c:	e8 98 c3 ff ff       	call   80101a39 <iput>

  commit_trans();
801056a1:	e8 ac db ff ff       	call   80103252 <commit_trans>

  return 0;
801056a6:	b8 00 00 00 00       	mov    $0x0,%eax
801056ab:	eb 3d                	jmp    801056ea <sys_link+0x17a>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
801056ad:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
801056ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056b1:	89 04 24             	mov    %eax,(%esp)
801056b4:	e8 ca c1 ff ff       	call   80101883 <ilock>
  ip->nlink--;
801056b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056bc:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801056c0:	8d 50 ff             	lea    -0x1(%eax),%edx
801056c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056c6:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801056ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056cd:	89 04 24             	mov    %eax,(%esp)
801056d0:	e8 ee bf ff ff       	call   801016c3 <iupdate>
  iunlockput(ip);
801056d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056d8:	89 04 24             	mov    %eax,(%esp)
801056db:	e8 2a c4 ff ff       	call   80101b0a <iunlockput>
  commit_trans();
801056e0:	e8 6d db ff ff       	call   80103252 <commit_trans>
  return -1;
801056e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056ea:	c9                   	leave  
801056eb:	c3                   	ret    

801056ec <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801056ec:	55                   	push   %ebp
801056ed:	89 e5                	mov    %esp,%ebp
801056ef:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801056f2:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801056f9:	eb 4b                	jmp    80105746 <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801056fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056fe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105701:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105708:	00 
80105709:	89 54 24 08          	mov    %edx,0x8(%esp)
8010570d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105711:	8b 45 08             	mov    0x8(%ebp),%eax
80105714:	89 04 24             	mov    %eax,(%esp)
80105717:	e8 60 c6 ff ff       	call   80101d7c <readi>
8010571c:	83 f8 10             	cmp    $0x10,%eax
8010571f:	74 0c                	je     8010572d <isdirempty+0x41>
      panic("isdirempty: readi");
80105721:	c7 04 24 4f 85 10 80 	movl   $0x8010854f,(%esp)
80105728:	e8 0d ae ff ff       	call   8010053a <panic>
    if(de.inum != 0)
8010572d:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105731:	66 85 c0             	test   %ax,%ax
80105734:	74 07                	je     8010573d <isdirempty+0x51>
      return 0;
80105736:	b8 00 00 00 00       	mov    $0x0,%eax
8010573b:	eb 1b                	jmp    80105758 <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010573d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105740:	83 c0 10             	add    $0x10,%eax
80105743:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105746:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105749:	8b 45 08             	mov    0x8(%ebp),%eax
8010574c:	8b 40 18             	mov    0x18(%eax),%eax
8010574f:	39 c2                	cmp    %eax,%edx
80105751:	72 a8                	jb     801056fb <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105753:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105758:	c9                   	leave  
80105759:	c3                   	ret    

8010575a <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
8010575a:	55                   	push   %ebp
8010575b:	89 e5                	mov    %esp,%ebp
8010575d:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105760:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105763:	89 44 24 04          	mov    %eax,0x4(%esp)
80105767:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010576e:	e8 36 fa ff ff       	call   801051a9 <argstr>
80105773:	85 c0                	test   %eax,%eax
80105775:	79 0a                	jns    80105781 <sys_unlink+0x27>
    return -1;
80105777:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010577c:	e9 aa 01 00 00       	jmp    8010592b <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80105781:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105784:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105787:	89 54 24 04          	mov    %edx,0x4(%esp)
8010578b:	89 04 24             	mov    %eax,(%esp)
8010578e:	e8 aa cc ff ff       	call   8010243d <nameiparent>
80105793:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105796:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010579a:	75 0a                	jne    801057a6 <sys_unlink+0x4c>
    return -1;
8010579c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a1:	e9 85 01 00 00       	jmp    8010592b <sys_unlink+0x1d1>

  begin_trans();
801057a6:	e8 5e da ff ff       	call   80103209 <begin_trans>

  ilock(dp);
801057ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057ae:	89 04 24             	mov    %eax,(%esp)
801057b1:	e8 cd c0 ff ff       	call   80101883 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801057b6:	c7 44 24 04 61 85 10 	movl   $0x80108561,0x4(%esp)
801057bd:	80 
801057be:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057c1:	89 04 24             	mov    %eax,(%esp)
801057c4:	e8 a7 c8 ff ff       	call   80102070 <namecmp>
801057c9:	85 c0                	test   %eax,%eax
801057cb:	0f 84 45 01 00 00    	je     80105916 <sys_unlink+0x1bc>
801057d1:	c7 44 24 04 63 85 10 	movl   $0x80108563,0x4(%esp)
801057d8:	80 
801057d9:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057dc:	89 04 24             	mov    %eax,(%esp)
801057df:	e8 8c c8 ff ff       	call   80102070 <namecmp>
801057e4:	85 c0                	test   %eax,%eax
801057e6:	0f 84 2a 01 00 00    	je     80105916 <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801057ec:	8d 45 c8             	lea    -0x38(%ebp),%eax
801057ef:	89 44 24 08          	mov    %eax,0x8(%esp)
801057f3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057f6:	89 44 24 04          	mov    %eax,0x4(%esp)
801057fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057fd:	89 04 24             	mov    %eax,(%esp)
80105800:	e8 8d c8 ff ff       	call   80102092 <dirlookup>
80105805:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105808:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010580c:	0f 84 03 01 00 00    	je     80105915 <sys_unlink+0x1bb>
    goto bad;
  ilock(ip);
80105812:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105815:	89 04 24             	mov    %eax,(%esp)
80105818:	e8 66 c0 ff ff       	call   80101883 <ilock>

  if(ip->nlink < 1)
8010581d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105820:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105824:	66 85 c0             	test   %ax,%ax
80105827:	7f 0c                	jg     80105835 <sys_unlink+0xdb>
    panic("unlink: nlink < 1");
80105829:	c7 04 24 66 85 10 80 	movl   $0x80108566,(%esp)
80105830:	e8 05 ad ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105835:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105838:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010583c:	66 83 f8 01          	cmp    $0x1,%ax
80105840:	75 1f                	jne    80105861 <sys_unlink+0x107>
80105842:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105845:	89 04 24             	mov    %eax,(%esp)
80105848:	e8 9f fe ff ff       	call   801056ec <isdirempty>
8010584d:	85 c0                	test   %eax,%eax
8010584f:	75 10                	jne    80105861 <sys_unlink+0x107>
    iunlockput(ip);
80105851:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105854:	89 04 24             	mov    %eax,(%esp)
80105857:	e8 ae c2 ff ff       	call   80101b0a <iunlockput>
    goto bad;
8010585c:	e9 b5 00 00 00       	jmp    80105916 <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80105861:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105868:	00 
80105869:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105870:	00 
80105871:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105874:	89 04 24             	mov    %eax,(%esp)
80105877:	e8 42 f5 ff ff       	call   80104dbe <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010587c:	8b 55 c8             	mov    -0x38(%ebp),%edx
8010587f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105882:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105889:	00 
8010588a:	89 54 24 08          	mov    %edx,0x8(%esp)
8010588e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105892:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105895:	89 04 24             	mov    %eax,(%esp)
80105898:	e8 43 c6 ff ff       	call   80101ee0 <writei>
8010589d:	83 f8 10             	cmp    $0x10,%eax
801058a0:	74 0c                	je     801058ae <sys_unlink+0x154>
    panic("unlink: writei");
801058a2:	c7 04 24 78 85 10 80 	movl   $0x80108578,(%esp)
801058a9:	e8 8c ac ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR){
801058ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058b1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801058b5:	66 83 f8 01          	cmp    $0x1,%ax
801058b9:	75 1c                	jne    801058d7 <sys_unlink+0x17d>
    dp->nlink--;
801058bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058be:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058c2:	8d 50 ff             	lea    -0x1(%eax),%edx
801058c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c8:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801058cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058cf:	89 04 24             	mov    %eax,(%esp)
801058d2:	e8 ec bd ff ff       	call   801016c3 <iupdate>
  }
  iunlockput(dp);
801058d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058da:	89 04 24             	mov    %eax,(%esp)
801058dd:	e8 28 c2 ff ff       	call   80101b0a <iunlockput>

  ip->nlink--;
801058e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058e5:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058e9:	8d 50 ff             	lea    -0x1(%eax),%edx
801058ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058ef:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801058f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058f6:	89 04 24             	mov    %eax,(%esp)
801058f9:	e8 c5 bd ff ff       	call   801016c3 <iupdate>
  iunlockput(ip);
801058fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105901:	89 04 24             	mov    %eax,(%esp)
80105904:	e8 01 c2 ff ff       	call   80101b0a <iunlockput>

  commit_trans();
80105909:	e8 44 d9 ff ff       	call   80103252 <commit_trans>

  return 0;
8010590e:	b8 00 00 00 00       	mov    $0x0,%eax
80105913:	eb 16                	jmp    8010592b <sys_unlink+0x1d1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105915:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105919:	89 04 24             	mov    %eax,(%esp)
8010591c:	e8 e9 c1 ff ff       	call   80101b0a <iunlockput>
  commit_trans();
80105921:	e8 2c d9 ff ff       	call   80103252 <commit_trans>
  return -1;
80105926:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010592b:	c9                   	leave  
8010592c:	c3                   	ret    

8010592d <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
8010592d:	55                   	push   %ebp
8010592e:	89 e5                	mov    %esp,%ebp
80105930:	83 ec 48             	sub    $0x48,%esp
80105933:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105936:	8b 55 10             	mov    0x10(%ebp),%edx
80105939:	8b 45 14             	mov    0x14(%ebp),%eax
8010593c:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105940:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105944:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105948:	8d 45 de             	lea    -0x22(%ebp),%eax
8010594b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010594f:	8b 45 08             	mov    0x8(%ebp),%eax
80105952:	89 04 24             	mov    %eax,(%esp)
80105955:	e8 e3 ca ff ff       	call   8010243d <nameiparent>
8010595a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010595d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105961:	75 0a                	jne    8010596d <create+0x40>
    return 0;
80105963:	b8 00 00 00 00       	mov    $0x0,%eax
80105968:	e9 7e 01 00 00       	jmp    80105aeb <create+0x1be>
  ilock(dp);
8010596d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105970:	89 04 24             	mov    %eax,(%esp)
80105973:	e8 0b bf ff ff       	call   80101883 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105978:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010597b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010597f:	8d 45 de             	lea    -0x22(%ebp),%eax
80105982:	89 44 24 04          	mov    %eax,0x4(%esp)
80105986:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105989:	89 04 24             	mov    %eax,(%esp)
8010598c:	e8 01 c7 ff ff       	call   80102092 <dirlookup>
80105991:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105994:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105998:	74 47                	je     801059e1 <create+0xb4>
    iunlockput(dp);
8010599a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010599d:	89 04 24             	mov    %eax,(%esp)
801059a0:	e8 65 c1 ff ff       	call   80101b0a <iunlockput>
    ilock(ip);
801059a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059a8:	89 04 24             	mov    %eax,(%esp)
801059ab:	e8 d3 be ff ff       	call   80101883 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801059b0:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801059b5:	75 15                	jne    801059cc <create+0x9f>
801059b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059ba:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801059be:	66 83 f8 02          	cmp    $0x2,%ax
801059c2:	75 08                	jne    801059cc <create+0x9f>
      return ip;
801059c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059c7:	e9 1f 01 00 00       	jmp    80105aeb <create+0x1be>
    iunlockput(ip);
801059cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059cf:	89 04 24             	mov    %eax,(%esp)
801059d2:	e8 33 c1 ff ff       	call   80101b0a <iunlockput>
    return 0;
801059d7:	b8 00 00 00 00       	mov    $0x0,%eax
801059dc:	e9 0a 01 00 00       	jmp    80105aeb <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801059e1:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
801059e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e8:	8b 00                	mov    (%eax),%eax
801059ea:	89 54 24 04          	mov    %edx,0x4(%esp)
801059ee:	89 04 24             	mov    %eax,(%esp)
801059f1:	e8 f0 bb ff ff       	call   801015e6 <ialloc>
801059f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059fd:	75 0c                	jne    80105a0b <create+0xde>
    panic("create: ialloc");
801059ff:	c7 04 24 87 85 10 80 	movl   $0x80108587,(%esp)
80105a06:	e8 2f ab ff ff       	call   8010053a <panic>

  ilock(ip);
80105a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a0e:	89 04 24             	mov    %eax,(%esp)
80105a11:	e8 6d be ff ff       	call   80101883 <ilock>
  ip->major = major;
80105a16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a19:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105a1d:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a24:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105a28:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a2f:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a38:	89 04 24             	mov    %eax,(%esp)
80105a3b:	e8 83 bc ff ff       	call   801016c3 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105a40:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105a45:	75 6a                	jne    80105ab1 <create+0x184>
    dp->nlink++;  // for ".."
80105a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a4a:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a4e:	8d 50 01             	lea    0x1(%eax),%edx
80105a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a54:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a5b:	89 04 24             	mov    %eax,(%esp)
80105a5e:	e8 60 bc ff ff       	call   801016c3 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105a63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a66:	8b 40 04             	mov    0x4(%eax),%eax
80105a69:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a6d:	c7 44 24 04 61 85 10 	movl   $0x80108561,0x4(%esp)
80105a74:	80 
80105a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a78:	89 04 24             	mov    %eax,(%esp)
80105a7b:	e8 da c6 ff ff       	call   8010215a <dirlink>
80105a80:	85 c0                	test   %eax,%eax
80105a82:	78 21                	js     80105aa5 <create+0x178>
80105a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a87:	8b 40 04             	mov    0x4(%eax),%eax
80105a8a:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a8e:	c7 44 24 04 63 85 10 	movl   $0x80108563,0x4(%esp)
80105a95:	80 
80105a96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a99:	89 04 24             	mov    %eax,(%esp)
80105a9c:	e8 b9 c6 ff ff       	call   8010215a <dirlink>
80105aa1:	85 c0                	test   %eax,%eax
80105aa3:	79 0c                	jns    80105ab1 <create+0x184>
      panic("create dots");
80105aa5:	c7 04 24 96 85 10 80 	movl   $0x80108596,(%esp)
80105aac:	e8 89 aa ff ff       	call   8010053a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105ab1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ab4:	8b 40 04             	mov    0x4(%eax),%eax
80105ab7:	89 44 24 08          	mov    %eax,0x8(%esp)
80105abb:	8d 45 de             	lea    -0x22(%ebp),%eax
80105abe:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ac5:	89 04 24             	mov    %eax,(%esp)
80105ac8:	e8 8d c6 ff ff       	call   8010215a <dirlink>
80105acd:	85 c0                	test   %eax,%eax
80105acf:	79 0c                	jns    80105add <create+0x1b0>
    panic("create: dirlink");
80105ad1:	c7 04 24 a2 85 10 80 	movl   $0x801085a2,(%esp)
80105ad8:	e8 5d aa ff ff       	call   8010053a <panic>

  iunlockput(dp);
80105add:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae0:	89 04 24             	mov    %eax,(%esp)
80105ae3:	e8 22 c0 ff ff       	call   80101b0a <iunlockput>

  return ip;
80105ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105aeb:	c9                   	leave  
80105aec:	c3                   	ret    

80105aed <sys_open>:

int
sys_open(void)
{
80105aed:	55                   	push   %ebp
80105aee:	89 e5                	mov    %esp,%ebp
80105af0:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105af3:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105af6:	89 44 24 04          	mov    %eax,0x4(%esp)
80105afa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105b01:	e8 a3 f6 ff ff       	call   801051a9 <argstr>
80105b06:	85 c0                	test   %eax,%eax
80105b08:	78 17                	js     80105b21 <sys_open+0x34>
80105b0a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105b18:	e8 f1 f5 ff ff       	call   8010510e <argint>
80105b1d:	85 c0                	test   %eax,%eax
80105b1f:	79 0a                	jns    80105b2b <sys_open+0x3e>
    return -1;
80105b21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b26:	e9 47 01 00 00       	jmp    80105c72 <sys_open+0x185>
  if(omode & O_CREATE){
80105b2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105b2e:	25 00 02 00 00       	and    $0x200,%eax
80105b33:	85 c0                	test   %eax,%eax
80105b35:	74 40                	je     80105b77 <sys_open+0x8a>
    begin_trans();
80105b37:	e8 cd d6 ff ff       	call   80103209 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105b3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105b3f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105b46:	00 
80105b47:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105b4e:	00 
80105b4f:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80105b56:	00 
80105b57:	89 04 24             	mov    %eax,(%esp)
80105b5a:	e8 ce fd ff ff       	call   8010592d <create>
80105b5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105b62:	e8 eb d6 ff ff       	call   80103252 <commit_trans>
    if(ip == 0)
80105b67:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b6b:	75 5c                	jne    80105bc9 <sys_open+0xdc>
      return -1;
80105b6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b72:	e9 fb 00 00 00       	jmp    80105c72 <sys_open+0x185>
  } else {
    if((ip = namei(path)) == 0)
80105b77:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105b7a:	89 04 24             	mov    %eax,(%esp)
80105b7d:	e8 99 c8 ff ff       	call   8010241b <namei>
80105b82:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b89:	75 0a                	jne    80105b95 <sys_open+0xa8>
      return -1;
80105b8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b90:	e9 dd 00 00 00       	jmp    80105c72 <sys_open+0x185>
    ilock(ip);
80105b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b98:	89 04 24             	mov    %eax,(%esp)
80105b9b:	e8 e3 bc ff ff       	call   80101883 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ba3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ba7:	66 83 f8 01          	cmp    $0x1,%ax
80105bab:	75 1d                	jne    80105bca <sys_open+0xdd>
80105bad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105bb0:	85 c0                	test   %eax,%eax
80105bb2:	74 16                	je     80105bca <sys_open+0xdd>
      iunlockput(ip);
80105bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bb7:	89 04 24             	mov    %eax,(%esp)
80105bba:	e8 4b bf ff ff       	call   80101b0a <iunlockput>
      return -1;
80105bbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc4:	e9 a9 00 00 00       	jmp    80105c72 <sys_open+0x185>
  if(omode & O_CREATE){
    begin_trans();
    ip = create(path, T_FILE, 0, 0);
    commit_trans();
    if(ip == 0)
      return -1;
80105bc9:	90                   	nop
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105bca:	e8 51 b3 ff ff       	call   80100f20 <filealloc>
80105bcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bd2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bd6:	74 14                	je     80105bec <sys_open+0xff>
80105bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bdb:	89 04 24             	mov    %eax,(%esp)
80105bde:	e8 42 f7 ff ff       	call   80105325 <fdalloc>
80105be3:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105be6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105bea:	79 23                	jns    80105c0f <sys_open+0x122>
    if(f)
80105bec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bf0:	74 0b                	je     80105bfd <sys_open+0x110>
      fileclose(f);
80105bf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bf5:	89 04 24             	mov    %eax,(%esp)
80105bf8:	e8 cc b3 ff ff       	call   80100fc9 <fileclose>
    iunlockput(ip);
80105bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c00:	89 04 24             	mov    %eax,(%esp)
80105c03:	e8 02 bf ff ff       	call   80101b0a <iunlockput>
    return -1;
80105c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0d:	eb 63                	jmp    80105c72 <sys_open+0x185>
  }
  iunlock(ip);
80105c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c12:	89 04 24             	mov    %eax,(%esp)
80105c15:	e8 ba bd ff ff       	call   801019d4 <iunlock>

  f->type = FD_INODE;
80105c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c1d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105c23:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c26:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c29:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105c2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c2f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105c36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c39:	83 e0 01             	and    $0x1,%eax
80105c3c:	85 c0                	test   %eax,%eax
80105c3e:	0f 94 c2             	sete   %dl
80105c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c44:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c4a:	83 e0 01             	and    $0x1,%eax
80105c4d:	84 c0                	test   %al,%al
80105c4f:	75 0a                	jne    80105c5b <sys_open+0x16e>
80105c51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c54:	83 e0 02             	and    $0x2,%eax
80105c57:	85 c0                	test   %eax,%eax
80105c59:	74 07                	je     80105c62 <sys_open+0x175>
80105c5b:	b8 01 00 00 00       	mov    $0x1,%eax
80105c60:	eb 05                	jmp    80105c67 <sys_open+0x17a>
80105c62:	b8 00 00 00 00       	mov    $0x0,%eax
80105c67:	89 c2                	mov    %eax,%edx
80105c69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c6c:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105c6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105c72:	c9                   	leave  
80105c73:	c3                   	ret    

80105c74 <sys_mkdir>:

int
sys_mkdir(void)
{
80105c74:	55                   	push   %ebp
80105c75:	89 e5                	mov    %esp,%ebp
80105c77:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105c7a:	e8 8a d5 ff ff       	call   80103209 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c7f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c82:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c86:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105c8d:	e8 17 f5 ff ff       	call   801051a9 <argstr>
80105c92:	85 c0                	test   %eax,%eax
80105c94:	78 2c                	js     80105cc2 <sys_mkdir+0x4e>
80105c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c99:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105ca0:	00 
80105ca1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105ca8:	00 
80105ca9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80105cb0:	00 
80105cb1:	89 04 24             	mov    %eax,(%esp)
80105cb4:	e8 74 fc ff ff       	call   8010592d <create>
80105cb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105cbc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105cc0:	75 0c                	jne    80105cce <sys_mkdir+0x5a>
    commit_trans();
80105cc2:	e8 8b d5 ff ff       	call   80103252 <commit_trans>
    return -1;
80105cc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ccc:	eb 15                	jmp    80105ce3 <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80105cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd1:	89 04 24             	mov    %eax,(%esp)
80105cd4:	e8 31 be ff ff       	call   80101b0a <iunlockput>
  commit_trans();
80105cd9:	e8 74 d5 ff ff       	call   80103252 <commit_trans>
  return 0;
80105cde:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105ce3:	c9                   	leave  
80105ce4:	c3                   	ret    

80105ce5 <sys_mknod>:

int
sys_mknod(void)
{
80105ce5:	55                   	push   %ebp
80105ce6:	89 e5                	mov    %esp,%ebp
80105ce8:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105ceb:	e8 19 d5 ff ff       	call   80103209 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105cf0:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105cf3:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cf7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105cfe:	e8 a6 f4 ff ff       	call   801051a9 <argstr>
80105d03:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d0a:	78 5e                	js     80105d6a <sys_mknod+0x85>
     argint(1, &major) < 0 ||
80105d0c:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105d1a:	e8 ef f3 ff ff       	call   8010510e <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105d1f:	85 c0                	test   %eax,%eax
80105d21:	78 47                	js     80105d6a <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105d23:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d26:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d2a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105d31:	e8 d8 f3 ff ff       	call   8010510e <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105d36:	85 c0                	test   %eax,%eax
80105d38:	78 30                	js     80105d6a <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d3d:	0f bf c8             	movswl %ax,%ecx
80105d40:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d43:	0f bf d0             	movswl %ax,%edx
80105d46:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105d49:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80105d4d:	89 54 24 08          	mov    %edx,0x8(%esp)
80105d51:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80105d58:	00 
80105d59:	89 04 24             	mov    %eax,(%esp)
80105d5c:	e8 cc fb ff ff       	call   8010592d <create>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105d61:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d64:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d68:	75 0c                	jne    80105d76 <sys_mknod+0x91>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105d6a:	e8 e3 d4 ff ff       	call   80103252 <commit_trans>
    return -1;
80105d6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d74:	eb 15                	jmp    80105d8b <sys_mknod+0xa6>
  }
  iunlockput(ip);
80105d76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d79:	89 04 24             	mov    %eax,(%esp)
80105d7c:	e8 89 bd ff ff       	call   80101b0a <iunlockput>
  commit_trans();
80105d81:	e8 cc d4 ff ff       	call   80103252 <commit_trans>
  return 0;
80105d86:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105d8b:	c9                   	leave  
80105d8c:	c3                   	ret    

80105d8d <sys_chdir>:

int
sys_chdir(void)
{
80105d8d:	55                   	push   %ebp
80105d8e:	89 e5                	mov    %esp,%ebp
80105d90:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105d93:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d96:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d9a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105da1:	e8 03 f4 ff ff       	call   801051a9 <argstr>
80105da6:	85 c0                	test   %eax,%eax
80105da8:	78 14                	js     80105dbe <sys_chdir+0x31>
80105daa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dad:	89 04 24             	mov    %eax,(%esp)
80105db0:	e8 66 c6 ff ff       	call   8010241b <namei>
80105db5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105db8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105dbc:	75 07                	jne    80105dc5 <sys_chdir+0x38>
    return -1;
80105dbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dc3:	eb 57                	jmp    80105e1c <sys_chdir+0x8f>
  ilock(ip);
80105dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dc8:	89 04 24             	mov    %eax,(%esp)
80105dcb:	e8 b3 ba ff ff       	call   80101883 <ilock>
  if(ip->type != T_DIR){
80105dd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105dd7:	66 83 f8 01          	cmp    $0x1,%ax
80105ddb:	74 12                	je     80105def <sys_chdir+0x62>
    iunlockput(ip);
80105ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de0:	89 04 24             	mov    %eax,(%esp)
80105de3:	e8 22 bd ff ff       	call   80101b0a <iunlockput>
    return -1;
80105de8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ded:	eb 2d                	jmp    80105e1c <sys_chdir+0x8f>
  }
  iunlock(ip);
80105def:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df2:	89 04 24             	mov    %eax,(%esp)
80105df5:	e8 da bb ff ff       	call   801019d4 <iunlock>
  iput(proc->cwd);
80105dfa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e00:	8b 40 68             	mov    0x68(%eax),%eax
80105e03:	89 04 24             	mov    %eax,(%esp)
80105e06:	e8 2e bc ff ff       	call   80101a39 <iput>
  proc->cwd = ip;
80105e0b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e11:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e14:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80105e17:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105e1c:	c9                   	leave  
80105e1d:	c3                   	ret    

80105e1e <sys_exec>:

int
sys_exec(void)
{
80105e1e:	55                   	push   %ebp
80105e1f:	89 e5                	mov    %esp,%ebp
80105e21:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e27:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e2a:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e2e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105e35:	e8 6f f3 ff ff       	call   801051a9 <argstr>
80105e3a:	85 c0                	test   %eax,%eax
80105e3c:	78 1a                	js     80105e58 <sys_exec+0x3a>
80105e3e:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80105e44:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105e4f:	e8 ba f2 ff ff       	call   8010510e <argint>
80105e54:	85 c0                	test   %eax,%eax
80105e56:	79 0a                	jns    80105e62 <sys_exec+0x44>
    return -1;
80105e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e5d:	e9 e0 00 00 00       	jmp    80105f42 <sys_exec+0x124>
  }
  memset(argv, 0, sizeof(argv));
80105e62:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105e69:	00 
80105e6a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105e71:	00 
80105e72:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105e78:	89 04 24             	mov    %eax,(%esp)
80105e7b:	e8 3e ef ff ff       	call   80104dbe <memset>
  for(i=0;; i++){
80105e80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80105e87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e8a:	83 f8 1f             	cmp    $0x1f,%eax
80105e8d:	76 0a                	jbe    80105e99 <sys_exec+0x7b>
      return -1;
80105e8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e94:	e9 a9 00 00 00       	jmp    80105f42 <sys_exec+0x124>
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
80105e99:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
80105e9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ea2:	c1 e0 02             	shl    $0x2,%eax
80105ea5:	89 c1                	mov    %eax,%ecx
80105ea7:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80105ead:	01 c1                	add    %eax,%ecx
80105eaf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105eb5:	89 54 24 08          	mov    %edx,0x8(%esp)
80105eb9:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105ebd:	89 04 24             	mov    %eax,(%esp)
80105ec0:	e8 b7 f1 ff ff       	call   8010507c <fetchint>
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	79 07                	jns    80105ed0 <sys_exec+0xb2>
      return -1;
80105ec9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ece:	eb 72                	jmp    80105f42 <sys_exec+0x124>
    if(uarg == 0){
80105ed0:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105ed6:	85 c0                	test   %eax,%eax
80105ed8:	75 25                	jne    80105eff <sys_exec+0xe1>
      argv[i] = 0;
80105eda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105edd:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80105ee4:	00 00 00 00 
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105ee8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eeb:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80105ef1:	89 54 24 04          	mov    %edx,0x4(%esp)
80105ef5:	89 04 24             	mov    %eax,(%esp)
80105ef8:	e8 ff ab ff ff       	call   80100afc <exec>
80105efd:	eb 43                	jmp    80105f42 <sys_exec+0x124>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
80105eff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f02:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105f09:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105f0f:	01 d0                	add    %edx,%eax
80105f11:	8b 8d 68 ff ff ff    	mov    -0x98(%ebp),%ecx
80105f17:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105f1e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f22:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105f26:	89 14 24             	mov    %edx,(%esp)
80105f29:	e8 82 f1 ff ff       	call   801050b0 <fetchstr>
80105f2e:	85 c0                	test   %eax,%eax
80105f30:	79 07                	jns    80105f39 <sys_exec+0x11b>
      return -1;
80105f32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f37:	eb 09                	jmp    80105f42 <sys_exec+0x124>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105f39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
80105f3d:	e9 45 ff ff ff       	jmp    80105e87 <sys_exec+0x69>
  return exec(path, argv);
}
80105f42:	c9                   	leave  
80105f43:	c3                   	ret    

80105f44 <sys_pipe>:

int
sys_pipe(void)
{
80105f44:	55                   	push   %ebp
80105f45:	89 e5                	mov    %esp,%ebp
80105f47:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f4a:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f4d:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105f54:	00 
80105f55:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105f60:	e8 e2 f1 ff ff       	call   80105147 <argptr>
80105f65:	85 c0                	test   %eax,%eax
80105f67:	79 0a                	jns    80105f73 <sys_pipe+0x2f>
    return -1;
80105f69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6e:	e9 9b 00 00 00       	jmp    8010600e <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80105f73:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f76:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f7a:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f7d:	89 04 24             	mov    %eax,(%esp)
80105f80:	e8 8b dc ff ff       	call   80103c10 <pipealloc>
80105f85:	85 c0                	test   %eax,%eax
80105f87:	79 07                	jns    80105f90 <sys_pipe+0x4c>
    return -1;
80105f89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f8e:	eb 7e                	jmp    8010600e <sys_pipe+0xca>
  fd0 = -1;
80105f90:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f97:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f9a:	89 04 24             	mov    %eax,(%esp)
80105f9d:	e8 83 f3 ff ff       	call   80105325 <fdalloc>
80105fa2:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105fa5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fa9:	78 14                	js     80105fbf <sys_pipe+0x7b>
80105fab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fae:	89 04 24             	mov    %eax,(%esp)
80105fb1:	e8 6f f3 ff ff       	call   80105325 <fdalloc>
80105fb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fb9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fbd:	79 37                	jns    80105ff6 <sys_pipe+0xb2>
    if(fd0 >= 0)
80105fbf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105fc3:	78 14                	js     80105fd9 <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
80105fc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105fcb:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105fce:	83 c2 08             	add    $0x8,%edx
80105fd1:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105fd8:	00 
    fileclose(rf);
80105fd9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fdc:	89 04 24             	mov    %eax,(%esp)
80105fdf:	e8 e5 af ff ff       	call   80100fc9 <fileclose>
    fileclose(wf);
80105fe4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fe7:	89 04 24             	mov    %eax,(%esp)
80105fea:	e8 da af ff ff       	call   80100fc9 <fileclose>
    return -1;
80105fef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ff4:	eb 18                	jmp    8010600e <sys_pipe+0xca>
  }
  fd[0] = fd0;
80105ff6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ff9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105ffc:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80105ffe:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106001:	8d 50 04             	lea    0x4(%eax),%edx
80106004:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106007:	89 02                	mov    %eax,(%edx)
  return 0;
80106009:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010600e:	c9                   	leave  
8010600f:	c3                   	ret    

80106010 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106016:	e8 ac e2 ff ff       	call   801042c7 <fork>
}
8010601b:	c9                   	leave  
8010601c:	c3                   	ret    

8010601d <sys_exit>:

int
sys_exit(void)
{
8010601d:	55                   	push   %ebp
8010601e:	89 e5                	mov    %esp,%ebp
80106020:	83 ec 08             	sub    $0x8,%esp
  exit();
80106023:	e8 02 e4 ff ff       	call   8010442a <exit>
  return 0;  // not reached
80106028:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010602d:	c9                   	leave  
8010602e:	c3                   	ret    

8010602f <sys_wait>:

int
sys_wait(void)
{
8010602f:	55                   	push   %ebp
80106030:	89 e5                	mov    %esp,%ebp
80106032:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106035:	e8 09 e5 ff ff       	call   80104543 <wait>
}
8010603a:	c9                   	leave  
8010603b:	c3                   	ret    

8010603c <sys_kill>:

int
sys_kill(void)
{
8010603c:	55                   	push   %ebp
8010603d:	89 e5                	mov    %esp,%ebp
8010603f:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106042:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106045:	89 44 24 04          	mov    %eax,0x4(%esp)
80106049:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106050:	e8 b9 f0 ff ff       	call   8010510e <argint>
80106055:	85 c0                	test   %eax,%eax
80106057:	79 07                	jns    80106060 <sys_kill+0x24>
    return -1;
80106059:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010605e:	eb 0b                	jmp    8010606b <sys_kill+0x2f>
  return kill(pid);
80106060:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106063:	89 04 24             	mov    %eax,(%esp)
80106066:	e8 37 e9 ff ff       	call   801049a2 <kill>
}
8010606b:	c9                   	leave  
8010606c:	c3                   	ret    

8010606d <sys_getpid>:

int
sys_getpid(void)
{
8010606d:	55                   	push   %ebp
8010606e:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106070:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106076:	8b 40 10             	mov    0x10(%eax),%eax
}
80106079:	5d                   	pop    %ebp
8010607a:	c3                   	ret    

8010607b <sys_sbrk>:

int
sys_sbrk(void)
{
8010607b:	55                   	push   %ebp
8010607c:	89 e5                	mov    %esp,%ebp
8010607e:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106081:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106084:	89 44 24 04          	mov    %eax,0x4(%esp)
80106088:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010608f:	e8 7a f0 ff ff       	call   8010510e <argint>
80106094:	85 c0                	test   %eax,%eax
80106096:	79 07                	jns    8010609f <sys_sbrk+0x24>
    return -1;
80106098:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010609d:	eb 24                	jmp    801060c3 <sys_sbrk+0x48>
  addr = proc->sz;
8010609f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060a5:	8b 00                	mov    (%eax),%eax
801060a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801060aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060ad:	89 04 24             	mov    %eax,(%esp)
801060b0:	e8 6c e1 ff ff       	call   80104221 <growproc>
801060b5:	85 c0                	test   %eax,%eax
801060b7:	79 07                	jns    801060c0 <sys_sbrk+0x45>
    return -1;
801060b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060be:	eb 03                	jmp    801060c3 <sys_sbrk+0x48>
  return addr;
801060c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801060c3:	c9                   	leave  
801060c4:	c3                   	ret    

801060c5 <sys_sleep>:

int
sys_sleep(void)
{
801060c5:	55                   	push   %ebp
801060c6:	89 e5                	mov    %esp,%ebp
801060c8:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
801060cb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060ce:	89 44 24 04          	mov    %eax,0x4(%esp)
801060d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060d9:	e8 30 f0 ff ff       	call   8010510e <argint>
801060de:	85 c0                	test   %eax,%eax
801060e0:	79 07                	jns    801060e9 <sys_sleep+0x24>
    return -1;
801060e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060e7:	eb 6c                	jmp    80106155 <sys_sleep+0x90>
  acquire(&tickslock);
801060e9:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
801060f0:	e8 7a ea ff ff       	call   80104b6f <acquire>
  ticks0 = ticks;
801060f5:	a1 a0 26 11 80       	mov    0x801126a0,%eax
801060fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801060fd:	eb 34                	jmp    80106133 <sys_sleep+0x6e>
    if(proc->killed){
801060ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106105:	8b 40 24             	mov    0x24(%eax),%eax
80106108:	85 c0                	test   %eax,%eax
8010610a:	74 13                	je     8010611f <sys_sleep+0x5a>
      release(&tickslock);
8010610c:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80106113:	e8 b8 ea ff ff       	call   80104bd0 <release>
      return -1;
80106118:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010611d:	eb 36                	jmp    80106155 <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
8010611f:	c7 44 24 04 60 1e 11 	movl   $0x80111e60,0x4(%esp)
80106126:	80 
80106127:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
8010612e:	e8 6a e7 ff ff       	call   8010489d <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106133:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80106138:	89 c2                	mov    %eax,%edx
8010613a:	2b 55 f4             	sub    -0xc(%ebp),%edx
8010613d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106140:	39 c2                	cmp    %eax,%edx
80106142:	72 bb                	jb     801060ff <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106144:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
8010614b:	e8 80 ea ff ff       	call   80104bd0 <release>
  return 0;
80106150:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106155:	c9                   	leave  
80106156:	c3                   	ret    

80106157 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106157:	55                   	push   %ebp
80106158:	89 e5                	mov    %esp,%ebp
8010615a:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
8010615d:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80106164:	e8 06 ea ff ff       	call   80104b6f <acquire>
  xticks = ticks;
80106169:	a1 a0 26 11 80       	mov    0x801126a0,%eax
8010616e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106171:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80106178:	e8 53 ea ff ff       	call   80104bd0 <release>
  return xticks;
8010617d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106180:	c9                   	leave  
80106181:	c3                   	ret    
	...

80106184 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106184:	55                   	push   %ebp
80106185:	89 e5                	mov    %esp,%ebp
80106187:	83 ec 08             	sub    $0x8,%esp
8010618a:	8b 55 08             	mov    0x8(%ebp),%edx
8010618d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106190:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106194:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106197:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010619b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010619f:	ee                   	out    %al,(%dx)
}
801061a0:	c9                   	leave  
801061a1:	c3                   	ret    

801061a2 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801061a2:	55                   	push   %ebp
801061a3:	89 e5                	mov    %esp,%ebp
801061a5:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801061a8:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
801061af:	00 
801061b0:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
801061b7:	e8 c8 ff ff ff       	call   80106184 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801061bc:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
801061c3:	00 
801061c4:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801061cb:	e8 b4 ff ff ff       	call   80106184 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801061d0:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
801061d7:	00 
801061d8:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
801061df:	e8 a0 ff ff ff       	call   80106184 <outb>
  picenable(IRQ_TIMER);
801061e4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061eb:	e8 a9 d8 ff ff       	call   80103a99 <picenable>
}
801061f0:	c9                   	leave  
801061f1:	c3                   	ret    
	...

801061f4 <alltraps>:
801061f4:	1e                   	push   %ds
801061f5:	06                   	push   %es
801061f6:	0f a0                	push   %fs
801061f8:	0f a8                	push   %gs
801061fa:	60                   	pusha  
801061fb:	66 b8 10 00          	mov    $0x10,%ax
801061ff:	8e d8                	mov    %eax,%ds
80106201:	8e c0                	mov    %eax,%es
80106203:	66 b8 18 00          	mov    $0x18,%ax
80106207:	8e e0                	mov    %eax,%fs
80106209:	8e e8                	mov    %eax,%gs
8010620b:	54                   	push   %esp
8010620c:	e8 d5 01 00 00       	call   801063e6 <trap>
80106211:	83 c4 04             	add    $0x4,%esp

80106214 <trapret>:
80106214:	61                   	popa   
80106215:	0f a9                	pop    %gs
80106217:	0f a1                	pop    %fs
80106219:	07                   	pop    %es
8010621a:	1f                   	pop    %ds
8010621b:	83 c4 08             	add    $0x8,%esp
8010621e:	cf                   	iret   
	...

80106220 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106226:	8b 45 0c             	mov    0xc(%ebp),%eax
80106229:	83 e8 01             	sub    $0x1,%eax
8010622c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106230:	8b 45 08             	mov    0x8(%ebp),%eax
80106233:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106237:	8b 45 08             	mov    0x8(%ebp),%eax
8010623a:	c1 e8 10             	shr    $0x10,%eax
8010623d:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106241:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106244:	0f 01 18             	lidtl  (%eax)
}
80106247:	c9                   	leave  
80106248:	c3                   	ret    

80106249 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106249:	55                   	push   %ebp
8010624a:	89 e5                	mov    %esp,%ebp
8010624c:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010624f:	0f 20 d0             	mov    %cr2,%eax
80106252:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106255:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106258:	c9                   	leave  
80106259:	c3                   	ret    

8010625a <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010625a:	55                   	push   %ebp
8010625b:	89 e5                	mov    %esp,%ebp
8010625d:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
80106260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106267:	e9 bf 00 00 00       	jmp    8010632b <tvinit+0xd1>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010626c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010626f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106272:	8b 14 95 98 b0 10 80 	mov    -0x7fef4f68(,%edx,4),%edx
80106279:	66 89 14 c5 a0 1e 11 	mov    %dx,-0x7feee160(,%eax,8)
80106280:	80 
80106281:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106284:	66 c7 04 c5 a2 1e 11 	movw   $0x8,-0x7feee15e(,%eax,8)
8010628b:	80 08 00 
8010628e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106291:	0f b6 14 c5 a4 1e 11 	movzbl -0x7feee15c(,%eax,8),%edx
80106298:	80 
80106299:	83 e2 e0             	and    $0xffffffe0,%edx
8010629c:	88 14 c5 a4 1e 11 80 	mov    %dl,-0x7feee15c(,%eax,8)
801062a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a6:	0f b6 14 c5 a4 1e 11 	movzbl -0x7feee15c(,%eax,8),%edx
801062ad:	80 
801062ae:	83 e2 1f             	and    $0x1f,%edx
801062b1:	88 14 c5 a4 1e 11 80 	mov    %dl,-0x7feee15c(,%eax,8)
801062b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062bb:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
801062c2:	80 
801062c3:	83 e2 f0             	and    $0xfffffff0,%edx
801062c6:	83 ca 0e             	or     $0xe,%edx
801062c9:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
801062d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d3:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
801062da:	80 
801062db:	83 e2 ef             	and    $0xffffffef,%edx
801062de:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
801062e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e8:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
801062ef:	80 
801062f0:	83 e2 9f             	and    $0xffffff9f,%edx
801062f3:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
801062fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062fd:	0f b6 14 c5 a5 1e 11 	movzbl -0x7feee15b(,%eax,8),%edx
80106304:	80 
80106305:	83 ca 80             	or     $0xffffff80,%edx
80106308:	88 14 c5 a5 1e 11 80 	mov    %dl,-0x7feee15b(,%eax,8)
8010630f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106312:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106315:	8b 14 95 98 b0 10 80 	mov    -0x7fef4f68(,%edx,4),%edx
8010631c:	c1 ea 10             	shr    $0x10,%edx
8010631f:	66 89 14 c5 a6 1e 11 	mov    %dx,-0x7feee15a(,%eax,8)
80106326:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106327:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010632b:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106332:	0f 8e 34 ff ff ff    	jle    8010626c <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106338:	a1 98 b1 10 80       	mov    0x8010b198,%eax
8010633d:	66 a3 a0 20 11 80    	mov    %ax,0x801120a0
80106343:	66 c7 05 a2 20 11 80 	movw   $0x8,0x801120a2
8010634a:	08 00 
8010634c:	0f b6 05 a4 20 11 80 	movzbl 0x801120a4,%eax
80106353:	83 e0 e0             	and    $0xffffffe0,%eax
80106356:	a2 a4 20 11 80       	mov    %al,0x801120a4
8010635b:	0f b6 05 a4 20 11 80 	movzbl 0x801120a4,%eax
80106362:	83 e0 1f             	and    $0x1f,%eax
80106365:	a2 a4 20 11 80       	mov    %al,0x801120a4
8010636a:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
80106371:	83 c8 0f             	or     $0xf,%eax
80106374:	a2 a5 20 11 80       	mov    %al,0x801120a5
80106379:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
80106380:	83 e0 ef             	and    $0xffffffef,%eax
80106383:	a2 a5 20 11 80       	mov    %al,0x801120a5
80106388:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
8010638f:	83 c8 60             	or     $0x60,%eax
80106392:	a2 a5 20 11 80       	mov    %al,0x801120a5
80106397:	0f b6 05 a5 20 11 80 	movzbl 0x801120a5,%eax
8010639e:	83 c8 80             	or     $0xffffff80,%eax
801063a1:	a2 a5 20 11 80       	mov    %al,0x801120a5
801063a6:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801063ab:	c1 e8 10             	shr    $0x10,%eax
801063ae:	66 a3 a6 20 11 80    	mov    %ax,0x801120a6
  
  initlock(&tickslock, "time");
801063b4:	c7 44 24 04 b4 85 10 	movl   $0x801085b4,0x4(%esp)
801063bb:	80 
801063bc:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
801063c3:	e8 86 e7 ff ff       	call   80104b4e <initlock>
}
801063c8:	c9                   	leave  
801063c9:	c3                   	ret    

801063ca <idtinit>:

void
idtinit(void)
{
801063ca:	55                   	push   %ebp
801063cb:	89 e5                	mov    %esp,%ebp
801063cd:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
801063d0:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
801063d7:	00 
801063d8:	c7 04 24 a0 1e 11 80 	movl   $0x80111ea0,(%esp)
801063df:	e8 3c fe ff ff       	call   80106220 <lidt>
}
801063e4:	c9                   	leave  
801063e5:	c3                   	ret    

801063e6 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801063e6:	55                   	push   %ebp
801063e7:	89 e5                	mov    %esp,%ebp
801063e9:	57                   	push   %edi
801063ea:	56                   	push   %esi
801063eb:	53                   	push   %ebx
801063ec:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
801063ef:	8b 45 08             	mov    0x8(%ebp),%eax
801063f2:	8b 40 30             	mov    0x30(%eax),%eax
801063f5:	83 f8 40             	cmp    $0x40,%eax
801063f8:	75 3e                	jne    80106438 <trap+0x52>
    if(proc->killed)
801063fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106400:	8b 40 24             	mov    0x24(%eax),%eax
80106403:	85 c0                	test   %eax,%eax
80106405:	74 05                	je     8010640c <trap+0x26>
      exit();
80106407:	e8 1e e0 ff ff       	call   8010442a <exit>
    proc->tf = tf;
8010640c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106412:	8b 55 08             	mov    0x8(%ebp),%edx
80106415:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106418:	e8 cf ed ff ff       	call   801051ec <syscall>
    if(proc->killed)
8010641d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106423:	8b 40 24             	mov    0x24(%eax),%eax
80106426:	85 c0                	test   %eax,%eax
80106428:	0f 84 34 02 00 00    	je     80106662 <trap+0x27c>
      exit();
8010642e:	e8 f7 df ff ff       	call   8010442a <exit>
    return;
80106433:	e9 2b 02 00 00       	jmp    80106663 <trap+0x27d>
  }

  switch(tf->trapno){
80106438:	8b 45 08             	mov    0x8(%ebp),%eax
8010643b:	8b 40 30             	mov    0x30(%eax),%eax
8010643e:	83 e8 20             	sub    $0x20,%eax
80106441:	83 f8 1f             	cmp    $0x1f,%eax
80106444:	0f 87 bc 00 00 00    	ja     80106506 <trap+0x120>
8010644a:	8b 04 85 5c 86 10 80 	mov    -0x7fef79a4(,%eax,4),%eax
80106451:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106453:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106459:	0f b6 00             	movzbl (%eax),%eax
8010645c:	84 c0                	test   %al,%al
8010645e:	75 31                	jne    80106491 <trap+0xab>
      acquire(&tickslock);
80106460:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80106467:	e8 03 e7 ff ff       	call   80104b6f <acquire>
      ticks++;
8010646c:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80106471:	83 c0 01             	add    $0x1,%eax
80106474:	a3 a0 26 11 80       	mov    %eax,0x801126a0
      wakeup(&ticks);
80106479:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80106480:	e8 f2 e4 ff ff       	call   80104977 <wakeup>
      release(&tickslock);
80106485:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
8010648c:	e8 3f e7 ff ff       	call   80104bd0 <release>
    }
    lapiceoi();
80106491:	e8 42 ca ff ff       	call   80102ed8 <lapiceoi>
    break;
80106496:	e9 41 01 00 00       	jmp    801065dc <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010649b:	e8 53 c2 ff ff       	call   801026f3 <ideintr>
    lapiceoi();
801064a0:	e8 33 ca ff ff       	call   80102ed8 <lapiceoi>
    break;
801064a5:	e9 32 01 00 00       	jmp    801065dc <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801064aa:	e8 0c c8 ff ff       	call   80102cbb <kbdintr>
    lapiceoi();
801064af:	e8 24 ca ff ff       	call   80102ed8 <lapiceoi>
    break;
801064b4:	e9 23 01 00 00       	jmp    801065dc <trap+0x1f6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801064b9:	e8 9d 03 00 00       	call   8010685b <uartintr>
    lapiceoi();
801064be:	e8 15 ca ff ff       	call   80102ed8 <lapiceoi>
    break;
801064c3:	e9 14 01 00 00       	jmp    801065dc <trap+0x1f6>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801064c8:	8b 45 08             	mov    0x8(%ebp),%eax
801064cb:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801064ce:	8b 45 08             	mov    0x8(%ebp),%eax
801064d1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801064d5:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
801064d8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801064de:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801064e1:	0f b6 c0             	movzbl %al,%eax
801064e4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801064e8:	89 54 24 08          	mov    %edx,0x8(%esp)
801064ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801064f0:	c7 04 24 bc 85 10 80 	movl   $0x801085bc,(%esp)
801064f7:	e8 9e 9e ff ff       	call   8010039a <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
801064fc:	e8 d7 c9 ff ff       	call   80102ed8 <lapiceoi>
    break;
80106501:	e9 d6 00 00 00       	jmp    801065dc <trap+0x1f6>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106506:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010650c:	85 c0                	test   %eax,%eax
8010650e:	74 11                	je     80106521 <trap+0x13b>
80106510:	8b 45 08             	mov    0x8(%ebp),%eax
80106513:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106517:	0f b7 c0             	movzwl %ax,%eax
8010651a:	83 e0 03             	and    $0x3,%eax
8010651d:	85 c0                	test   %eax,%eax
8010651f:	75 46                	jne    80106567 <trap+0x181>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106521:	e8 23 fd ff ff       	call   80106249 <rcr2>
80106526:	8b 55 08             	mov    0x8(%ebp),%edx
80106529:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010652c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106533:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106536:	0f b6 ca             	movzbl %dl,%ecx
80106539:	8b 55 08             	mov    0x8(%ebp),%edx
8010653c:	8b 52 30             	mov    0x30(%edx),%edx
8010653f:	89 44 24 10          	mov    %eax,0x10(%esp)
80106543:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80106547:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010654b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010654f:	c7 04 24 e0 85 10 80 	movl   $0x801085e0,(%esp)
80106556:	e8 3f 9e ff ff       	call   8010039a <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
8010655b:	c7 04 24 12 86 10 80 	movl   $0x80108612,(%esp)
80106562:	e8 d3 9f ff ff       	call   8010053a <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106567:	e8 dd fc ff ff       	call   80106249 <rcr2>
8010656c:	89 c2                	mov    %eax,%edx
8010656e:	8b 45 08             	mov    0x8(%ebp),%eax
80106571:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106574:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010657a:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010657d:	0f b6 f0             	movzbl %al,%esi
80106580:	8b 45 08             	mov    0x8(%ebp),%eax
80106583:	8b 58 34             	mov    0x34(%eax),%ebx
80106586:	8b 45 08             	mov    0x8(%ebp),%eax
80106589:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010658c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106592:	83 c0 6c             	add    $0x6c,%eax
80106595:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106598:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010659e:	8b 40 10             	mov    0x10(%eax),%eax
801065a1:	89 54 24 1c          	mov    %edx,0x1c(%esp)
801065a5:	89 7c 24 18          	mov    %edi,0x18(%esp)
801065a9:	89 74 24 14          	mov    %esi,0x14(%esp)
801065ad:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801065b1:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801065b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801065b8:	89 54 24 08          	mov    %edx,0x8(%esp)
801065bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801065c0:	c7 04 24 18 86 10 80 	movl   $0x80108618,(%esp)
801065c7:	e8 ce 9d ff ff       	call   8010039a <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
801065cc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065d2:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801065d9:	eb 01                	jmp    801065dc <trap+0x1f6>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
801065db:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801065dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065e2:	85 c0                	test   %eax,%eax
801065e4:	74 24                	je     8010660a <trap+0x224>
801065e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ec:	8b 40 24             	mov    0x24(%eax),%eax
801065ef:	85 c0                	test   %eax,%eax
801065f1:	74 17                	je     8010660a <trap+0x224>
801065f3:	8b 45 08             	mov    0x8(%ebp),%eax
801065f6:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801065fa:	0f b7 c0             	movzwl %ax,%eax
801065fd:	83 e0 03             	and    $0x3,%eax
80106600:	83 f8 03             	cmp    $0x3,%eax
80106603:	75 05                	jne    8010660a <trap+0x224>
    exit();
80106605:	e8 20 de ff ff       	call   8010442a <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
8010660a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106610:	85 c0                	test   %eax,%eax
80106612:	74 1e                	je     80106632 <trap+0x24c>
80106614:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010661a:	8b 40 0c             	mov    0xc(%eax),%eax
8010661d:	83 f8 04             	cmp    $0x4,%eax
80106620:	75 10                	jne    80106632 <trap+0x24c>
80106622:	8b 45 08             	mov    0x8(%ebp),%eax
80106625:	8b 40 30             	mov    0x30(%eax),%eax
80106628:	83 f8 20             	cmp    $0x20,%eax
8010662b:	75 05                	jne    80106632 <trap+0x24c>
    yield();
8010662d:	e8 0d e2 ff ff       	call   8010483f <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106632:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106638:	85 c0                	test   %eax,%eax
8010663a:	74 27                	je     80106663 <trap+0x27d>
8010663c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106642:	8b 40 24             	mov    0x24(%eax),%eax
80106645:	85 c0                	test   %eax,%eax
80106647:	74 1a                	je     80106663 <trap+0x27d>
80106649:	8b 45 08             	mov    0x8(%ebp),%eax
8010664c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106650:	0f b7 c0             	movzwl %ax,%eax
80106653:	83 e0 03             	and    $0x3,%eax
80106656:	83 f8 03             	cmp    $0x3,%eax
80106659:	75 08                	jne    80106663 <trap+0x27d>
    exit();
8010665b:	e8 ca dd ff ff       	call   8010442a <exit>
80106660:	eb 01                	jmp    80106663 <trap+0x27d>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106662:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106663:	83 c4 3c             	add    $0x3c,%esp
80106666:	5b                   	pop    %ebx
80106667:	5e                   	pop    %esi
80106668:	5f                   	pop    %edi
80106669:	5d                   	pop    %ebp
8010666a:	c3                   	ret    
	...

8010666c <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010666c:	55                   	push   %ebp
8010666d:	89 e5                	mov    %esp,%ebp
8010666f:	83 ec 14             	sub    $0x14,%esp
80106672:	8b 45 08             	mov    0x8(%ebp),%eax
80106675:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106679:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010667d:	89 c2                	mov    %eax,%edx
8010667f:	ec                   	in     (%dx),%al
80106680:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106683:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106687:	c9                   	leave  
80106688:	c3                   	ret    

80106689 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106689:	55                   	push   %ebp
8010668a:	89 e5                	mov    %esp,%ebp
8010668c:	83 ec 08             	sub    $0x8,%esp
8010668f:	8b 55 08             	mov    0x8(%ebp),%edx
80106692:	8b 45 0c             	mov    0xc(%ebp),%eax
80106695:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106699:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010669c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801066a0:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801066a4:	ee                   	out    %al,(%dx)
}
801066a5:	c9                   	leave  
801066a6:	c3                   	ret    

801066a7 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801066a7:	55                   	push   %ebp
801066a8:	89 e5                	mov    %esp,%ebp
801066aa:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801066ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801066b4:	00 
801066b5:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
801066bc:	e8 c8 ff ff ff       	call   80106689 <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801066c1:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
801066c8:	00 
801066c9:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
801066d0:	e8 b4 ff ff ff       	call   80106689 <outb>
  outb(COM1+0, 115200/9600);
801066d5:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
801066dc:	00 
801066dd:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
801066e4:	e8 a0 ff ff ff       	call   80106689 <outb>
  outb(COM1+1, 0);
801066e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801066f0:	00 
801066f1:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
801066f8:	e8 8c ff ff ff       	call   80106689 <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801066fd:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106704:	00 
80106705:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
8010670c:	e8 78 ff ff ff       	call   80106689 <outb>
  outb(COM1+4, 0);
80106711:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106718:	00 
80106719:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106720:	e8 64 ff ff ff       	call   80106689 <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106725:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
8010672c:	00 
8010672d:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106734:	e8 50 ff ff ff       	call   80106689 <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106739:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106740:	e8 27 ff ff ff       	call   8010666c <inb>
80106745:	3c ff                	cmp    $0xff,%al
80106747:	74 6c                	je     801067b5 <uartinit+0x10e>
    return;
  uart = 1;
80106749:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106750:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106753:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
8010675a:	e8 0d ff ff ff       	call   8010666c <inb>
  inb(COM1+0);
8010675f:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106766:	e8 01 ff ff ff       	call   8010666c <inb>
  picenable(IRQ_COM1);
8010676b:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106772:	e8 22 d3 ff ff       	call   80103a99 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106777:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010677e:	00 
8010677f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106786:	e8 eb c1 ff ff       	call   80102976 <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010678b:	c7 45 f4 dc 86 10 80 	movl   $0x801086dc,-0xc(%ebp)
80106792:	eb 15                	jmp    801067a9 <uartinit+0x102>
    uartputc(*p);
80106794:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106797:	0f b6 00             	movzbl (%eax),%eax
8010679a:	0f be c0             	movsbl %al,%eax
8010679d:	89 04 24             	mov    %eax,(%esp)
801067a0:	e8 13 00 00 00       	call   801067b8 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801067a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801067a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ac:	0f b6 00             	movzbl (%eax),%eax
801067af:	84 c0                	test   %al,%al
801067b1:	75 e1                	jne    80106794 <uartinit+0xed>
801067b3:	eb 01                	jmp    801067b6 <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
801067b5:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
801067b6:	c9                   	leave  
801067b7:	c3                   	ret    

801067b8 <uartputc>:

void
uartputc(int c)
{
801067b8:	55                   	push   %ebp
801067b9:	89 e5                	mov    %esp,%ebp
801067bb:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
801067be:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
801067c3:	85 c0                	test   %eax,%eax
801067c5:	74 4d                	je     80106814 <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801067ce:	eb 10                	jmp    801067e0 <uartputc+0x28>
    microdelay(10);
801067d0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
801067d7:	e8 21 c7 ff ff       	call   80102efd <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801067dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801067e0:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801067e4:	7f 16                	jg     801067fc <uartputc+0x44>
801067e6:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
801067ed:	e8 7a fe ff ff       	call   8010666c <inb>
801067f2:	0f b6 c0             	movzbl %al,%eax
801067f5:	83 e0 20             	and    $0x20,%eax
801067f8:	85 c0                	test   %eax,%eax
801067fa:	74 d4                	je     801067d0 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
801067fc:	8b 45 08             	mov    0x8(%ebp),%eax
801067ff:	0f b6 c0             	movzbl %al,%eax
80106802:	89 44 24 04          	mov    %eax,0x4(%esp)
80106806:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
8010680d:	e8 77 fe ff ff       	call   80106689 <outb>
80106812:	eb 01                	jmp    80106815 <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106814:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106815:	c9                   	leave  
80106816:	c3                   	ret    

80106817 <uartgetc>:

static int
uartgetc(void)
{
80106817:	55                   	push   %ebp
80106818:	89 e5                	mov    %esp,%ebp
8010681a:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
8010681d:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106822:	85 c0                	test   %eax,%eax
80106824:	75 07                	jne    8010682d <uartgetc+0x16>
    return -1;
80106826:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010682b:	eb 2c                	jmp    80106859 <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
8010682d:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106834:	e8 33 fe ff ff       	call   8010666c <inb>
80106839:	0f b6 c0             	movzbl %al,%eax
8010683c:	83 e0 01             	and    $0x1,%eax
8010683f:	85 c0                	test   %eax,%eax
80106841:	75 07                	jne    8010684a <uartgetc+0x33>
    return -1;
80106843:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106848:	eb 0f                	jmp    80106859 <uartgetc+0x42>
  return inb(COM1+0);
8010684a:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106851:	e8 16 fe ff ff       	call   8010666c <inb>
80106856:	0f b6 c0             	movzbl %al,%eax
}
80106859:	c9                   	leave  
8010685a:	c3                   	ret    

8010685b <uartintr>:

void
uartintr(void)
{
8010685b:	55                   	push   %ebp
8010685c:	89 e5                	mov    %esp,%ebp
8010685e:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106861:	c7 04 24 17 68 10 80 	movl   $0x80106817,(%esp)
80106868:	e8 41 9f ff ff       	call   801007ae <consoleintr>
}
8010686d:	c9                   	leave  
8010686e:	c3                   	ret    
	...

80106870 <vector0>:
80106870:	6a 00                	push   $0x0
80106872:	6a 00                	push   $0x0
80106874:	e9 7b f9 ff ff       	jmp    801061f4 <alltraps>

80106879 <vector1>:
80106879:	6a 00                	push   $0x0
8010687b:	6a 01                	push   $0x1
8010687d:	e9 72 f9 ff ff       	jmp    801061f4 <alltraps>

80106882 <vector2>:
80106882:	6a 00                	push   $0x0
80106884:	6a 02                	push   $0x2
80106886:	e9 69 f9 ff ff       	jmp    801061f4 <alltraps>

8010688b <vector3>:
8010688b:	6a 00                	push   $0x0
8010688d:	6a 03                	push   $0x3
8010688f:	e9 60 f9 ff ff       	jmp    801061f4 <alltraps>

80106894 <vector4>:
80106894:	6a 00                	push   $0x0
80106896:	6a 04                	push   $0x4
80106898:	e9 57 f9 ff ff       	jmp    801061f4 <alltraps>

8010689d <vector5>:
8010689d:	6a 00                	push   $0x0
8010689f:	6a 05                	push   $0x5
801068a1:	e9 4e f9 ff ff       	jmp    801061f4 <alltraps>

801068a6 <vector6>:
801068a6:	6a 00                	push   $0x0
801068a8:	6a 06                	push   $0x6
801068aa:	e9 45 f9 ff ff       	jmp    801061f4 <alltraps>

801068af <vector7>:
801068af:	6a 00                	push   $0x0
801068b1:	6a 07                	push   $0x7
801068b3:	e9 3c f9 ff ff       	jmp    801061f4 <alltraps>

801068b8 <vector8>:
801068b8:	6a 08                	push   $0x8
801068ba:	e9 35 f9 ff ff       	jmp    801061f4 <alltraps>

801068bf <vector9>:
801068bf:	6a 00                	push   $0x0
801068c1:	6a 09                	push   $0x9
801068c3:	e9 2c f9 ff ff       	jmp    801061f4 <alltraps>

801068c8 <vector10>:
801068c8:	6a 0a                	push   $0xa
801068ca:	e9 25 f9 ff ff       	jmp    801061f4 <alltraps>

801068cf <vector11>:
801068cf:	6a 0b                	push   $0xb
801068d1:	e9 1e f9 ff ff       	jmp    801061f4 <alltraps>

801068d6 <vector12>:
801068d6:	6a 0c                	push   $0xc
801068d8:	e9 17 f9 ff ff       	jmp    801061f4 <alltraps>

801068dd <vector13>:
801068dd:	6a 0d                	push   $0xd
801068df:	e9 10 f9 ff ff       	jmp    801061f4 <alltraps>

801068e4 <vector14>:
801068e4:	6a 0e                	push   $0xe
801068e6:	e9 09 f9 ff ff       	jmp    801061f4 <alltraps>

801068eb <vector15>:
801068eb:	6a 00                	push   $0x0
801068ed:	6a 0f                	push   $0xf
801068ef:	e9 00 f9 ff ff       	jmp    801061f4 <alltraps>

801068f4 <vector16>:
801068f4:	6a 00                	push   $0x0
801068f6:	6a 10                	push   $0x10
801068f8:	e9 f7 f8 ff ff       	jmp    801061f4 <alltraps>

801068fd <vector17>:
801068fd:	6a 11                	push   $0x11
801068ff:	e9 f0 f8 ff ff       	jmp    801061f4 <alltraps>

80106904 <vector18>:
80106904:	6a 00                	push   $0x0
80106906:	6a 12                	push   $0x12
80106908:	e9 e7 f8 ff ff       	jmp    801061f4 <alltraps>

8010690d <vector19>:
8010690d:	6a 00                	push   $0x0
8010690f:	6a 13                	push   $0x13
80106911:	e9 de f8 ff ff       	jmp    801061f4 <alltraps>

80106916 <vector20>:
80106916:	6a 00                	push   $0x0
80106918:	6a 14                	push   $0x14
8010691a:	e9 d5 f8 ff ff       	jmp    801061f4 <alltraps>

8010691f <vector21>:
8010691f:	6a 00                	push   $0x0
80106921:	6a 15                	push   $0x15
80106923:	e9 cc f8 ff ff       	jmp    801061f4 <alltraps>

80106928 <vector22>:
80106928:	6a 00                	push   $0x0
8010692a:	6a 16                	push   $0x16
8010692c:	e9 c3 f8 ff ff       	jmp    801061f4 <alltraps>

80106931 <vector23>:
80106931:	6a 00                	push   $0x0
80106933:	6a 17                	push   $0x17
80106935:	e9 ba f8 ff ff       	jmp    801061f4 <alltraps>

8010693a <vector24>:
8010693a:	6a 00                	push   $0x0
8010693c:	6a 18                	push   $0x18
8010693e:	e9 b1 f8 ff ff       	jmp    801061f4 <alltraps>

80106943 <vector25>:
80106943:	6a 00                	push   $0x0
80106945:	6a 19                	push   $0x19
80106947:	e9 a8 f8 ff ff       	jmp    801061f4 <alltraps>

8010694c <vector26>:
8010694c:	6a 00                	push   $0x0
8010694e:	6a 1a                	push   $0x1a
80106950:	e9 9f f8 ff ff       	jmp    801061f4 <alltraps>

80106955 <vector27>:
80106955:	6a 00                	push   $0x0
80106957:	6a 1b                	push   $0x1b
80106959:	e9 96 f8 ff ff       	jmp    801061f4 <alltraps>

8010695e <vector28>:
8010695e:	6a 00                	push   $0x0
80106960:	6a 1c                	push   $0x1c
80106962:	e9 8d f8 ff ff       	jmp    801061f4 <alltraps>

80106967 <vector29>:
80106967:	6a 00                	push   $0x0
80106969:	6a 1d                	push   $0x1d
8010696b:	e9 84 f8 ff ff       	jmp    801061f4 <alltraps>

80106970 <vector30>:
80106970:	6a 00                	push   $0x0
80106972:	6a 1e                	push   $0x1e
80106974:	e9 7b f8 ff ff       	jmp    801061f4 <alltraps>

80106979 <vector31>:
80106979:	6a 00                	push   $0x0
8010697b:	6a 1f                	push   $0x1f
8010697d:	e9 72 f8 ff ff       	jmp    801061f4 <alltraps>

80106982 <vector32>:
80106982:	6a 00                	push   $0x0
80106984:	6a 20                	push   $0x20
80106986:	e9 69 f8 ff ff       	jmp    801061f4 <alltraps>

8010698b <vector33>:
8010698b:	6a 00                	push   $0x0
8010698d:	6a 21                	push   $0x21
8010698f:	e9 60 f8 ff ff       	jmp    801061f4 <alltraps>

80106994 <vector34>:
80106994:	6a 00                	push   $0x0
80106996:	6a 22                	push   $0x22
80106998:	e9 57 f8 ff ff       	jmp    801061f4 <alltraps>

8010699d <vector35>:
8010699d:	6a 00                	push   $0x0
8010699f:	6a 23                	push   $0x23
801069a1:	e9 4e f8 ff ff       	jmp    801061f4 <alltraps>

801069a6 <vector36>:
801069a6:	6a 00                	push   $0x0
801069a8:	6a 24                	push   $0x24
801069aa:	e9 45 f8 ff ff       	jmp    801061f4 <alltraps>

801069af <vector37>:
801069af:	6a 00                	push   $0x0
801069b1:	6a 25                	push   $0x25
801069b3:	e9 3c f8 ff ff       	jmp    801061f4 <alltraps>

801069b8 <vector38>:
801069b8:	6a 00                	push   $0x0
801069ba:	6a 26                	push   $0x26
801069bc:	e9 33 f8 ff ff       	jmp    801061f4 <alltraps>

801069c1 <vector39>:
801069c1:	6a 00                	push   $0x0
801069c3:	6a 27                	push   $0x27
801069c5:	e9 2a f8 ff ff       	jmp    801061f4 <alltraps>

801069ca <vector40>:
801069ca:	6a 00                	push   $0x0
801069cc:	6a 28                	push   $0x28
801069ce:	e9 21 f8 ff ff       	jmp    801061f4 <alltraps>

801069d3 <vector41>:
801069d3:	6a 00                	push   $0x0
801069d5:	6a 29                	push   $0x29
801069d7:	e9 18 f8 ff ff       	jmp    801061f4 <alltraps>

801069dc <vector42>:
801069dc:	6a 00                	push   $0x0
801069de:	6a 2a                	push   $0x2a
801069e0:	e9 0f f8 ff ff       	jmp    801061f4 <alltraps>

801069e5 <vector43>:
801069e5:	6a 00                	push   $0x0
801069e7:	6a 2b                	push   $0x2b
801069e9:	e9 06 f8 ff ff       	jmp    801061f4 <alltraps>

801069ee <vector44>:
801069ee:	6a 00                	push   $0x0
801069f0:	6a 2c                	push   $0x2c
801069f2:	e9 fd f7 ff ff       	jmp    801061f4 <alltraps>

801069f7 <vector45>:
801069f7:	6a 00                	push   $0x0
801069f9:	6a 2d                	push   $0x2d
801069fb:	e9 f4 f7 ff ff       	jmp    801061f4 <alltraps>

80106a00 <vector46>:
80106a00:	6a 00                	push   $0x0
80106a02:	6a 2e                	push   $0x2e
80106a04:	e9 eb f7 ff ff       	jmp    801061f4 <alltraps>

80106a09 <vector47>:
80106a09:	6a 00                	push   $0x0
80106a0b:	6a 2f                	push   $0x2f
80106a0d:	e9 e2 f7 ff ff       	jmp    801061f4 <alltraps>

80106a12 <vector48>:
80106a12:	6a 00                	push   $0x0
80106a14:	6a 30                	push   $0x30
80106a16:	e9 d9 f7 ff ff       	jmp    801061f4 <alltraps>

80106a1b <vector49>:
80106a1b:	6a 00                	push   $0x0
80106a1d:	6a 31                	push   $0x31
80106a1f:	e9 d0 f7 ff ff       	jmp    801061f4 <alltraps>

80106a24 <vector50>:
80106a24:	6a 00                	push   $0x0
80106a26:	6a 32                	push   $0x32
80106a28:	e9 c7 f7 ff ff       	jmp    801061f4 <alltraps>

80106a2d <vector51>:
80106a2d:	6a 00                	push   $0x0
80106a2f:	6a 33                	push   $0x33
80106a31:	e9 be f7 ff ff       	jmp    801061f4 <alltraps>

80106a36 <vector52>:
80106a36:	6a 00                	push   $0x0
80106a38:	6a 34                	push   $0x34
80106a3a:	e9 b5 f7 ff ff       	jmp    801061f4 <alltraps>

80106a3f <vector53>:
80106a3f:	6a 00                	push   $0x0
80106a41:	6a 35                	push   $0x35
80106a43:	e9 ac f7 ff ff       	jmp    801061f4 <alltraps>

80106a48 <vector54>:
80106a48:	6a 00                	push   $0x0
80106a4a:	6a 36                	push   $0x36
80106a4c:	e9 a3 f7 ff ff       	jmp    801061f4 <alltraps>

80106a51 <vector55>:
80106a51:	6a 00                	push   $0x0
80106a53:	6a 37                	push   $0x37
80106a55:	e9 9a f7 ff ff       	jmp    801061f4 <alltraps>

80106a5a <vector56>:
80106a5a:	6a 00                	push   $0x0
80106a5c:	6a 38                	push   $0x38
80106a5e:	e9 91 f7 ff ff       	jmp    801061f4 <alltraps>

80106a63 <vector57>:
80106a63:	6a 00                	push   $0x0
80106a65:	6a 39                	push   $0x39
80106a67:	e9 88 f7 ff ff       	jmp    801061f4 <alltraps>

80106a6c <vector58>:
80106a6c:	6a 00                	push   $0x0
80106a6e:	6a 3a                	push   $0x3a
80106a70:	e9 7f f7 ff ff       	jmp    801061f4 <alltraps>

80106a75 <vector59>:
80106a75:	6a 00                	push   $0x0
80106a77:	6a 3b                	push   $0x3b
80106a79:	e9 76 f7 ff ff       	jmp    801061f4 <alltraps>

80106a7e <vector60>:
80106a7e:	6a 00                	push   $0x0
80106a80:	6a 3c                	push   $0x3c
80106a82:	e9 6d f7 ff ff       	jmp    801061f4 <alltraps>

80106a87 <vector61>:
80106a87:	6a 00                	push   $0x0
80106a89:	6a 3d                	push   $0x3d
80106a8b:	e9 64 f7 ff ff       	jmp    801061f4 <alltraps>

80106a90 <vector62>:
80106a90:	6a 00                	push   $0x0
80106a92:	6a 3e                	push   $0x3e
80106a94:	e9 5b f7 ff ff       	jmp    801061f4 <alltraps>

80106a99 <vector63>:
80106a99:	6a 00                	push   $0x0
80106a9b:	6a 3f                	push   $0x3f
80106a9d:	e9 52 f7 ff ff       	jmp    801061f4 <alltraps>

80106aa2 <vector64>:
80106aa2:	6a 00                	push   $0x0
80106aa4:	6a 40                	push   $0x40
80106aa6:	e9 49 f7 ff ff       	jmp    801061f4 <alltraps>

80106aab <vector65>:
80106aab:	6a 00                	push   $0x0
80106aad:	6a 41                	push   $0x41
80106aaf:	e9 40 f7 ff ff       	jmp    801061f4 <alltraps>

80106ab4 <vector66>:
80106ab4:	6a 00                	push   $0x0
80106ab6:	6a 42                	push   $0x42
80106ab8:	e9 37 f7 ff ff       	jmp    801061f4 <alltraps>

80106abd <vector67>:
80106abd:	6a 00                	push   $0x0
80106abf:	6a 43                	push   $0x43
80106ac1:	e9 2e f7 ff ff       	jmp    801061f4 <alltraps>

80106ac6 <vector68>:
80106ac6:	6a 00                	push   $0x0
80106ac8:	6a 44                	push   $0x44
80106aca:	e9 25 f7 ff ff       	jmp    801061f4 <alltraps>

80106acf <vector69>:
80106acf:	6a 00                	push   $0x0
80106ad1:	6a 45                	push   $0x45
80106ad3:	e9 1c f7 ff ff       	jmp    801061f4 <alltraps>

80106ad8 <vector70>:
80106ad8:	6a 00                	push   $0x0
80106ada:	6a 46                	push   $0x46
80106adc:	e9 13 f7 ff ff       	jmp    801061f4 <alltraps>

80106ae1 <vector71>:
80106ae1:	6a 00                	push   $0x0
80106ae3:	6a 47                	push   $0x47
80106ae5:	e9 0a f7 ff ff       	jmp    801061f4 <alltraps>

80106aea <vector72>:
80106aea:	6a 00                	push   $0x0
80106aec:	6a 48                	push   $0x48
80106aee:	e9 01 f7 ff ff       	jmp    801061f4 <alltraps>

80106af3 <vector73>:
80106af3:	6a 00                	push   $0x0
80106af5:	6a 49                	push   $0x49
80106af7:	e9 f8 f6 ff ff       	jmp    801061f4 <alltraps>

80106afc <vector74>:
80106afc:	6a 00                	push   $0x0
80106afe:	6a 4a                	push   $0x4a
80106b00:	e9 ef f6 ff ff       	jmp    801061f4 <alltraps>

80106b05 <vector75>:
80106b05:	6a 00                	push   $0x0
80106b07:	6a 4b                	push   $0x4b
80106b09:	e9 e6 f6 ff ff       	jmp    801061f4 <alltraps>

80106b0e <vector76>:
80106b0e:	6a 00                	push   $0x0
80106b10:	6a 4c                	push   $0x4c
80106b12:	e9 dd f6 ff ff       	jmp    801061f4 <alltraps>

80106b17 <vector77>:
80106b17:	6a 00                	push   $0x0
80106b19:	6a 4d                	push   $0x4d
80106b1b:	e9 d4 f6 ff ff       	jmp    801061f4 <alltraps>

80106b20 <vector78>:
80106b20:	6a 00                	push   $0x0
80106b22:	6a 4e                	push   $0x4e
80106b24:	e9 cb f6 ff ff       	jmp    801061f4 <alltraps>

80106b29 <vector79>:
80106b29:	6a 00                	push   $0x0
80106b2b:	6a 4f                	push   $0x4f
80106b2d:	e9 c2 f6 ff ff       	jmp    801061f4 <alltraps>

80106b32 <vector80>:
80106b32:	6a 00                	push   $0x0
80106b34:	6a 50                	push   $0x50
80106b36:	e9 b9 f6 ff ff       	jmp    801061f4 <alltraps>

80106b3b <vector81>:
80106b3b:	6a 00                	push   $0x0
80106b3d:	6a 51                	push   $0x51
80106b3f:	e9 b0 f6 ff ff       	jmp    801061f4 <alltraps>

80106b44 <vector82>:
80106b44:	6a 00                	push   $0x0
80106b46:	6a 52                	push   $0x52
80106b48:	e9 a7 f6 ff ff       	jmp    801061f4 <alltraps>

80106b4d <vector83>:
80106b4d:	6a 00                	push   $0x0
80106b4f:	6a 53                	push   $0x53
80106b51:	e9 9e f6 ff ff       	jmp    801061f4 <alltraps>

80106b56 <vector84>:
80106b56:	6a 00                	push   $0x0
80106b58:	6a 54                	push   $0x54
80106b5a:	e9 95 f6 ff ff       	jmp    801061f4 <alltraps>

80106b5f <vector85>:
80106b5f:	6a 00                	push   $0x0
80106b61:	6a 55                	push   $0x55
80106b63:	e9 8c f6 ff ff       	jmp    801061f4 <alltraps>

80106b68 <vector86>:
80106b68:	6a 00                	push   $0x0
80106b6a:	6a 56                	push   $0x56
80106b6c:	e9 83 f6 ff ff       	jmp    801061f4 <alltraps>

80106b71 <vector87>:
80106b71:	6a 00                	push   $0x0
80106b73:	6a 57                	push   $0x57
80106b75:	e9 7a f6 ff ff       	jmp    801061f4 <alltraps>

80106b7a <vector88>:
80106b7a:	6a 00                	push   $0x0
80106b7c:	6a 58                	push   $0x58
80106b7e:	e9 71 f6 ff ff       	jmp    801061f4 <alltraps>

80106b83 <vector89>:
80106b83:	6a 00                	push   $0x0
80106b85:	6a 59                	push   $0x59
80106b87:	e9 68 f6 ff ff       	jmp    801061f4 <alltraps>

80106b8c <vector90>:
80106b8c:	6a 00                	push   $0x0
80106b8e:	6a 5a                	push   $0x5a
80106b90:	e9 5f f6 ff ff       	jmp    801061f4 <alltraps>

80106b95 <vector91>:
80106b95:	6a 00                	push   $0x0
80106b97:	6a 5b                	push   $0x5b
80106b99:	e9 56 f6 ff ff       	jmp    801061f4 <alltraps>

80106b9e <vector92>:
80106b9e:	6a 00                	push   $0x0
80106ba0:	6a 5c                	push   $0x5c
80106ba2:	e9 4d f6 ff ff       	jmp    801061f4 <alltraps>

80106ba7 <vector93>:
80106ba7:	6a 00                	push   $0x0
80106ba9:	6a 5d                	push   $0x5d
80106bab:	e9 44 f6 ff ff       	jmp    801061f4 <alltraps>

80106bb0 <vector94>:
80106bb0:	6a 00                	push   $0x0
80106bb2:	6a 5e                	push   $0x5e
80106bb4:	e9 3b f6 ff ff       	jmp    801061f4 <alltraps>

80106bb9 <vector95>:
80106bb9:	6a 00                	push   $0x0
80106bbb:	6a 5f                	push   $0x5f
80106bbd:	e9 32 f6 ff ff       	jmp    801061f4 <alltraps>

80106bc2 <vector96>:
80106bc2:	6a 00                	push   $0x0
80106bc4:	6a 60                	push   $0x60
80106bc6:	e9 29 f6 ff ff       	jmp    801061f4 <alltraps>

80106bcb <vector97>:
80106bcb:	6a 00                	push   $0x0
80106bcd:	6a 61                	push   $0x61
80106bcf:	e9 20 f6 ff ff       	jmp    801061f4 <alltraps>

80106bd4 <vector98>:
80106bd4:	6a 00                	push   $0x0
80106bd6:	6a 62                	push   $0x62
80106bd8:	e9 17 f6 ff ff       	jmp    801061f4 <alltraps>

80106bdd <vector99>:
80106bdd:	6a 00                	push   $0x0
80106bdf:	6a 63                	push   $0x63
80106be1:	e9 0e f6 ff ff       	jmp    801061f4 <alltraps>

80106be6 <vector100>:
80106be6:	6a 00                	push   $0x0
80106be8:	6a 64                	push   $0x64
80106bea:	e9 05 f6 ff ff       	jmp    801061f4 <alltraps>

80106bef <vector101>:
80106bef:	6a 00                	push   $0x0
80106bf1:	6a 65                	push   $0x65
80106bf3:	e9 fc f5 ff ff       	jmp    801061f4 <alltraps>

80106bf8 <vector102>:
80106bf8:	6a 00                	push   $0x0
80106bfa:	6a 66                	push   $0x66
80106bfc:	e9 f3 f5 ff ff       	jmp    801061f4 <alltraps>

80106c01 <vector103>:
80106c01:	6a 00                	push   $0x0
80106c03:	6a 67                	push   $0x67
80106c05:	e9 ea f5 ff ff       	jmp    801061f4 <alltraps>

80106c0a <vector104>:
80106c0a:	6a 00                	push   $0x0
80106c0c:	6a 68                	push   $0x68
80106c0e:	e9 e1 f5 ff ff       	jmp    801061f4 <alltraps>

80106c13 <vector105>:
80106c13:	6a 00                	push   $0x0
80106c15:	6a 69                	push   $0x69
80106c17:	e9 d8 f5 ff ff       	jmp    801061f4 <alltraps>

80106c1c <vector106>:
80106c1c:	6a 00                	push   $0x0
80106c1e:	6a 6a                	push   $0x6a
80106c20:	e9 cf f5 ff ff       	jmp    801061f4 <alltraps>

80106c25 <vector107>:
80106c25:	6a 00                	push   $0x0
80106c27:	6a 6b                	push   $0x6b
80106c29:	e9 c6 f5 ff ff       	jmp    801061f4 <alltraps>

80106c2e <vector108>:
80106c2e:	6a 00                	push   $0x0
80106c30:	6a 6c                	push   $0x6c
80106c32:	e9 bd f5 ff ff       	jmp    801061f4 <alltraps>

80106c37 <vector109>:
80106c37:	6a 00                	push   $0x0
80106c39:	6a 6d                	push   $0x6d
80106c3b:	e9 b4 f5 ff ff       	jmp    801061f4 <alltraps>

80106c40 <vector110>:
80106c40:	6a 00                	push   $0x0
80106c42:	6a 6e                	push   $0x6e
80106c44:	e9 ab f5 ff ff       	jmp    801061f4 <alltraps>

80106c49 <vector111>:
80106c49:	6a 00                	push   $0x0
80106c4b:	6a 6f                	push   $0x6f
80106c4d:	e9 a2 f5 ff ff       	jmp    801061f4 <alltraps>

80106c52 <vector112>:
80106c52:	6a 00                	push   $0x0
80106c54:	6a 70                	push   $0x70
80106c56:	e9 99 f5 ff ff       	jmp    801061f4 <alltraps>

80106c5b <vector113>:
80106c5b:	6a 00                	push   $0x0
80106c5d:	6a 71                	push   $0x71
80106c5f:	e9 90 f5 ff ff       	jmp    801061f4 <alltraps>

80106c64 <vector114>:
80106c64:	6a 00                	push   $0x0
80106c66:	6a 72                	push   $0x72
80106c68:	e9 87 f5 ff ff       	jmp    801061f4 <alltraps>

80106c6d <vector115>:
80106c6d:	6a 00                	push   $0x0
80106c6f:	6a 73                	push   $0x73
80106c71:	e9 7e f5 ff ff       	jmp    801061f4 <alltraps>

80106c76 <vector116>:
80106c76:	6a 00                	push   $0x0
80106c78:	6a 74                	push   $0x74
80106c7a:	e9 75 f5 ff ff       	jmp    801061f4 <alltraps>

80106c7f <vector117>:
80106c7f:	6a 00                	push   $0x0
80106c81:	6a 75                	push   $0x75
80106c83:	e9 6c f5 ff ff       	jmp    801061f4 <alltraps>

80106c88 <vector118>:
80106c88:	6a 00                	push   $0x0
80106c8a:	6a 76                	push   $0x76
80106c8c:	e9 63 f5 ff ff       	jmp    801061f4 <alltraps>

80106c91 <vector119>:
80106c91:	6a 00                	push   $0x0
80106c93:	6a 77                	push   $0x77
80106c95:	e9 5a f5 ff ff       	jmp    801061f4 <alltraps>

80106c9a <vector120>:
80106c9a:	6a 00                	push   $0x0
80106c9c:	6a 78                	push   $0x78
80106c9e:	e9 51 f5 ff ff       	jmp    801061f4 <alltraps>

80106ca3 <vector121>:
80106ca3:	6a 00                	push   $0x0
80106ca5:	6a 79                	push   $0x79
80106ca7:	e9 48 f5 ff ff       	jmp    801061f4 <alltraps>

80106cac <vector122>:
80106cac:	6a 00                	push   $0x0
80106cae:	6a 7a                	push   $0x7a
80106cb0:	e9 3f f5 ff ff       	jmp    801061f4 <alltraps>

80106cb5 <vector123>:
80106cb5:	6a 00                	push   $0x0
80106cb7:	6a 7b                	push   $0x7b
80106cb9:	e9 36 f5 ff ff       	jmp    801061f4 <alltraps>

80106cbe <vector124>:
80106cbe:	6a 00                	push   $0x0
80106cc0:	6a 7c                	push   $0x7c
80106cc2:	e9 2d f5 ff ff       	jmp    801061f4 <alltraps>

80106cc7 <vector125>:
80106cc7:	6a 00                	push   $0x0
80106cc9:	6a 7d                	push   $0x7d
80106ccb:	e9 24 f5 ff ff       	jmp    801061f4 <alltraps>

80106cd0 <vector126>:
80106cd0:	6a 00                	push   $0x0
80106cd2:	6a 7e                	push   $0x7e
80106cd4:	e9 1b f5 ff ff       	jmp    801061f4 <alltraps>

80106cd9 <vector127>:
80106cd9:	6a 00                	push   $0x0
80106cdb:	6a 7f                	push   $0x7f
80106cdd:	e9 12 f5 ff ff       	jmp    801061f4 <alltraps>

80106ce2 <vector128>:
80106ce2:	6a 00                	push   $0x0
80106ce4:	68 80 00 00 00       	push   $0x80
80106ce9:	e9 06 f5 ff ff       	jmp    801061f4 <alltraps>

80106cee <vector129>:
80106cee:	6a 00                	push   $0x0
80106cf0:	68 81 00 00 00       	push   $0x81
80106cf5:	e9 fa f4 ff ff       	jmp    801061f4 <alltraps>

80106cfa <vector130>:
80106cfa:	6a 00                	push   $0x0
80106cfc:	68 82 00 00 00       	push   $0x82
80106d01:	e9 ee f4 ff ff       	jmp    801061f4 <alltraps>

80106d06 <vector131>:
80106d06:	6a 00                	push   $0x0
80106d08:	68 83 00 00 00       	push   $0x83
80106d0d:	e9 e2 f4 ff ff       	jmp    801061f4 <alltraps>

80106d12 <vector132>:
80106d12:	6a 00                	push   $0x0
80106d14:	68 84 00 00 00       	push   $0x84
80106d19:	e9 d6 f4 ff ff       	jmp    801061f4 <alltraps>

80106d1e <vector133>:
80106d1e:	6a 00                	push   $0x0
80106d20:	68 85 00 00 00       	push   $0x85
80106d25:	e9 ca f4 ff ff       	jmp    801061f4 <alltraps>

80106d2a <vector134>:
80106d2a:	6a 00                	push   $0x0
80106d2c:	68 86 00 00 00       	push   $0x86
80106d31:	e9 be f4 ff ff       	jmp    801061f4 <alltraps>

80106d36 <vector135>:
80106d36:	6a 00                	push   $0x0
80106d38:	68 87 00 00 00       	push   $0x87
80106d3d:	e9 b2 f4 ff ff       	jmp    801061f4 <alltraps>

80106d42 <vector136>:
80106d42:	6a 00                	push   $0x0
80106d44:	68 88 00 00 00       	push   $0x88
80106d49:	e9 a6 f4 ff ff       	jmp    801061f4 <alltraps>

80106d4e <vector137>:
80106d4e:	6a 00                	push   $0x0
80106d50:	68 89 00 00 00       	push   $0x89
80106d55:	e9 9a f4 ff ff       	jmp    801061f4 <alltraps>

80106d5a <vector138>:
80106d5a:	6a 00                	push   $0x0
80106d5c:	68 8a 00 00 00       	push   $0x8a
80106d61:	e9 8e f4 ff ff       	jmp    801061f4 <alltraps>

80106d66 <vector139>:
80106d66:	6a 00                	push   $0x0
80106d68:	68 8b 00 00 00       	push   $0x8b
80106d6d:	e9 82 f4 ff ff       	jmp    801061f4 <alltraps>

80106d72 <vector140>:
80106d72:	6a 00                	push   $0x0
80106d74:	68 8c 00 00 00       	push   $0x8c
80106d79:	e9 76 f4 ff ff       	jmp    801061f4 <alltraps>

80106d7e <vector141>:
80106d7e:	6a 00                	push   $0x0
80106d80:	68 8d 00 00 00       	push   $0x8d
80106d85:	e9 6a f4 ff ff       	jmp    801061f4 <alltraps>

80106d8a <vector142>:
80106d8a:	6a 00                	push   $0x0
80106d8c:	68 8e 00 00 00       	push   $0x8e
80106d91:	e9 5e f4 ff ff       	jmp    801061f4 <alltraps>

80106d96 <vector143>:
80106d96:	6a 00                	push   $0x0
80106d98:	68 8f 00 00 00       	push   $0x8f
80106d9d:	e9 52 f4 ff ff       	jmp    801061f4 <alltraps>

80106da2 <vector144>:
80106da2:	6a 00                	push   $0x0
80106da4:	68 90 00 00 00       	push   $0x90
80106da9:	e9 46 f4 ff ff       	jmp    801061f4 <alltraps>

80106dae <vector145>:
80106dae:	6a 00                	push   $0x0
80106db0:	68 91 00 00 00       	push   $0x91
80106db5:	e9 3a f4 ff ff       	jmp    801061f4 <alltraps>

80106dba <vector146>:
80106dba:	6a 00                	push   $0x0
80106dbc:	68 92 00 00 00       	push   $0x92
80106dc1:	e9 2e f4 ff ff       	jmp    801061f4 <alltraps>

80106dc6 <vector147>:
80106dc6:	6a 00                	push   $0x0
80106dc8:	68 93 00 00 00       	push   $0x93
80106dcd:	e9 22 f4 ff ff       	jmp    801061f4 <alltraps>

80106dd2 <vector148>:
80106dd2:	6a 00                	push   $0x0
80106dd4:	68 94 00 00 00       	push   $0x94
80106dd9:	e9 16 f4 ff ff       	jmp    801061f4 <alltraps>

80106dde <vector149>:
80106dde:	6a 00                	push   $0x0
80106de0:	68 95 00 00 00       	push   $0x95
80106de5:	e9 0a f4 ff ff       	jmp    801061f4 <alltraps>

80106dea <vector150>:
80106dea:	6a 00                	push   $0x0
80106dec:	68 96 00 00 00       	push   $0x96
80106df1:	e9 fe f3 ff ff       	jmp    801061f4 <alltraps>

80106df6 <vector151>:
80106df6:	6a 00                	push   $0x0
80106df8:	68 97 00 00 00       	push   $0x97
80106dfd:	e9 f2 f3 ff ff       	jmp    801061f4 <alltraps>

80106e02 <vector152>:
80106e02:	6a 00                	push   $0x0
80106e04:	68 98 00 00 00       	push   $0x98
80106e09:	e9 e6 f3 ff ff       	jmp    801061f4 <alltraps>

80106e0e <vector153>:
80106e0e:	6a 00                	push   $0x0
80106e10:	68 99 00 00 00       	push   $0x99
80106e15:	e9 da f3 ff ff       	jmp    801061f4 <alltraps>

80106e1a <vector154>:
80106e1a:	6a 00                	push   $0x0
80106e1c:	68 9a 00 00 00       	push   $0x9a
80106e21:	e9 ce f3 ff ff       	jmp    801061f4 <alltraps>

80106e26 <vector155>:
80106e26:	6a 00                	push   $0x0
80106e28:	68 9b 00 00 00       	push   $0x9b
80106e2d:	e9 c2 f3 ff ff       	jmp    801061f4 <alltraps>

80106e32 <vector156>:
80106e32:	6a 00                	push   $0x0
80106e34:	68 9c 00 00 00       	push   $0x9c
80106e39:	e9 b6 f3 ff ff       	jmp    801061f4 <alltraps>

80106e3e <vector157>:
80106e3e:	6a 00                	push   $0x0
80106e40:	68 9d 00 00 00       	push   $0x9d
80106e45:	e9 aa f3 ff ff       	jmp    801061f4 <alltraps>

80106e4a <vector158>:
80106e4a:	6a 00                	push   $0x0
80106e4c:	68 9e 00 00 00       	push   $0x9e
80106e51:	e9 9e f3 ff ff       	jmp    801061f4 <alltraps>

80106e56 <vector159>:
80106e56:	6a 00                	push   $0x0
80106e58:	68 9f 00 00 00       	push   $0x9f
80106e5d:	e9 92 f3 ff ff       	jmp    801061f4 <alltraps>

80106e62 <vector160>:
80106e62:	6a 00                	push   $0x0
80106e64:	68 a0 00 00 00       	push   $0xa0
80106e69:	e9 86 f3 ff ff       	jmp    801061f4 <alltraps>

80106e6e <vector161>:
80106e6e:	6a 00                	push   $0x0
80106e70:	68 a1 00 00 00       	push   $0xa1
80106e75:	e9 7a f3 ff ff       	jmp    801061f4 <alltraps>

80106e7a <vector162>:
80106e7a:	6a 00                	push   $0x0
80106e7c:	68 a2 00 00 00       	push   $0xa2
80106e81:	e9 6e f3 ff ff       	jmp    801061f4 <alltraps>

80106e86 <vector163>:
80106e86:	6a 00                	push   $0x0
80106e88:	68 a3 00 00 00       	push   $0xa3
80106e8d:	e9 62 f3 ff ff       	jmp    801061f4 <alltraps>

80106e92 <vector164>:
80106e92:	6a 00                	push   $0x0
80106e94:	68 a4 00 00 00       	push   $0xa4
80106e99:	e9 56 f3 ff ff       	jmp    801061f4 <alltraps>

80106e9e <vector165>:
80106e9e:	6a 00                	push   $0x0
80106ea0:	68 a5 00 00 00       	push   $0xa5
80106ea5:	e9 4a f3 ff ff       	jmp    801061f4 <alltraps>

80106eaa <vector166>:
80106eaa:	6a 00                	push   $0x0
80106eac:	68 a6 00 00 00       	push   $0xa6
80106eb1:	e9 3e f3 ff ff       	jmp    801061f4 <alltraps>

80106eb6 <vector167>:
80106eb6:	6a 00                	push   $0x0
80106eb8:	68 a7 00 00 00       	push   $0xa7
80106ebd:	e9 32 f3 ff ff       	jmp    801061f4 <alltraps>

80106ec2 <vector168>:
80106ec2:	6a 00                	push   $0x0
80106ec4:	68 a8 00 00 00       	push   $0xa8
80106ec9:	e9 26 f3 ff ff       	jmp    801061f4 <alltraps>

80106ece <vector169>:
80106ece:	6a 00                	push   $0x0
80106ed0:	68 a9 00 00 00       	push   $0xa9
80106ed5:	e9 1a f3 ff ff       	jmp    801061f4 <alltraps>

80106eda <vector170>:
80106eda:	6a 00                	push   $0x0
80106edc:	68 aa 00 00 00       	push   $0xaa
80106ee1:	e9 0e f3 ff ff       	jmp    801061f4 <alltraps>

80106ee6 <vector171>:
80106ee6:	6a 00                	push   $0x0
80106ee8:	68 ab 00 00 00       	push   $0xab
80106eed:	e9 02 f3 ff ff       	jmp    801061f4 <alltraps>

80106ef2 <vector172>:
80106ef2:	6a 00                	push   $0x0
80106ef4:	68 ac 00 00 00       	push   $0xac
80106ef9:	e9 f6 f2 ff ff       	jmp    801061f4 <alltraps>

80106efe <vector173>:
80106efe:	6a 00                	push   $0x0
80106f00:	68 ad 00 00 00       	push   $0xad
80106f05:	e9 ea f2 ff ff       	jmp    801061f4 <alltraps>

80106f0a <vector174>:
80106f0a:	6a 00                	push   $0x0
80106f0c:	68 ae 00 00 00       	push   $0xae
80106f11:	e9 de f2 ff ff       	jmp    801061f4 <alltraps>

80106f16 <vector175>:
80106f16:	6a 00                	push   $0x0
80106f18:	68 af 00 00 00       	push   $0xaf
80106f1d:	e9 d2 f2 ff ff       	jmp    801061f4 <alltraps>

80106f22 <vector176>:
80106f22:	6a 00                	push   $0x0
80106f24:	68 b0 00 00 00       	push   $0xb0
80106f29:	e9 c6 f2 ff ff       	jmp    801061f4 <alltraps>

80106f2e <vector177>:
80106f2e:	6a 00                	push   $0x0
80106f30:	68 b1 00 00 00       	push   $0xb1
80106f35:	e9 ba f2 ff ff       	jmp    801061f4 <alltraps>

80106f3a <vector178>:
80106f3a:	6a 00                	push   $0x0
80106f3c:	68 b2 00 00 00       	push   $0xb2
80106f41:	e9 ae f2 ff ff       	jmp    801061f4 <alltraps>

80106f46 <vector179>:
80106f46:	6a 00                	push   $0x0
80106f48:	68 b3 00 00 00       	push   $0xb3
80106f4d:	e9 a2 f2 ff ff       	jmp    801061f4 <alltraps>

80106f52 <vector180>:
80106f52:	6a 00                	push   $0x0
80106f54:	68 b4 00 00 00       	push   $0xb4
80106f59:	e9 96 f2 ff ff       	jmp    801061f4 <alltraps>

80106f5e <vector181>:
80106f5e:	6a 00                	push   $0x0
80106f60:	68 b5 00 00 00       	push   $0xb5
80106f65:	e9 8a f2 ff ff       	jmp    801061f4 <alltraps>

80106f6a <vector182>:
80106f6a:	6a 00                	push   $0x0
80106f6c:	68 b6 00 00 00       	push   $0xb6
80106f71:	e9 7e f2 ff ff       	jmp    801061f4 <alltraps>

80106f76 <vector183>:
80106f76:	6a 00                	push   $0x0
80106f78:	68 b7 00 00 00       	push   $0xb7
80106f7d:	e9 72 f2 ff ff       	jmp    801061f4 <alltraps>

80106f82 <vector184>:
80106f82:	6a 00                	push   $0x0
80106f84:	68 b8 00 00 00       	push   $0xb8
80106f89:	e9 66 f2 ff ff       	jmp    801061f4 <alltraps>

80106f8e <vector185>:
80106f8e:	6a 00                	push   $0x0
80106f90:	68 b9 00 00 00       	push   $0xb9
80106f95:	e9 5a f2 ff ff       	jmp    801061f4 <alltraps>

80106f9a <vector186>:
80106f9a:	6a 00                	push   $0x0
80106f9c:	68 ba 00 00 00       	push   $0xba
80106fa1:	e9 4e f2 ff ff       	jmp    801061f4 <alltraps>

80106fa6 <vector187>:
80106fa6:	6a 00                	push   $0x0
80106fa8:	68 bb 00 00 00       	push   $0xbb
80106fad:	e9 42 f2 ff ff       	jmp    801061f4 <alltraps>

80106fb2 <vector188>:
80106fb2:	6a 00                	push   $0x0
80106fb4:	68 bc 00 00 00       	push   $0xbc
80106fb9:	e9 36 f2 ff ff       	jmp    801061f4 <alltraps>

80106fbe <vector189>:
80106fbe:	6a 00                	push   $0x0
80106fc0:	68 bd 00 00 00       	push   $0xbd
80106fc5:	e9 2a f2 ff ff       	jmp    801061f4 <alltraps>

80106fca <vector190>:
80106fca:	6a 00                	push   $0x0
80106fcc:	68 be 00 00 00       	push   $0xbe
80106fd1:	e9 1e f2 ff ff       	jmp    801061f4 <alltraps>

80106fd6 <vector191>:
80106fd6:	6a 00                	push   $0x0
80106fd8:	68 bf 00 00 00       	push   $0xbf
80106fdd:	e9 12 f2 ff ff       	jmp    801061f4 <alltraps>

80106fe2 <vector192>:
80106fe2:	6a 00                	push   $0x0
80106fe4:	68 c0 00 00 00       	push   $0xc0
80106fe9:	e9 06 f2 ff ff       	jmp    801061f4 <alltraps>

80106fee <vector193>:
80106fee:	6a 00                	push   $0x0
80106ff0:	68 c1 00 00 00       	push   $0xc1
80106ff5:	e9 fa f1 ff ff       	jmp    801061f4 <alltraps>

80106ffa <vector194>:
80106ffa:	6a 00                	push   $0x0
80106ffc:	68 c2 00 00 00       	push   $0xc2
80107001:	e9 ee f1 ff ff       	jmp    801061f4 <alltraps>

80107006 <vector195>:
80107006:	6a 00                	push   $0x0
80107008:	68 c3 00 00 00       	push   $0xc3
8010700d:	e9 e2 f1 ff ff       	jmp    801061f4 <alltraps>

80107012 <vector196>:
80107012:	6a 00                	push   $0x0
80107014:	68 c4 00 00 00       	push   $0xc4
80107019:	e9 d6 f1 ff ff       	jmp    801061f4 <alltraps>

8010701e <vector197>:
8010701e:	6a 00                	push   $0x0
80107020:	68 c5 00 00 00       	push   $0xc5
80107025:	e9 ca f1 ff ff       	jmp    801061f4 <alltraps>

8010702a <vector198>:
8010702a:	6a 00                	push   $0x0
8010702c:	68 c6 00 00 00       	push   $0xc6
80107031:	e9 be f1 ff ff       	jmp    801061f4 <alltraps>

80107036 <vector199>:
80107036:	6a 00                	push   $0x0
80107038:	68 c7 00 00 00       	push   $0xc7
8010703d:	e9 b2 f1 ff ff       	jmp    801061f4 <alltraps>

80107042 <vector200>:
80107042:	6a 00                	push   $0x0
80107044:	68 c8 00 00 00       	push   $0xc8
80107049:	e9 a6 f1 ff ff       	jmp    801061f4 <alltraps>

8010704e <vector201>:
8010704e:	6a 00                	push   $0x0
80107050:	68 c9 00 00 00       	push   $0xc9
80107055:	e9 9a f1 ff ff       	jmp    801061f4 <alltraps>

8010705a <vector202>:
8010705a:	6a 00                	push   $0x0
8010705c:	68 ca 00 00 00       	push   $0xca
80107061:	e9 8e f1 ff ff       	jmp    801061f4 <alltraps>

80107066 <vector203>:
80107066:	6a 00                	push   $0x0
80107068:	68 cb 00 00 00       	push   $0xcb
8010706d:	e9 82 f1 ff ff       	jmp    801061f4 <alltraps>

80107072 <vector204>:
80107072:	6a 00                	push   $0x0
80107074:	68 cc 00 00 00       	push   $0xcc
80107079:	e9 76 f1 ff ff       	jmp    801061f4 <alltraps>

8010707e <vector205>:
8010707e:	6a 00                	push   $0x0
80107080:	68 cd 00 00 00       	push   $0xcd
80107085:	e9 6a f1 ff ff       	jmp    801061f4 <alltraps>

8010708a <vector206>:
8010708a:	6a 00                	push   $0x0
8010708c:	68 ce 00 00 00       	push   $0xce
80107091:	e9 5e f1 ff ff       	jmp    801061f4 <alltraps>

80107096 <vector207>:
80107096:	6a 00                	push   $0x0
80107098:	68 cf 00 00 00       	push   $0xcf
8010709d:	e9 52 f1 ff ff       	jmp    801061f4 <alltraps>

801070a2 <vector208>:
801070a2:	6a 00                	push   $0x0
801070a4:	68 d0 00 00 00       	push   $0xd0
801070a9:	e9 46 f1 ff ff       	jmp    801061f4 <alltraps>

801070ae <vector209>:
801070ae:	6a 00                	push   $0x0
801070b0:	68 d1 00 00 00       	push   $0xd1
801070b5:	e9 3a f1 ff ff       	jmp    801061f4 <alltraps>

801070ba <vector210>:
801070ba:	6a 00                	push   $0x0
801070bc:	68 d2 00 00 00       	push   $0xd2
801070c1:	e9 2e f1 ff ff       	jmp    801061f4 <alltraps>

801070c6 <vector211>:
801070c6:	6a 00                	push   $0x0
801070c8:	68 d3 00 00 00       	push   $0xd3
801070cd:	e9 22 f1 ff ff       	jmp    801061f4 <alltraps>

801070d2 <vector212>:
801070d2:	6a 00                	push   $0x0
801070d4:	68 d4 00 00 00       	push   $0xd4
801070d9:	e9 16 f1 ff ff       	jmp    801061f4 <alltraps>

801070de <vector213>:
801070de:	6a 00                	push   $0x0
801070e0:	68 d5 00 00 00       	push   $0xd5
801070e5:	e9 0a f1 ff ff       	jmp    801061f4 <alltraps>

801070ea <vector214>:
801070ea:	6a 00                	push   $0x0
801070ec:	68 d6 00 00 00       	push   $0xd6
801070f1:	e9 fe f0 ff ff       	jmp    801061f4 <alltraps>

801070f6 <vector215>:
801070f6:	6a 00                	push   $0x0
801070f8:	68 d7 00 00 00       	push   $0xd7
801070fd:	e9 f2 f0 ff ff       	jmp    801061f4 <alltraps>

80107102 <vector216>:
80107102:	6a 00                	push   $0x0
80107104:	68 d8 00 00 00       	push   $0xd8
80107109:	e9 e6 f0 ff ff       	jmp    801061f4 <alltraps>

8010710e <vector217>:
8010710e:	6a 00                	push   $0x0
80107110:	68 d9 00 00 00       	push   $0xd9
80107115:	e9 da f0 ff ff       	jmp    801061f4 <alltraps>

8010711a <vector218>:
8010711a:	6a 00                	push   $0x0
8010711c:	68 da 00 00 00       	push   $0xda
80107121:	e9 ce f0 ff ff       	jmp    801061f4 <alltraps>

80107126 <vector219>:
80107126:	6a 00                	push   $0x0
80107128:	68 db 00 00 00       	push   $0xdb
8010712d:	e9 c2 f0 ff ff       	jmp    801061f4 <alltraps>

80107132 <vector220>:
80107132:	6a 00                	push   $0x0
80107134:	68 dc 00 00 00       	push   $0xdc
80107139:	e9 b6 f0 ff ff       	jmp    801061f4 <alltraps>

8010713e <vector221>:
8010713e:	6a 00                	push   $0x0
80107140:	68 dd 00 00 00       	push   $0xdd
80107145:	e9 aa f0 ff ff       	jmp    801061f4 <alltraps>

8010714a <vector222>:
8010714a:	6a 00                	push   $0x0
8010714c:	68 de 00 00 00       	push   $0xde
80107151:	e9 9e f0 ff ff       	jmp    801061f4 <alltraps>

80107156 <vector223>:
80107156:	6a 00                	push   $0x0
80107158:	68 df 00 00 00       	push   $0xdf
8010715d:	e9 92 f0 ff ff       	jmp    801061f4 <alltraps>

80107162 <vector224>:
80107162:	6a 00                	push   $0x0
80107164:	68 e0 00 00 00       	push   $0xe0
80107169:	e9 86 f0 ff ff       	jmp    801061f4 <alltraps>

8010716e <vector225>:
8010716e:	6a 00                	push   $0x0
80107170:	68 e1 00 00 00       	push   $0xe1
80107175:	e9 7a f0 ff ff       	jmp    801061f4 <alltraps>

8010717a <vector226>:
8010717a:	6a 00                	push   $0x0
8010717c:	68 e2 00 00 00       	push   $0xe2
80107181:	e9 6e f0 ff ff       	jmp    801061f4 <alltraps>

80107186 <vector227>:
80107186:	6a 00                	push   $0x0
80107188:	68 e3 00 00 00       	push   $0xe3
8010718d:	e9 62 f0 ff ff       	jmp    801061f4 <alltraps>

80107192 <vector228>:
80107192:	6a 00                	push   $0x0
80107194:	68 e4 00 00 00       	push   $0xe4
80107199:	e9 56 f0 ff ff       	jmp    801061f4 <alltraps>

8010719e <vector229>:
8010719e:	6a 00                	push   $0x0
801071a0:	68 e5 00 00 00       	push   $0xe5
801071a5:	e9 4a f0 ff ff       	jmp    801061f4 <alltraps>

801071aa <vector230>:
801071aa:	6a 00                	push   $0x0
801071ac:	68 e6 00 00 00       	push   $0xe6
801071b1:	e9 3e f0 ff ff       	jmp    801061f4 <alltraps>

801071b6 <vector231>:
801071b6:	6a 00                	push   $0x0
801071b8:	68 e7 00 00 00       	push   $0xe7
801071bd:	e9 32 f0 ff ff       	jmp    801061f4 <alltraps>

801071c2 <vector232>:
801071c2:	6a 00                	push   $0x0
801071c4:	68 e8 00 00 00       	push   $0xe8
801071c9:	e9 26 f0 ff ff       	jmp    801061f4 <alltraps>

801071ce <vector233>:
801071ce:	6a 00                	push   $0x0
801071d0:	68 e9 00 00 00       	push   $0xe9
801071d5:	e9 1a f0 ff ff       	jmp    801061f4 <alltraps>

801071da <vector234>:
801071da:	6a 00                	push   $0x0
801071dc:	68 ea 00 00 00       	push   $0xea
801071e1:	e9 0e f0 ff ff       	jmp    801061f4 <alltraps>

801071e6 <vector235>:
801071e6:	6a 00                	push   $0x0
801071e8:	68 eb 00 00 00       	push   $0xeb
801071ed:	e9 02 f0 ff ff       	jmp    801061f4 <alltraps>

801071f2 <vector236>:
801071f2:	6a 00                	push   $0x0
801071f4:	68 ec 00 00 00       	push   $0xec
801071f9:	e9 f6 ef ff ff       	jmp    801061f4 <alltraps>

801071fe <vector237>:
801071fe:	6a 00                	push   $0x0
80107200:	68 ed 00 00 00       	push   $0xed
80107205:	e9 ea ef ff ff       	jmp    801061f4 <alltraps>

8010720a <vector238>:
8010720a:	6a 00                	push   $0x0
8010720c:	68 ee 00 00 00       	push   $0xee
80107211:	e9 de ef ff ff       	jmp    801061f4 <alltraps>

80107216 <vector239>:
80107216:	6a 00                	push   $0x0
80107218:	68 ef 00 00 00       	push   $0xef
8010721d:	e9 d2 ef ff ff       	jmp    801061f4 <alltraps>

80107222 <vector240>:
80107222:	6a 00                	push   $0x0
80107224:	68 f0 00 00 00       	push   $0xf0
80107229:	e9 c6 ef ff ff       	jmp    801061f4 <alltraps>

8010722e <vector241>:
8010722e:	6a 00                	push   $0x0
80107230:	68 f1 00 00 00       	push   $0xf1
80107235:	e9 ba ef ff ff       	jmp    801061f4 <alltraps>

8010723a <vector242>:
8010723a:	6a 00                	push   $0x0
8010723c:	68 f2 00 00 00       	push   $0xf2
80107241:	e9 ae ef ff ff       	jmp    801061f4 <alltraps>

80107246 <vector243>:
80107246:	6a 00                	push   $0x0
80107248:	68 f3 00 00 00       	push   $0xf3
8010724d:	e9 a2 ef ff ff       	jmp    801061f4 <alltraps>

80107252 <vector244>:
80107252:	6a 00                	push   $0x0
80107254:	68 f4 00 00 00       	push   $0xf4
80107259:	e9 96 ef ff ff       	jmp    801061f4 <alltraps>

8010725e <vector245>:
8010725e:	6a 00                	push   $0x0
80107260:	68 f5 00 00 00       	push   $0xf5
80107265:	e9 8a ef ff ff       	jmp    801061f4 <alltraps>

8010726a <vector246>:
8010726a:	6a 00                	push   $0x0
8010726c:	68 f6 00 00 00       	push   $0xf6
80107271:	e9 7e ef ff ff       	jmp    801061f4 <alltraps>

80107276 <vector247>:
80107276:	6a 00                	push   $0x0
80107278:	68 f7 00 00 00       	push   $0xf7
8010727d:	e9 72 ef ff ff       	jmp    801061f4 <alltraps>

80107282 <vector248>:
80107282:	6a 00                	push   $0x0
80107284:	68 f8 00 00 00       	push   $0xf8
80107289:	e9 66 ef ff ff       	jmp    801061f4 <alltraps>

8010728e <vector249>:
8010728e:	6a 00                	push   $0x0
80107290:	68 f9 00 00 00       	push   $0xf9
80107295:	e9 5a ef ff ff       	jmp    801061f4 <alltraps>

8010729a <vector250>:
8010729a:	6a 00                	push   $0x0
8010729c:	68 fa 00 00 00       	push   $0xfa
801072a1:	e9 4e ef ff ff       	jmp    801061f4 <alltraps>

801072a6 <vector251>:
801072a6:	6a 00                	push   $0x0
801072a8:	68 fb 00 00 00       	push   $0xfb
801072ad:	e9 42 ef ff ff       	jmp    801061f4 <alltraps>

801072b2 <vector252>:
801072b2:	6a 00                	push   $0x0
801072b4:	68 fc 00 00 00       	push   $0xfc
801072b9:	e9 36 ef ff ff       	jmp    801061f4 <alltraps>

801072be <vector253>:
801072be:	6a 00                	push   $0x0
801072c0:	68 fd 00 00 00       	push   $0xfd
801072c5:	e9 2a ef ff ff       	jmp    801061f4 <alltraps>

801072ca <vector254>:
801072ca:	6a 00                	push   $0x0
801072cc:	68 fe 00 00 00       	push   $0xfe
801072d1:	e9 1e ef ff ff       	jmp    801061f4 <alltraps>

801072d6 <vector255>:
801072d6:	6a 00                	push   $0x0
801072d8:	68 ff 00 00 00       	push   $0xff
801072dd:	e9 12 ef ff ff       	jmp    801061f4 <alltraps>
	...

801072e4 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
801072e4:	55                   	push   %ebp
801072e5:	89 e5                	mov    %esp,%ebp
801072e7:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801072ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801072ed:	83 e8 01             	sub    $0x1,%eax
801072f0:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801072f4:	8b 45 08             	mov    0x8(%ebp),%eax
801072f7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801072fb:	8b 45 08             	mov    0x8(%ebp),%eax
801072fe:	c1 e8 10             	shr    $0x10,%eax
80107301:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107305:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107308:	0f 01 10             	lgdtl  (%eax)
}
8010730b:	c9                   	leave  
8010730c:	c3                   	ret    

8010730d <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
8010730d:	55                   	push   %ebp
8010730e:	89 e5                	mov    %esp,%ebp
80107310:	83 ec 04             	sub    $0x4,%esp
80107313:	8b 45 08             	mov    0x8(%ebp),%eax
80107316:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
8010731a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010731e:	0f 00 d8             	ltr    %ax
}
80107321:	c9                   	leave  
80107322:	c3                   	ret    

80107323 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107323:	55                   	push   %ebp
80107324:	89 e5                	mov    %esp,%ebp
80107326:	83 ec 04             	sub    $0x4,%esp
80107329:	8b 45 08             	mov    0x8(%ebp),%eax
8010732c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107330:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107334:	8e e8                	mov    %eax,%gs
}
80107336:	c9                   	leave  
80107337:	c3                   	ret    

80107338 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107338:	55                   	push   %ebp
80107339:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010733b:	8b 45 08             	mov    0x8(%ebp),%eax
8010733e:	0f 22 d8             	mov    %eax,%cr3
}
80107341:	5d                   	pop    %ebp
80107342:	c3                   	ret    

80107343 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107343:	55                   	push   %ebp
80107344:	89 e5                	mov    %esp,%ebp
80107346:	8b 45 08             	mov    0x8(%ebp),%eax
80107349:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010734e:	5d                   	pop    %ebp
8010734f:	c3                   	ret    

80107350 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	8b 45 08             	mov    0x8(%ebp),%eax
80107356:	2d 00 00 00 80       	sub    $0x80000000,%eax
8010735b:	5d                   	pop    %ebp
8010735c:	c3                   	ret    

8010735d <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
8010735d:	55                   	push   %ebp
8010735e:	89 e5                	mov    %esp,%ebp
80107360:	53                   	push   %ebx
80107361:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107364:	e8 13 bb ff ff       	call   80102e7c <cpunum>
80107369:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010736f:	05 20 f9 10 80       	add    $0x8010f920,%eax
80107374:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107377:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010737a:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107380:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107383:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107389:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010738c:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107390:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107393:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107397:	83 e2 f0             	and    $0xfffffff0,%edx
8010739a:	83 ca 0a             	or     $0xa,%edx
8010739d:	88 50 7d             	mov    %dl,0x7d(%eax)
801073a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073a3:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801073a7:	83 ca 10             	or     $0x10,%edx
801073aa:	88 50 7d             	mov    %dl,0x7d(%eax)
801073ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073b0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801073b4:	83 e2 9f             	and    $0xffffff9f,%edx
801073b7:	88 50 7d             	mov    %dl,0x7d(%eax)
801073ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073bd:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801073c1:	83 ca 80             	or     $0xffffff80,%edx
801073c4:	88 50 7d             	mov    %dl,0x7d(%eax)
801073c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073ca:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801073ce:	83 ca 0f             	or     $0xf,%edx
801073d1:	88 50 7e             	mov    %dl,0x7e(%eax)
801073d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073d7:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801073db:	83 e2 ef             	and    $0xffffffef,%edx
801073de:	88 50 7e             	mov    %dl,0x7e(%eax)
801073e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073e4:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801073e8:	83 e2 df             	and    $0xffffffdf,%edx
801073eb:	88 50 7e             	mov    %dl,0x7e(%eax)
801073ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073f1:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801073f5:	83 ca 40             	or     $0x40,%edx
801073f8:	88 50 7e             	mov    %dl,0x7e(%eax)
801073fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073fe:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107402:	83 ca 80             	or     $0xffffff80,%edx
80107405:	88 50 7e             	mov    %dl,0x7e(%eax)
80107408:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010740b:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010740f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107412:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107419:	ff ff 
8010741b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010741e:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107425:	00 00 
80107427:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010742a:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107431:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107434:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010743b:	83 e2 f0             	and    $0xfffffff0,%edx
8010743e:	83 ca 02             	or     $0x2,%edx
80107441:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107447:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010744a:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107451:	83 ca 10             	or     $0x10,%edx
80107454:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010745a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010745d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107464:	83 e2 9f             	and    $0xffffff9f,%edx
80107467:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010746d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107470:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107477:	83 ca 80             	or     $0xffffff80,%edx
8010747a:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107483:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010748a:	83 ca 0f             	or     $0xf,%edx
8010748d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107493:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107496:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010749d:	83 e2 ef             	and    $0xffffffef,%edx
801074a0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801074a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074a9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801074b0:	83 e2 df             	and    $0xffffffdf,%edx
801074b3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801074b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074bc:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801074c3:	83 ca 40             	or     $0x40,%edx
801074c6:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801074cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074cf:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801074d6:	83 ca 80             	or     $0xffffff80,%edx
801074d9:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801074df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074e2:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801074e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074ec:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801074f3:	ff ff 
801074f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074f8:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801074ff:	00 00 
80107501:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107504:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010750b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010750e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107515:	83 e2 f0             	and    $0xfffffff0,%edx
80107518:	83 ca 0a             	or     $0xa,%edx
8010751b:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107521:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107524:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010752b:	83 ca 10             	or     $0x10,%edx
8010752e:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107534:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107537:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010753e:	83 ca 60             	or     $0x60,%edx
80107541:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107547:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010754a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107551:	83 ca 80             	or     $0xffffff80,%edx
80107554:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010755a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010755d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107564:	83 ca 0f             	or     $0xf,%edx
80107567:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010756d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107570:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107577:	83 e2 ef             	and    $0xffffffef,%edx
8010757a:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107580:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107583:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010758a:	83 e2 df             	and    $0xffffffdf,%edx
8010758d:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107593:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107596:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010759d:	83 ca 40             	or     $0x40,%edx
801075a0:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801075a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075a9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801075b0:	83 ca 80             	or     $0xffffff80,%edx
801075b3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801075b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075bc:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801075c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c6:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
801075cd:	ff ff 
801075cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075d2:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
801075d9:	00 00 
801075db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075de:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
801075e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075e8:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801075ef:	83 e2 f0             	and    $0xfffffff0,%edx
801075f2:	83 ca 02             	or     $0x2,%edx
801075f5:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801075fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075fe:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107605:	83 ca 10             	or     $0x10,%edx
80107608:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010760e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107611:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107618:	83 ca 60             	or     $0x60,%edx
8010761b:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107621:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107624:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010762b:	83 ca 80             	or     $0xffffff80,%edx
8010762e:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107634:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107637:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010763e:	83 ca 0f             	or     $0xf,%edx
80107641:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107647:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764a:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107651:	83 e2 ef             	and    $0xffffffef,%edx
80107654:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010765a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010765d:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107664:	83 e2 df             	and    $0xffffffdf,%edx
80107667:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010766d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107670:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107677:	83 ca 40             	or     $0x40,%edx
8010767a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107680:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107683:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
8010768a:	83 ca 80             	or     $0xffffff80,%edx
8010768d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107693:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107696:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010769d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a0:	05 b4 00 00 00       	add    $0xb4,%eax
801076a5:	89 c3                	mov    %eax,%ebx
801076a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076aa:	05 b4 00 00 00       	add    $0xb4,%eax
801076af:	c1 e8 10             	shr    $0x10,%eax
801076b2:	89 c1                	mov    %eax,%ecx
801076b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b7:	05 b4 00 00 00       	add    $0xb4,%eax
801076bc:	c1 e8 18             	shr    $0x18,%eax
801076bf:	89 c2                	mov    %eax,%edx
801076c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c4:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801076cb:	00 00 
801076cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d0:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
801076d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076da:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
801076e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076e3:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
801076ea:	83 e1 f0             	and    $0xfffffff0,%ecx
801076ed:	83 c9 02             	or     $0x2,%ecx
801076f0:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801076f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076f9:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107700:	83 c9 10             	or     $0x10,%ecx
80107703:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107709:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010770c:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107713:	83 e1 9f             	and    $0xffffff9f,%ecx
80107716:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
8010771c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771f:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107726:	83 c9 80             	or     $0xffffff80,%ecx
80107729:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
8010772f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107732:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107739:	83 e1 f0             	and    $0xfffffff0,%ecx
8010773c:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107742:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107745:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
8010774c:	83 e1 ef             	and    $0xffffffef,%ecx
8010774f:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107758:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
8010775f:	83 e1 df             	and    $0xffffffdf,%ecx
80107762:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107768:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010776b:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107772:	83 c9 40             	or     $0x40,%ecx
80107775:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
8010777b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777e:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107785:	83 c9 80             	or     $0xffffff80,%ecx
80107788:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
8010778e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107791:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107797:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010779a:	83 c0 70             	add    $0x70,%eax
8010779d:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
801077a4:	00 
801077a5:	89 04 24             	mov    %eax,(%esp)
801077a8:	e8 37 fb ff ff       	call   801072e4 <lgdt>
  loadgs(SEG_KCPU << 3);
801077ad:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
801077b4:	e8 6a fb ff ff       	call   80107323 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
801077b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077bc:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
801077c2:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801077c9:	00 00 00 00 
}
801077cd:	83 c4 24             	add    $0x24,%esp
801077d0:	5b                   	pop    %ebx
801077d1:	5d                   	pop    %ebp
801077d2:	c3                   	ret    

801077d3 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801077d3:	55                   	push   %ebp
801077d4:	89 e5                	mov    %esp,%ebp
801077d6:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801077d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801077dc:	c1 e8 16             	shr    $0x16,%eax
801077df:	c1 e0 02             	shl    $0x2,%eax
801077e2:	03 45 08             	add    0x8(%ebp),%eax
801077e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
801077e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801077eb:	8b 00                	mov    (%eax),%eax
801077ed:	83 e0 01             	and    $0x1,%eax
801077f0:	84 c0                	test   %al,%al
801077f2:	74 17                	je     8010780b <walkpgdir+0x38>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
801077f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801077f7:	8b 00                	mov    (%eax),%eax
801077f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077fe:	89 04 24             	mov    %eax,(%esp)
80107801:	e8 4a fb ff ff       	call   80107350 <p2v>
80107806:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107809:	eb 4b                	jmp    80107856 <walkpgdir+0x83>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010780b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010780f:	74 0e                	je     8010781f <walkpgdir+0x4c>
80107811:	e8 ec b2 ff ff       	call   80102b02 <kalloc>
80107816:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107819:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010781d:	75 07                	jne    80107826 <walkpgdir+0x53>
      return 0;
8010781f:	b8 00 00 00 00       	mov    $0x0,%eax
80107824:	eb 41                	jmp    80107867 <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107826:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010782d:	00 
8010782e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107835:	00 
80107836:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107839:	89 04 24             	mov    %eax,(%esp)
8010783c:	e8 7d d5 ff ff       	call   80104dbe <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107841:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107844:	89 04 24             	mov    %eax,(%esp)
80107847:	e8 f7 fa ff ff       	call   80107343 <v2p>
8010784c:	89 c2                	mov    %eax,%edx
8010784e:	83 ca 07             	or     $0x7,%edx
80107851:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107854:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107856:	8b 45 0c             	mov    0xc(%ebp),%eax
80107859:	c1 e8 0c             	shr    $0xc,%eax
8010785c:	25 ff 03 00 00       	and    $0x3ff,%eax
80107861:	c1 e0 02             	shl    $0x2,%eax
80107864:	03 45 f4             	add    -0xc(%ebp),%eax
}
80107867:	c9                   	leave  
80107868:	c3                   	ret    

80107869 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107869:	55                   	push   %ebp
8010786a:	89 e5                	mov    %esp,%ebp
8010786c:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
8010786f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107872:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107877:	89 45 ec             	mov    %eax,-0x14(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010787a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010787d:	03 45 10             	add    0x10(%ebp),%eax
80107880:	83 e8 01             	sub    $0x1,%eax
80107883:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107888:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010788b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107892:	00 
80107893:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107896:	89 44 24 04          	mov    %eax,0x4(%esp)
8010789a:	8b 45 08             	mov    0x8(%ebp),%eax
8010789d:	89 04 24             	mov    %eax,(%esp)
801078a0:	e8 2e ff ff ff       	call   801077d3 <walkpgdir>
801078a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801078a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801078ac:	75 07                	jne    801078b5 <mappages+0x4c>
      return -1;
801078ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801078b3:	eb 47                	jmp    801078fc <mappages+0x93>
    if(*pte & PTE_P)
801078b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b8:	8b 00                	mov    (%eax),%eax
801078ba:	83 e0 01             	and    $0x1,%eax
801078bd:	84 c0                	test   %al,%al
801078bf:	74 0c                	je     801078cd <mappages+0x64>
      panic("remap");
801078c1:	c7 04 24 e4 86 10 80 	movl   $0x801086e4,(%esp)
801078c8:	e8 6d 8c ff ff       	call   8010053a <panic>
    *pte = pa | perm | PTE_P;
801078cd:	8b 45 18             	mov    0x18(%ebp),%eax
801078d0:	0b 45 14             	or     0x14(%ebp),%eax
801078d3:	89 c2                	mov    %eax,%edx
801078d5:	83 ca 01             	or     $0x1,%edx
801078d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078db:	89 10                	mov    %edx,(%eax)
    if(a == last)
801078dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801078e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801078e3:	75 07                	jne    801078ec <mappages+0x83>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801078e5:	b8 00 00 00 00       	mov    $0x0,%eax
801078ea:	eb 10                	jmp    801078fc <mappages+0x93>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
801078ec:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
    pa += PGSIZE;
801078f3:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
801078fa:	eb 8f                	jmp    8010788b <mappages+0x22>
  return 0;
}
801078fc:	c9                   	leave  
801078fd:	c3                   	ret    

801078fe <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm()
{
801078fe:	55                   	push   %ebp
801078ff:	89 e5                	mov    %esp,%ebp
80107901:	53                   	push   %ebx
80107902:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107905:	e8 f8 b1 ff ff       	call   80102b02 <kalloc>
8010790a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010790d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107911:	75 0a                	jne    8010791d <setupkvm+0x1f>
    return 0;
80107913:	b8 00 00 00 00       	mov    $0x0,%eax
80107918:	e9 99 00 00 00       	jmp    801079b6 <setupkvm+0xb8>
  memset(pgdir, 0, PGSIZE);
8010791d:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107924:	00 
80107925:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010792c:	00 
8010792d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107930:	89 04 24             	mov    %eax,(%esp)
80107933:	e8 86 d4 ff ff       	call   80104dbe <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107938:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
8010793f:	e8 0c fa ff ff       	call   80107350 <p2v>
80107944:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107949:	76 0c                	jbe    80107957 <setupkvm+0x59>
    panic("PHYSTOP too high");
8010794b:	c7 04 24 ea 86 10 80 	movl   $0x801086ea,(%esp)
80107952:	e8 e3 8b ff ff       	call   8010053a <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107957:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
8010795e:	eb 49                	jmp    801079a9 <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107960:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107963:	8b 48 0c             	mov    0xc(%eax),%ecx
80107966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107969:	8b 50 04             	mov    0x4(%eax),%edx
8010796c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796f:	8b 58 08             	mov    0x8(%eax),%ebx
80107972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107975:	8b 40 04             	mov    0x4(%eax),%eax
80107978:	29 c3                	sub    %eax,%ebx
8010797a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797d:	8b 00                	mov    (%eax),%eax
8010797f:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107983:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107987:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010798b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010798f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107992:	89 04 24             	mov    %eax,(%esp)
80107995:	e8 cf fe ff ff       	call   80107869 <mappages>
8010799a:	85 c0                	test   %eax,%eax
8010799c:	79 07                	jns    801079a5 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
8010799e:	b8 00 00 00 00       	mov    $0x0,%eax
801079a3:	eb 11                	jmp    801079b6 <setupkvm+0xb8>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801079a5:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801079a9:	b8 e0 b4 10 80       	mov    $0x8010b4e0,%eax
801079ae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801079b1:	72 ad                	jb     80107960 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
801079b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801079b6:	83 c4 34             	add    $0x34,%esp
801079b9:	5b                   	pop    %ebx
801079ba:	5d                   	pop    %ebp
801079bb:	c3                   	ret    

801079bc <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801079bc:	55                   	push   %ebp
801079bd:	89 e5                	mov    %esp,%ebp
801079bf:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801079c2:	e8 37 ff ff ff       	call   801078fe <setupkvm>
801079c7:	a3 f8 26 11 80       	mov    %eax,0x801126f8
  switchkvm();
801079cc:	e8 02 00 00 00       	call   801079d3 <switchkvm>
}
801079d1:	c9                   	leave  
801079d2:	c3                   	ret    

801079d3 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801079d3:	55                   	push   %ebp
801079d4:	89 e5                	mov    %esp,%ebp
801079d6:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
801079d9:	a1 f8 26 11 80       	mov    0x801126f8,%eax
801079de:	89 04 24             	mov    %eax,(%esp)
801079e1:	e8 5d f9 ff ff       	call   80107343 <v2p>
801079e6:	89 04 24             	mov    %eax,(%esp)
801079e9:	e8 4a f9 ff ff       	call   80107338 <lcr3>
}
801079ee:	c9                   	leave  
801079ef:	c3                   	ret    

801079f0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	53                   	push   %ebx
801079f4:	83 ec 14             	sub    $0x14,%esp
  pushcli();
801079f7:	e8 bc d2 ff ff       	call   80104cb8 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801079fc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107a02:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a09:	83 c2 08             	add    $0x8,%edx
80107a0c:	89 d3                	mov    %edx,%ebx
80107a0e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a15:	83 c2 08             	add    $0x8,%edx
80107a18:	c1 ea 10             	shr    $0x10,%edx
80107a1b:	89 d1                	mov    %edx,%ecx
80107a1d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a24:	83 c2 08             	add    $0x8,%edx
80107a27:	c1 ea 18             	shr    $0x18,%edx
80107a2a:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107a31:	67 00 
80107a33:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107a3a:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107a40:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107a47:	83 e1 f0             	and    $0xfffffff0,%ecx
80107a4a:	83 c9 09             	or     $0x9,%ecx
80107a4d:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107a53:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107a5a:	83 c9 10             	or     $0x10,%ecx
80107a5d:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107a63:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107a6a:	83 e1 9f             	and    $0xffffff9f,%ecx
80107a6d:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107a73:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107a7a:	83 c9 80             	or     $0xffffff80,%ecx
80107a7d:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107a83:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107a8a:	83 e1 f0             	and    $0xfffffff0,%ecx
80107a8d:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107a93:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107a9a:	83 e1 ef             	and    $0xffffffef,%ecx
80107a9d:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107aa3:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107aaa:	83 e1 df             	and    $0xffffffdf,%ecx
80107aad:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ab3:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107aba:	83 c9 40             	or     $0x40,%ecx
80107abd:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ac3:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107aca:	83 e1 7f             	and    $0x7f,%ecx
80107acd:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107ad3:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107ad9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107adf:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107ae6:	83 e2 ef             	and    $0xffffffef,%edx
80107ae9:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107aef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107af5:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107afb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107b01:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107b08:	8b 52 08             	mov    0x8(%edx),%edx
80107b0b:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107b11:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107b14:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
80107b1b:	e8 ed f7 ff ff       	call   8010730d <ltr>
  if(p->pgdir == 0)
80107b20:	8b 45 08             	mov    0x8(%ebp),%eax
80107b23:	8b 40 04             	mov    0x4(%eax),%eax
80107b26:	85 c0                	test   %eax,%eax
80107b28:	75 0c                	jne    80107b36 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
80107b2a:	c7 04 24 fb 86 10 80 	movl   $0x801086fb,(%esp)
80107b31:	e8 04 8a ff ff       	call   8010053a <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107b36:	8b 45 08             	mov    0x8(%ebp),%eax
80107b39:	8b 40 04             	mov    0x4(%eax),%eax
80107b3c:	89 04 24             	mov    %eax,(%esp)
80107b3f:	e8 ff f7 ff ff       	call   80107343 <v2p>
80107b44:	89 04 24             	mov    %eax,(%esp)
80107b47:	e8 ec f7 ff ff       	call   80107338 <lcr3>
  popcli();
80107b4c:	e8 af d1 ff ff       	call   80104d00 <popcli>
}
80107b51:	83 c4 14             	add    $0x14,%esp
80107b54:	5b                   	pop    %ebx
80107b55:	5d                   	pop    %ebp
80107b56:	c3                   	ret    

80107b57 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107b57:	55                   	push   %ebp
80107b58:	89 e5                	mov    %esp,%ebp
80107b5a:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107b5d:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107b64:	76 0c                	jbe    80107b72 <inituvm+0x1b>
    panic("inituvm: more than a page");
80107b66:	c7 04 24 0f 87 10 80 	movl   $0x8010870f,(%esp)
80107b6d:	e8 c8 89 ff ff       	call   8010053a <panic>
  mem = kalloc();
80107b72:	e8 8b af ff ff       	call   80102b02 <kalloc>
80107b77:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107b7a:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107b81:	00 
80107b82:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107b89:	00 
80107b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8d:	89 04 24             	mov    %eax,(%esp)
80107b90:	e8 29 d2 ff ff       	call   80104dbe <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b98:	89 04 24             	mov    %eax,(%esp)
80107b9b:	e8 a3 f7 ff ff       	call   80107343 <v2p>
80107ba0:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80107ba7:	00 
80107ba8:	89 44 24 0c          	mov    %eax,0xc(%esp)
80107bac:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107bb3:	00 
80107bb4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107bbb:	00 
80107bbc:	8b 45 08             	mov    0x8(%ebp),%eax
80107bbf:	89 04 24             	mov    %eax,(%esp)
80107bc2:	e8 a2 fc ff ff       	call   80107869 <mappages>
  memmove(mem, init, sz);
80107bc7:	8b 45 10             	mov    0x10(%ebp),%eax
80107bca:	89 44 24 08          	mov    %eax,0x8(%esp)
80107bce:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80107bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd8:	89 04 24             	mov    %eax,(%esp)
80107bdb:	e8 b1 d2 ff ff       	call   80104e91 <memmove>
}
80107be0:	c9                   	leave  
80107be1:	c3                   	ret    

80107be2 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107be2:	55                   	push   %ebp
80107be3:	89 e5                	mov    %esp,%ebp
80107be5:	53                   	push   %ebx
80107be6:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107be9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bec:	25 ff 0f 00 00       	and    $0xfff,%eax
80107bf1:	85 c0                	test   %eax,%eax
80107bf3:	74 0c                	je     80107c01 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80107bf5:	c7 04 24 2c 87 10 80 	movl   $0x8010872c,(%esp)
80107bfc:	e8 39 89 ff ff       	call   8010053a <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107c01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80107c08:	e9 ae 00 00 00       	jmp    80107cbb <loaduvm+0xd9>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107c0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c10:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c13:	8d 04 02             	lea    (%edx,%eax,1),%eax
80107c16:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107c1d:	00 
80107c1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80107c22:	8b 45 08             	mov    0x8(%ebp),%eax
80107c25:	89 04 24             	mov    %eax,(%esp)
80107c28:	e8 a6 fb ff ff       	call   801077d3 <walkpgdir>
80107c2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c30:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107c34:	75 0c                	jne    80107c42 <loaduvm+0x60>
      panic("loaduvm: address should exist");
80107c36:	c7 04 24 4f 87 10 80 	movl   $0x8010874f,(%esp)
80107c3d:	e8 f8 88 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
80107c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c45:	8b 00                	mov    (%eax),%eax
80107c47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(sz - i < PGSIZE)
80107c4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c52:	8b 55 18             	mov    0x18(%ebp),%edx
80107c55:	89 d1                	mov    %edx,%ecx
80107c57:	29 c1                	sub    %eax,%ecx
80107c59:	89 c8                	mov    %ecx,%eax
80107c5b:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107c60:	77 11                	ja     80107c73 <loaduvm+0x91>
      n = sz - i;
80107c62:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c65:	8b 55 18             	mov    0x18(%ebp),%edx
80107c68:	89 d1                	mov    %edx,%ecx
80107c6a:	29 c1                	sub    %eax,%ecx
80107c6c:	89 c8                	mov    %ecx,%eax
80107c6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c71:	eb 07                	jmp    80107c7a <loaduvm+0x98>
    else
      n = PGSIZE;
80107c73:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107c7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c7d:	8b 55 14             	mov    0x14(%ebp),%edx
80107c80:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107c83:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c86:	89 04 24             	mov    %eax,(%esp)
80107c89:	e8 c2 f6 ff ff       	call   80107350 <p2v>
80107c8e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107c91:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107c95:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107c99:	89 44 24 04          	mov    %eax,0x4(%esp)
80107c9d:	8b 45 10             	mov    0x10(%ebp),%eax
80107ca0:	89 04 24             	mov    %eax,(%esp)
80107ca3:	e8 d4 a0 ff ff       	call   80101d7c <readi>
80107ca8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107cab:	74 07                	je     80107cb4 <loaduvm+0xd2>
      return -1;
80107cad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107cb2:	eb 18                	jmp    80107ccc <loaduvm+0xea>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107cb4:	81 45 e8 00 10 00 00 	addl   $0x1000,-0x18(%ebp)
80107cbb:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107cbe:	3b 45 18             	cmp    0x18(%ebp),%eax
80107cc1:	0f 82 46 ff ff ff    	jb     80107c0d <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107cc7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ccc:	83 c4 24             	add    $0x24,%esp
80107ccf:	5b                   	pop    %ebx
80107cd0:	5d                   	pop    %ebp
80107cd1:	c3                   	ret    

80107cd2 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107cd2:	55                   	push   %ebp
80107cd3:	89 e5                	mov    %esp,%ebp
80107cd5:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107cd8:	8b 45 10             	mov    0x10(%ebp),%eax
80107cdb:	85 c0                	test   %eax,%eax
80107cdd:	79 0a                	jns    80107ce9 <allocuvm+0x17>
    return 0;
80107cdf:	b8 00 00 00 00       	mov    $0x0,%eax
80107ce4:	e9 c1 00 00 00       	jmp    80107daa <allocuvm+0xd8>
  if(newsz < oldsz)
80107ce9:	8b 45 10             	mov    0x10(%ebp),%eax
80107cec:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107cef:	73 08                	jae    80107cf9 <allocuvm+0x27>
    return oldsz;
80107cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
80107cf4:	e9 b1 00 00 00       	jmp    80107daa <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
80107cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107cfc:	05 ff 0f 00 00       	add    $0xfff,%eax
80107d01:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d06:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107d09:	e9 8d 00 00 00       	jmp    80107d9b <allocuvm+0xc9>
    mem = kalloc();
80107d0e:	e8 ef ad ff ff       	call   80102b02 <kalloc>
80107d13:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107d16:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107d1a:	75 2c                	jne    80107d48 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
80107d1c:	c7 04 24 6d 87 10 80 	movl   $0x8010876d,(%esp)
80107d23:	e8 72 86 ff ff       	call   8010039a <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80107d28:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80107d2f:	8b 45 10             	mov    0x10(%ebp),%eax
80107d32:	89 44 24 04          	mov    %eax,0x4(%esp)
80107d36:	8b 45 08             	mov    0x8(%ebp),%eax
80107d39:	89 04 24             	mov    %eax,(%esp)
80107d3c:	e8 6b 00 00 00       	call   80107dac <deallocuvm>
      return 0;
80107d41:	b8 00 00 00 00       	mov    $0x0,%eax
80107d46:	eb 62                	jmp    80107daa <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
80107d48:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107d4f:	00 
80107d50:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107d57:	00 
80107d58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d5b:	89 04 24             	mov    %eax,(%esp)
80107d5e:	e8 5b d0 ff ff       	call   80104dbe <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107d63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d66:	89 04 24             	mov    %eax,(%esp)
80107d69:	e8 d5 f5 ff ff       	call   80107343 <v2p>
80107d6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107d71:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80107d78:	00 
80107d79:	89 44 24 0c          	mov    %eax,0xc(%esp)
80107d7d:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107d84:	00 
80107d85:	89 54 24 04          	mov    %edx,0x4(%esp)
80107d89:	8b 45 08             	mov    0x8(%ebp),%eax
80107d8c:	89 04 24             	mov    %eax,(%esp)
80107d8f:	e8 d5 fa ff ff       	call   80107869 <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107d94:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9e:	3b 45 10             	cmp    0x10(%ebp),%eax
80107da1:	0f 82 67 ff ff ff    	jb     80107d0e <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107da7:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107daa:	c9                   	leave  
80107dab:	c3                   	ret    

80107dac <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107dac:	55                   	push   %ebp
80107dad:	89 e5                	mov    %esp,%ebp
80107daf:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107db2:	8b 45 10             	mov    0x10(%ebp),%eax
80107db5:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107db8:	72 08                	jb     80107dc2 <deallocuvm+0x16>
    return oldsz;
80107dba:	8b 45 0c             	mov    0xc(%ebp),%eax
80107dbd:	e9 a4 00 00 00       	jmp    80107e66 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
80107dc2:	8b 45 10             	mov    0x10(%ebp),%eax
80107dc5:	05 ff 0f 00 00       	add    $0xfff,%eax
80107dca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107dcf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107dd2:	e9 80 00 00 00       	jmp    80107e57 <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107dd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107dda:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107de1:	00 
80107de2:	89 44 24 04          	mov    %eax,0x4(%esp)
80107de6:	8b 45 08             	mov    0x8(%ebp),%eax
80107de9:	89 04 24             	mov    %eax,(%esp)
80107dec:	e8 e2 f9 ff ff       	call   801077d3 <walkpgdir>
80107df1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(!pte)
80107df4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80107df8:	75 09                	jne    80107e03 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
80107dfa:	81 45 ec 00 f0 3f 00 	addl   $0x3ff000,-0x14(%ebp)
80107e01:	eb 4d                	jmp    80107e50 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80107e03:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107e06:	8b 00                	mov    (%eax),%eax
80107e08:	83 e0 01             	and    $0x1,%eax
80107e0b:	84 c0                	test   %al,%al
80107e0d:	74 41                	je     80107e50 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
80107e0f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107e12:	8b 00                	mov    (%eax),%eax
80107e14:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e19:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(pa == 0)
80107e1c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e20:	75 0c                	jne    80107e2e <deallocuvm+0x82>
        panic("kfree");
80107e22:	c7 04 24 85 87 10 80 	movl   $0x80108785,(%esp)
80107e29:	e8 0c 87 ff ff       	call   8010053a <panic>
      char *v = p2v(pa);
80107e2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e31:	89 04 24             	mov    %eax,(%esp)
80107e34:	e8 17 f5 ff ff       	call   80107350 <p2v>
80107e39:	89 45 f4             	mov    %eax,-0xc(%ebp)
      kfree(v);
80107e3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3f:	89 04 24             	mov    %eax,(%esp)
80107e42:	e8 22 ac ff ff       	call   80102a69 <kfree>
      *pte = 0;
80107e47:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107e4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e50:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
80107e57:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e5a:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107e5d:	0f 82 74 ff ff ff    	jb     80107dd7 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80107e63:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107e66:	c9                   	leave  
80107e67:	c3                   	ret    

80107e68 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107e68:	55                   	push   %ebp
80107e69:	89 e5                	mov    %esp,%ebp
80107e6b:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
80107e6e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80107e72:	75 0c                	jne    80107e80 <freevm+0x18>
    panic("freevm: no pgdir");
80107e74:	c7 04 24 8b 87 10 80 	movl   $0x8010878b,(%esp)
80107e7b:	e8 ba 86 ff ff       	call   8010053a <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80107e80:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107e87:	00 
80107e88:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80107e8f:	80 
80107e90:	8b 45 08             	mov    0x8(%ebp),%eax
80107e93:	89 04 24             	mov    %eax,(%esp)
80107e96:	e8 11 ff ff ff       	call   80107dac <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
80107e9b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80107ea2:	eb 3c                	jmp    80107ee0 <freevm+0x78>
    if(pgdir[i] & PTE_P){
80107ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ea7:	c1 e0 02             	shl    $0x2,%eax
80107eaa:	03 45 08             	add    0x8(%ebp),%eax
80107ead:	8b 00                	mov    (%eax),%eax
80107eaf:	83 e0 01             	and    $0x1,%eax
80107eb2:	84 c0                	test   %al,%al
80107eb4:	74 26                	je     80107edc <freevm+0x74>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80107eb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107eb9:	c1 e0 02             	shl    $0x2,%eax
80107ebc:	03 45 08             	add    0x8(%ebp),%eax
80107ebf:	8b 00                	mov    (%eax),%eax
80107ec1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ec6:	89 04 24             	mov    %eax,(%esp)
80107ec9:	e8 82 f4 ff ff       	call   80107350 <p2v>
80107ece:	89 45 f4             	mov    %eax,-0xc(%ebp)
      kfree(v);
80107ed1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed4:	89 04 24             	mov    %eax,(%esp)
80107ed7:	e8 8d ab ff ff       	call   80102a69 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107edc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80107ee0:	81 7d f0 ff 03 00 00 	cmpl   $0x3ff,-0x10(%ebp)
80107ee7:	76 bb                	jbe    80107ea4 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80107eec:	89 04 24             	mov    %eax,(%esp)
80107eef:	e8 75 ab ff ff       	call   80102a69 <kfree>
}
80107ef4:	c9                   	leave  
80107ef5:	c3                   	ret    

80107ef6 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107ef6:	55                   	push   %ebp
80107ef7:	89 e5                	mov    %esp,%ebp
80107ef9:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107efc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107f03:	00 
80107f04:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f07:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f0b:	8b 45 08             	mov    0x8(%ebp),%eax
80107f0e:	89 04 24             	mov    %eax,(%esp)
80107f11:	e8 bd f8 ff ff       	call   801077d3 <walkpgdir>
80107f16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80107f19:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107f1d:	75 0c                	jne    80107f2b <clearpteu+0x35>
    panic("clearpteu");
80107f1f:	c7 04 24 9c 87 10 80 	movl   $0x8010879c,(%esp)
80107f26:	e8 0f 86 ff ff       	call   8010053a <panic>
  *pte &= ~PTE_U;
80107f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f2e:	8b 00                	mov    (%eax),%eax
80107f30:	89 c2                	mov    %eax,%edx
80107f32:	83 e2 fb             	and    $0xfffffffb,%edx
80107f35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f38:	89 10                	mov    %edx,(%eax)
}
80107f3a:	c9                   	leave  
80107f3b:	c3                   	ret    

80107f3c <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107f3c:	55                   	push   %ebp
80107f3d:	89 e5                	mov    %esp,%ebp
80107f3f:	83 ec 48             	sub    $0x48,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80107f42:	e8 b7 f9 ff ff       	call   801078fe <setupkvm>
80107f47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107f4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80107f4e:	75 0a                	jne    80107f5a <copyuvm+0x1e>
    return 0;
80107f50:	b8 00 00 00 00       	mov    $0x0,%eax
80107f55:	e9 f1 00 00 00       	jmp    8010804b <copyuvm+0x10f>
  for(i = 0; i < sz; i += PGSIZE){
80107f5a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80107f61:	e9 c0 00 00 00       	jmp    80108026 <copyuvm+0xea>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107f66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107f69:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80107f70:	00 
80107f71:	89 44 24 04          	mov    %eax,0x4(%esp)
80107f75:	8b 45 08             	mov    0x8(%ebp),%eax
80107f78:	89 04 24             	mov    %eax,(%esp)
80107f7b:	e8 53 f8 ff ff       	call   801077d3 <walkpgdir>
80107f80:	89 45 e8             	mov    %eax,-0x18(%ebp)
80107f83:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80107f87:	75 0c                	jne    80107f95 <copyuvm+0x59>
      panic("copyuvm: pte should exist");
80107f89:	c7 04 24 a6 87 10 80 	movl   $0x801087a6,(%esp)
80107f90:	e8 a5 85 ff ff       	call   8010053a <panic>
    if(!(*pte & PTE_P))
80107f95:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107f98:	8b 00                	mov    (%eax),%eax
80107f9a:	83 e0 01             	and    $0x1,%eax
80107f9d:	85 c0                	test   %eax,%eax
80107f9f:	75 0c                	jne    80107fad <copyuvm+0x71>
      panic("copyuvm: page not present");
80107fa1:	c7 04 24 c0 87 10 80 	movl   $0x801087c0,(%esp)
80107fa8:	e8 8d 85 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
80107fad:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107fb0:	8b 00                	mov    (%eax),%eax
80107fb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((mem = kalloc()) == 0)
80107fba:	e8 43 ab ff ff       	call   80102b02 <kalloc>
80107fbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107fc2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107fc6:	74 6f                	je     80108037 <copyuvm+0xfb>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80107fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107fcb:	89 04 24             	mov    %eax,(%esp)
80107fce:	e8 7d f3 ff ff       	call   80107350 <p2v>
80107fd3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107fda:	00 
80107fdb:	89 44 24 04          	mov    %eax,0x4(%esp)
80107fdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fe2:	89 04 24             	mov    %eax,(%esp)
80107fe5:	e8 a7 ce ff ff       	call   80104e91 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80107fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fed:	89 04 24             	mov    %eax,(%esp)
80107ff0:	e8 4e f3 ff ff       	call   80107343 <v2p>
80107ff5:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107ff8:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
80107fff:	00 
80108000:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108004:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010800b:	00 
8010800c:	89 54 24 04          	mov    %edx,0x4(%esp)
80108010:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108013:	89 04 24             	mov    %eax,(%esp)
80108016:	e8 4e f8 ff ff       	call   80107869 <mappages>
8010801b:	85 c0                	test   %eax,%eax
8010801d:	78 1b                	js     8010803a <copyuvm+0xfe>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010801f:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
80108026:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108029:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010802c:	0f 82 34 ff ff ff    	jb     80107f66 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108032:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108035:	eb 14                	jmp    8010804b <copyuvm+0x10f>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
80108037:	90                   	nop
80108038:	eb 01                	jmp    8010803b <copyuvm+0xff>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
8010803a:	90                   	nop
  }
  return d;

bad:
  freevm(d);
8010803b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010803e:	89 04 24             	mov    %eax,(%esp)
80108041:	e8 22 fe ff ff       	call   80107e68 <freevm>
  return 0;
80108046:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010804b:	c9                   	leave  
8010804c:	c3                   	ret    

8010804d <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010804d:	55                   	push   %ebp
8010804e:	89 e5                	mov    %esp,%ebp
80108050:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108053:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010805a:	00 
8010805b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010805e:	89 44 24 04          	mov    %eax,0x4(%esp)
80108062:	8b 45 08             	mov    0x8(%ebp),%eax
80108065:	89 04 24             	mov    %eax,(%esp)
80108068:	e8 66 f7 ff ff       	call   801077d3 <walkpgdir>
8010806d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108070:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108073:	8b 00                	mov    (%eax),%eax
80108075:	83 e0 01             	and    $0x1,%eax
80108078:	85 c0                	test   %eax,%eax
8010807a:	75 07                	jne    80108083 <uva2ka+0x36>
    return 0;
8010807c:	b8 00 00 00 00       	mov    $0x0,%eax
80108081:	eb 25                	jmp    801080a8 <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
80108083:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108086:	8b 00                	mov    (%eax),%eax
80108088:	83 e0 04             	and    $0x4,%eax
8010808b:	85 c0                	test   %eax,%eax
8010808d:	75 07                	jne    80108096 <uva2ka+0x49>
    return 0;
8010808f:	b8 00 00 00 00       	mov    $0x0,%eax
80108094:	eb 12                	jmp    801080a8 <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
80108096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108099:	8b 00                	mov    (%eax),%eax
8010809b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080a0:	89 04 24             	mov    %eax,(%esp)
801080a3:	e8 a8 f2 ff ff       	call   80107350 <p2v>
}
801080a8:	c9                   	leave  
801080a9:	c3                   	ret    

801080aa <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801080aa:	55                   	push   %ebp
801080ab:	89 e5                	mov    %esp,%ebp
801080ad:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801080b0:	8b 45 10             	mov    0x10(%ebp),%eax
801080b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  while(len > 0){
801080b6:	e9 8b 00 00 00       	jmp    80108146 <copyout+0x9c>
    va0 = (uint)PGROUNDDOWN(va);
801080bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801080be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801080c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801080cd:	8b 45 08             	mov    0x8(%ebp),%eax
801080d0:	89 04 24             	mov    %eax,(%esp)
801080d3:	e8 75 ff ff ff       	call   8010804d <uva2ka>
801080d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pa0 == 0)
801080db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080df:	75 07                	jne    801080e8 <copyout+0x3e>
      return -1;
801080e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080e6:	eb 6d                	jmp    80108155 <copyout+0xab>
    n = PGSIZE - (va - va0);
801080e8:	8b 45 0c             	mov    0xc(%ebp),%eax
801080eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801080ee:	89 d1                	mov    %edx,%ecx
801080f0:	29 c1                	sub    %eax,%ecx
801080f2:	89 c8                	mov    %ecx,%eax
801080f4:	05 00 10 00 00       	add    $0x1000,%eax
801080f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801080fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801080ff:	3b 45 14             	cmp    0x14(%ebp),%eax
80108102:	76 06                	jbe    8010810a <copyout+0x60>
      n = len;
80108104:	8b 45 14             	mov    0x14(%ebp),%eax
80108107:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010810a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010810d:	8b 55 0c             	mov    0xc(%ebp),%edx
80108110:	89 d1                	mov    %edx,%ecx
80108112:	29 c1                	sub    %eax,%ecx
80108114:	89 c8                	mov    %ecx,%eax
80108116:	03 45 ec             	add    -0x14(%ebp),%eax
80108119:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010811c:	89 54 24 08          	mov    %edx,0x8(%esp)
80108120:	8b 55 e8             	mov    -0x18(%ebp),%edx
80108123:	89 54 24 04          	mov    %edx,0x4(%esp)
80108127:	89 04 24             	mov    %eax,(%esp)
8010812a:	e8 62 cd ff ff       	call   80104e91 <memmove>
    len -= n;
8010812f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108132:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108135:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108138:	01 45 e8             	add    %eax,-0x18(%ebp)
    va = va0 + PGSIZE;
8010813b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010813e:	05 00 10 00 00       	add    $0x1000,%eax
80108143:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108146:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010814a:	0f 85 6b ff ff ff    	jne    801080bb <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108150:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108155:	c9                   	leave  
80108156:	c3                   	ret    
