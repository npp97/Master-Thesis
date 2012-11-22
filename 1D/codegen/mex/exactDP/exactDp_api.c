/*
 * exactDp_api.c
 *
 * Code generation for function 'exactDp_api'
 *
 * C source code generated on: Thu Nov 22 10:38:55 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "exactDp.h"
#include "exactDp_api.h"
#include "exactDp_emxutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRTEInfo k_emlrtRTEI = { 1, 1, "exactDp_api", "" };

/* Function Declarations */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T c_emlrt_marshallIn(const mxArray *rstar, const char_T *identifier);
static real_T d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const mxArray *Xp, const char_T *identifier,
  emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);

/* Function Definitions */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  e_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T c_emlrt_marshallIn(const mxArray *rstar, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  y = d_emlrt_marshallIn(emlrtAlias(rstar), &thisId);
  emlrtDestroyArray(&rstar);
  return y;
}

static real_T d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv13[2];
  boolean_T bv0[2];
  int32_T i;
  for (i = 0; i < 2; i++) {
    iv13[i] = -1;
    bv0[i] = TRUE;
  }

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 2U,
    iv13, bv0, ret->size);
  ret->size[0] = ret->size[0];
  ret->size[1] = ret->size[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = FALSE;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const mxArray *Xp, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  b_emlrt_marshallIn(emlrtAlias(Xp), &thisId, y);
  emlrtDestroyArray(&Xp);
}

static const mxArray *emlrt_marshallOut(emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv12[1] = { 0 };

  const mxArray *m5;
  y = NULL;
  m5 = mxCreateNumericArray(1, (int32_T *)&iv12, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m5, (void *)u->data);
  mxSetDimensions((mxArray *)m5, u->size, 1);
  emlrtAssign(&y, m5);
  return y;
}

static real_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", FALSE, 0U, 0);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void exactDp_api(const mxArray * const prhs[4], const mxArray *plhs[1])
{
  emxArray_real_T *Xp;
  emxArray_real_T *DF;
  emxArray_real_T *Dp;
  real_T rstar;
  real_T Dzero;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&Xp, 2, &k_emlrtRTEI, TRUE);
  emxInit_real_T(&DF, 2, &k_emlrtRTEI, TRUE);
  b_emxInit_real_T(&Dp, 1, &k_emlrtRTEI, TRUE);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAlias(prhs[0]), "Xp", Xp);
  emlrt_marshallIn(emlrtAlias(prhs[1]), "DF", DF);
  rstar = c_emlrt_marshallIn(emlrtAliasP(prhs[2]), "rstar");
  Dzero = c_emlrt_marshallIn(emlrtAliasP(prhs[3]), "Dzero");

  /* Invoke the target function */
  exactDp(Xp, DF, rstar, Dzero, Dp);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(Dp);
  Dp->canFreeData = FALSE;
  emxFree_real_T(&Dp);
  DF->canFreeData = FALSE;
  emxFree_real_T(&DF);
  Xp->canFreeData = FALSE;
  emxFree_real_T(&Xp);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (exactDp_api.c) */
