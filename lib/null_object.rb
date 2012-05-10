require "null_object/version"

class NullObject
  def initialize(*methods, &return_block)
    if methods.first.is_a?(Hash)
      @methods = methods.first
    else
      @methods = methods
    end

    @return_block = return_block
  end

  def method_missing(method, *args, &block)
    if @methods.empty?
      __global_return_value__(*args, &block)
    elsif @methods.is_a?(Hash) && @methods.key?(method.to_sym)
      @methods[method.to_sym]
    elsif @methods.is_a?(Enumerable) && @methods.include?(method.to_sym)
      __global_return_value__(*args, &block)
    else
      super
    end
  end

  private

  def __global_return_value__(*args, &block)
    @return_block ? @return_block.call(*args, &block) : self
  end
end
