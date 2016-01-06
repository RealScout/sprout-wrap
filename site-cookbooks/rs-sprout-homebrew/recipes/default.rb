directory '/Library/Caches/Homebrew/Casks' do
  owner node['sprout']['user']
  group 'staff'
end

execute 'remove legacy brew-cask' do
  command 'brew uninstall --force brew-cask || true'
end

