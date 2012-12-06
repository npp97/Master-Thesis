/*
 * chol.c
 *
 * Code generation for function 'chol'
 *
 * C source code generated on: Thu Dec  6 20:27:30 2012
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Riley.h"
#include "chol.h"
#include "mldivide.h"
#include "Riley_emxutil.h"
#include "Riley_mexutil.h"
#include "Riley_data.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */
static emlrtRSInfo n_emlrtRSI = { 32, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo o_emlrtRSI = { 43, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo q_emlrtRSI = { 52, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo r_emlrtRSI = { 57, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo s_emlrtRSI = { 63, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo t_emlrtRSI = { 64, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtRSInfo u_emlrtRSI = { 20, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtRSInfo v_emlrtRSI = { 31, "eml_xdotc",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xdotc.m"
};

static emlrtRSInfo w_emlrtRSI = { 28, "eml_xdot",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/eml_xdot.m" };

static emlrtRSInfo bb_emlrtRSI = { 8, "eml_xpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/eml_xpotrf.m"
};

static emlrtRSInfo cb_emlrtRSI = { 8, "eml_lapack_xpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/internal/eml_lapack_xpotrf.m"
};

static emlrtRSInfo db_emlrtRSI = { 37, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo eb_emlrtRSI = { 42, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo fb_emlrtRSI = { 57, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo gb_emlrtRSI = { 61, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo hb_emlrtRSI = { 65, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo ib_emlrtRSI = { 69, "eml_matlab_zpotrf",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/lapack/matlab/eml_matlab_zpotrf.m"
};

static emlrtRSInfo ob_emlrtRSI = { 90, "eml_blas_xgemv",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/blas/external/eml_blas_xgemv.m"
};

static emlrtMCInfo g_emlrtMCI = { 33, 5, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtMCInfo h_emlrtMCI = { 32, 15, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

static emlrtMCInfo i_emlrtMCI = { 20, 11, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtMCInfo j_emlrtMCI = { 20, 5, "eml_error",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/eml/eml_error.m" };

static emlrtRTEInfo d_emlrtRTEI = { 1, 18, "chol",
  "/Applications/MATLAB_R2012b.app/toolbox/eml/lib/matlab/matfun/chol.m" };

/* Function Declarations */
static void eml_error(void);

/* Function Definitions */
static void eml_error(void)
{
  const mxArray *y;
  static const int32_T iv3[2] = { 1, 19 };

  const mxArray *m2;
  static const char_T cv3[19] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 'p', 'o', 's', 'd', 'e', 'f' };

  emlrtPushRtStackR2012b(&u_emlrtRSI, emlrtRootTLSGlobal);
  y = NULL;
  m2 = mxCreateCharArray(2, iv3);
  emlrtInitCharArray(19, m2, cv3);
  emlrtAssign(&y, m2);
  error(message(y, &i_emlrtMCI), &j_emlrtMCI);
  emlrtPopRtStackR2012b(&u_emlrtRSI, emlrtRootTLSGlobal);
}

void chol(emxArray_real_T *A)
{
  int32_T n;
  boolean_T overflow;
  const mxArray *y;
  static const int32_T iv12[2] = { 1, 19 };

  const mxArray *m13;
  static const char_T cv8[19] = { 'C', 'o', 'd', 'e', 'r', ':', 'M', 'A', 'T',
    'L', 'A', 'B', ':', 's', 'q', 'u', 'a', 'r', 'e' };

  emxArray_real_T *b_A;
  emxArray_real_T *c_A;
  emxArray_real_T *d_A;
  int32_T jj;
  int32_T nmj;
  int32_T incy;
  int32_T j;
  int32_T jmax;
  boolean_T exitg1;
  real_T ajj;
  boolean_T b2;
  real_T alpha1;
  real_T beta1;
  char_T TRANSA;
  boolean_T b3;
  boolean_T b4;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  n = A->size[1];
  overflow = (A->size[0] == A->size[1]);
  if (overflow) {
  } else {
    emlrtPushRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
    y = NULL;
    m13 = mxCreateCharArray(2, iv12);
    emlrtInitCharArray(19, m13, cv8);
    emlrtAssign(&y, m13);
    error(message(y, &g_emlrtMCI), &h_emlrtMCI);
    emlrtPopRtStackR2012b(&n_emlrtRSI, emlrtRootTLSGlobal);
  }

  if (A->size[1] == 0) {
  } else {
    emlrtPushRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    if (1 > A->size[1]) {
      overflow = FALSE;
    } else {
      overflow = (A->size[1] > 2147483646);
    }

    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    check_forloop_overflow_error(overflow);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&o_emlrtRSI, emlrtRootTLSGlobal);
    emxInit_real_T(&b_A, 2, &d_emlrtRTEI, TRUE);
    emxInit_real_T(&c_A, 2, &d_emlrtRTEI, TRUE);
    emxInit_real_T(&d_A, 2, &d_emlrtRTEI, TRUE);
    emlrtPushRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
    jj = c_A->size[0] * c_A->size[1];
    c_A->size[0] = A->size[0];
    c_A->size[1] = A->size[1];
    emxEnsureCapacity((emxArray__common *)c_A, jj, (int32_T)sizeof(real_T),
                      &d_emlrtRTEI);
    nmj = A->size[1];
    for (jj = 0; jj < nmj; jj++) {
      incy = A->size[0];
      for (j = 0; j < incy; j++) {
        c_A->data[j + c_A->size[0] * jj] = A->data[j + A->size[0] * jj];
      }
    }

    jj = b_A->size[0] * b_A->size[1];
    b_A->size[0] = c_A->size[0];
    b_A->size[1] = c_A->size[1];
    emxEnsureCapacity((emxArray__common *)b_A, jj, (int32_T)sizeof(real_T),
                      &d_emlrtRTEI);
    nmj = c_A->size[1];
    for (jj = 0; jj < nmj; jj++) {
      incy = c_A->size[0];
      for (j = 0; j < incy; j++) {
        b_A->data[j + b_A->size[0] * jj] = c_A->data[j + c_A->size[0] * jj];
      }
    }

    jmax = -1;
    if ((A->size[0] == 0) || (A->size[1] == 0)) {
    } else {
      emlrtPushRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
      if (1 > A->size[0]) {
        overflow = FALSE;
      } else {
        overflow = (A->size[0] > 2147483646);
      }

      emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(overflow);
      emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&db_emlrtRSI, emlrtRootTLSGlobal);
      j = 0;
      exitg1 = FALSE;
      while ((exitg1 == FALSE) && (j + 1 <= A->size[0])) {
        jj = j + j * A->size[1];
        emlrtPushRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&v_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPushRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
        if (j < 1) {
          ajj = 0.0;
        } else {
          ajj = ddot32(&j, &b_A->data[j], &n, &b_A->data[j], &n);
        }

        emlrtPopRtStackR2012b(&w_emlrtRSI, emlrtRootTLSGlobal);
        emlrtPopRtStackR2012b(&v_emlrtRSI, emlrtRootTLSGlobal);
        ajj = b_A->data[jj] - ajj;
        emlrtPopRtStackR2012b(&eb_emlrtRSI, emlrtRootTLSGlobal);
        if (ajj > 0.0) {
          ajj = muDoubleScalarSqrt(ajj);
          b_A->data[jj] = ajj;
          if (j + 1 < A->size[0]) {
            nmj = (A->size[0] - j) - 1;
            emlrtPushRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
            if (1 > j) {
              b2 = FALSE;
            } else {
              b2 = (j > 2147483646);
            }

            check_forloop_overflow_error(b2);
            emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPopRtStackR2012b(&fb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
            if ((nmj < 1) || (j < 1)) {
            } else {
              emlrtPushRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
              alpha1 = -1.0;
              beta1 = 1.0;
              incy = 1;
              TRANSA = 'N';
              emlrtPushRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
              dgemv32(&TRANSA, &nmj, &j, &alpha1, &b_A->data[j + 1], &n,
                      &b_A->data[j], &n, &beta1, &b_A->data[jj + 1], &incy);
              emlrtPopRtStackR2012b(&ob_emlrtRSI, emlrtRootTLSGlobal);
              emlrtPopRtStackR2012b(&lb_emlrtRSI, emlrtRootTLSGlobal);
            }

            emlrtPopRtStackR2012b(&jb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPopRtStackR2012b(&gb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
            if (1 > j) {
              b3 = FALSE;
            } else {
              b3 = (j > 2147483646);
            }

            check_forloop_overflow_error(b3);
            emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPopRtStackR2012b(&hb_emlrtRSI, emlrtRootTLSGlobal);
            emlrtPushRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
            eml_xscal(nmj, 1.0 / ajj, b_A, jj + 2);
            emlrtPopRtStackR2012b(&ib_emlrtRSI, emlrtRootTLSGlobal);
          }

          j++;
        } else {
          b_A->data[jj] = ajj;
          jmax = j;
          exitg1 = TRUE;
        }
      }
    }

    emlrtPopRtStackR2012b(&cb_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&bb_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&q_emlrtRSI, emlrtRootTLSGlobal);
    jj = d_A->size[0] * d_A->size[1];
    d_A->size[0] = b_A->size[0];
    d_A->size[1] = b_A->size[1];
    emxEnsureCapacity((emxArray__common *)d_A, jj, (int32_T)sizeof(real_T),
                      &d_emlrtRTEI);
    nmj = b_A->size[1];
    for (jj = 0; jj < nmj; jj++) {
      incy = b_A->size[0];
      for (j = 0; j < incy; j++) {
        d_A->data[j + d_A->size[0] * jj] = b_A->data[j + b_A->size[0] * jj];
      }
    }

    jj = A->size[0] * A->size[1];
    A->size[0] = d_A->size[0];
    A->size[1] = d_A->size[1];
    emxEnsureCapacity((emxArray__common *)A, jj, (int32_T)sizeof(real_T),
                      &d_emlrtRTEI);
    nmj = d_A->size[1];
    for (jj = 0; jj < nmj; jj++) {
      incy = d_A->size[0];
      for (j = 0; j < incy; j++) {
        A->data[j + A->size[0] * jj] = d_A->data[j + d_A->size[0] * jj];
      }
    }

    if (jmax + 1 == 0) {
      jmax = n;
    } else {
      emlrtPushRtStackR2012b(&r_emlrtRSI, emlrtRootTLSGlobal);
      eml_error();
      emlrtPopRtStackR2012b(&r_emlrtRSI, emlrtRootTLSGlobal);
    }

    emlrtPushRtStackR2012b(&s_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    if (2 > jmax) {
      b4 = FALSE;
    } else {
      b4 = (jmax > 2147483646);
    }

    check_forloop_overflow_error(b4);
    emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
    emlrtPopRtStackR2012b(&s_emlrtRSI, emlrtRootTLSGlobal);
    for (j = 1; j + 1 <= jmax; j++) {
      emlrtPushRtStackR2012b(&t_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPushRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      check_forloop_overflow_error(j > 2147483646);
      emlrtPopRtStackR2012b(&l_emlrtRSI, emlrtRootTLSGlobal);
      emlrtPopRtStackR2012b(&t_emlrtRSI, emlrtRootTLSGlobal);
      for (jj = 1; jj <= j; jj++) {
        A->data[(jj + A->size[0] * j) - 1] = 0.0;
      }
    }

    emxFree_real_T(&d_A);
    emxFree_real_T(&c_A);
    emxFree_real_T(&b_A);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (chol.c) */
