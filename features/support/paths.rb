# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the landing page$/
      root_path

    when /^the Student-Tutor Home Page$/
      pairings_path
      
    when /^the Student-Tutor Landing Page$/
      welcome_landing_path
    when /^the Browse Subjects Page$/
      subjects_path
      
    when /^Schedule a Session Page$/
      schedules_path
      
    when /^the about us page$/
      about_index_path
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /^the RottenPotatoes edit Profile Path for "([^"]*)"$/
      edit_user_profile_path(1, 2)
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
