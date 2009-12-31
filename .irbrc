def hist
  puts Readline::HISTORY.entries.split("exit").last[0..-2].join("\n")
end