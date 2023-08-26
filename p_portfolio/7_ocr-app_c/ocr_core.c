#include "ocr_core.h"
#include <stdio.h>
#include "io_filter.h"
#include "img_proc.h"

void run_core_funcs(void)
{
    printf("Running core OCR and I/O functions ...\n");

    ProcList l;
    
    l.fname = get_fname();
    get_img_props(&l);
    get_bounded_vals();
    proc_img();
}
