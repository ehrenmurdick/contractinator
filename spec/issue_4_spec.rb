require 'spec_helper'

describe Contractinator do
  describe 'issue #4' do
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
          [Object]
        end
      end
      END
    end

    context 'with no items' do
      before do
        spec_data <<-END
        describe A do
          it do
            a = A.new
            a.b = double(:b)
            stipulate(a.b).must receive(:thing).and_return([])
            a.b.thing
          end
        end
        END
      end

      it { is_expected.to have(1).unfulfilled_contracts }
      it { is_expected.to contain_contract('b.thing -> [empty]') }
    end

    context 'with some items' do
      before do
        spec_data <<-END
        describe A do
          it do
            a = A.new
            a.b = double(:b)
            stipulate(a.b).must receive(:thing).and_return([Object, Object])
            a.b.thing
          end
        end
        END
      end

      it { is_expected.to have(1).unfulfilled_contracts }
      it { is_expected.to contain_contract('b.thing -> [some Object]') }

      context 'with a matching fulfillment' do
        before do
          spec_data <<-END
          describe B do
            it do
              b = B.new
              agree(b, :thing).will eql([Object])
            end
          end
          END
        end

        it { is_expected.to have(1).fulfilled_contracts }
      end
    end
  end
end
