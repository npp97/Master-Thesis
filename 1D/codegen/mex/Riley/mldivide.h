/*
 * mldivide.h
 *
 * Code generation for function 'mldivide'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

#ifndef __MLDIVIDE_H__
#define __MLDIVIDE_H__
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
#include "Riley_types.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern void check_forloop_overflow_error(boolean_T overflow);
extern void eml_xscal(int32_T n, real_T a, emxArray_real_T *x, int32_T ix0);
extern void mldivide(const emxArray_real_T *A, const emxArray_real_T *B, emxArray_real_T *Y);
#endif
/* End of code generation (mldivide.h) */
