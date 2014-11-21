module Subsume
  class Wrapper

    def initialize(array_of_hashes)
      @array_of_hashes = array_of_hashes
    end

    def ==(other_object)
      @array_of_hashes == other_object
    end

    def to_ary
      @array_of_hashes
    end

    def subsume(opts)
      map(:select, opts)
    end

    def exclude(opts)
      map(:reject, opts)
    end

    def map(action, opts)
      new_array_of_hashes = @array_of_hashes.send(action) do |hash|
        opts.all? { |opt_key, opt_val| opt_val.include?(hash[opt_key]) }
      end
      self.class.new(new_array_of_hashes)
    end
    private :map

  end
end