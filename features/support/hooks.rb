count = 0
After do |scenario|
  if scenario.failed?
    p (count+=1).to_s+": #{scenario.exception.message}"
  end
end
