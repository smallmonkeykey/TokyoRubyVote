# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :logged_in_user

  def terms; end

  def privacy; end
end
