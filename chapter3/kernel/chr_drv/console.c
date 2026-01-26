#include <linux/tty.h>

#define ORIG_X (*(unsigned char *)0x90000)
#define ORIG_Y (*(unsigned char *)0x90001)
#define ORIG_VIDEO_PAGE (*(unsigned short *)0x90004)
#define ORIG_VIDEO_MODE ((*(unsigned short *)0x90006) & 0xff)
#define ORIG_VIDEO_COLS (((*(unsigned short *)0x90006) & 0xff00) >> 8)
#define ORIG_VIDEO_LINES ((*(unsigned short *)0x9000e) & 0xff)
#define ORIG_VIDEO_EGA_AX (*(unsigned short *)0x90008)
#define ORIG_VIDEO_EGA_BX (*(unsigned short *)0x9000a)
#define ORIG_VIDEO_EGA_CX (*(unsigned short *)0x9000c)

#define VIDEO_TYPE_MDA 0x10
#define VIDEO_TYPE_CGA 0x11
#define VIDEO_TYPE_EGAM 0x20
#define VIDEO_TYPE_EGAC 0x21

static unsigned char video_type;
static unsigned long video_num_columns;
static unsigned long video_num_lines;
static unsigned long video_mem_base;
static unsigned long video_mem_term;
static unsigned long video_size_row;
static unsigned char video_page;
static unsigned short video_port_reg;
static unsigned short video_port_val;

void con_init() {
  char *display_desc = "????";
  char *display_ptr;

  video_num_columns = ORIG_VIDEO_COLS;
  video_size_row = video_num_columns * 2;
  video_num_lines = ORIG_VIDEO_LINES;
  video_page = ORIG_VIDEO_PAGE;

  if (ORIG_VIDEO_MODE == 7) {
    //
  } else { // color display
    video_mem_base = 0xb8000;
    video_port_reg = 0x3d4;
    video_port_val = 0x3d5;

    if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10) {
      video_type = VIDEO_TYPE_EGAC;
      video_mem_term = 0xc0000;
      display_desc = "EGAc";
    } else {
      //
    }
  }
  display_ptr = ((char *)video_mem_base) + video_size_row - 8;
  while (*display_desc) {
    *display_ptr++ = *display_desc++;
    *display_ptr++;
  }
}
