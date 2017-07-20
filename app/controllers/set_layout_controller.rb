class SetLayoutController < ApplicationController
  layout 'logined'
  before_filter :set_new

  def set_new
    @question = Question.new
  end
end
