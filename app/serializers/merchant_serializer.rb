# frozen_string_literal: true

class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
