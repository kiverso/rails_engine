# frozen_string_literal: true

class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :revenue
end
