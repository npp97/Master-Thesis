/*
 * exactDp.h
 *
 * Code generation for function 'exactDp'
 *
 * C source code generated on: Thu Nov 22 10:38:55 2012
 *
 */

#ifndef __EXACTDP_H__
#define __EXACTDP_H__
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
#include "exactDp_types.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern void check_forloop_overflow_error(boolean_T overflow);
extern void exactDp(const emxArray_real_T *Xp, const emxArray_real_T *DF, real_T rstar, real_T Dzero, emxArray_real_T *Dp);
#endif
/* End of code generation (exactDp.h) */
