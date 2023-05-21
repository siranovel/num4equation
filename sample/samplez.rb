require 'num4equ'

class Num4EquTest
    def initialize
        @f1 = proc {|x| 
          next x * x - 2
        }
        @f1x = proc {|x| 
          next x * x - 4
        }
        @f2 = proc {|x| x * x - x + 1}
    end
    def newtonMethodTest
        p "newtonMethodTest in"
        x = Num4EquLib.newtonMethod(-1.8, @f1)
        print "-1.8 x:", x
        puts
        x = Num4EquLib.newtonMethod(-3, @f2)
        print "-3 x:", x
        puts
    rescue => e
        p e.class
        p e.message
        p e.backtrace
    end
    def bisectionMethodTest
        p "bisectionMethodTest in"
        x = Num4EquLib.bisectionMethod(-3, -1, @f1)
        print "-3, -1 x:", x
        puts
        #x = Num4EquLib.bisectionMethod(2, 3, @f1)
        #print "2,   3 x:", x
        #puts
        x = Num4EquLib.bisectionMethod(-3, 4, @f2)
        print "-3,   4 x:", x
        puts
    rescue => e
        p e.class
        p e.message
        p e.backtrace
    end
    def secantMethodTest
        p "secantMethodTest in"
        x = Num4EquLib.secantMethod(-1, 3, @f1)
        print "-1, 3 x:", x
        puts
        x = Num4EquLib.secantMethod(2, 3, @f1)
        print "2,   3 x:", x
        puts
        x = Num4EquLib.secantMethod(-3, 4, @f2)
        print "-3,   4 x:", x
        puts
    rescue => e
        p e.class
        p e.message
        p e.backtrace
    end
end
tst = Num4EquTest.new
tst.newtonMethodTest()
tst.bisectionMethodTest()
tst.secantMethodTest()

