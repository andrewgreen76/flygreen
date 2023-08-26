#include "ocr_core.h"
#include <stdio.h>
#include "io_filter.h"
#include "opencv_mgmt.h"
#include "ProcList.h"

void run_core_funcs(void)
{
    printf("Running core OCR and I/O functions ...\n");

    ProcList l;
    
    get_valid_name();
    get_img_props();
    get_bounded_vals();
    proc_img();
}
