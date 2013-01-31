BetterErrors.editor = proc { |file, line| "mvim://open?url=file://#{file}&line=#{line}" } #:mvim if defined? BetterErrors
