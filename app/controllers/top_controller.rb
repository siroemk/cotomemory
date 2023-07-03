# frozen_string_literal: true

class TopController < ApplicationController
  skip_before_action :authenticate, only: :index

  def index; end
end
