#ifndef _CNum4Equ_H_
#define _CNum4Equ_H_

/**********************************************/
/* 構造体宣言                                 */
/**********************************************/
typedef struct _CNum4Equ CNum4Equ;
typedef double (*Func)(double x);

struct _CNum4Equ
{
    double (*FP_newtonMethodFFI)(double a, Func func, int *ok);
    double (*FP_bisectionMethodFFI)(double a, double b, Func func, int *ok);
    double (*FP_secantMethodFFI)(double a, double b, Func func, int *ok);
};
/**********************************************/
/* definen宣言                                */
/**********************************************/
#define EPS (1.0e-7)
#define DX  0.001
/**********************************************/
/* プロトタイプ宣言                           */
/**********************************************/
double CNum4Equ_newtonMethodFFI(double a, Func func, int *ok);
double CNum4Equ_bisectionMethodFFI(double a, double b, Func func, int *ok);
double CNum4Equ_secantMethodFFI(double a, double b, Func func, int *ok);
#endif
