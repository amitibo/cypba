from __future__ import division
import numpy as np
cimport numpy as np
cimport pba

DTYPEd = np.double
ctypedef np.double_t DTYPEd_t

DTYPEu8 = np.uint8
ctypedef np.uint8_t DTYPEu8_t


def run_pba(cameras, points, measurements, vmask):
    
    num_pts, num_cameras = vmask.shape
    num_projs = len(np.nonzero(vmask)[0])
    
    if cameras is None:
        cameras = np.tile([1000, 1.0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], reps=num_cameras)
        
    if points is None:
        points = np.tile([0, 0, 0], reps=num_pts)
    
    motstruct = np.concatenate((cameras.ravel(), points.ravel()))
    cdef np.ndarray[DTYPEd_t, ndim=1] np_motstruct = np.array(motstruct, dtype=DTYPEd, copy=False, order='C').ravel()
    
    cdef np.ndarray[DTYPEd_t, ndim=1] np_measurements = np.array(measurements, dtype=DTYPEd, copy=False, order='C').ravel()
    cdef np.ndarray[DTYPEu8_t, ndim=1] np_vmask = np.array(vmask, dtype=DTYPEu8, copy=False, order='C').ravel()
    
    pba.run_pba(
        num_cameras,
        num_pts,
        num_projs,
        <double *>np_motstruct.data,
        <double *>np_measurements.data,
        <char *>np_vmask.data
        );
    
    cameras = np.ascontiguousarray(np.array(motstruct[:num_cameras*13]).reshape(num_cameras, 13))
    points = np.ascontiguousarray(np.array(motstruct[num_cameras*13:]).reshape(num_pts, 3))
    
    return cameras, points

