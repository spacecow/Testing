filename = 'habtm_checkboxes.html'
File.open filename, 'r' do |f|
  b_contents = false;
  contents = ""
  f.readlines.each do |line|
    if line =~ /<doc/
      line.split[1] =~ /.+\[(.+)\].+/
      p tags = $1.split( "," ).map{|e| e[1,e.length-2]}
      line.split[2] =~ /.+=(.+)/
      p title = $1[1,$1.length]
      b_contents = true;
    elsif line =~ /<\/doc>/
      b_contents = false
    elsif b_contents
      contents += line
    end
  end
end