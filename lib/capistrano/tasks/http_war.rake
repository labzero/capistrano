namespace :http_war do
  desc 'Check that the artifact is reachable'
  task :check do
    #fetch(:branch)
    #on roles :all do
    #  exit 1 unless test :curl, :'-I', fetch(:artifact_url)
    #end
    puts "yay, we're in qwar:check!"
  end

  desc 'Use wget to fetch the artifact_url and unpack it releases'
  task :create_release do
    on roles :all do
      within tmp_path do
        execute :mkdir, '-p', release_path
        execute "wget -nv #{fetch[:artifact_url]} -O - | jar -xf - -C #{release_path}"
      end
    end
  end
end

