#include "ocr_core.h"

void run_core_funcs(void)
{
    printf("Running core OCR and I/O functions ...\n");

    ProcList pm;
    BmpHeader imgh54;
    
    get_fname(pm.fname);    
    get_img_props(&pm, &imgh54);
    get_bounded_vals();
    proc_img();
}
