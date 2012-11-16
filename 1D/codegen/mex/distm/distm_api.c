/*
 * distm_api.c
 *
 * Code generation for function 'distm_api'
 *
 * C source code generated on: Wed Nov 14 02:13:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "distm.h"
#include "distm_api.h"
#include "distm_emxutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = { 1, 1, "distm_api", "" };

/* Function Declarations */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const mxArray *X, const char_T *identifier,
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
  int32_T iv7[2];
  boolean_T bv0[2];
  int32_T i;
  for (i = 0; i < 2; i++) {
    iv7[i] = -1;
    bv0[i] = TRUE;
  }

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 2U,
    iv7, bv0, ret->size);
  ret->size[0] = ret->size[0];
  ret->size[1] = ret->size[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = FALSE;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *X, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  b_emlrt_marshallIn(emlrtAlias(X), &thisId, y);
  emlrtDestroyArray(&X);
}

static const mxArray *emlrt_marshallOut(emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv6[2] = { 0, 0 };

  const mxArray *m3;
  y = NULL;
  m3 = mxCreateNumericArray(2, (int32_T *)&iv6, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m3, (void *)u->data);
  mxSetDimensions((mxArray *)m3, u->size, 2);
  emlrtAssign(&y, m3);
  return y;
}

void distm_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  emxArray_real_T *X;
  emxArray_real_T *Y;
  emxArray_real_T *D;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&X, 2, &e_emlrtRTEI, TRUE);
  emxInit_real_T(&Y, 2, &e_emlrtRTEI, TRUE);
  emxInit_real_T(&D, 2, &e_emlrtRTEI, TRUE);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAlias(prhs[0]), "X", X);
  emlrt_marshallIn(emlrtAlias(prhs[1]), "Y", Y);

  /* Invoke the target function */
  distm(X, Y, D);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(D);
  D->canFreeData = FALSE;
  emxFree_real_T(&D);
  Y->canFreeData = FALSE;
  emxFree_real_T(&Y);
  X->canFreeData = FALSE;
  emxFree_real_T(&X);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (distm_api.c) */
