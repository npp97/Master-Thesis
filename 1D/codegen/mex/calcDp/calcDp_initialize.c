/*
 * calcDp_initialize.c
 *
 * Code generation for function 'calcDp_initialize'
 *
 * C source code generated on: Sat Nov 17 15:52:36 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "calcDp.h"
#include "calcDp_initialize.h"
#include "calcDp_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void calcDp_initialize(emlrtContext *aContext)
{
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, aContext, NULL, 1);
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, FALSE, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (calcDp_initialize.c) */
