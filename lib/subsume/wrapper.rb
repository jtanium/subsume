require 'delegate'

module Subsume
  class Wrapper < Delegator

    def initialize(array_of_hashes)
      super(array_of_hashes)
      @array_of_hashes = array_of_hashes
    end

    def filter(opts)
      __map__(:select, opts)
    end

    def sift(opts)
      __map__(:reject, opts)
    end

    def __map__(action, opts)
      new_array_of_hashes = @array_of_hashes.send(action) do |hash|
        opts.all? { |opt_key, opt_val| opt_val.include?(hash[opt_key]) }
      end
      self.class.new(new_array_of_hashes)
    end
    private :__map__

    def __getobj__
      @array_of_hashes # return object we are delegating to, required
    end

    def __setobj__(obj)
      @array_of_hashes = obj # change delegation object,
                             # a feature we're providing
    end

  end
end