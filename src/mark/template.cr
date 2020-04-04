require "../mark"

module Mark::Template
  DEFAULT_HTML = {{ `cat #{__DIR__}/../../asset/template.html`.stringify }}
end
