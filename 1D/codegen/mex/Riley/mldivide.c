/*
 * mldivide.c
 *
 * Code generation for function 'mldivide'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "mldivide.h"
#include "Riley_emxutil.h"
#include "colon.h"
#include "Riley_mexutil.h"
#include "Riley_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo m_emlrtRSI = { 49, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtRSInfo pb_emlrtRSI = { 28, "eml_xscal",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xscal.m"
};

static emlrtRSInfo rb_emlrtRSI = { 20, "eml_blas_xscal",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xscal.m"
};

static emlrtRSInfo tb_emlrtRSI = { 55, "eml_blas_xscal",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xscal.m"
};

static emlrtRSInfo ub_emlrtRSI = { 1, "mldivide",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mldivide.p" };

static emlrtRSInfo vb_emlrtRSI = { 20, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo wb_emlrtRSI = { 70, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo xb_emlrtRSI = { 68, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo yb_emlrtRSI = { 77, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo ac_emlrtRSI = { 80, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo bc_emlrtRSI = { 88, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo cc_emlrtRSI = { 90, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo dc_emlrtRSI = { 8, "eml_xgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/eml_xgetrf.m"
};

static emlrtRSInfo ec_emlrtRSI = { 8, "eml_lapack_xgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/internal/eml_lapack_xgetrf.m"
};

static emlrtRSInfo fc_emlrtRSI = { 23, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo gc_emlrtRSI = { 30, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo hc_emlrtRSI = { 36, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo ic_emlrtRSI = { 44, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo jc_emlrtRSI = { 50, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo kc_emlrtRSI = { 58, "eml_matlab_zgetrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgetrf.m"
};

static emlrtRSInfo lc_emlrtRSI = { 75, "colon",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/colon.m" };

static emlrtRSInfo mc_emlrtRSI = { 107, "colon",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/colon.m" };

static emlrtRSInfo oc_emlrtRSI = { 20, "eml_ixamax",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_ixamax.m"
};

static emlrtRSInfo rc_emlrtRSI = { 26, "eml_xswap",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xswap.m"
};

static emlrtRSInfo sc_emlrtRSI = { 15, "eml_blas_xswap",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xswap.m"
};

static emlrtRSInfo tc_emlrtRSI = { 19, "eml_refblas_xswap",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/refblas/eml_refblas_xswap.m"
};

static emlrtRSInfo uc_emlrtRSI = { 42, "eml_xgeru",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xgeru.m"
};

static emlrtRSInfo vc_emlrtRSI = { 37, "eml_xger",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xger.m" };

static emlrtRSInfo xc_emlrtRSI = { 26, "eml_blas_xger",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m"
};

static emlrtRSInfo cd_emlrtRSI = { 85, "eml_blas_xger",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m"
};

static emlrtRSInfo dd_emlrtRSI = { 54, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRSInfo ed_emlrtRSI = { 16, "eml_warning",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_warning.m" };

static emlrtRSInfo fd_emlrtRSI = { 54, "eml_xtrsm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xtrsm.m"
};

static emlrtRSInfo hd_emlrtRSI = { 28, "eml_blas_xtrsm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m"
};

static emlrtRSInfo ld_emlrtRSI = { 80, "eml_blas_xtrsm",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xtrsm.m"
};

static emlrtRSInfo pd_emlrtRSI = { 29, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRSInfo qd_emlrtRSI = { 37, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRSInfo rd_emlrtRSI = { 8, "eml_xgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/eml_xgeqp3.m"
};

static emlrtRSInfo sd_emlrtRSI = { 8, "eml_lapack_xgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/internal/eml_lapack_xgeqp3.m"
};

static emlrtRSInfo td_emlrtRSI = { 19, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo ud_emlrtRSI = { 31, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo vd_emlrtRSI = { 32, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo wd_emlrtRSI = { 37, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo xd_emlrtRSI = { 47, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo yd_emlrtRSI = { 51, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo ae_emlrtRSI = { 64, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo be_emlrtRSI = { 66, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo ce_emlrtRSI = { 74, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo de_emlrtRSI = { 79, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo ee_emlrtRSI = { 93, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRSInfo fe_emlrtRSI = { 19, "eml_xnrm2",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xnrm2.m"
};

static emlrtRSInfo ie_emlrtRSI = { 18, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo je_emlrtRSI = { 39, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo ke_emlrtRSI = { 51, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo le_emlrtRSI = { 66, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo me_emlrtRSI = { 69, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo ne_emlrtRSI = { 79, "eml_matlab_zlarfg",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarfg.m"
};

static emlrtRSInfo oe_emlrtRSI = { 103, "eml_matlab_zlarf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarf.m"
};

static emlrtRSInfo pe_emlrtRSI = { 50, "eml_matlab_zlarf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarf.m"
};

static emlrtRSInfo qe_emlrtRSI = { 68, "eml_matlab_zlarf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarf.m"
};

static emlrtRSInfo re_emlrtRSI = { 75, "eml_matlab_zlarf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zlarf.m"
};

static emlrtRSInfo ve_emlrtRSI = { 105, "eml_blas_xgemv",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemv.m"
};

static emlrtRSInfo we_emlrtRSI = { 42, "eml_xgerc",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xgerc.m"
};

static emlrtRSInfo xe_emlrtRSI = { 90, "eml_blas_xger",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xger.m"
};

static emlrtRSInfo ye_emlrtRSI = { 29, "eml_flt2str",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };

static emlrtMCInfo e_emlrtMCI = { 50, 9, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo f_emlrtMCI = { 49, 15, "eml_int_forloop_overflow_check",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"
};

static emlrtMCInfo k_emlrtMCI = { 1, 1, "mldivide",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mldivide.p" };

static emlrtMCInfo l_emlrtMCI = { 16, 13, "eml_warning",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_warning.m" };

static emlrtMCInfo m_emlrtMCI = { 16, 5, "eml_warning",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_warning.m" };

static emlrtMCInfo n_emlrtMCI = { 29, 23, "eml_flt2str",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };

static emlrtMCInfo o_emlrtMCI = { 29, 15, "eml_flt2str",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_flt2str.m" };

static emlrtRTEInfo f_emlrtRTEI = { 1, 2, "mldivide",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/ops/mldivide.p" };

static emlrtRTEInfo g_emlrtRTEI = { 1, 19, "eml_lusolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_lusolve.m" };

static emlrtRTEInfo j_emlrtRTEI = { 1, 24, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRTEInfo k_emlrtRTEI = { 16, 1, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRTEInfo l_emlrtRTEI = { 28, 5, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRTEInfo m_emlrtRTEI = { 29, 5, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRTEInfo n_emlrtRTEI = { 24, 1, "eml_matlab_zgeqp3",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zgeqp3.m"
};

static emlrtRTEInfo r_emlrtRTEI = { 106, 5, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRTEInfo s_emlrtRTEI = { 99, 5, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRTEInfo t_emlrtRTEI = { 82, 21, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

static emlrtRTEInfo u_emlrtRTEI = { 76, 17, "eml_qrsolve",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_qrsolve.m" };

/* Function Declarations */
static void b_eml_warning(real_T varargin_2, const char_T varargin_3[14]);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14]);
static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location);
static const mxArray *b_sprintf(const mxArray *b, const mxArray *c, const
  mxArray *d, emlrtMCInfo *location);
static const mxArray *c_message(const mxArray *b, const mxArray *c, const
  mxArray *d, emlrtMCInfo *location);
static const mxArray *c_sprintf(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location);
static int32_T eml_ixamax(int32_T n, const emxArray_real_T *x, int32_T ix0);
static void eml_lusolve(const emxArray_real_T *A, const emxArray_real_T *B,
  emxArray_real_T *X);
static void eml_matlab_zlarf(int32_T m, int32_T n, int32_T iv0, real_T tau,
  emxArray_real_T *C, int32_T ic0, int32_T ldc, emxArray_real_T *work);
static real_T eml_matlab_zlarfg(int32_T n, real_T *alpha1, emxArray_real_T *x,
  int32_T ix0);
static void eml_qrsolve(const emxArray_real_T *A, emxArray_real_T *B,
  emxArray_real_T *Y);
static void eml_warning(void);
static real_T eml_xnrm2(int32_T n, const emxArray_real_T *x, int32_T ix0);
static void eml_xswap(int32_T n, emxArray_real_T *x, int32_T ix0, int32_T incx,
                      int32_T iy0, int32_T incy);
static void emlrt_marshallIn(const mxArray *d_sprintf, const char_T *identifier,
  char_T y[14]);
static void g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14]);
static void warn_singular(void);
static void warning(const mxArray *b, emlrtMCInfo *location);

/* Function Definitions */
static void b_eml_warning(real_T varargin_2, const char_T varargin_3[14])
{
  const mxArray *y;
  static const int32_T iv7[2] = { 1, 32 };

  const mxArray *m6;
  static const char_T cv7[32] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'r', 'a', 'n', 'k', 'D', 'e', 'f', 'i', 'c', 'i', 'e',
    'n', 't', 'M', 'a', 't', 'r', 'i', 'x' };

  const mxArray *b_y;
  const mxArray *c_y;
  static const int32_T iv8[2] = { 1, 14 };

  emlrtPushRtStackR2012b(&ed_emlrtRSI, emlrtRootTLSGlobal);
  y = NULL;
  m6 = mxCreateCharArray(2, iv7);
  emlrtInitCharArray(32, m6, cv7);
  emlrtAssign(&y, m6);
  b_y = NULL;
  m6 = mxCreateDoubleScalar(varargin_2);
  emlrtAssign(&b_y, m6);
  c_y = NULL;
  m6 = mxCreateCharArray(2, iv8);
  emlrtInitCharArray(14, m6, varargin_3);
  emlrtAssign(&c_y, m6);
  warning(c_message(y, b_y, c_y, &l_emlrtMCI), &m_emlrtMCI);
  emlrtPopRtStackR2012b(&ed_emlrtRSI, emlrtRootTLSGlobal);
}

static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14])
{
  g_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *b_message(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location)
{
  const mxArray *pArrays[2];
  const mxArray *m9;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m9, 2, pArrays, "message",
    TRUE, location);
}

static const mxArray *b_sprintf(const mxArray *b, const mxArray *c, const
  mxArray *d, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m10;
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m10, 3, pArrays,
    "sprintf", TRUE, location);
}

static const mxArray *c_message(const mxArray *b, const mxArray *c, const
  mxArray *d, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m12;
  pArrays[0] = b;
  pArrays[1] = c;
  pArrays[2] = d;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m12, 3, pArrays,
    "message", TRUE, location);
}

static const mxArray *c_sprintf(const mxArray *b, const mxArray *c, emlrtMCInfo *
  location)
{
  const mxArray *pArrays[2];
  const mxArray *m11;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m11, 2, pArrays,
    "sprintf", TRUE, location);
}

static int32_T eml_ixamax(int32_T n, const emxArray_real_T *x, int32_T ix0)
{
  int32_T idxmax;
  int32_T incx;
  emlrtPushRtStackR2012b(&oc_emlrtRSI, emlrtRootTLSGlobal);
  if (n < 1) {
    idxmax = 0;
  } else {
    incx = 1;
    idxmax = idamax32(&n, &x->data[ix0 - 1], &incx);
  }

  emlrtPopRtStackR2012b(&oc_emlrtRSI, emlrtRootTLSGlobal);
  return idxmax;
}

static void eml_lusolve(const emxArray_real_T *A, const emxArray_real_T *B,
  emxArray_real_T *X)
{
  emxArray_real_T *b_A;
  int32_T n;
  int32_T nb;
  int32_T loop_ub;
  emxArray_int32_T *ipiv;
  int32_T info;
  int32_T b;
  int32_T j;
  int32_T mmj;
  int32_T c;
  boolean_T b_c;
  int32_T i;
  real_T temp;
  boolean_T overflow;
  char_T DIAGA;
  char_T TRANSA;
  char_T UPLO;
  char_T SIDE;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_A, 2, &g_emlrtRTEI, TRUE);
  emlrtPushRtStackR2012b(&vb_emlrtRSI, emlrtRootTLSGlobal);
  n = A->size[1];
  emlrtPushRtStackR2012b(&xb_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&dc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&ec_emlrtRSI, emlrtRootTLSGlobal);
  nb = b_A->size[0] * b_A->size[1];
  b_A->size[0] = A->size[0];
  b_A->size[1] = A->size[1];
  emxEnsureCapacity((emxArray__common *)b_A, nb, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = A->size[0] * A->size[1];
  for (nb = 0; nb < loop_ub; nb++) {
    b_A->data[nb] = A->data[nb];
  }

  emxInit_int32_T(&ipiv, 2, &g_emlrtRTEI, TRUE);
  emlrtPushRtStackR2012b(&fc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&lc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&mc_emlrtRSI, emlrtRootTLSGlobal);
  eml_signed_integer_colon(muIntScalarMin_sint32(A->size[1], A->size[1]), ipiv);
  emlrtPopRtStackR2012b(&mc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&lc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&fc_emlrtRSI, emlrtRootTLSGlobal);
  info = 0;
  if (A->size[1] < 1) {
  } else {
    b = muIntScalarMin_sint32(A->size[1] - 1, A->size[1]);
    emlrtPushRtStackR2012b(&gc_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(FALSE);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&gc_emlrtRSI, emlrtRootTLSGlobal);
    for (j = 1; j <= b; j++) {
      mmj = A->size[1] - j;
      c = (j - 1) * (A->size[1] + 1);
      emlrtPushRtStackR2012b(&hc_emlrtRSI, emlrtRootTLSGlobal);
      loop_ub = mmj + 1;
      emlrtPushRtStackR2012b(&oc_emlrtRSI, emlrtRootTLSGlobal);
      if (mmj + 1 < 1) {
        loop_ub = -1;
      } else {
        nb = 1;
        loop_ub = idamax32(&loop_ub, &b_A->data[c], &nb) - 1;
      }

      emlrtPopRtStackR2012b(&oc_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&hc_emlrtRSI, emlrtRootTLSGlobal);
      if (b_A->data[c + loop_ub] != 0.0) {
        if (loop_ub != 0) {
          ipiv->data[j - 1] = j + loop_ub;
          emlrtPushRtStackR2012b(&ic_emlrtRSI, emlrtRootTLSGlobal);
          eml_xswap(A->size[1], b_A, j, A->size[1], j + loop_ub, A->size[1]);
          emlrtPopRtStackR2012b(&ic_emlrtRSI, emlrtRootTLSGlobal);
        }

        loop_ub = (c + mmj) + 1;
        emlrtPushRtStackR2012b(&jc_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
        if (c + 2 > loop_ub) {
          b_c = FALSE;
        } else {
          b_c = (loop_ub > 2147483646);
        }

        check_forloop_overflow_error(b_c);
        emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPopRtStackR2012b(&jc_emlrtRSI, emlrtRootTLSGlobal);
        for (i = c + 1; i + 1 <= loop_ub; i++) {
          b_A->data[i] /= b_A->data[c];
        }
      } else {
        info = j;
      }

      emlrtPushRtStackR2012b(&kc_emlrtRSI, emlrtRootTLSGlobal);
      loop_ub = A->size[1] - j;
      emlrtPushRtStackR2012b(&uc_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&vc_emlrtRSI, emlrtRootTLSGlobal);
      if ((mmj < 1) || (loop_ub < 1)) {
      } else {
        emlrtPushRtStackR2012b(&xc_emlrtRSI, emlrtRootTLSGlobal);
        temp = -1.0;
        nb = 1;
        emlrtPushRtStackR2012b(&cd_emlrtRSI, emlrtRootTLSGlobal);
        dger32(&mmj, &loop_ub, &temp, &b_A->data[c + 1], &nb, &b_A->data[c +
               A->size[1]], &n, &b_A->data[(c + A->size[1]) + 1], &n);
        emlrtPopRtStackR2012b(&cd_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPopRtStackR2012b(&xc_emlrtRSI, emlrtRootTLSGlobal);
      }

      emlrtPopRtStackR2012b(&vc_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&uc_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&kc_emlrtRSI, emlrtRootTLSGlobal);
    }

    if ((info == 0) && (!(b_A->data[(A->size[1] + b_A->size[0] * (A->size[1] - 1))
                          - 1] != 0.0))) {
      info = A->size[1];
    }
  }

  emlrtPopRtStackR2012b(&ec_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&dc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&xb_emlrtRSI, emlrtRootTLSGlobal);
  if (info > 0) {
    emlrtPushRtStackR2012b(&wb_emlrtRSI, emlrtRootTLSGlobal);
    warn_singular();
    emlrtPopRtStackR2012b(&wb_emlrtRSI, emlrtRootTLSGlobal);
  }

  nb = X->size[0] * X->size[1];
  X->size[0] = B->size[0];
  X->size[1] = B->size[1];
  emxEnsureCapacity((emxArray__common *)X, nb, (int32_T)sizeof(real_T),
                    &g_emlrtRTEI);
  loop_ub = B->size[0] * B->size[1];
  for (nb = 0; nb < loop_ub; nb++) {
    X->data[nb] = B->data[nb];
  }

  nb = B->size[1];
  emlrtPushRtStackR2012b(&yb_emlrtRSI, emlrtRootTLSGlobal);
  if (1 > A->size[1]) {
    overflow = FALSE;
  } else {
    overflow = (A->size[1] > 2147483646);
  }

  emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  check_forloop_overflow_error(overflow);
  emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&yb_emlrtRSI, emlrtRootTLSGlobal);
  for (i = 0; i + 1 <= A->size[1]; i++) {
    if (ipiv->data[i] != i + 1) {
      emlrtPushRtStackR2012b(&ac_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > B->size[1]) {
        overflow = FALSE;
      } else {
        overflow = (B->size[1] > 2147483646);
      }

      emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&ac_emlrtRSI, emlrtRootTLSGlobal);
      for (j = 0; j + 1 <= B->size[1]; j++) {
        temp = X->data[i + X->size[0] * j];
        X->data[i + X->size[0] * j] = X->data[(ipiv->data[i] + X->size[0] * j) -
          1];
        X->data[(ipiv->data[i] + X->size[0] * j) - 1] = temp;
      }
    }
  }

  emxFree_int32_T(&ipiv);
  emlrtPushRtStackR2012b(&bc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&fd_emlrtRSI, emlrtRootTLSGlobal);
  if ((A->size[1] < 1) || (B->size[1] < 1)) {
  } else {
    emlrtPushRtStackR2012b(&hd_emlrtRSI, emlrtRootTLSGlobal);
    temp = 1.0;
    DIAGA = 'U';
    TRANSA = 'N';
    UPLO = 'L';
    SIDE = 'L';
    emlrtPushRtStackR2012b(&ld_emlrtRSI, emlrtRootTLSGlobal);
    dtrsm32(&SIDE, &UPLO, &TRANSA, &DIAGA, &n, &nb, &temp, &b_A->data[0], &n,
            &X->data[0], &n);
    emlrtPopRtStackR2012b(&ld_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&hd_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&fd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&bc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&cc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&fd_emlrtRSI, emlrtRootTLSGlobal);
  if ((A->size[1] < 1) || (B->size[1] < 1)) {
  } else {
    emlrtPushRtStackR2012b(&hd_emlrtRSI, emlrtRootTLSGlobal);
    temp = 1.0;
    DIAGA = 'N';
    TRANSA = 'N';
    UPLO = 'U';
    SIDE = 'L';
    emlrtPushRtStackR2012b(&ld_emlrtRSI, emlrtRootTLSGlobal);
    dtrsm32(&SIDE, &UPLO, &TRANSA, &DIAGA, &n, &nb, &temp, &b_A->data[0], &n,
            &X->data[0], &n);
    emlrtPopRtStackR2012b(&ld_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&hd_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxFree_real_T(&b_A);
  emlrtPopRtStackR2012b(&fd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&cc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&vb_emlrtRSI, emlrtRootTLSGlobal);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void eml_matlab_zlarf(int32_T m, int32_T n, int32_T iv0, real_T tau,
  emxArray_real_T *C, int32_T ic0, int32_T ldc, emxArray_real_T *work)
{
  int32_T lastv;
  int32_T i;
  int32_T lastc;
  boolean_T exitg2;
  int32_T colbottom;
  boolean_T b_i;
  int32_T exitg1;
  real_T alpha1;
  real_T beta1;
  char_T TRANSA;
  if (tau != 0.0) {
    lastv = m;
    i = iv0 + m;
    while ((lastv > 0) && (C->data[i - 2] == 0.0)) {
      lastv--;
      i--;
    }

    emlrtPushRtStackR2012b(&pe_emlrtRSI, emlrtRootTLSGlobal);
    lastc = n;
    exitg2 = FALSE;
    while ((exitg2 == FALSE) && (lastc > 0)) {
      i = ic0 + (lastc - 1) * ldc;
      colbottom = (i + lastv) - 1;
      emlrtPushRtStackR2012b(&oe_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      if (i > colbottom) {
        b_i = FALSE;
      } else {
        b_i = (colbottom > 2147483646);
      }

      check_forloop_overflow_error(b_i);
      emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&oe_emlrtRSI, emlrtRootTLSGlobal);
      do {
        exitg1 = 0;
        if (i <= colbottom) {
          if (C->data[i - 1] != 0.0) {
            exitg1 = 1;
          } else {
            i++;
          }
        } else {
          lastc--;
          exitg1 = 2;
        }
      } while (exitg1 == 0);

      if (exitg1 == 1) {
        exitg2 = TRUE;
      }
    }

    emlrtPopRtStackR2012b(&pe_emlrtRSI, emlrtRootTLSGlobal);
  } else {
    lastv = 0;
    lastc = 0;
  }

  if (lastv > 0) {
    emlrtPushRtStackR2012b(&qe_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
    if (lastc < 1) {
    } else {
      emlrtPushRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
      alpha1 = 1.0;
      i = 1;
      beta1 = 0.0;
      colbottom = 1;
      TRANSA = 'C';
      emlrtPushRtStackR2012b(&ve_emlrtRSI, emlrtRootTLSGlobal);
      dgemv32(&TRANSA, &lastv, &lastc, &alpha1, &C->data[ic0 - 1], &ldc,
              &C->data[iv0 - 1], &i, &beta1, &work->data[0], &colbottom);
      emlrtPopRtStackR2012b(&ve_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPopRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&qe_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&re_emlrtRSI, emlrtRootTLSGlobal);
    alpha1 = -tau;
    emlrtPushRtStackR2012b(&we_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&vc_emlrtRSI, emlrtRootTLSGlobal);
    if (lastc < 1) {
    } else {
      emlrtPushRtStackR2012b(&xc_emlrtRSI, emlrtRootTLSGlobal);
      i = 1;
      colbottom = 1;
      emlrtPushRtStackR2012b(&xe_emlrtRSI, emlrtRootTLSGlobal);
      dger32(&lastv, &lastc, &alpha1, &C->data[iv0 - 1], &i, &work->data[0],
             &colbottom, &C->data[ic0 - 1], &ldc);
      emlrtPopRtStackR2012b(&xe_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&xc_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPopRtStackR2012b(&vc_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&we_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&re_emlrtRSI, emlrtRootTLSGlobal);
  }
}

static real_T eml_matlab_zlarfg(int32_T n, real_T *alpha1, emxArray_real_T *x,
  int32_T ix0)
{
  real_T tau;
  real_T xnorm;
  int32_T knt;
  real_T d0;
  boolean_T b6;
  int32_T k;
  tau = 0.0;
  if (n <= 0) {
  } else {
    emlrtPushRtStackR2012b(&ie_emlrtRSI, emlrtRootTLSGlobal);
    xnorm = eml_xnrm2(n - 1, x, ix0);
    emlrtPopRtStackR2012b(&ie_emlrtRSI, emlrtRootTLSGlobal);
    if (xnorm != 0.0) {
      xnorm = muDoubleScalarHypot(muDoubleScalarAbs(*alpha1), muDoubleScalarAbs
        (xnorm));
      if (*alpha1 >= 0.0) {
        xnorm = -xnorm;
      }

      if (muDoubleScalarAbs(xnorm) < 1.0020841800044864E-292) {
        knt = 0;
        do {
          knt++;
          emlrtPushRtStackR2012b(&je_emlrtRSI, emlrtRootTLSGlobal);
          eml_xscal(n - 1, 9.9792015476736E+291, x, ix0);
          emlrtPopRtStackR2012b(&je_emlrtRSI, emlrtRootTLSGlobal);
          xnorm *= 9.9792015476736E+291;
          *alpha1 *= 9.9792015476736E+291;
        } while (!(muDoubleScalarAbs(xnorm) >= 1.0020841800044864E-292));

        emlrtPushRtStackR2012b(&ke_emlrtRSI, emlrtRootTLSGlobal);
        xnorm = eml_xnrm2(n - 1, x, ix0);
        emlrtPopRtStackR2012b(&ke_emlrtRSI, emlrtRootTLSGlobal);
        xnorm = muDoubleScalarHypot(muDoubleScalarAbs(*alpha1),
          muDoubleScalarAbs(xnorm));
        if (*alpha1 >= 0.0) {
          xnorm = -xnorm;
        }

        tau = (xnorm - *alpha1) / xnorm;
        emlrtPushRtStackR2012b(&le_emlrtRSI, emlrtRootTLSGlobal);
        d0 = 1.0 / (*alpha1 - xnorm);
        eml_xscal(n - 1, d0, x, ix0);
        emlrtPopRtStackR2012b(&le_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&me_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
        if (1 > knt) {
          b6 = FALSE;
        } else {
          b6 = (knt > 2147483646);
        }

        check_forloop_overflow_error(b6);
        emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPopRtStackR2012b(&me_emlrtRSI, emlrtRootTLSGlobal);
        for (k = 1; k <= knt; k++) {
          xnorm *= 1.0020841800044864E-292;
        }

        *alpha1 = xnorm;
      } else {
        tau = (xnorm - *alpha1) / xnorm;
        emlrtPushRtStackR2012b(&ne_emlrtRSI, emlrtRootTLSGlobal);
        d0 = 1.0 / (*alpha1 - xnorm);
        eml_xscal(n - 1, d0, x, ix0);
        emlrtPopRtStackR2012b(&ne_emlrtRSI, emlrtRootTLSGlobal);
        *alpha1 = xnorm;
      }
    }
  }

  return tau;
}

static void eml_qrsolve(const emxArray_real_T *A, emxArray_real_T *B,
  emxArray_real_T *Y)
{
  emxArray_real_T *b_A;
  int32_T nb;
  int32_T mn;
  int32_T i1;
  int32_T k;
  emxArray_real_T *tau;
  emxArray_int32_T *jpvt;
  int32_T b_mn;
  emxArray_real_T *work;
  emxArray_real_T *vn1;
  emxArray_real_T *vn2;
  boolean_T overflow;
  int32_T pvt;
  boolean_T b1;
  int32_T i;
  int32_T i_i;
  int32_T nmi;
  int32_T mmi;
  real_T atmp;
  real_T temp2;
  boolean_T exitg1;
  const mxArray *y;
  static const int32_T iv6[2] = { 1, 8 };

  const mxArray *m5;
  static const char_T cv6[8] = { '%', '%', '%', 'd', '.', '%', 'd', 'e' };

  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  char_T str[14];
  uint32_T unnamed_idx_0;
  uint32_T unnamed_idx_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_A, 2, &j_emlrtRTEI, TRUE);
  nb = B->size[1] - 1;
  mn = (int32_T)muDoubleScalarMin((real_T)A->size[0], (real_T)A->size[1]);
  emlrtPushRtStackR2012b(&pd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&rd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&sd_emlrtRSI, emlrtRootTLSGlobal);
  i1 = b_A->size[0] * b_A->size[1];
  b_A->size[0] = A->size[0];
  b_A->size[1] = A->size[1];
  emxEnsureCapacity((emxArray__common *)b_A, i1, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  k = A->size[0] * A->size[1];
  for (i1 = 0; i1 < k; i1++) {
    b_A->data[i1] = A->data[i1];
  }

  b_emxInit_real_T(&tau, 1, &j_emlrtRTEI, TRUE);
  emxInit_int32_T(&jpvt, 2, &j_emlrtRTEI, TRUE);
  b_mn = muIntScalarMin_sint32(A->size[0], A->size[1]);
  i1 = tau->size[0];
  tau->size[0] = b_mn;
  emxEnsureCapacity((emxArray__common *)tau, i1, (int32_T)sizeof(real_T),
                    &k_emlrtRTEI);
  emlrtPushRtStackR2012b(&td_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&lc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&mc_emlrtRSI, emlrtRootTLSGlobal);
  eml_signed_integer_colon(A->size[1], jpvt);
  emlrtPopRtStackR2012b(&mc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&lc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&td_emlrtRSI, emlrtRootTLSGlobal);
  if ((A->size[0] == 0) || (A->size[1] == 0)) {
  } else {
    b_emxInit_real_T(&work, 1, &n_emlrtRTEI, TRUE);
    k = A->size[1];
    i1 = work->size[0];
    work->size[0] = k;
    emxEnsureCapacity((emxArray__common *)work, i1, (int32_T)sizeof(real_T),
                      &j_emlrtRTEI);
    for (i1 = 0; i1 < k; i1++) {
      work->data[i1] = 0.0;
    }

    b_emxInit_real_T(&vn1, 1, &l_emlrtRTEI, TRUE);
    b_emxInit_real_T(&vn2, 1, &m_emlrtRTEI, TRUE);
    k = A->size[1];
    i1 = vn1->size[0];
    vn1->size[0] = k;
    emxEnsureCapacity((emxArray__common *)vn1, i1, (int32_T)sizeof(real_T),
                      &l_emlrtRTEI);
    i1 = vn2->size[0];
    vn2->size[0] = k;
    emxEnsureCapacity((emxArray__common *)vn2, i1, (int32_T)sizeof(real_T),
                      &m_emlrtRTEI);
    k = 1;
    emlrtPushRtStackR2012b(&ud_emlrtRSI, emlrtRootTLSGlobal);
    overflow = (A->size[1] > 2147483646);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&ud_emlrtRSI, emlrtRootTLSGlobal);
    for (pvt = 0; pvt + 1 <= A->size[1]; pvt++) {
      emlrtPushRtStackR2012b(&vd_emlrtRSI, emlrtRootTLSGlobal);
      vn1->data[pvt] = eml_xnrm2(A->size[0], A, k);
      emlrtPopRtStackR2012b(&vd_emlrtRSI, emlrtRootTLSGlobal);
      vn2->data[pvt] = vn1->data[pvt];
      k += A->size[0];
    }

    emlrtPushRtStackR2012b(&wd_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > b_mn) {
      b1 = FALSE;
    } else {
      b1 = (b_mn > 2147483646);
    }

    check_forloop_overflow_error(b1);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&wd_emlrtRSI, emlrtRootTLSGlobal);
    for (i = 1; i <= b_mn; i++) {
      i_i = (i + (i - 1) * A->size[0]) - 1;
      nmi = A->size[1] - i;
      mmi = A->size[0] - i;
      emlrtPushRtStackR2012b(&xd_emlrtRSI, emlrtRootTLSGlobal);
      k = eml_ixamax(1 + nmi, vn1, i);
      pvt = (i + k) - 2;
      emlrtPopRtStackR2012b(&xd_emlrtRSI, emlrtRootTLSGlobal);
      if (pvt + 1 != i) {
        emlrtPushRtStackR2012b(&yd_emlrtRSI, emlrtRootTLSGlobal);
        i1 = A->size[0] * pvt + 1;
        k = A->size[0] * (i - 1) + 1;
        eml_xswap(A->size[0], b_A, i1, 1, k, 1);
        emlrtPopRtStackR2012b(&yd_emlrtRSI, emlrtRootTLSGlobal);
        k = jpvt->data[pvt];
        jpvt->data[pvt] = jpvt->data[i - 1];
        jpvt->data[i - 1] = k;
        vn1->data[pvt] = vn1->data[i - 1];
        vn2->data[pvt] = vn2->data[i - 1];
      }

      if (i < A->size[0]) {
        emlrtPushRtStackR2012b(&ae_emlrtRSI, emlrtRootTLSGlobal);
        atmp = b_A->data[i_i];
        temp2 = eml_matlab_zlarfg(mmi + 1, &atmp, b_A, i_i + 2);
        emlrtPopRtStackR2012b(&ae_emlrtRSI, emlrtRootTLSGlobal);
        tau->data[i - 1] = temp2;
      } else {
        emlrtPushRtStackR2012b(&be_emlrtRSI, emlrtRootTLSGlobal);
        temp2 = b_A->data[i_i];
        atmp = b_A->data[i_i];
        emlrtPopRtStackR2012b(&be_emlrtRSI, emlrtRootTLSGlobal);
        b_A->data[i_i] = temp2;
        tau->data[i - 1] = 0.0;
      }

      b_A->data[i_i] = atmp;
      if (i < A->size[1]) {
        atmp = b_A->data[i_i];
        b_A->data[i_i] = 1.0;
        emlrtPushRtStackR2012b(&ce_emlrtRSI, emlrtRootTLSGlobal);
        eml_matlab_zlarf(mmi + 1, nmi, i_i + 1, tau->data[i - 1], b_A, i + i *
                         A->size[0], A->size[0], work);
        emlrtPopRtStackR2012b(&ce_emlrtRSI, emlrtRootTLSGlobal);
        b_A->data[i_i] = atmp;
      }

      emlrtPushRtStackR2012b(&de_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(FALSE);
      emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&de_emlrtRSI, emlrtRootTLSGlobal);
      for (pvt = i; pvt + 1 <= A->size[1]; pvt++) {
        if (vn1->data[pvt] != 0.0) {
          atmp = muDoubleScalarAbs(b_A->data[(i + b_A->size[0] * pvt) - 1]) /
            vn1->data[pvt];
          temp2 = atmp * atmp;
          atmp = 1.0 - atmp * atmp;
          if (1.0 - temp2 < 0.0) {
            atmp = 0.0;
          }

          temp2 = vn1->data[pvt] / vn2->data[pvt];
          if (atmp * (temp2 * temp2) <= 1.4901161193847656E-8) {
            if (i < A->size[0]) {
              emlrtPushRtStackR2012b(&ee_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPushRtStackR2012b(&fe_emlrtRSI, emlrtRootTLSGlobal);
              if (mmi < 1) {
                temp2 = 0.0;
              } else {
                k = 1;
                temp2 = dnrm232(&mmi, &b_A->data[i + A->size[0] * pvt], &k);
              }

              emlrtPopRtStackR2012b(&fe_emlrtRSI, emlrtRootTLSGlobal);
              vn1->data[pvt] = temp2;
              emlrtPopRtStackR2012b(&ee_emlrtRSI, emlrtRootTLSGlobal);
              vn2->data[pvt] = vn1->data[pvt];
            } else {
              vn1->data[pvt] = 0.0;
              vn2->data[pvt] = 0.0;
            }
          } else {
            vn1->data[pvt] *= muDoubleScalarSqrt(atmp);
          }
        }
      }
    }

    emxFree_real_T(&vn2);
    emxFree_real_T(&vn1);
    emxFree_real_T(&work);
  }

  emlrtPopRtStackR2012b(&sd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&rd_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&pd_emlrtRSI, emlrtRootTLSGlobal);
  atmp = 0.0;
  if (mn > 0) {
    temp2 = muDoubleScalarMax((real_T)A->size[0], (real_T)A->size[1]) *
      muDoubleScalarAbs(b_A->data[0]) * 2.2204460492503131E-16;
    k = 0;
    exitg1 = FALSE;
    while ((exitg1 == FALSE) && (k <= mn - 1)) {
      if (muDoubleScalarAbs(b_A->data[k + b_A->size[0] * k]) <= temp2) {
        emlrtPushRtStackR2012b(&qd_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&ye_emlrtRSI, emlrtRootTLSGlobal);
        y = NULL;
        m5 = mxCreateCharArray(2, iv6);
        emlrtInitCharArray(8, m5, cv6);
        emlrtAssign(&y, m5);
        b_y = NULL;
        m5 = mxCreateDoubleScalar(14.0);
        emlrtAssign(&b_y, m5);
        c_y = NULL;
        m5 = mxCreateDoubleScalar(6.0);
        emlrtAssign(&c_y, m5);
        d_y = NULL;
        m5 = mxCreateDoubleScalar(temp2);
        emlrtAssign(&d_y, m5);
        emlrt_marshallIn(c_sprintf(b_sprintf(y, b_y, c_y, &n_emlrtMCI), d_y,
          &o_emlrtMCI), "sprintf", str);
        emlrtPopRtStackR2012b(&ye_emlrtRSI, emlrtRootTLSGlobal);
        b_eml_warning(atmp, str);
        emlrtPopRtStackR2012b(&qd_emlrtRSI, emlrtRootTLSGlobal);
        exitg1 = TRUE;
      } else {
        atmp++;
        k++;
      }
    }
  }

  unnamed_idx_0 = (uint32_T)A->size[1];
  unnamed_idx_1 = (uint32_T)B->size[1];
  i1 = Y->size[0] * Y->size[1];
  Y->size[0] = (int32_T)unnamed_idx_0;
  emxEnsureCapacity((emxArray__common *)Y, i1, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  i1 = Y->size[0] * Y->size[1];
  Y->size[1] = (int32_T)unnamed_idx_1;
  emxEnsureCapacity((emxArray__common *)Y, i1, (int32_T)sizeof(real_T),
                    &j_emlrtRTEI);
  k = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1;
  for (i1 = 0; i1 < k; i1++) {
    Y->data[i1] = 0.0;
  }

  for (pvt = 0; pvt < mn; pvt++) {
    if (tau->data[pvt] != 0.0) {
      for (k = 0; k <= nb; k++) {
        temp2 = B->data[pvt + B->size[0] * k];
        i1 = A->size[0] + (int32_T)(1.0 - ((1.0 + (real_T)pvt) + 1.0));
        emlrtForLoopVectorCheckR2012b((1.0 + (real_T)pvt) + 1.0, 1.0, (real_T)
          A->size[0], mxDOUBLE_CLASS, i1, &u_emlrtRTEI, emlrtRootTLSGlobal);
        for (i = 0; i < i1; i++) {
          unnamed_idx_0 = ((uint32_T)pvt + (uint32_T)i) + 2U;
          temp2 += b_A->data[((int32_T)unnamed_idx_0 + b_A->size[0] * pvt) - 1] *
            B->data[((int32_T)unnamed_idx_0 + B->size[0] * k) - 1];
        }

        temp2 *= tau->data[pvt];
        if (temp2 != 0.0) {
          B->data[pvt + B->size[0] * k] -= temp2;
          i1 = A->size[0] + (int32_T)(1.0 - ((1.0 + (real_T)pvt) + 1.0));
          emlrtForLoopVectorCheckR2012b((1.0 + (real_T)pvt) + 1.0, 1.0, (real_T)
            A->size[0], mxDOUBLE_CLASS, i1, &t_emlrtRTEI, emlrtRootTLSGlobal);
          for (i = 0; i < i1; i++) {
            unnamed_idx_0 = ((uint32_T)pvt + (uint32_T)i) + 2U;
            B->data[((int32_T)unnamed_idx_0 + B->size[0] * k) - 1] -= b_A->data
              [((int32_T)unnamed_idx_0 + b_A->size[0] * pvt) - 1] * temp2;
          }
        }
      }
    }
  }

  emxFree_real_T(&tau);
  for (k = 0; k <= nb; k++) {
    emlrtForLoopVectorCheckR2012b(1.0, 1.0, atmp, mxDOUBLE_CLASS, (int32_T)atmp,
      &s_emlrtRTEI, emlrtRootTLSGlobal);
    for (i = 0; i < (int32_T)atmp; i++) {
      Y->data[(jpvt->data[(int32_T)(1.0 + (real_T)i) - 1] + Y->size[0] * k) - 1]
        = B->data[((int32_T)(1.0 + (real_T)i) + B->size[0] * k) - 1];
    }

    emlrtForLoopVectorCheckR2012b(atmp, -1.0, 1.0, mxDOUBLE_CLASS, (int32_T)
      -(1.0 + (-1.0 - atmp)), &r_emlrtRTEI, emlrtRootTLSGlobal);
    for (pvt = 0; pvt < (int32_T)-(1.0 + (-1.0 - atmp)); pvt++) {
      temp2 = atmp + -(real_T)pvt;
      Y->data[(jpvt->data[(int32_T)temp2 - 1] + Y->size[0] * k) - 1] /=
        b_A->data[((int32_T)temp2 + b_A->size[0] * ((int32_T)temp2 - 1)) - 1];
      for (i = 0; i < (int32_T)(temp2 - 1.0); i++) {
        Y->data[(jpvt->data[(int32_T)(1.0 + (real_T)i) - 1] + Y->size[0] * k) -
          1] -= Y->data[(jpvt->data[(int32_T)temp2 - 1] + Y->size[0] * k) - 1] *
          b_A->data[((int32_T)(1.0 + (real_T)i) + b_A->size[0] * ((int32_T)temp2
          - 1)) - 1];
      }
    }
  }

  emxFree_int32_T(&jpvt);
  emxFree_real_T(&b_A);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void eml_warning(void)
{
  const mxArray *y;
  static const int32_T iv5[2] = { 1, 27 };

  const mxArray *m4;
  static const char_T cv5[27] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 's', 'i', 'n', 'g', 'u', 'l', 'a', 'r', 'M', 'a', 't',
    'r', 'i', 'x' };

  emlrtPushRtStackR2012b(&ed_emlrtRSI, emlrtRootTLSGlobal);
  y = NULL;
  m4 = mxCreateCharArray(2, iv5);
  emlrtInitCharArray(27, m4, cv5);
  emlrtAssign(&y, m4);
  warning(message(y, &l_emlrtMCI), &m_emlrtMCI);
  emlrtPopRtStackR2012b(&ed_emlrtRSI, emlrtRootTLSGlobal);
}

static real_T eml_xnrm2(int32_T n, const emxArray_real_T *x, int32_T ix0)
{
  real_T y;
  int32_T incx;
  emlrtPushRtStackR2012b(&fe_emlrtRSI, emlrtRootTLSGlobal);
  if (n < 1) {
    y = 0.0;
  } else {
    incx = 1;
    y = dnrm232(&n, &x->data[ix0 - 1], &incx);
  }

  emlrtPopRtStackR2012b(&fe_emlrtRSI, emlrtRootTLSGlobal);
  return y;
}

static void eml_xswap(int32_T n, emxArray_real_T *x, int32_T ix0, int32_T incx,
                      int32_T iy0, int32_T incy)
{
  int32_T ix;
  int32_T iy;
  boolean_T b5;
  int32_T k;
  real_T temp;
  emlrtPushRtStackR2012b(&rc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&sc_emlrtRSI, emlrtRootTLSGlobal);
  ix = ix0 - 1;
  iy = iy0 - 1;
  emlrtPushRtStackR2012b(&tc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  if (1 > n) {
    b5 = FALSE;
  } else {
    b5 = (n > 2147483646);
  }

  check_forloop_overflow_error(b5);
  emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&tc_emlrtRSI, emlrtRootTLSGlobal);
  for (k = 1; k <= n; k++) {
    temp = x->data[ix];
    x->data[ix] = x->data[iy];
    x->data[iy] = temp;
    ix += incx;
    iy += incy;
  }

  emlrtPopRtStackR2012b(&sc_emlrtRSI, emlrtRootTLSGlobal);
  emlrtPopRtStackR2012b(&rc_emlrtRSI, emlrtRootTLSGlobal);
}

static void emlrt_marshallIn(const mxArray *d_sprintf, const char_T *identifier,
  char_T y[14])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  b_emlrt_marshallIn(emlrtAlias(d_sprintf), &thisId, y);
  emlrtDestroyArray(&d_sprintf);
}

static void g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[14])
{
  int32_T iv10[2];
  int32_T i2;
  for (i2 = 0; i2 < 2; i2++) {
    iv10[i2] = 1 + 13 * i2;
  }

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", FALSE, 2U,
    iv10);
  emlrtImportCharArray(src, ret, 14);
  emlrtDestroyArray(&src);
}

static void warn_singular(void)
{
  emlrtPushRtStackR2012b(&dd_emlrtRSI, emlrtRootTLSGlobal);
  eml_warning();
  emlrtPopRtStackR2012b(&dd_emlrtRSI, emlrtRootTLSGlobal);
}

static void warning(const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, NULL, 1, &pArray, "warning", TRUE,
                        location);
}

void check_forloop_overflow_error(boolean_T overflow)
{
  const mxArray *y;
  static const int32_T iv1[2] = { 1, 34 };

  const mxArray *m1;
  static const char_T cv1[34] = { 'C', 'o', 'd', 'e', 'r', ':', 't', 'o', 'o',
    'l', 'b', 'o', 'x', ':', 'i', 'n', 't', '_', 'f', 'o', 'r', 'l', 'o', 'o',
    'p', '_', 'o', 'v', 'e', 'r', 'f', 'l', 'o', 'w' };

  const mxArray *b_y;
  static const int32_T iv2[2] = { 1, 23 };

  static const char_T cv2[23] = { 'c', 'o', 'd', 'e', 'r', '.', 'i', 'n', 't',
    'e', 'r', 'n', 'a', 'l', '.', 'i', 'n', 'd', 'e', 'x', 'I', 'n', 't' };

  if (!overflow) {
  } else {
    emlrtPushRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m1 = mxCreateCharArray(2, iv1);
    emlrtInitCharArray(34, m1, cv1);
    emlrtAssign(&y, m1);
    b_y = NULL;
    m1 = mxCreateCharArray(2, iv2);
    emlrtInitCharArray(23, m1, cv2);
    emlrtAssign(&b_y, m1);
    error(b_message(y, b_y, &e_emlrtMCI), &f_emlrtMCI);
    emlrtPopRtStackR2012b(&m_emlrtRSI, emlrtRootTLSGlobal);
  }
}

void eml_xscal(int32_T n, real_T a, emxArray_real_T *x, int32_T ix0)
{
  int32_T incx;
  emlrtPushRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
  if (n < 1) {
  } else {
    emlrtPushRtStackR2012b(&rb_emlrtRSI, emlrtRootTLSGlobal);
    incx = 1;
    emlrtPushRtStackR2012b(&tb_emlrtRSI, emlrtRootTLSGlobal);
    dscal32(&n, &a, &x->data[ix0 - 1], &incx);
    emlrtPopRtStackR2012b(&tb_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&rb_emlrtRSI, emlrtRootTLSGlobal);
  }

  emlrtPopRtStackR2012b(&pb_emlrtRSI, emlrtRootTLSGlobal);
}

void mldivide(const emxArray_real_T *A, const emxArray_real_T *B,
              emxArray_real_T *Y)
{
  const mxArray *y;
  static const int32_T iv4[2] = { 1, 21 };

  const mxArray *m3;
  static const char_T cv4[21] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'd', 'i', 'm', 'a', 'g', 'r', 'e', 'e' };

  emxArray_real_T *b_B;
  uint32_T unnamed_idx_0;
  uint32_T unnamed_idx_1;
  int32_T i0;
  int32_T loop_ub;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if (B->size[0] == A->size[0]) {
  } else {
    emlrtPushRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m3 = mxCreateCharArray(2, iv4);
    emlrtInitCharArray(21, m3, cv4);
    emlrtAssign(&y, m3);
    error(message(y, &k_emlrtMCI), &k_emlrtMCI);
    emlrtPopRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxInit_real_T(&b_B, 2, &f_emlrtRTEI, TRUE);
  if ((A->size[0] == 0) || (A->size[1] == 0) || ((B->size[0] == 0) || (B->size[1]
        == 0))) {
    unnamed_idx_0 = (uint32_T)A->size[1];
    unnamed_idx_1 = (uint32_T)B->size[1];
    i0 = Y->size[0] * Y->size[1];
    Y->size[0] = (int32_T)unnamed_idx_0;
    emxEnsureCapacity((emxArray__common *)Y, i0, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    i0 = Y->size[0] * Y->size[1];
    Y->size[1] = (int32_T)unnamed_idx_1;
    emxEnsureCapacity((emxArray__common *)Y, i0, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    loop_ub = (int32_T)unnamed_idx_0 * (int32_T)unnamed_idx_1;
    for (i0 = 0; i0 < loop_ub; i0++) {
      Y->data[i0] = 0.0;
    }
  } else if (A->size[0] == A->size[1]) {
    emlrtPushRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
    eml_lusolve(A, B, Y);
    emlrtPopRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
  } else {
    emlrtPushRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
    i0 = b_B->size[0] * b_B->size[1];
    b_B->size[0] = B->size[0];
    b_B->size[1] = B->size[1];
    emxEnsureCapacity((emxArray__common *)b_B, i0, (int32_T)sizeof(real_T),
                      &f_emlrtRTEI);
    loop_ub = B->size[0] * B->size[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_B->data[i0] = B->data[i0];
    }

    eml_qrsolve(A, b_B, Y);
    emlrtPopRtStackR2012b(&ub_emlrtRSI, emlrtRootTLSGlobal);
  }

  emxFree_real_T(&b_B);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (mldivide.c) */
