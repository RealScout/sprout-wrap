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
