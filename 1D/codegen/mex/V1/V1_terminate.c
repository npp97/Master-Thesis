/*
 * V1_terminate.c
 *
 * Code generation for function 'V1_terminate'
 *
 * C source code generated on: Thu Nov 22 11:00:22 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "V1.h"
#include "V1_terminate.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void V1_atexit(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void V1_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (V1_terminate.c) */
