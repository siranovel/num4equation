#ifndef _CNum4Equ_H_
#define _CNum4Equ_H_

/**********************************************/
/* 構造体宣言                                 */
/**********************************************/
typedef struct _CNum4Equ CNum4Equ;
typedef double (*Func)(double x);
typedef double (*DFunc)(double x);

struct _CNum4Equ
{
    double (*FP_newtonMethodFFI)(double a, Func func, DFunc dFunc, int *ok);
    double (*FP_bisectionMethodFFI)(double a, double b, Func func, int *ok);
};
/**********************************************/
/* definen宣言                                */
/**********************************************/
#define EPS (1.0e-6)
/**********************************************/
/* プロトタイプ宣言                           */
/**********************************************/
double CNum4Equ_newtonMethodFFI(double a, Func func, DFunc dFunc, int *ok);
double CNum4Equ_bisectionMethodFFI(double a, double b, Func func, int *ok);
#endif
