from libcpp cimport bool

cdef extern from "interface.h":

    bool run_pba(
        int num_cameras,
        int num_pts,
        int numprojs,
        double *motstruct,
        const double *imgpts,
        const char *vmask
    )
    
    
