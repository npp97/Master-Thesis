/*
 * Riley_api.c
 *
 * Code generation for function 'Riley_api'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "Riley_api.h"
#include "Riley_emxutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRTEInfo q_emlrtRTEI = { 1, 1, "Riley_api", "" };

/* Function Declarations */
static void c_emlrt_marshallIn(const mxArray *A, const char_T *identifier,
  emxArray_real_T *y);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T e_emlrt_marshallIn(const mxArray *mu, const char_T *identifier);
static const mxArray *emlrt_marshallOut(emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);

/* Function Definitions */
static void c_emlrt_marshallIn(const mxArray *A, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  d_emlrt_marshallIn(emlrtAlias(A), &thisId, y);
  emlrtDestroyArray(&A);
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  h_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T e_emlrt_marshallIn(const mxArray *mu, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = f_emlrt_marshallIn(emlrtAlias(mu), &thisId);
  emlrtDestroyArray(&mu);
  return y;
}

static const mxArray *emlrt_marshallOut(emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv9[2] = { 0, 0 };

  const mxArray *m7;
  y = NULL;
  m7 = mxCreateNumericArray(2, (int32_T *)&iv9, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m7, (void *)u->data);
  mxSetDimensions((mxArray *)m7, u->size, 2);
  emlrtAssign(&y, m7);
  return y;
}

static real_T f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv11[2];
  boolean_T bv0[2];
  int32_T i;
  for (i = 0; i < 2; i++) {
    iv11[i] = -1;
    bv0[i] = TRUE;
  }

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 2U,
    iv11, bv0, ret->size);
  ret->size[0] = ret->size[0];
  ret->size[1] = ret->size[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = FALSE;
  emlrtDestroyArray(&src);
}

static real_T i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 0U, 0);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void Riley_api(const mxArray * const prhs[3], const mxArray *plhs[1])
{
  emxArray_real_T *A;
  emxArray_real_T *b;
  emxArray_real_T *x;
  real_T mu;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&A, 2, &q_emlrtRTEI, TRUE);
  emxInit_real_T(&b, 2, &q_emlrtRTEI, TRUE);
  emxInit_real_T(&x, 2, &q_emlrtRTEI, TRUE);

  /* Marshall function inputs */
  c_emlrt_marshallIn(emlrtAlias(prhs[0]), "A", A);
  c_emlrt_marshallIn(emlrtAlias(prhs[1]), "b", b);
  mu = e_emlrt_marshallIn(emlrtAliasP(prhs[2]), "mu");

  /* Invoke the target function */
  Riley(A, b, mu, x);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(x);
  x->canFreeData = FALSE;
  emxFree_real_T(&x);
  b->canFreeData = FALSE;
  emxFree_real_T(&b);
  A->canFreeData = FALSE;
  emxFree_real_T(&A);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (Riley_api.c) */
