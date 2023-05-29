#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include "CNum4Equ.h"

static double CNum4Equ_doNewtonMethodFFI(double a, Func func, int *ok);
static double CNum4Equ_doBisectionMethodFFI(double a, double b, Func func, int *ok);
static double CNum4Equ_doSecantMethodFFI(double a, double b, Func func, int *ok);

static CNum4Equ _cNum4Equ = {
    .FP_newtonMethodFFI = CNum4Equ_doNewtonMethodFFI,
    .FP_bisectionMethodFFI = CNum4Equ_doBisectionMethodFFI,
    .FP_secantMethodFFI = CNum4Equ_doSecantMethodFFI,
};

/**************************************/
/* InterFface部                       */
/**************************************/
/**************************************/
/* Class部                            */
/**************************************/
double CNum4Equ_newtonMethodFFI(double a, Func func, int *ok)
{
    assert(func != 0);

    return _cNum4Equ.FP_newtonMethodFFI(a, func, ok);
}
double CNum4Equ_bisectionMethodFFI(double a, double b, Func func, int *ok)
{
    assert(func != 0);
    assert(a < b);

    return _cNum4Equ.FP_bisectionMethodFFI(a, b, func, ok);
}
double CNum4Equ_secantMethodFFI(double a, double b, Func func, int *ok)
{
    assert(func != 0);
    assert(a < b);

    return _cNum4Equ.FP_secantMethodFFI(a, b, func, ok);
}
/**************************************/
/* 処理実行部                          */
/**************************************/
/*
 * ニュートン法
 */
static double CNum4Equ_doNewtonMethodFFI(double a, Func func, int *ok)
{
    double xn = a;
    double xn_1;
    long idx = 0;

    *ok = 0;
    do {
        double fx;
        double fxh;

        // xn_1 = xn - f(x)/f'(x)
        // f'(x) = lim    (f(x + h) - f(x)) / h
        //         h -> 0
        fx = func(xn);
        fxh = func(xn + DX);
        xn_1 = xn + -1 * DX * fx / (fxh - fx);
        if (fabs(xn_1 - xn) < EPS) break;
        xn = xn_1;
        idx++;
        if (100000 < idx) {
            *ok = -1;
            break;
        } 
    } while(1);
    return xn;
}
/*
 * ２分法
 */
static double CNum4Equ_doBisectionMethodFFI(double a, double b, Func func, int *ok)
{
    double fa = func(a);
    double fb = func(b);
    double fxc;
    double xc;

    *ok = (fa * fb) < 0 ? 0 : -1; 
    if (0 != *ok) { return 0; }
    do {
        xc = (a + b) / 2.0;
        fxc = func(xc);
        if (0.0 >= fa * fxc) {
            b = xc;
            fb = fxc;
        } else {
            a = xc;
            fa = fxc;
        }
    } while(fxc != 0 && fabs(b - a) > EPS);
    return xc; 
}
/*
 * 割線法
 */
static double CNum4Equ_doSecantMethodFFI(double a, double b, Func func, int *ok)
{
    double new_x = 0.0;
    double x_n = b;
    double x_n_1 = a;
    double fa = 0.0;
    double fb = 0.0;
    double df;
    long idx = 0;

    *ok = 0; 
    do {
        fa = func(x_n_1);
        fb = func(x_n);
        df = (x_n - x_n_1 ) / (fb - fa);
        new_x = x_n - fb * df;
        if (fabs(fb * df) < EPS) break;
        if (fabs(func(new_x)) < EPS) break;
        idx++;
        if (100000 < idx) {
            *ok = -1;
            break;
        } 
        x_n_1 = x_n;
        x_n = new_x;
    } while(1);
    return new_x;
}

