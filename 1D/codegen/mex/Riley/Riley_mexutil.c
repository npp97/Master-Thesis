/*
 * Riley_mexutil.c
 *
 * Code generation for function 'Riley_mexutil'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "Riley_mexutil.h"

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
  const mxArray *m8;
  pArray = b;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m8, 1, &pArray, "message",
    TRUE, location);
}

/* End of code generation (Riley_mexutil.c) */
