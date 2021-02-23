
#include <gba_base.h>
#include <gba_video.h>
#include <gba_systemcalls.h>
#include <gba_interrupt.h>

#define RGB16(r,g,b)  ((r)+((g)<<5)+((b)<<10)) 

int main()
{
	int x,y,g = 0;  

	// Set up the interrupt handlers
	irqInit();
	// Enable Vblank Interrupt to allow VblankIntrWait
	irqEnable(IRQ_VBLANK);
 
	// Allow Interrupts
	REG_IME = 1;

  // GBA's VRAM is located at address 0x6000000. 
  // Screen memory in MODE 3 is located at the same place
  volatile unsigned short* screen = (unsigned short*)0x6000000;
  // GBA's graphics chip is controled by registers located at 0x4000000 
  volatile unsigned int* video_regs = (unsigned int*) 0x4000000; // mode3, bg2 on (16 bits RGB)
  // Configure the screen at mode 3 using the display mode register
  video_regs[0] = 0x403; // mode3, bg2 on (16 bits RGB)

    for(int i = 0; i < 160*240; i++)
        screen[i] = 0x7fff;

    /*for(x = 20; x < 221; x++)
    {
        screen[x+30*240] = 0;
        screen[x+150*240] = 0;
    }

    for(y = 30; y < 150; y++)
    {
        screen[20+y*240] = 0;
        screen[220+y*240] = 0;
    }*/

    unsigned short* place = &screen[20+30*240];

    for(int i = 20; i < 221; i++)
        *place++ = 0;

    place = place + 39 + 120*240;
    for(int i = 20; i < 221; i++)
        *place++ = 0;

    place = place - 201 - 120*240;
    for(int i = 30; i < 150; i++)
    {
        *place = 0;
        place+=200;
        *place = 0;
        place+=40;
    }
    


	while(1) {
		VBlankIntrWait();

    // Fill scren
    /*for(y = 0; y<160; y++) 
      for(x = 0; x<240;x++)
        screen[x + y * 240] = RGB16(y & 31, g, x & 31);*/

    
    g++;
  }
}


