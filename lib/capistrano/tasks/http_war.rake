namespace :http_war do
  desc 'Check that the artifact is reachable'
  task :check do
    puts "yay, we're in http_war:check!"
  end

  desc 'Use wget to fetch the artifact_url and unpack it'
  task :create_release do
    on roles :all do
      within deploy_path do
        execute :mkdir, '-p', repo_path
      end
      within repo_path do
        execute :mkdir, '-p', release_path
        execute "wget -nv #{fetch[:artifact_url]} -O - | jar -xf -C #{release_path}"
      end
    end
  end
end

