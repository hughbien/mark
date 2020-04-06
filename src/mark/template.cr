require "../mark"

module Mark::Template
  DEFAULT_HTML = {{ read_file "#{__DIR__}/../../asset/template.html" }}
end
