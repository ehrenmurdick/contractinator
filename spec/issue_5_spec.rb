require 'spec_helper'

describe Contractinator do
  subject { spec_result }

  before do
    spec_data <<-END
      class A
        attr_accessor :b

        def doit
          b.thing
        end
      end

      class B
        def thing
          true
        end
      end
    END
  end

  context 'with one stipulation' do
    before do
      spec_data <<-END
        describe A do
          it do
            a = A.new
            a.b = double(:b)
            stipulate(a.b).must receive(:thing).and_return(true)
            a.b.thing
          end
        end
      END
    end

    it { is_expected.to have(1).unfulfilled_contracts }
    it { is_expected.to contain_contract('b.thing -> bool') }

    context 'with a matching fulfillment' do
      before do
        spec_data <<-END
          describe B do
            it do
              b = B.new
              agree(b, :thing).will eq(true)
            end
          end
        END
      end

      it { is_expected.to have(1).fulfilled_contracts }
    end
  end
end
