/*
 * distm.h
 *
 * Code generation for function 'distm'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

#ifndef __DISTM_H__
#define __DISTM_H__
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
#include "distm_types.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern void check_forloop_overflow_error(boolean_T overflow);
extern void distm(const emxArray_real_T *X, const emxArray_real_T *Y, emxArray_real_T *D);
#endif
/* End of code generation (distm.h) */
