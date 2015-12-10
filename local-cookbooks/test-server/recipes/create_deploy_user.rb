deploy = {
    :user => 'deploy',
    :group => 'www-data',
    :shell => '/bin/bash',
    :home => '/home/deploy'
}

Chef::Log.info("#{deploy}")

group deploy[:group] do
    action :create
end

user deploy[:user] do
  action :create
  comment "deploy user"
  gid deploy[:group]
  home deploy[:home]
  supports :manage_home => true
  shell deploy[:shell]
  not_if do
    existing_usernames = []
    Etc.passwd {|user| existing_usernames << user['name']}
    existing_usernames.include?(deploy[:user])
  end
end
