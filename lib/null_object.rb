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

  def method_missing(method, *args)
    matched = false
    return_value = if @methods.empty?
                     matched = true and __global_return_value__
                   elsif @methods.is_a?(Hash) && @methods.key?(method.to_sym)
                     matched = true and @methods[method.to_sym]
                   elsif @methods.is_a?(Enumerable) && @methods.include?(method.to_sym)
                     matched = true and __global_return_value__
                   end

    if matched
      # Next time, there'll be a real method and we'll avoid the method_missing
      # chain
      singleton_class = class << self; self; end;
      singleton_class.__send__(:define_method, method) { return_value }

      return_value
    else
      super
    end
  end

  private

  def __global_return_value__
    @return_block ? @return_block.call : self
  end
end
