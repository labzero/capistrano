namespace :http_war do
  desc 'Check that the artifact is reachable'
  task :check do
    # do nossing for now, perhaps perform a head operation in the future?
  end

  desc 'Use wget to fetch artifact_url and unpack it with unzip as a release'
  task :create_release do
    on roles :all do
      within deploy_path do
        execute :mkdir, '-p', repo_path
      end

      artifact_name = File.basename fetch(:artifact_url)

      artifact_file_path = "#{repo_path}/#{artifact_name}"

      within repo_path do
        execute :rm, '-rf', artifact_name
        execute :wget, '-nv', fetch(:artifact_url)
        execute :mkdir, '-p', release_path
        execute :unzip, '-q', artifact_file_path, '-d', release_path
      end
    end
  end
end

