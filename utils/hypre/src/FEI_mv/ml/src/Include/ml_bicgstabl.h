/*BHEADER**********************************************************************
 * Copyright (c) 2008,  Lawrence Livermore National Security, LLC.
 * Produced at the Lawrence Livermore National Laboratory.
 * This file is part of HYPRE.  See file COPYRIGHT for details.
 *
 * HYPRE is free software; you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License (as published by the Free
 * Software Foundation) version 2.1 dated February 1999.
 *
 * $Revision$
 ***********************************************************************EHEADER*/




/* ******************************************************************** */
/* See the file COPYRIGHT for a complete copyright notice, contact      */
/* person and disclaimer.                                               */        
/* ******************************************************************** */

/* ******************************************************************** */
/* Functions for the BICGSTABL Krylov solver                            */
/* ******************************************************************** */
/* Author        : Charles Tong (LLNL)                                  */
/* Date          : December, 1999                                       */
/* ******************************************************************** */

#include "ml_common.h"
#include "ml_krylov.h"

#ifndef __MLCGSTABL__
#define __MLCGSTABL__

#ifndef ML_CPP
#ifdef __cplusplus
extern "C" {
#endif
#endif

extern int ML_BICGSTABL_Solve(ML_Krylov *,int,double *rhs,double *sol);

#ifndef ML_CPP
#ifdef __cplusplus
}
#endif
#endif

#endif

