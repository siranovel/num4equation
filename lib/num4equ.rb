require 'ffi'
require 'ffi-compiler/loader'

#
# 数値計算による方程式の解法ライブラリ
#
module Num4EquLib
    extend FFI::Library

    ffi_lib FFI::Compiler::Loader.find('num4equ') 
    # @overload func(a)
    #   @yield [a] 関数  
    #   @yieldparam [double] aの値
    #   @return [double] xの値
    callback   :f, [:double], :double

    attach_function :newtonMethodFFI,
        :CNum4Equ_newtonMethodFFI, [:double, :f, :buffer_out], :double
    attach_function :bisectionMethodFFI,
        :CNum4Equ_bisectionMethodFFI, [:double, :double, :f, :buffer_out], :double
    attach_function :secantMethodFFI,
        :CNum4Equ_secantMethodFFI, [:double, :double, :f, :buffer_out], :double
    class << self
        # @overload newtonMethod(a, func)
        #   ニュートン法による解法
        #   @param [double] a aの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        def newtonMethod(a, func)
            ok_ptr = FFI::MemoryPointer.new :int 
            x = newtonMethodFFI(a, func, ok_ptr)
            ok = ok_ptr.read_int
            ok_ptr.free()
            if ok < 0 then
                raise RangeError.new("a:" + a.to_s)
            end
            return x
        end
        # @overload bisection(a, b, func)
        #   二分法による解法
        #   @param [double] a aの値
        #   @param [double] b bの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        def bisectionMethod(a, b, func)
            ok_ptr = FFI::MemoryPointer.new :int 
            x = bisectionMethodFFI(a, b, func, ok_ptr)
            ok = ok_ptr.read_int
            ok_ptr.free()
            if ok < 0 then
                raise RangeError.new("a:" + a.to_s + " " + "b:" + b.to_s)
            end
            return x
        end
        # @overload secantMethod(a, b, func)
        #   割線法による解法
        #   @param [double] a aの値
        #   @param [double] b bの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        def secantMethod(a, b, func)
            ok_ptr = FFI::MemoryPointer.new :int 
            x = secantMethodFFI(a, b, func, ok_ptr)
            ok = ok_ptr.read_int
            ok_ptr.free()
            if ok < 0 then
                raise RangeError.new("a:" + a.to_s + " " + "b:" + b.to_s)
            end
            return x
        end
        private :newtonMethodFFI
        private :bisectionMethodFFI
        private :secantMethodFFI
    end
end
