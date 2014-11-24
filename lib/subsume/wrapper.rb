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

    class NullValue
      def include?(other_value)
        other_value.nil?
      end
    end
    def __map__(action, opts)
      new_array_of_hashes = @array_of_hashes.send(action) do |hash|
        opts.all? do |opt_key, opt_val|
          begin
            (opt_val || NullValue.new).include?(hash[opt_key])
          rescue TypeError
            # if there is a type mismatch, just assume the option value can't contain the hash value, e.g.
            #     'a String'.include?(nil) #=> TypeError: no implicit conversion of nil into String
            false
          end
        end
      end
      self.class.new(new_array_of_hashes)
    end
    private :__map__


    # According to the RDocs, these methods have to be implemented...
    def __getobj__
      @array_of_hashes # return object we are delegating to, required
    end

    def __setobj__(obj)
      @array_of_hashes = obj # change delegation object,
                             # a feature we're providing
    end

  end
end