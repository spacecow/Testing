module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
      
    when /mypage/
      '/mypage'    
      
    when /the root page/
      '/'
      
    when /path "(.+)"/
      $1
      
    when /^the (?:error )?(.+?) page$/
      send "#{$1.downcase.gsub(' ','_')}_path"
      
    when /^the (?:error )?show page (?:for|of) (.+)$/
      polymorphic_path( model($1) )
      
    when /^the edit page (?:for|of) (.+)$/
      edit_polymorphic_path( model($1) )
      
    when /^the (already reserved|already confirmed|confirm|reserve|edit courses|edit role) page (?:for|of) (.+)$/
      path = $1
      params = $2.split(" on ")
      path = path.downcase.gsub(' ','_')
      mdl  = params[0]
      sat  = params.size == 2 ? params[1].split : []
      date = ""
      if params.size == 2
        date = "?saturday=#{sat[0].gsub(/\"/,'')}"
      end
      time = sat.size == 2 ? "&time=#{sat[1].gsub(/\"/,'')}" : ""
      polymorphic_path( model(mdl) )+"/#{path}#{date}#{time}"
      

    when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
      path_to_pickle $1

    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
      path_to_pickle $1, $2

    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
      path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page

    when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
      path_to_pickle $1, :extra => $2                               #  or the forum's edit page

    when /^the (.+?) page$/                                         # translate to named route
      send "#{$1.downcase.gsub(' ','_')}_path"
  
    # end added by pickle path

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
