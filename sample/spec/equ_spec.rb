require 'spec_helper'
require 'num4equ'

RSpec.describe Num4EquLib do
    before do
        @f1 = proc {|x| 
          next x * x - 2
        }
        @f1x = proc {|x| 
          next x * x - 4
        }
        @f2 = proc {|x| x * x - x + 1}
    end
    context 'normal' do
        it '#newtonMethod' do
            expect(
                Num4EquLib.newtonMethod(-1.8, @f1)
            ).to my_round(-1.4142, 4)
        end
        it '#bisectionMethod' do
            expect(
                Num4EquLib.bisectionMethod(-3, -1, @f1)
            ).to my_round(-1.4142, 4)
        end
        it '#secantMethod 1' do
            expect(
                Num4EquLib.secantMethod(-1, 3, @f1)
            ).to my_round(-1.4142, 4)
        end
        it '#secantMethod 2' do
            expect(
                Num4EquLib.secantMethod(2, 3, @f1)
            ).to my_round(1.4142, 4)
        end
    end
    context 'raise' do
        it '#newtonMethod' do
            expect { Num4EquLib.newtonMethod(-3, @f2) }.to raise_error(RangeError)
        end
        it '#bisectionMethod' do
            expect { Num4EquLib.bisectionMethod(-3, 4, @f2) }.to raise_error(RangeError)
        end
        it '#secantMethod' do
            expect { Num4EquLib.secantMethod(-3, 4, @f2) }.to raise_error(RangeError)
        end
    end
end

