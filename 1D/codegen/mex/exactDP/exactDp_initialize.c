/*
 * exactDp_initialize.c
 *
 * Code generation for function 'exactDp_initialize'
 *
 * C source code generated on: Thu Nov 22 10:38:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "exactDp.h"
#include "exactDp_initialize.h"
#include "exactDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void exactDp_initialize(emlrtContext *aContext)
{
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, aContext, NULL, 1);
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, FALSE, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (exactDp_initialize.c) */
