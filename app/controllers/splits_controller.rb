class SplitsController < ApplicationController
  before_action :calculate_total_amount, only: [:create, :update_split]

  def create
  end

  def update_split
  end
end
