include_recipe "sprout-osx-settings"

osx_defaults "disable auto spelling correct" do
  domain 'NSGlobalDomain'
  key 'NSAutomaticSpellingCorrectionEnabled'
  boolean false
end

osx_defaults "disable web auto spelling correct" do
  domain 'NSGlobalDomain'
  key 'WebAutomaticSpellingCorrectionEnabled'
  boolean false
end

osx_defaults "disable smart quotes" do
  domain 'NSGlobalDomain'
  key 'NSAutomaticQuoteSubstitutionEnabled'
  boolean false
end

osx_defaults "disable smart dashes" do
  domain 'NSGlobalDomain'
  key 'NSAutomaticDashSubstitutionEnabled'
  boolean false
end

osx_defaults "fast key repeat" do
  domain 'NSGlobalDomain'
  key 'KeyRepeat'
  integer 2
end

osx_defaults "fast initial key repeat" do
  domain 'NSGlobalDomain'
  key 'InitialKeyRepeat'
  integer 15
end
