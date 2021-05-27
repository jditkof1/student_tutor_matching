class AboutController < ApplicationController
  skip_before_action :keep_out_unless_logged_in
end

