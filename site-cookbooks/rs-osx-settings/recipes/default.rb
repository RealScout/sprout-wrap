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
