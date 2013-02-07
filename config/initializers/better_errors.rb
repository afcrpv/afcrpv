BetterErrors.editor = proc { |file, line| "mvim://open?url=file://#{file}&line=#{line}" } if defined? BetterErrors
