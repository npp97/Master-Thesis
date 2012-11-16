/*
 * distm_mexutil.c
 *
 * Code generation for function 'distm_mexutil'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "distm.h"
#include "distm_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
const mxArray *b_message(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  const mxArray *m5;
  pArray = b;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m5, 1, &pArray, "message",
    TRUE, location);
}

void error(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "error", TRUE,
                        location);
}

/* End of code generation (distm_mexutil.c) */
