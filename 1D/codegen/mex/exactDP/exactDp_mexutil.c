/*
 * exactDp_mexutil.c
 *
 * Code generation for function 'exactDp_mexutil'
 *
 * C source code generated on: Thu Nov 22 10:38:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "exactDp.h"
#include "exactDp_mexutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
void error(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "error", TRUE,
                        location);
}

const mxArray *message(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  const mxArray *m6;
  pArray = b;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m6, 1, &pArray, "message",
    TRUE, location);
}

/* End of code generation (exactDp_mexutil.c) */
