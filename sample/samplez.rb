require 'num4equ'

class Num4EquTest
    def newtonMethodTest
        f1 = proc {|x| x * x - 2}
        f2 = proc {|x| x * x - x + 1}
        df1 = proc {|x| 2 * x}
        df2 = proc {|x| 2 * x - 1}
        begin
            x = Num4EquLib.newtonMethod(
              -1.8, f1, df1
            )
            print "3 x:", x
            puts
            x = Num4EquLib.newtonMethod(
             -3, f2, df2
            )
            print "-3 x:", x
            puts
        rescue => e
            p e.class
            p e.message
            p e.backtrace
        end
    end
    def bisectionMethodTest
        f1 = proc {|x| x * x - 2}
        f2 = proc {|x| x * x - x + 1}
        begin
            x = Num4EquLib.bisectionMethod(-3, -1, f1)
            print "-3, -1 x:", x
            puts
            x = Num4EquLib.bisectionMethod(2, 3, f1)
            print "2,   3 x:", x
            puts
            x = Num4EquLib.bisectionMethod(-3, 4, f2)
            print "3,   4 x:", x
            puts
        rescue => e
            p e.class
            p e.message
            p e.backtrace
        end
    end
end
tst = Num4EquTest.new
tst.newtonMethodTest()
tst.bisectionMethodTest()

