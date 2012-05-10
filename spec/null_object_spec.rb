require "spec_helper"

describe NullObject do
  it "responds to ALL of the things" do
    obj = NullObject.new
    obj.foo.should be_nil
    obj.bar.should be_nil
  end

  it "responds to SOME of the things" do
    obj = NullObject.new(:foo, :bar)
    obj.foo.should be_nil
    obj.bar.should be_nil
    expect { obj.baz }.to raise_error(NoMethodError)
  end

  it "responds to SOME of the things with CERTAIN return values" do
    obj = NullObject.new(:foo => :bar)
    obj.foo.should == :bar
    expect { obj.baz }.to raise_error(NoMethodError)
  end

  it "responds to ALL of the things with a CERTAIN return value" do
    obj = NullObject.new { "foo" }
    obj.foo.should == "foo"
    obj.bar.should == "foo"
  end

  it "responds to ALL of the things with `self`" do
    obj = NullObject.new { obj }
    obj.foo.should equal obj
    obj.foo.bar.baz.should equal obj
  end
end
