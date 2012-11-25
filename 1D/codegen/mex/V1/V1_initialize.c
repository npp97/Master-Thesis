/*
 * V1_initialize.c
 *
 * Code generation for function 'V1_initialize'
 *
 * C source code generated on: Thu Nov 22 11:00:22 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "V1.h"
#include "V1_initialize.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static const volatile char_T *emlrtBreakCheckR2012bFlagVar;

/* Function Declarations */

/* Function Definitions */
void V1_initialize(emlrtContext *aContext)
{
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, aContext, NULL, 1);
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, FALSE, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (V1_initialize.c) */
