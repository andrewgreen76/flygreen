#include "ocr_core.h"

void run_core_funcs(void)
{
    printf("Running core OCR and I/O functions ...\n");

    ProcList pm;
    BmpHeader h54;
    
    pm.fname = get_fname();    
    get_img_props(&pm, &h54);
    get_bounded_vals();
    proc_img();
}
