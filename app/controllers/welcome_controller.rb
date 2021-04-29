class WelcomeController < ApplicationController
  skip_before_action :keep_out_unless_logged_in
  def landing # this code already there
    @action = 'login'  # <----- add code
  end # this code already there
end