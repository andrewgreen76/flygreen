#include "ocr_core.h"
#include <stdio.h>
#include "io_filter.h"
#include "opencv_mgmt.h"

void run_core_funcs(void)
{
    printf("Running core OCR and I/O functions ...\n");

    ProcList l;
    
    get_valid_name(&l);
    get_img_props(&l);
    get_bounded_vals(&l);
    proc_img(&l);
}
