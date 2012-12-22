/*
 * V2_api.c
 *
 * Code generation for function 'V2_api'
 *
 * C source code generated on: Sat Dec 22 16:05:48 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "V2.h"
#include "V2_api.h"
#include "V2_emxutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = { 1, 1, "V2_api", "" };

/* Function Declarations */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const mxArray *r, const char_T *identifier,
  emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(emxArray_real_T *u);

/* Function Definitions */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv4[2];
  boolean_T bv0[2];
  int32_T i;
  for (i = 0; i < 2; i++) {
    iv4[i] = -1;
    bv0[i] = TRUE;
  }

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 2U,
    iv4, bv0, ret->size);
  ret->size[0] = ret->size[0];
  ret->size[1] = ret->size[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = FALSE;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *r, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  b_emlrt_marshallIn(emlrtAlias(r), &thisId, y);
  emlrtDestroyArray(&r);
}

static const mxArray *emlrt_marshallOut(emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv3[2] = { 0, 0 };

  const mxArray *m2;
  y = NULL;
  m2 = mxCreateNumericArray(2, (int32_T *)&iv3, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m2, (void *)u->data);
  mxSetDimensions((mxArray *)m2, u->size, 2);
  emlrtAssign(&y, m2);
  return y;
}

void V2_api(const mxArray *prhs[1], const mxArray *plhs[1])
{
  emxArray_real_T *r;
  emxArray_real_T *V;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&r, 2, &e_emlrtRTEI, TRUE);
  emxInit_real_T(&V, 2, &e_emlrtRTEI, TRUE);
  prhs[0] = emlrtProtectR2012b(prhs[0], 0, FALSE, -1);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAlias(prhs[0]), "r", r);

  /* Invoke the target function */
  V2(r, V);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(V);
  V->canFreeData = FALSE;
  emxFree_real_T(&V);
  r->canFreeData = FALSE;
  emxFree_real_T(&r);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (V2_api.c) */
