#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include "CNum4Equ.h"

static double CNum4Equ_doNewtonMethodFFI(double a, Func func, DFunc dFunc, int *ok);
static double CNum4Equ_doBisectionMethodFFI(double a, double b, Func func, int *ok);

static CNum4Equ _cNum4Equ = {
    .FP_newtonMethodFFI = CNum4Equ_doNewtonMethodFFI,
    .FP_bisectionMethodFFI = CNum4Equ_doBisectionMethodFFI,
};

/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Equ_newtonMethodFFI(double a, Func func, DFunc dFunc, int *ok)
{
    assert(func != 0);

    return _cNum4Equ.FP_newtonMethodFFI(a, func, dFunc, ok);
}
double CNum4Equ_bisectionMethodFFI(double a, double b, Func func, int *ok)
{
    assert(func != 0);

    return _cNum4Equ.FP_bisectionMethodFFI(a, b, func, ok);
}
/**************************************/
/* 処理実行部                         */
/**************************************/
static double CNum4Equ_doNewtonMethodFFI(double a, Func func, DFunc dFunc, int *ok)
{
    double xn;
    double x0 = a;
    long idx = 0;

    *ok = 0;
    xn = x0;
    do {
        double f;
        double df;

        x0 = xn;
        f = func(x0);
        df = dFunc(x0);
        xn = -1 * f / df + x0;
        idx++;
        if (100000 < idx) {
            *ok = -1;
            break;
        } 
    } while(fabs(xn - x0) > EPS);
    return xn;
}
static double CNum4Equ_doBisectionMethodFFI(double a, double b, Func func, int *ok)
{
    double fa = func(a);
    double fb = func(b);
    double fxc;
    double xc;

    *ok = (fa * fb) < 0 ? 0 : -1; 
    while(!(fabs(a - b) < EPS)) {
        xc = (a + b) / 2.0;
        fxc = func(xc);
        if (fxc * fa < 0) { b = xc; }
        else { a = xc; }
        fa = func(a);
    }
    return xc; 
}

