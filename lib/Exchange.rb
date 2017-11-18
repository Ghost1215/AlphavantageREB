module Alphavantage
  class Exchange
    include HelperFunctions

    def initialize from:, to:, key:, verbose: false
      check_argument([true, false], verbose, "verbose")
      @client = return_client(key, verbose)
      @from = from
      @to = to
      @hash = @client.request("function=CURRENCY_EXCHANGE_RATE&from_currency=#{@from}&to_currency=#{@to}")
      hash = @hash["Realtime Currency Exchange Rate"]
      hash.each do |key, val|
        key_sym = key.downcase.gsub(/[0-9.]/, "").lstrip.gsub(" ", "_").to_sym
        define_singleton_method(key_sym) do
          return val
        end
      end
    end

    attr_reader :hash

  end
end
