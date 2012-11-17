/*
 * calcDp.h
 *
 * Code generation for function 'calcDp'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
 *
 */

#ifndef __CALCDP_H__
#define __CALCDP_H__
/* Include files */
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"

#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blascompat32.h"
#include "rtwtypes.h"
#include "calcDp_types.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern void calcDp(const emxArray_real_T *X, const emxArray_real_T *Xp, real_T rstar, real_T Dzero, const emxArray_real_T *DF, emxArray_real_T *Dp);
extern void check_forloop_overflow_error(boolean_T overflow);
#endif
/* End of code generation (calcDp.h) */
