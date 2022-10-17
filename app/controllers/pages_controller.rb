# frozen_string_literal: true

# Controller: pages

class PagesController < ApplicationController
  after_action :set_status
  def home; end

  def set_status
    current_user&.update!(status: User.statuses[:offline])
  end
end
  