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

      artifact_name = File.basename fetch(:artifact_url)

      within fetch(:tmp_path) do
        execute :rm, '-rf', artifact_name
        execute :wget, '-nv', fetch(:artifact_url)
      end

      artifact_file_path = "#{fetch(:tmp_path)}/#{artifact_name}"

      within repo_path do
        execute :mkdir, '-p', release_path
        execute :unzip, artifact_file_path, '-d', release_path
      end
    end
  end
end

