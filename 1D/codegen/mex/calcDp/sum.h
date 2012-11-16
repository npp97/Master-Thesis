/*
 * sum.h
 *
 * Code generation for function 'sum'
 *
 * C source code generated on: Wed Nov 14 18:19:50 2012
 *
 */

#ifndef __SUM_H__
#define __SUM_H__
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
extern void b_sum(const emxArray_real_T *x, emxArray_real_T *y);
extern real_T c_sum(const emxArray_boolean_T *x);
#ifdef __WATCOMC__
#pragma aux c_sum value [8087];
#endif
extern real_T sum(const emxArray_real_T *x);
#ifdef __WATCOMC__
#pragma aux sum value [8087];
#endif
#endif
/* End of code generation (sum.h) */
