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
        # ニュートン法による解法
        # 
        # @overload newtonMethod(a, func)
        #   @param [double] a aの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        # @example
        #   f1 = proc {|x| 
        #     next x * x - 2
        #   }
        #   x = Num4EquLib.newtonMethod(-1.8, f1)
        # 
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
        # 二分法による解法
        # 
        # @overload bisection(a, b, func)
        #   @param [double] a aの値
        #   @param [double] b bの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        # @example
        #   f1 = proc {|x| 
        #     next x * x - 2
        #   }
        #   x = Num4EquLib.bisectionMethod(-3, -1, f1)
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
        # 割線法による解法
        # 
        # @overload secantMethod(a, b, func)
        #   @param [double] a aの値
        #   @param [double] b bの値
        #   @param [callback] func aに対する値を計算
        #   @return [double] xの値
        #   @raise RangeError
        # @example
        #   f1 = proc {|x| 
        #     next x * x - 2
        #   }
        #   x = Num4EquLib.secantMethod(-1, 3, f1)
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
